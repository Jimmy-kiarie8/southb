<?php

namespace App\Jobs;

use App\Models\Dailymail;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use Symfony\Component\Mime\Part\TextPart;

class DailyMailJob implements ShouldQueue
// class DailyMailJob
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $data, $company, $to;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($data, $company, $to)
    {
        $this->data = $data;
        $this->company = $company;
        $this->to = $to;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $model = Dailymail::latest()->first();
        $last_job = ($model) ? Carbon::parse($model->last_job) : Carbon::parse(Carbon::now()->subDays(2));
        // $next_job = Carbon::now()->addHours(23);

        // Get the current time in the same timezone as the model's last_job column
        $now = Carbon::now($last_job->getTimezone());
        // dd($last_job->getTimezone());
        // dd($last_job->diffInHours($now));
        // Check if the difference between the last_job column and the current time is greater than 23 hours
        if ($last_job->diffInHours($now) > 23) {
            Dailymail::firstOrCreate([
                'last_job' => now()
            ]);
            // The last_job column is more than 23 hours old
            $data = ['data' => $this->data['data'], 'selling_price' => $this->data['selling_price'],  'buying_price' => $this->data['buying_price'], 'company' =>  $this->company];
            $pdf = PDF::loadView('reports::pdf.sales-profit', $data);
            // $pdf = PDF::loadView('reports::pdf.sales', ['data' => $this->sales, 'company' =>  $this->company, 'sum' => $this->sum]);
            $pdfContent = $pdf->output();
            $message = "Hello,\n\nPlease find attached report.\n\nThank you.";
            $body = new TextPart($message);

            Mail::send([], [], function ($mail) use ($pdfContent, $body) {
                $mail->to('engsyms@gmail.com')
                    ->bcc($this->to)
                    ->subject('Daily Report')
                    // ->setBody($body)
                    ->attachData($pdfContent, Carbon::now() . '-daily-report.pdf');
            });
        } else {
            return true;
        }
    }
}
