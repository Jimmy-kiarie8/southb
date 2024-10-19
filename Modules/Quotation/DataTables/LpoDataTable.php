<?php

namespace Modules\Quotation\DataTables;

use App\Models\Quotation;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Modules\Quotation\Entities\Lpo;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class LpoDataTable extends DataTable
{


    public function dataTable($query) {
        return datatables()
            ->eloquent($query)
            ->addColumn('total_amount', function ($data) {
                return format_currency($data->total_amount);
            })
            ->addColumn('status', function ($data) {
                return view('quotation::lpo.partials.status', compact('data'));
            })
            ->addColumn('action', function ($data) {
                return view('quotation::lpo.partials.actions', compact('data'));
            });
    }

    public function query(Lpo $model) {
        return $model->newQuery();
    }

    public function html() {
        return $this->builder()
            ->setTableId('sales-table')
            ->columns($this->getColumns())
            ->minifiedAjax()
            ->dom("<'row'<'col-md-3'l><'col-md-5 mb-2'B><'col-md-4'f>> .
                                'tr' .
                                <'row'<'col-md-5'i><'col-md-7 mt-2'p>>")
            ->orderBy(6)
            ->buttons(
                Button::make('excel')
                    ->text('<i class="bi bi-file-earmark-excel-fill"></i> Excel'),
                Button::make('print')
                    ->text('<i class="bi bi-printer-fill"></i> Print'),
                Button::make('reset')
                    ->text('<i class="bi bi-x-circle"></i> Reset'),
                Button::make('reload')
                    ->text('<i class="bi bi-arrow-repeat"></i> Reload')
            );
    }

    protected function getColumns() {
        return [
            Column::make('date')
                ->className('text-left align-middle'),

            Column::make('reference')
                ->className('text-left align-middle'),

            Column::make('supplier_name')
                ->title('Customer')
                ->className('text-left align-middle'),

            Column::computed('status')
                ->className('text-left align-middle'),

            Column::computed('total_amount')
                ->className('text-left align-middle'),

            Column::computed('action')
                ->exportable(false)
                ->printable(false)
                ->className('text-left align-middle'),

            Column::make('created_at')
                ->visible(false)
        ];
    }

}
