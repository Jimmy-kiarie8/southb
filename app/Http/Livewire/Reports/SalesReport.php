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

class SalesReport extends Component
{

    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $customers;
    public $start_date;
    public $end_date;
    public $customer_id;
    public $sale_status;
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
        $this->sale_status = '';
        $this->payment_status = '';
    }

    public function render()
    {
        $sales = Sale::whereDate('date', '>=', $this->start_date)
            ->whereDate('date', '<=', $this->end_date)
            ->when($this->customer_id, function ($query) {
                return $query->where('clientcode', $this->customer_id);
                // return $query->where('customer_id', $this->customer_id);
            })
            ->when($this->sale_status, function ($query) {
                return $query->where('status', $this->sale_status);
            })
            ->when($this->location_id, function ($query) {
                return $query->where('branch_id', $this->location_id);
            })
            ->when($this->payment_status, function ($query) {
                return $query->where('payment_status', $this->payment_status);
            })
            ->orderBy('date', 'desc')->paginate(10);

        return view('livewire.reports.sales-report', [
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
        return Excel::download(new SaleExport($this->customers, $this->start_date, $this->end_date, $this->customer_id, $this->sale_status, $this->payment_status),  date('d-M-Y h:i') . ' sales.xlsx');
    }

    public function pdf()
    {
        $this->validate();
        $data = $this->query();

        $company = Setting::first();
        // dd($company->site_logo);

        $pdfContent = PDF::loadView('reports::pdf.sales', ['data' => $data['sales'], 'company' =>  $company, 'sum' => $data['sum']])->output();
        return response()->streamDownload(
            fn () => print($pdfContent),
            Carbon::now() . '-sales.pdf'
        );

        // $pdf = PDF::loadView('reports::pdf.sales', ['data' => $data, 'company' =>  $company]);
        // return $pdf->stream(Carbon::now() . '-sales.pdf');
    }


    public function pdf2()
    {
        $this->validate();
        $data = $this->query2();

        $company = Setting::first();
        // dd($company->site_logo);

        $pdfContent = PDF::loadView('reports::pdf.sales-profit', ['data' => $data['data'], 'selling_price' => $data['selling_price'],  'buying_price' => $data['buying_price'], 'company' =>  $company])->output();
        return response()->streamDownload(
            fn () => print($pdfContent),
            Carbon::now() . '-sales.pdf'
        );
        // $pdf = \PDF::loadView('reports::pdf.sales-profit', ['data' => $data, 'company' =>  $company]);
        // return $pdf->stream(Carbon::now() . '-sales.pdf');
    }


    public function pdf3()
    {
        $this->validate();
        $salesData = $this->query3();

        $company = Setting::first();
        // dd($salesData);

        $pdfContent = PDF::loadView('reports::pdf.payment-method', ['data' => $salesData, 'company' =>  $company])->output();
        return response()->streamDownload(
            fn () => print($pdfContent),
            Carbon::now() . '-sales.pdf'
        );
        // $pdf = \PDF::loadView('reports::pdf.sales-profit', ['data' => $data, 'company' =>  $company]);
        // return $pdf->stream(Carbon::now() . '-sales.pdf');
    }
    public function query3()
    {
        $start_date = $this->start_date;
        $end_date = $this->end_date;

        // Adjust the end date to the end of the day
        $adjusted_end_date = Carbon::parse($end_date)->endOfDay();

        // Subquery to get the total amount per sale and mark it as credit if no payment exists
        $salesData = DB::table('sales')
            ->leftJoin('sale_payments', 'sales.id', '=', 'sale_payments.sale_id')
            ->select(
                DB::raw('COALESCE(sale_payments.payment_method, "credit") as payment_method'),
                DB::raw('SUM(sales.total_amount) as total_sales_amount')
            )
            ->when($start_date == $end_date, function ($query) use ($start_date) {
                return $query->whereDate('sales.created_at', $start_date);
            })
            ->when($start_date != $end_date, function ($query) use ($start_date, $adjusted_end_date) {
                return $query->whereBetween('sales.created_at', [$start_date, $adjusted_end_date]);
            })
            ->groupBy('sales.id', 'payment_method')
            ->get()
            ->groupBy('payment_method')
            ->map(function ($item, $key) {
                return [
                    'payment_method' => $key,
                    'total_sales_amount' => $item->sum('total_sales_amount')
                ];
            })
            ->values();

        return ($salesData);
    }


    public function query2()
    {
        $start_date = $this->start_date;
        $end_date = $this->end_date;

        $productData = Product::select(
            'products.id',
            'products.product_name',
            'products.product_cost',
            'products.product_price',
            DB::raw('SUM(sale_details.quantity) as total_quantity'),
            DB::raw('SUM(sale_details.quantity * products.product_cost) as total_buying_price'),
            DB::raw('SUM(sale_details.quantity * sale_details.price) as total_selling_price')
        )
            ->join('sale_details', 'products.id', '=', 'sale_details.product_id')
            ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
            ->when($start_date == $end_date, function ($query) use ($start_date) {
                return $query->whereDate('sale_details.created_at', $start_date);
            })
            ->when($start_date != $end_date, function ($query) use ($start_date, $end_date) {
                return $query->whereBetween('sale_details.created_at', [$start_date, $end_date]);
            })
            ->groupBy('products.id', 'products.product_name', 'products.product_cost', 'products.product_price')
            ->get();

        $selling_price = $productData->sum('total_selling_price');
        $buying_price = $productData->sum('total_buying_price');

        return array('data' => $productData, 'selling_price' => $selling_price, 'buying_price' => $buying_price);
    }

    public function query12()
    {
        $start_date = $this->start_date;
        $end_date = $this->end_date;


        $productData = Product::select(
            'products.id',
            'products.product_name',
            'products.product_cost',
            'products.product_price',
            DB::raw('SUM(sale_details.quantity) as total_quantity'),
            DB::raw('SUM(sale_details.quantity * products.product_cost) as total_buying_price'),
            DB::raw('SUM(sale_details.quantity * sale_details.price) as total_selling_price')
            // DB::raw('SUM(sale_details.quantity * products.product_price) as total_selling_price')
        )
            ->join('sale_details', 'products.id', '=', 'sale_details.product_id')
            ->when($start_date == $end_date, function ($query) use ($start_date) {
                return $query->whereDate('sale_details.created_at', $start_date);
                // return $query->where('customer_id', $this->customer_id);
            })
            ->when($start_date != $end_date, function ($query) use ($start_date, $end_date) {
                return $query->whereBetween('sale_details.created_at', [$start_date, $end_date]);
                // return $query->where('clientcode', $this->customer_id);
                // return $query->where('customer_id', $this->customer_id);
            })
            // ->groupBy('products.id')
            ->groupBy('products.id', 'products.product_name', 'products.product_cost', 'products.product_price')

            ->get();


        $selling_price = 0;
        $buying_price = 0;

        foreach ($productData as $key => $data) {
            $selling_price += $data->total_selling_price;
            $buying_price += $data->total_buying_price;
        }

        return array('data' => $productData, 'selling_price' => $selling_price,  'buying_price' => $buying_price);


        return $productData;
    }

    public function query()
    {
        $sales = Sale::whereDate('date', '>=', $this->start_date)
            ->whereDate('date', '<=', $this->end_date)
            ->when($this->customer_id, function ($query) {
                return $query->where('clientcode', $this->customer_id);
                // return $query->where('customer_id', $this->customer_id);
            })
            ->when($this->location_id, function ($query) {
                return $query->where('branch_id', $this->location_id);
            })
            ->when($this->sale_status, function ($query) {
                return $query->where('status', $this->sale_status);
            })
            ->when($this->payment_status, function ($query) {
                return $query->where('payment_status', $this->payment_status);
            })
            ->orderBy('date', 'desc');


        $sum = $sales->sum('total_amount');
        $sales = $sales->get();

        return [
            'sum' => $sum,
            'sales' => $sales
        ];
    }
}
