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
                ->when($customer, function ($query) use ($customer) {
                    return $query->whereHas('sale', $this->forCustomer($customer));
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
                ->when($customer, function ($query) use ($customer) {
                    return $query->where($this->forCustomer($customer));
                })
                ->when($this->payment_status, function ($query) {
                    return $query->where('payment_status', $this->payment_status);
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

        $pdfContent = PDF::loadView('reports::pdf.customer', ['data' => $data['sales'], 'company' =>  $company, 'sumSales' => $data['sumSales'], 'sumPayments' => $data['sumPayments'], 'difference' => $data['difference'], 'start_date' => $this->start_date, 'end_date' => $this->end_date, 'running_balance' => $data['running_balance'], 'customer_name' => $customer])->output();
        return response()->streamDownload(
            fn() => print($pdfContent),
            Carbon::now() . '-sales.pdf'
        );
    }

    public function query()
    {
        $customer = Customer::find($this->customer_id);
        $customer_code = $customer ? $customer->code : null;

        $sales = Sale::whereBetween('date', [$this->start_date, $this->end_date])
            ->when($customer, function ($query) use ($customer) {
                return $query->where($this->forCustomer($customer));
            })
            ->when($this->payment_status, function ($query) {
                return $query->where('payment_status', $this->payment_status);
            })
            ->get();

        $sales->transform(function ($sale) {
            $sale->type = 'Sale';
            $sale->total_amount = $sale->total_amount; // Ensure total_amount is set
            return $sale;
        });

        $bulk_payments = SaleBulkPayment::whereBetween('date', [$this->start_date, $this->end_date])
            ->where('client_id', $this->customer_id)
            ->get();

        $bulk_payments->transform(function ($payment) use ($customer) {
            $payment->type = 'Payment';
            $payment->customer_name = $customer->customer_name;
            $payment->paid_amount = $payment->amount;
            return $payment;
        });

        $bulk_payments_ids = $bulk_payments->pluck('reference')->toArray();

        $payments = SalePayment::whereNotIn('reference', $bulk_payments_ids)
            ->whereBetween('date', [$this->start_date, $this->end_date])
            ->when($customer, function ($query) use ($customer) {
                return $query->whereHas('sale', $this->forCustomer($customer));
            })
            ->get();

        $payments->transform(function ($payment) use ($customer) {
            $payment->type = 'Payment';
            $payment->customer_name = $customer ? $customer->customer_name : '';
            $payment->paid_amount = $payment->amount;
            $payment->payment_code = $payment->note;
            return $payment;
        });

        $combined = $sales->concat($payments);
        $data_items = $bulk_payments->concat($combined);
        $sorted = $data_items->sortBy('date');

        $sumSales = $sales->sum('total_amount');
        $sumPayments = $payments->sum('paid_amount');
        // $sumPayments = $payments->sum('paid_amount') + $bulk_payments->sum('paid_amount');

        $difference = $sumSales - $sumPayments;

        $running_balance = $this->calculateRunningBalance($customer_code, $customer);

        return [
            'sales' => $sorted,
            'sumSales' => $sumSales,
            'sumPayments' => $sumPayments,
            'difference' => $difference,
            'running_balance' => $running_balance
        ];
    }

    /**
     * Sales belong to a customer by customer_id; clientcode is only used for older sales that have no customer_id.
     * Payments are matched through their sale with the same rule, so both sides of the statement always agree.
     */
    private function forCustomer($customer)
    {
        return function ($query) use ($customer) {
            $query->where('customer_id', $customer->id)
                ->orWhere(function ($q) use ($customer) {
                    $q->whereNull('customer_id')->where('clientcode', $customer->code);
                });
        };
    }

    private function calculateRunningBalance($customer_code, $customer)
    {
        $startDate = Carbon::parse($this->start_date)->startOfDay();

        // Calculate total sales
        $total_sales = Sale::where($this->forCustomer($customer))
            ->whereDate('date', '<', $startDate)
            // ->where('status', '!=', 'Paid')
            ->sum('total_amount');

        // Calculate payments using the same customer identification logic
        $total_payments = $this->calculateTotalPayments($customer_code, $customer, $startDate);

        Log::info('total_sales: ' . $total_sales);
        Log::info('total_payments: ' . $total_payments);
        return $total_sales - $total_payments;
    }

    private function calculateTotalPayments($customer_code, $customer, $startDate)
    {
        // $bulk_payments = SaleBulkPayment::whereDate('date', '<', $startDate)
        //     ->where('client_id', $customer->id)  // Use consistent ID
        //     ->sum('amount');

        $payments = SalePayment::whereDate('date', '<', $startDate)
            ->whereHas('sale', $this->forCustomer($customer))
            ->get(['id', 'sale_id', 'date', 'amount', 'reference']);

        Log::info('bf_payments', [
            'database' => DB::connection()->getDatabaseName(),
            'customer_id' => $customer->id,
            'start_date' => $startDate->toDateString(),
            'count' => $payments->count(),
            'rows' => $payments->map(fn ($p) => [$p->id, $p->sale_id, $p->date, $p->amount, $p->reference])->values()->all(),
        ]);

        return $payments->sum('amount');
    }


    public function balance()
    {

        $customer = Customer::find($this->customer_id);
        $customer_code = null;
        if ($customer) {
            $customer_code = $customer->code;
        }
        // Retrieve sales
        $sales = Sale::when($customer, function ($query) use ($customer) {
            return $query->where($this->forCustomer($customer));
        })->when($this->payment_status, function ($query) {
            return $query->where('payment_status', $this->payment_status);
        })
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



        $payments = SalePayment::whereNotIn('reference', $bulk_payments_ids)
            ->when($customer, function ($query) use ($customer) {
                return $query->whereHas('sale', $this->forCustomer($customer));
            })
            ->get();



        $payments->transform(function ($payment) use ($customer) {
            $payment->type = 'Payment';
            $payment->customer_name = $customer->customer_name;
            $payment->paid_amount = $payment->amount;
            $payment->payment_code = $payment->note;
            return $payment;
        });


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
