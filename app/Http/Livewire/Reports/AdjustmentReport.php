<?php

namespace App\Http\Livewire\Reports;

use App\Exports\AdjustmentExport;
use App\Exports\SaleExport;
use Carbon\Carbon;
use Livewire\Component;
use Livewire\WithPagination;
use Maatwebsite\Excel\Facades\Excel;
use Modules\Setting\Entities\Setting;
use Barryvdh\DomPDF\Facade\Pdf;
use Modules\Adjustment\Entities\AdjustedProduct;
use Modules\Adjustment\Entities\Adjustment;

class AdjustmentReport extends Component
{

    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $start_date;
    public $end_date;
    public $location_id;

    protected $rules = [
        'start_date' => 'required|date',
        'end_date'   => 'required|date',
    ];

    public function mount()
    {
        $this->start_date = today()->subDays(30)->format('Y-m-d');
        $this->end_date = today()->format('Y-m-d');
    }

    public function render()
    {
        $adjustments = AdjustedProduct::with(['adjustment'])->whereDate('created_at', '>=', $this->start_date)
            ->whereDate('created_at', '<=', $this->end_date)
            ->orderBy('created_at', 'desc')->paginate(10);
            // dd($adjustments);

        return view('livewire.reports.adjustment-report', [
            'adjustments' => $adjustments
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
        return Excel::download(new AdjustmentExport($this->start_date, $this->end_date),  date('d-M-Y h:i') . ' sales.xlsx');
    }

    public function pdf()
    {
        $this->validate();
        $data = $this->query();

        $company = Setting::first();
        // dd($company->site_logo);

        $pdfContent = PDF::loadView('reports::pdf.adjustments', ['adjustments' => $data['adjustments'], 'company' =>  $company])->output();
        return response()->streamDownload(
            fn () => print($pdfContent),
            Carbon::now() . '-sales.pdf'
        );

        // $pdf = PDF::loadView('reports::pdf.sales', ['data' => $data, 'company' =>  $company]);
        // return $pdf->stream(Carbon::now() . '-sales.pdf');
    }

    public function query()
    {

        $adjustments = AdjustedProduct::with(['adjustment'])->whereDate('created_at', '>=', $this->start_date)
            ->whereDate('created_at', '<=', $this->end_date)
            ->orderBy('created_at', 'desc');


            // $sum = $adjustments->sum('total_amount');
            $adjustments = $adjustments->get();
            return [
                'adjustments' => $adjustments
            ];
    }
}
