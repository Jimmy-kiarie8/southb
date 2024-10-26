<?php

namespace App\Http\Livewire\Reports;

use Carbon\Carbon;
use Livewire\Component;
use Livewire\WithPagination;
use Modules\Product\Entities\Product;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleDetails;
use Modules\Setting\Entities\Setting;

class ProductReport extends Component
{
    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $products;
    public $user_id;
    public $start_date;
    public $end_date;
    public $product_id;

    protected $rules = [
        'start_date' => 'required|date',
        'end_date'   => 'required|date',
        'user_id'   => 'required',
        'product_id'   => 'required',
    ];

    public function mount()
    {
        // $this->products = $products;
        $this->user_id = null;
        $this->end_date = now();
        $this->start_date = now();
        $this->product_id = '';
    }

    public function render()
    {
        // dd($sales);
        $sales_details =  $this->query();

        return view('livewire.reports.product-report', [
            'sales' => $sales_details->paginate(),
            'count' => $sales_details->sum('quantity'),
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
        // return Excel::download(new SaleReturnExport($this->customers,$this->start_date,$this->end_date,$this->customer_id,$this->sale_return_status,$this->payment_status),  date('d-M-Y h:i') .' sale return.xlsx');
    }

    public function pdf()
    {
        // $this->validate();
        $data = $this->query()->get();

        $company = Setting::first();
        $pdf = \PDF::loadView('reports::pdf.products', ['count' => $this->query()->sum('quantity'), 'data' => $data, 'company' =>  $company]);
        return $pdf->stream(Carbon::now() . '-product-sale.pdf');
    }

    public function query()
    {

        $start_date = Carbon::parse($this->start_date)->startOfDay();
        $end_date = Carbon::parse($this->end_date)->endOfDay();
        $same_day = ($start_date == $end_date) ? true : false;
        $sales = Sale::when($this->user_id, function ($query) {
                        return $query->where('user_id', $this->user_id);
                    })->orderBy('date', 'desc');

        if ($same_day) {
            $sales = $sales->whereDate('date', $this->start_date);
        } else {
            $sales = $sales->whereBetween('date', [$this->start_date, $this->end_date]);
        }

        $sales = $sales->pluck('id');

        // dd($sales);

        return SaleDetails::when($this->product_id, function ($query) {
            return $query->where('product_id', $this->product_id);
        })->with(['sale'])->whereIn('sale_id', $sales)->orderBy('created_at', 'Asc');

        // return  SaleDetails::with(['sale'])->whereIn('sale_id', $sales);
        // dd($sales);
    }
}
