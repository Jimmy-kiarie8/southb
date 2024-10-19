<?php

namespace Modules\Sale\DataTables;

use Modules\Sale\Entities\CloseDay;
use Modules\Sale\Entities\Sale;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class CloseDataTable extends DataTable
{

    public function dataTable($query)
    {
        return datatables()
            ->eloquent($query)
            ->addColumn('action', function ($data) {
                return view('sale::close.actions', compact('data'));
            });;
    }

    public function query(CloseDay $model)
    {
        return $model->newQuery();
    }

    public function html()
    {
        return $this->builder()
            ->setTableId('sales-table')
            ->columns($this->getColumns())
            ->minifiedAjax()
            ->dom("<'row'<'col-md-3'l><'col-md-5 mb-2'B><'col-md-4'f>> .
                                'tr' .
                                <'row'<'col-md-5'i><'col-md-7 mt-2'p>>")
            ->orderBy(8)
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

    protected function getColumns()
    {
        return [
            Column::make('reference')
                ->className('text-left align-middle'),

                Column::make('created_at')
                // Column::make('created_at')
                ->title('Date'),

            // Column::make('total')
            //     ->title('Total Cash Sold')
            //     ->className('text-left align-middle'),

                Column::make('cash')
                ->title('Cash')
                ->className('text-left align-middle'),

            Column::make('cb1')
                ->title('CB1')
                ->className('text-left align-middle'),

            Column::make('cb2')
                ->title('CB2')
                ->className('text-left align-middle'),

            Column::make('kcb')
                ->title('KCB')
                ->className('text-left align-middle'),

            Column::make('equity')
                ->title('Equity')
                ->className('text-left align-middle'),


            Column::make('credit')
                ->title('Credit')
                ->className('text-left align-middle'),


            Column::computed('action')
                ->exportable(false)
                ->printable(false)
                ->className('text-left align-middle')

        ];
    }

    public function filename(): string
    {
        return 'Sales_' . date('YmdHis');
    }
}
