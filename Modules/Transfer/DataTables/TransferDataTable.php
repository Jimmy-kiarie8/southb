<?php

namespace Modules\Transfer\DataTables;

use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Illuminate\Support\Facades\Log;
use Modules\Transfer\Entities\Transfer;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class TransferDataTable extends DataTable
{
    /**
     * Build DataTable class.
     *
     * @param mixed $query Results from query() method.
     * @return \Yajra\DataTables\DataTableAbstract
     */
    public function dataTable($query)
    {
        return datatables()
            ->eloquent($query)
            ->addColumn('action', function ($data) {
                Log::debug($data);
                Log::debug('************************************');
                return view('transfer::transfer.partials.actions', compact('data'));
            })
            ->addColumn('reference', function ($data) {
                return $data->reference;
            })
            // ->addColumn('location.name', function ($data) {
            //     return $data->from_location;
            // })
            // ->addColumn('location_to', function ($data) {
            //     return $data->location_to;
            // })
            // ->addColumn('quantity', function ($data) {
            //     return $data->quantity;
            // })
            ->addColumn('received', function ($data) {
                return $data->received;
            })
            ->rawColumns(['reference']);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \Transfer $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query(Transfer $model)
    {
        return $model->newQuery()->with(['products','location', 'from_location']);
    }

    /**
     * Optional method if you want to use html builder.
     *
     * @return \Yajra\DataTables\Html\Builder
     */
    public function html()
    {
        return $this->builder()
            ->setTableId('transferdatatable-table')
            ->columns($this->getColumns())
            ->minifiedAjax()
            ->dom("<'row'<'col-md-3'l><'col-md-5 mb-2'B><'col-md-4'f>> .
                                'tr' .
                                <'row'<'col-md-5'i><'col-md-7 mt-2'p>>")
            ->orderBy(1)

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

    /**
     * Get columns.
     *
     * @return array
     */
    protected function getColumns()
    {
        return [
            Column::make('reference')
                ->title('Reference')
                ->className('text-left align-middle'),

            // Column::make('product.product_name')
            //     ->title('Product')
            //     ->className('text-left align-middle'),


            Column::make('location.name')
                ->title('From')
                ->className('text-left align-middle'),

            Column::make('from_location.name')
                ->title('To')
                ->className('text-left align-middle'),
            // Column::make('quantity')
            //     ->title('Quantity')
            //     ->className('text-left align-middle'),
            // Column::make('received')
            //     ->title('Received Qty')
            //     ->className('text-left align-middle'),

            Column::make('status')
                ->title('Status')
                ->className('text-left align-middle'),

            Column::make('created_at'),

            Column::computed('action')
                ->exportable(false)
                ->printable(false)
                ->className('text-left align-middle')

        ];
    }


    /**
     * Get filename for export.
     *
     * @return string
     */
    protected function filename(): string
    {
        return 'Transfer_' . date('YmdHis');
    }
}
