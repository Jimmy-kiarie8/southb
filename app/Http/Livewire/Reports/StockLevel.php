<?php

namespace App\Http\Livewire\Reports;

use Livewire\Component;
use Livewire\WithPagination;
use Maatwebsite\Excel\Facades\Excel;
use Modules\Product\Entities\Product;

class StockLevel extends Component
{


    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $products;
    public $branch_id;

    protected $rules = [
        'start_date' => 'required|date|before:end_date',
        'end_date'   => 'required|date|after:start_date',
    ];

    public function mount($products)
    {
        $this->products = $products;
        $this->branch_id = 0;
    }


    // public function render()
    // {
    //     return view('livewire.stock-level');
    // }

    public function render()
    {
        $this->products = Product::when($this->branch_id, function ($query) {
                return $query->where('branch_id', $this->branch_id);
            })
            ->orderBy('date', 'desc')->paginate(10);

        return view('livewire.reports.stock-level', [
            'products' => $this->products
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

    public function selectLocation($data)
    {
        // $this->emit('locationChange', $data);
        $this->branch_id = $data;

        $this->products = Product::when($this->branch_id, function ($query) {
            return $query->where('branch_id', $this->branch_id);
        })
        ->orderBy('date', 'desc')->paginate(10);
    }

    public function pdf()
    {
        // $this->validate();
        // $data = $this->query();

        // $company = Setting::first();

        // $pdf = \PDF::loadView('reports::pdf.sales', ['data' => $data, 'company' =>  $company]);
        // return $pdf->stream(Carbon::now() . '-sales.pdf');
    }

    public function query()
    {
        // return SaleReturn::whereDate('date', '>=', $this->start_date)
        // ->whereDate('date', '<=', $this->end_date)
        // ->when($this->customer_id, function ($query) {
        //     return $query->where('customer_id', $this->customer_id);
        // })
        // ->when($this->sale_return_status, function ($query) {
        //     return $query->where('status', $this->sale_return_status);
        // })
        // ->when($this->payment_status, function ($query) {
        //     return $query->where('payment_status', $this->payment_status);
        // })
        // ->orderBy('date', 'desc')->get();
    }
}
