<?php

namespace App\Console\Commands;

use App\Jobs\DailyMailJob;
use App\Mail\DailyReportMail;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Modules\Product\Entities\Product;
use Modules\Sale\Entities\Sale;
use Modules\Setting\Entities\Setting;

class DailyReportCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'daily:mail';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        // return Command::SUCCESS;

        $to = 'jimlaravel@gmail.com';
        $subject = 'Your PDF attachment';
        $attachmentName = 'example.pdf';
        // $pdfContent = $pdf->output();
        // Mail::to($to)->send(new DailyReportMail());

        $this->query();

    }




    public function query()
    {
        $start_date = now()->format('Y-m-d');

        // $start_date = Carbon::now()->subDay()->format('Y-m-d');

        // $sales = Sale::whereDate('date', '>=', $start_date)
        //     ->orderBy('date', 'desc');



        $sales = Product::select(
            'products.id',
            'products.product_name',
            'products.product_cost',
            'products.product_price',
            DB::raw('SUM(sale_details.quantity) as total_quantity'),
            DB::raw('SUM(sale_details.quantity * products.product_cost) as total_buying_price'),
            DB::raw('SUM(sale_details.quantity * products.product_price) as total_selling_price')
        )
            ->join('sale_details', 'products.id', '=', 'sale_details.product_id')
            // ->whereDate('date', '>=', $start_date)
            ->whereDate('sale_details.created_at', $start_date)
            // ->groupBy('products.id')
            ->groupBy('products.id', 'products.product_name', 'products.product_cost', 'products.product_price')

            ->get();



        // $sales = $sales->get();
        // $sum = $sales->sum('total_amount');



        $selling_price = 0;
        $buying_price = 0;

        foreach ($sales as $key => $data) {
            $selling_price += $data->total_selling_price;
            $buying_price += $data->total_buying_price;
        }

        $data_arr = array('data' => $sales, 'selling_price' => $selling_price,  'buying_price' => $buying_price);

        // return;
        // Log::debug($sales);
        // $data = [
        //     'sum' => $sum,
        //     'sales' => $sales
        // ];

        $company = Setting::first();
        // $pdf = PDF::loadView('reports::pdf.sales', ['data' => $data['sales'], 'company' =>  $company, 'sum' => $data['sum']]);

        // $subject = 'Your PDF attachment';
        // $attachmentName = Carbon::now() . '-daily-report.pdf';
        // $pdfContent = $pdf->output();

        // $to = ['jimlaravel@gmail.com'];
        $to = ['jimlaravel@gmail.com', 'samuelwchr98@gmail.com'];


        DailyMailJob::dispatch($data_arr, $company, $to);

        // Mail::to($to)->send(new DailyReportMail(json_encode($pdfContent), $attachmentName));

        // Mail::send([], [], function ($message) use ($to, $subject, $pdfContent, $attachmentName) {
        //     $message->to($to)
        //         ->subject($subject)
        //         ->attachData($pdfContent, $attachmentName, [
        //             'mime' => 'application/pdf',
        //         ]);
        // });

        $this->info('Report Generated');

    }
}
