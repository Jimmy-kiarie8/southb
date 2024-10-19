<?php

namespace App\Http\Livewire\Reports;

use App\Exports\SaleExport;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Livewire\Component;
use Livewire\WithPagination;
use Maatwebsite\Excel\Facades\Excel;
use Modules\Product\Entities\Product;
use Modules\Setting\Entities\Setting;
use Barryvdh\DomPDF\Facade\Pdf;
use Modules\People\Entities\Customer;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleBulkPayment;
use Modules\Sale\Entities\SalePayment;

class ClientReport extends Component
{

    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $customers;
    public $start_date;
    public $end_date;
    public $customer_id;
    public $report_type;
    public $payment_status;
    public $location_id;

    protected $rules = [
        'start_date' => 'required|date',
        'end_date'   => 'required|date',
    ];

    public function mount($customers)
    {
        $this->customers = $customers;
        $this->start_date = today()->subDays(30)->format('Y-m-d');
        $this->end_date = today()->format('Y-m-d');
        $this->customer_id = '';
        $this->report_type = '';
        $this->payment_status = '';
    }

    public function render()
    {
        // dd($this->customer_id);
        $customer = Customer::find($this->customer_id);
        $customer_code = null;
        if ($customer) {
            $customer_code = $customer->code;
        }

        if ($this->report_type === 'Payments') {
            $sales = SalePayment::whereDate('date', '>=', $this->start_date)
                ->whereDate('date', '<=', $this->end_date)
                ->when($customer_code, function ($query) use ($customer_code) {
                    return $query->where('customer_code', $customer_code);
                })
                ->orderBy('date', 'desc')->paginate(10);
            $sales->transform(function ($sale) use ($customer) {
                $sale->customer_name = $customer->customer_name;
                $sale->total_amount = $sale->amount;
                return $sale;
            });
            // dd($customer->customer_name);
        } else {

            $sales = Sale::with(['saleDetails'])->whereDate('date', '>=', $this->start_date)
                ->whereDate('date', '<=', $this->end_date)
                ->when($customer_code, function ($query) use($customer_code) {
                    return $query->where('clientcode', $customer_code);
                })
                ->orderBy('date', 'desc')->paginate(10);
        }

        return view('livewire.reports.client-report', [
            'sales' => $sales
        ]);
    }

    public function generateReport()
    {
        $this->validate();
        $this->render();
    }

    public function export()
    {
        $this->validate();
        return Excel::download(new SaleExport($this->customers, $this->start_date, $this->end_date, $this->customer_id, $this->report_type, $this->payment_status),  date('d-M-Y h:i') . ' sales.xlsx');
    }

    public function pdf()
    {
        $this->validate();
        $data = $this->query();

        $company = Setting::first();
        // dd($company->site_logo);
        $customer = Customer::find($this->customer_id)->customer_name;

        $pdfContent = PDF::loadView('reports::pdf.customer', ['data' => $data['sales'], 'company' =>  $company , 'sumSales' => $data['sumSales'], 'sumPayments' => $data['sumPayments'], 'difference' => $data['difference'], 'start_date' => $this->start_date, 'end_date' => $this->end_date, 'running_balance' => $data['running_balance'], 'customer_name' => $customer])->output();
        return response()->streamDownload(
            fn () => print($pdfContent),
            Carbon::now() . '-sales.pdf'
        );

        // $pdf = PDF::loadView('reports::pdf.sales', ['data' => $data, 'company' =>  $company]);
        // return $pdf->stream(Carbon::now() . '-sales.pdf');
    }

    public function query()
    {
        $customer = Customer::find($this->customer_id);
        // Log::debug($this->customer_id);
        $customer_code = null;
        if ($customer) {
            $customer_code = $customer->code;
        }
        // Retrieve sales
        $sales = Sale::whereBetween('date', [$this->start_date, $this->end_date])->when($customer_code, function ($query) use($customer_code) {
            return $query->where('clientcode', $customer_code);
        })
        // ->where('customer_id', $this->customer_id)
        ->get();
        $sales->transform(function ($payment) {
            $payment->type = 'Sale';
            return $payment;
        });



        $bulk_payments = SaleBulkPayment::whereBetween('date', [$this->start_date, $this->end_date])->where('client_id', $this->customer_id)->get();


        $bulk_payments->transform(function ($payment) use ($customer) {
            $payment->type = 'Payment';
            $payment->customer_name = $customer->customer_name;
            $payment->paid_amount = $payment->amount;
            return $payment;
        });


        $bulk_payments_ids = $bulk_payments->pluck('reference')->toArray();



        $payments = SalePayment::whereNotIn('reference', $bulk_payments_ids)->whereBetween('date', [$this->start_date, $this->end_date])->when($customer_code, function ($query) use($customer_code) {
            return $query->where('customer_code', $customer_code);
        })->get();


        // Retrieve payments
        $payments = SalePayment::whereBetween('date', [$this->start_date, $this->end_date])->when($customer_code, function ($query) use($customer_code) {
            return $query->where('customer_code', $customer_code);
        })->get();

        $payments->transform(function ($payment) use ($customer) {
            $payment->type = 'Payment';
            $payment->customer_name = ($customer) ? $customer->customer_name :'';
            $payment->paid_amount = $payment->amount;
            $payment->payment_code = $payment->note;
            return $payment;
        });


        // dd($sales, $payments);
        // $combined = $sales->concat($payments);
        // $sorted = $combined->sortBy('date');

        // dd($purchases, $payments);
        $combined = $sales->concat($payments);


        $data_items = $bulk_payments->concat($combined);

        $sorted = $data_items->sortBy('date');


        // Initialize variables for sum of sales and sum of payments
        $sumSales = 0;
        $sumPayments = 0;

        // Calculate the sums
        foreach ($sorted as $record) {
            if ($record instanceof Sale) {
                $sumSales += $record->total_amount;
            } elseif ($record instanceof SalePayment ||  $record instanceof SaleBulkPayment) {
                $sumPayments += $record->paid_amount;
            }
        }

        // Calculate the difference
        $difference = $this->balance();
        // $difference = $sumSales - $sumPayments;


        $bulk_ref = SaleBulkPayment::whereDate('date', '<',$this->start_date)->where('client_id', $this->customer_id)->pluck('reference');

        $purchase_balance = Sale::whereDate('date', '<', $this->start_date)->where('clientcode', $customer_code)->sum('total_amount');
        $bulk_sum = SaleBulkPayment::whereDate('date', '<',$this->start_date)->where('client_id', $this->customer_id)->sum('amount');
        $payment_sum = SalePayment::whereNotIn('reference', $bulk_ref)->whereDate('date', '<',$this->start_date)->where('customer_code', $customer_code)->sum('amount');

        $running_balance = $purchase_balance - ($bulk_sum + $payment_sum);


        // $sale = Sale::sum('total_amount');
        // $sum_bulk = SaleBulkPayment::sum('amount');
        // $sum = SalePayment::sum('amount');

        // $cum_total = $sale - $sum_bulk - $sum;
        return array('sales' => $sorted, 'sumSales' => $sumSales, 'sumPayments' => $sumPayments, 'difference' => $difference, 'running_balance' => $running_balance);

    }



    public function balance()
    {

        $customer = Customer::find($this->customer_id);
        $customer_code = null;
        if ($customer) {
            $customer_code = $customer->code;
        }
        // Retrieve sales
        $sales = Sale::when($customer_code, function ($query) use($customer_code) {
            return $query->where('clientcode', $customer_code);
        })
        // ->where('customer_id', $this->customer_id)
        ->get();
        $sales->transform(function ($payment) {
            $payment->type = 'Sale';
            return $payment;
        });



        $bulk_payments = SaleBulkPayment::where('client_id', $this->customer_id)->get();


        $bulk_payments->transform(function ($payment) use ($customer) {
            $payment->type = 'Payment';
            $payment->customer_name = $customer->customer_name;
            $payment->paid_amount = $payment->amount;
            return $payment;
        });


        $bulk_payments_ids = $bulk_payments->pluck('reference')->toArray();



        $payments = SalePayment::whereNotIn('reference', $bulk_payments_ids)->where('customer_code', $customer_code)->get();


        // Retrieve payments
        $payments = SalePayment::where('customer_code', $customer_code)->get();

        $payments->transform(function ($payment) use ($customer) {
            $payment->type = 'Payment';
            $payment->customer_name = $customer->customer_name;
            $payment->paid_amount = $payment->amount;
            $payment->payment_code = $payment->note;
            return $payment;
        });

        // dd($sales, $payments);
        // $combined = $sales->concat($payments);
        // $sorted = $combined->sortBy('date');

        // dd($purchases, $payments);
        $combined = $sales->concat($payments);


        $data_items = $bulk_payments->concat($combined);

        $sorted = $data_items->sortBy('date');


        // Initialize variables for sum of sales and sum of payments
        $sumSales = 0;
        $sumPayments = 0;

        // Calculate the sums
        foreach ($sorted as $record) {
            if ($record instanceof Sale) {
                $sumSales += $record->total_amount;
            } elseif ($record instanceof SalePayment ||  $record instanceof SaleBulkPayment) {
                $sumPayments += $record->paid_amount;
            }
        }

        // Calculate the difference
        return $sumSales - $sumPayments;
    }
}
