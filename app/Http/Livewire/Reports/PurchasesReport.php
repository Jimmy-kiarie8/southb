<?php

namespace App\Http\Livewire\Reports;

use App\Exports\PurchaseExport;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Livewire\Component;
use Livewire\WithPagination;
use Maatwebsite\Excel\Facades\Excel;
use Modules\Purchase\Entities\Purchase;
use Modules\Setting\Entities\Setting;
use Barryvdh\DomPDF\Facade\Pdf;

class PurchasesReport extends Component
{

    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $suppliers;
    public $start_date;
    public $end_date;
    public $supplier_id;
    public $location_id;
    public $purchase_status;
    public $payment_status;

    protected $rules = [
        'start_date' => 'required|date|before:end_date',
        'end_date'   => 'required|date|after:start_date',
    ];

    public function mount($suppliers) {
        $this->suppliers = $suppliers;
        $this->start_date = today()->subDays(30)->format('Y-m-d');
        $this->end_date = today()->format('Y-m-d');
        $this->supplier_id = '';
        // $this->location_id = '';
        $this->purchase_status = '';
        $this->payment_status = '';
    }

    public function render() {
        $purchases = Purchase::whereDate('date', '>=', $this->start_date)
            ->whereDate('date', '<=', $this->end_date)
            ->when($this->supplier_id, function ($query) {
                return $query->where('supplier_id', $this->supplier_id);
            })
            ->when($this->location_id, function ($query) {
                return $query->where('location_id', $this->location_id);
            })
            ->when($this->purchase_status, function ($query) {
                return $query->where('status', $this->purchase_status);
            })
            ->when($this->payment_status, function ($query) {
                return $query->where('payment_status', $this->payment_status);
            })
            ->orderBy('date', 'desc')->paginate(10);

        return view('livewire.reports.purchases-report', [
            'purchases' => $purchases
        ]);
    }

    public function generateReport() {
        $this->validate();
        $this->render();
    }

    public function export()
    {
        $this->validate();
        return Excel::download(new PurchaseExport($this->suppliers,$this->start_date,$this->end_date,$this->supplier_id,$this->purchase_status,$this->payment_status),  date('d-M-Y h:i') .' purchase.xlsx');
    }

    public function pdf()
    {
        $this->validate();
        $data = $this->query();

        // dd($data);
        $total = 0;
        foreach ($data as $key => $value) {
            $total += (int)$value->total_amount;
        }
        Log::alert($total);

        $company = Setting::first();

        $pdf = Pdf::loadView('reports::pdf.purchase', ['data' => $data, 'company' =>  $company, 'total' => $total]);
        // return $pdf->download(Carbon::now() . '-purchase.pdf');

        // Return the PDF as a response that can be downloaded
        return response()->streamDownload(function() use ($pdf) {
            echo $pdf->output();
        }, Carbon::now() . '-purchase.pdf', [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'attachment; filename="' . Carbon::now() . '-purchase.pdf"',
        ]);
    }

    public function query()
    {
        return Purchase::whereDate('date', '>=', $this->start_date)
        ->whereDate('date', '<=', $this->end_date)
        ->when($this->supplier_id, function ($query) {
            return $query->where('supplier_id', $this->supplier_id);
        })
        ->when($this->location_id, function ($query) {
            return $query->where('location_id', $this->location_id);
        })
        ->when($this->purchase_status, function ($query) {
            return $query->where('status', $this->purchase_status);
        })
        ->when($this->payment_status, function ($query) {
            return $query->where('payment_status', $this->payment_status);
        })
        ->orderBy('date', 'desc')->get();
    }
}
