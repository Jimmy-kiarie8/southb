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
use Modules\Sale\Entities\Sale;
use Modules\Setting\Entities\Setting;
use Barryvdh\DomPDF\Facade\Pdf;
use Modules\People\Entities\Supplier;
use Modules\Purchase\Entities\Purchase;
use Modules\Purchase\Entities\PurchaseBulkPayment;
use Modules\Purchase\Entities\PurchasePayment;

class SupplierReport extends Component
{

    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $suppliers;
    public $start_date;
    public $end_date;
    public $supplier_id;
    public $report_type;
    public $payment_status;
    public $location_id;

    protected $rules = [
        'start_date' => 'required|date',
        'end_date'   => 'required|date',
    ];

    public function mount($suppliers)
    {
        $this->suppliers = $suppliers;
        $this->start_date = today()->subDays(30)->format('Y-m-d');
        $this->end_date = today()->format('Y-m-d');
        $this->supplier_id = '';
        $this->report_type = '';
        $this->payment_status = '';
    }

    public function render()
    {
        // dd($this->supplier_id);
        $supplier = Supplier::find($this->supplier_id);

        $supplier_code = null;
        if ($supplier) {
            $supplier_code = $supplier->supplier_code;
        }
        if ($this->report_type === 'Payments') {
            $purchases = PurchasePayment::whereDate('date', '>=', $this->start_date)
                ->whereDate('date', '<=', $this->end_date)
                ->when($supplier_code, function ($query) use ($supplier_code) {
                    return $query->where('clientcode', $supplier_code);
                })
                ->orderBy('date', 'desc')->paginate(10);
            $purchases->transform(function ($purchase) use ($supplier) {
                $purchase->supplier_name = ($supplier) ? $supplier->supplier_name : '';
                $purchase->total_amount = $purchase->amount;
                return $purchase;
            });
        } else {
            $purchases = Purchase::with(['purchaseDetails'])->whereDate('date', '>=', $this->start_date)
                ->whereDate('date', '<=', $this->end_date)
                ->when($this->supplier_id, function ($query) {
                    return $query->where('supplier_id', $this->supplier_id);
                })
                ->orderBy('date', 'desc')->paginate(10);
        }

        return view('livewire.reports.supplier-report', [
            'purchases' => $purchases
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
        return Excel::download(new SaleExport($this->suppliers, $this->start_date, $this->end_date, $this->supplier_id, $this->report_type, $this->payment_status),  date('d-M-Y h:i') . ' sales.xlsx');
    }

    public function pdf()
    {
        $this->validate();
        $data = $this->query();

        $company = Setting::first();
        // dd($company->site_logo);

        $supplier_name = Supplier::find($this->supplier_id)->supplier_name;

        $pdfContent = PDF::loadView('reports::pdf.supplier', ['data' => $data['purchases'], 'company' =>  $company , 'sumPurchases' => $data['sumPurchases'], 'sumPayments' => $data['sumPayments'], 'difference' => $data['difference'], 'start_date' => $this->start_date, 'end_date' => $this->end_date, 'running_balance' => $data['running_balance'], 'supplier_name' => $supplier_name])->output();
        return response()->streamDownload(
            fn () => print($pdfContent),
            Carbon::now() . '-sales.pdf'
        );

        // $pdf = PDF::loadView('reports::pdf.sales', ['data' => $data, 'company' =>  $company]);
        // return $pdf->stream(Carbon::now() . '-sales.pdf');
    }

    public function query()
    {
        $supplier = Supplier::find($this->supplier_id);

        // Retrieve purchases
        $purchases = Purchase::whereBetween('date', [$this->start_date, $this->end_date])->where('supplier_id', $this->supplier_id)->get();
        $purchases->transform(function ($payment) {
            $payment->type = 'Purchase';
            return $payment;
        });


        // Retrieve payments

        $bulk_payments = PurchaseBulkPayment::whereBetween('date', [$this->start_date, $this->end_date])->where('supplier_id', $this->supplier_id)->get();




        $bulk_payments->transform(function ($payment) use ($supplier) {
            $payment->type = ($payment->payment_method == 'Credit') ? 'Credit Note' : 'Payment';
            $payment->supplier_name = $supplier->supplier_name;
            $payment->paid_amount = $payment->amount;
            return $payment;
        });

        $bulk_payments_ids = $bulk_payments->pluck('reference')->toArray();



        $payments = PurchasePayment::whereNotIn('reference', $bulk_payments_ids)->whereBetween('date', [$this->start_date, $this->end_date])->where('supplier_id', $this->supplier_id)->get();



        $payments->transform(function ($payment) use ($supplier) {
            $payment->type = 'Payment';
            $payment->supplier_name = $supplier->supplier_name;
            $payment->paid_amount = $payment->amount;
            return $payment;
        });


        // dd($purchases, $payments);
        $combined = $purchases->concat($payments);


        $data_items = $bulk_payments->concat($combined);

        $sorted = $data_items->sortBy('date');


        // Initialize variables for sum of purchases and sum of payments
        $sumPurchases = 0;
        $sumPayments = 0;

        // Calculate the sums
        foreach ($sorted as $record) {
            if ($record instanceof Purchase) {
                $sumPurchases += $record->total_amount;
            } elseif ($record instanceof PurchasePayment ||  $record instanceof PurchaseBulkPayment) {
                $sumPayments += $record->paid_amount;
            }
        }

        // Calculate the difference
        // $difference = $sumPurchases - $sumPayments;

        $difference =  $this->balance();

        // $purchase = Purchase::whereYear('created_at', date('Y'))->sum('total_amount');
        // $sum_bulk = PurchaseBulkPayment::whereYear('created_at', date('Y'))->sum('amount');
        // $sum = PurchasePayment::whereYear('created_at', date('Y'))->sum('amount');

        // $cum_total = $this->balance();

        $bulk_ref = PurchaseBulkPayment::whereDate('date', '<',$this->start_date)->where('supplier_id', $this->supplier_id)->pluck('reference');

        $purchase_balance = Purchase::whereDate('date', '<', $this->start_date)->where('supplier_id', $this->supplier_id)->sum('total_amount');
        $bulk_sum = PurchaseBulkPayment::whereDate('date', '<',$this->start_date)->where('supplier_id', $this->supplier_id)->sum('amount');
        $payment_sum = PurchasePayment::whereNotIn('reference', $bulk_ref)->whereDate('date', '<',$this->start_date)->where('supplier_id', $this->supplier_id)->sum('amount');

        $running_balance = $purchase_balance - ($bulk_sum + $payment_sum);

        return array('purchases' => $sorted, 'sumPurchases' => $sumPurchases, 'sumPayments' => $sumPayments, 'difference' => $difference, 'running_balance' => $running_balance);

    }



    public function balance()
    {
        $supplier = Supplier::find($this->supplier_id);

        // Retrieve purchases
        $purchases = Purchase::where('supplier_id', $this->supplier_id)->get();
        $purchases->transform(function ($payment) {
            $payment->type = 'Purchase';
            return $payment;
        });


        // Retrieve payments

        $bulk_payments = PurchaseBulkPayment::where('supplier_id', $this->supplier_id)->get();


        $bulk_payments->transform(function ($payment) use ($supplier) {
            $payment->type = ($payment->payment_method == 'Credit') ? 'Credit Note' : 'Payment';
            $payment->supplier_name = $supplier->supplier_name;
            $payment->paid_amount = $payment->amount;
            return $payment;
        });

        $bulk_payments_ids = $bulk_payments->pluck('reference')->toArray();



        $payments = PurchasePayment::whereNotIn('reference', $bulk_payments_ids)->where('supplier_id', $this->supplier_id)->get();



        $payments->transform(function ($payment) use ($supplier) {
            $payment->type = 'Payment';
            $payment->supplier_name = $supplier->supplier_name;
            $payment->paid_amount = $payment->amount;
            return $payment;
        });


        // dd($purchases, $payments);
        $combined = $purchases->concat($payments);


        $data_items = $bulk_payments->concat($combined);

        $sorted = $data_items->sortBy('date');


        // Initialize variables for sum of purchases and sum of payments
        $sumPurchases = 0;
        $sumPayments = 0;

        // Calculate the sums
        foreach ($sorted as $record) {
            if ($record instanceof Purchase) {
                $sumPurchases += $record->total_amount;
            } elseif ($record instanceof PurchasePayment ||  $record instanceof PurchaseBulkPayment) {
                $sumPayments += $record->paid_amount;
            }
        }

        // Calculate the difference
       return $sumPurchases - $sumPayments;
    }
}
