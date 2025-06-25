<?php

namespace App\Http\Livewire\Reports;

use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Livewire\Component;
use Livewire\WithPagination;
use Modules\Product\Entities\Product;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleDetails;
use Modules\Setting\Entities\Setting;
use Barryvdh\DomPDF\Facade\Pdf;

class ProductReport extends Component
{
    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $products;
    public $user_id;
    public $start_date;
    public $end_date;
    public $product_id;

    public $productSearch = '';
    public $showProductDropdown = false;
    public $selectedProductName = 'All';



    public function getFilteredProductsProperty()
    {
        $products = Product::where('product_code', 'like', '%' . $this->productSearch . '%')
            ->orderBy('product_code', 'asc')
            ->limit(50)
            ->get();

        Log::info($this->productSearch);

        Log::info($products);

        return $products;
    }

    public function toggleProductDropdown()
    {
        $this->showProductDropdown = !$this->showProductDropdown;
    }

    public function selectProduct($id, $name)
    {
        $this->product_id = $id;
        $this->selectedProductName = $name;
        $this->productSearch = $name;
        $this->showProductDropdown = false;
    }


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
        $pdf = Pdf::loadView('reports::pdf.products', ['count' => $this->query()->sum('quantity'), 'data' => $data, 'company' =>  $company]);
        return response()->streamDownload(
            fn () => print($pdf->output()),
            Carbon::now()->format('Y-m-d') . '-product-sale.pdf'
        );
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
