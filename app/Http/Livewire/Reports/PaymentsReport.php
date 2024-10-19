<?php

namespace App\Http\Livewire\Reports;

use App\Exports\PaymentExport;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Livewire\Component;
use Livewire\WithPagination;
use Maatwebsite\Excel\Facades\Excel;
use Modules\People\Entities\Customer;
use Modules\People\Entities\Supplier;
use Modules\Purchase\Entities\Purchase;
use Modules\Purchase\Entities\PurchasePayment;
use Modules\PurchasesReturn\Entities\PurchaseReturnPayment;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SalePayment;
use Modules\SalesReturn\Entities\SaleReturn;
use Modules\SalesReturn\Entities\SaleReturnPayment;
use Modules\Setting\Entities\Setting;

class PaymentsReport extends Component
{

    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $start_date;
    public $end_date;
    public $payments;
    public $customer_id;
    public $supplier_id;
    public $payment_method;
    public $sale_made;
    public $payments_made;
    public $mergedData;

    public $sale_payments;

    protected $rules = [
        'start_date' => 'required|date|before:end_date',
        'end_date'   => 'required|date|after:start_date',
        'payments'   => 'required|string'
    ];
    protected $query;

    public function mount()
    {
        $this->start_date = today()->subDays(30)->format('Y-m-d');
        $this->end_date = today()->format('Y-m-d');
        $this->payments = '';
        $this->supplier_id = '';
        $this->query = null;
    }

    public function render()
    {
        $this->getQuery();
        // dd($this->supplier_id);
       $count = $this->query ? $this->query->orderBy('date', 'desc')
                ->when($this->start_date, function ($query) {
                    return $query->whereDate('date', '>=', $this->start_date);
                })
                ->when($this->end_date, function ($query) {
                    return $query->whereDate('date', '<=', $this->end_date);
                })
                ->when($this->payment_method, function ($query) {
                    return $query->where('payment_method', $this->payment_method);
                })
                ->when(($this->payments == 'sale' && $this->customer_id), function ($query) {
                    return $query->where('customer_code', $this->customer_id);
                })->when(($this->payments == 'purchase' && $this->supplier_id), function ($query) {
                    $supplier_code = Supplier::find($this->supplier_id);

                    return $query->where('clientcode', $supplier_code->supplier_code);
                })
                ->sum('amount') : 0;





        return view('livewire.reports.payments-report', [
            'information' => $this->query ? $this->query->orderBy('date', 'desc')
                ->when($this->start_date, function ($query) {
                    return $query->whereDate('date', '>=', $this->start_date);
                })
                ->when($this->end_date, function ($query) {
                    return $query->whereDate('date', '<=', $this->end_date);
                })
                ->when($this->payment_method, function ($query) {
                    return $query->where('payment_method', $this->payment_method);
                })
                ->when(($this->payments == 'sale' && $this->customer_id), function ($query) {
                    return $query->where('customer_code', $this->customer_id);
                })->when(($this->payments == 'purchase' && $this->supplier_id), function ($query) {
                    $supplier_code = Supplier::find($this->supplier_id);

                    return $query->where('clientcode', $supplier_code->supplier_code);
                })
                ->paginate(10) : collect(),

                'totals' => $count
        ]);
    }

    public function generateReport()
    {
        $this->validate();
        $this->render();
    }


    public function updatedPayments($value)
    {
        $this->resetPage();
    }

    public function getQuery()
    {
        if ($this->payments == 'sale') {
            $this->query = SalePayment::query()->with('sale');
        } elseif ($this->payments == 'sale_return') {
            $this->query = SaleReturnPayment::query()->with('saleReturn');
        } elseif ($this->payments == 'purchase') {
            $this->query = PurchasePayment::query()->with('purchase');
        } elseif ($this->payments == 'purchase_return') {
            $this->query = PurchaseReturnPayment::query()->with('purchaseReturn');
        } else {
            $this->query = null;
        }
    }

    public function export()
    {
        $this->validate();
        return Excel::download(new PaymentExport($this->start_date, $this->end_date, $this->payment_method, $this->payments), date('d-M-Y h:i') . ' payment.xlsx');
    }


    public function pdf()
    {
        $this->validate();
        $data = $this->queryFilter();

        // dd($data);

        $company = Setting::first();

        $pdf = \PDF::loadView('reports::pdf.payment', ['data' => $data, 'company' =>  $company, 'sale_made' => $this->sale_made, 'payments_made' => $this->payments_made, 'payments' => $this->payments]);
        return $pdf->stream(Carbon::now() . '-sales.pdf');
    }

    public function queryFilter()
    {
        if ($this->payments == 'sale') {
            // $this->query = SalePayment::query()->with('sale')->get();
            $this->sale_made  = Sale::where('clientcode', $this->customer_id)->sum('total_amount');
            $this->payments_made  = SalePayment::where('customer_code', $this->customer_id)->sum('amount');
            $sale_made  = Sale::where('clientcode', $this->customer_id)->get();
            $payments_made  = SalePayment::where('customer_code', $this->customer_id)->get();
            $mergedData = $sale_made->concat($payments_made);
            return $mergedData->sortBy('date');
        } elseif ($this->payments == 'sale_return') {
            return $this->query = SaleReturnPayment::query()->with('saleReturn')->get();
        } elseif ($this->payments == 'purchase') {
            // $this->query = PurchasePayment::query()->with('purchase')->get();
            $supplier_code = Supplier::find($this->supplier_id);
            // dd($supplier_code->supplier_code);
            $this->sale_made  = Purchase::where('supplier_id', $this->supplier_id)->sum('total_amount');
            $this->payments_made  = PurchasePayment::where('clientcode', $supplier_code->supplier_code)->sum('amount');
            // dd($this->sale_made);
            $sale_made  = Purchase::where('supplier_id', $this->supplier_id)->get();
            $payments_made  = PurchasePayment::where('clientcode', $supplier_code->supplier_code)->get();
            $mergedData = $sale_made->concat($payments_made);
            return $mergedData->sortBy('date');
        } elseif ($this->payments == 'purchase_return') {
            return $this->query = PurchaseReturnPayment::query()->with('purchaseReturn')->get();
        } else {
            return $this->query = null;
        }
    }
}
