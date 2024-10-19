<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;
use Modules\Sale\Entities\Sale;
use Modules\Setting\Entities\Setting;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Mail;

class DailyReportMail extends Mailable implements ShouldQueue
{
    use Queueable, SerializesModels;

    // public $pdfContent, $attachmentName;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct()
    {
        // $this->pdfContent = json_decode($pdfContent);
        // $this->attachmentName = $attachmentName;
    }

    /**
     * Get the message envelope.
     *
     * @return \Illuminate\Mail\Mailables\Envelope
     */
    public function envelope()
    {
        return new Envelope(
            subject: 'Daily Report Mail',
        );
    }

    /**
     * Get the message content definition.
     *
     * @return \Illuminate\Mail\Mailables\Content
     */
    public function content()
    {
        return new Content(
            markdown: 'mails/daily-report',
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array
     */
    public function attachments()
    {
        return [$this->query()];
    }



    public function query()
    {
        $start_date = now()->format('d-m-y');
        $sales = Sale::whereDate('date', '>=', $start_date)
            ->orderBy('date', 'desc');

        $sum = $sales->sum('total_amount');
        $sales = $sales->get();

        $data = [
            'sum' => $sum,
            'sales' => $sales
        ];

        $company = Setting::first();
        $pdf = PDF::loadView('reports::pdf.sales', ['data' => $data['sales'], 'company' =>  $company, 'sum' => $data['sum']]);


        return $pdf->output();

        // Mail::to($to)->send(new DailyReportMail(json_encode($pdfContent), $attachmentName));

        // Mail::send([], [], function ($message) use ($to, $subject, $pdfContent, $attachmentName) {
        //     $message->to($to)
        //         ->subject($subject)
        //         ->attachData($pdfContent, $attachmentName, [
        //             'mime' => 'application/pdf',
        //         ]);
        // });
    }
}
