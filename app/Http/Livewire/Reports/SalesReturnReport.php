<?php

namespace App\Http\Livewire\Reports;

use App\Exports\SaleReturnExport;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Livewire\Component;
use Livewire\WithPagination;
use Maatwebsite\Excel\Facades\Excel;
use Modules\SalesReturn\Entities\SaleReturn;
use Modules\Setting\Entities\Setting;

class SalesReturnReport extends Component
{

    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $customers;
    public $start_date;
    public $end_date;
    public $customer_id;
    public $sale_return_status;
    public $payment_status;

    protected $rules = [
        'start_date' => 'required|date|before:end_date',
        'end_date'   => 'required|date|after:start_date',
    ];

    public function mount($customers)
    {
        $this->customers = $customers;
        $this->start_date = today()->subDays(30)->format('Y-m-d');
        $this->end_date = today()->format('Y-m-d');
        $this->customer_id = '';
        $this->sale_return_status = '';
        $this->payment_status = '';
    }

    public function render()
    {
        $sale_returns = SaleReturn::whereDate('date', '>=', $this->start_date)
            ->whereDate('date', '<=', $this->end_date)
            ->when($this->customer_id, function ($query) {
                return $query->where('customer_id', $this->customer_id);
            })
            ->when($this->sale_return_status, function ($query) {
                return $query->where('status', $this->sale_return_status);
            })
            ->when($this->payment_status, function ($query) {
                return $query->where('payment_status', $this->payment_status);
            })
            ->orderBy('date', 'desc')->paginate(10);

        return view('livewire.reports.sales-return-report', [
            'sale_returns' => $sale_returns
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
        return Excel::download(new SaleReturnExport($this->customers,$this->start_date,$this->end_date,$this->customer_id,$this->sale_return_status,$this->payment_status),  date('d-M-Y h:i') .' sale return.xlsx');
    }

    public function pdf()
    {
        $this->validate();
        $data = $this->query();

        $company = Setting::first();

        $pdfContent = PDF::loadView('reports::pdf.sales', ['data' => $data, 'company' =>  $company])->output();
        return response()->streamDownload(
            fn () => print($pdfContent),
            Carbon::now() . '-sales.pdf'
        );
    }

    public function query()
    {
        return SaleReturn::whereDate('date', '>=', $this->start_date)
        ->whereDate('date', '<=', $this->end_date)
        ->when($this->customer_id, function ($query) {
            return $query->where('customer_id', $this->customer_id);
        })
        ->when($this->sale_return_status, function ($query) {
            return $query->where('status', $this->sale_return_status);
        })
        ->when($this->payment_status, function ($query) {
            return $query->where('payment_status', $this->payment_status);
        })
        ->orderBy('date', 'desc')->get();
    }
}
