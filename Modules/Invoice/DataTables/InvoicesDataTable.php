<?php

namespace Modules\Invoice\DataTables;

use Modules\Invoice\Entities\Invoice;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class InvoicesDataTable extends DataTable
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
                return view('invoice::invoices.partials.actions', compact('data'));
            })
            ->addColumn('invoice_no', function ($data) {
                return $data->invoice_no;
            })
            ->addColumn('amount', function ($data) {
                return format_currency($data->amount);
            })
            ->addColumn('balance', function ($data) {
                return format_currency($data->balance);
            })
            ->addColumn('customer_name', function ($data) {
                return $data->customer_name;
            })
            ->addColumn('status', function ($data) {
                return view('invoice::invoices.partials.status', compact('data'));
            })
            ->rawColumns(['invoice_no']);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \Invoice $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query(Invoice $model)
    {
        return $model->newQuery()->with('sale');
    }

    /**
     * Optional method if you want to use html builder.
     *
     * @return \Yajra\DataTables\Html\Builder
     */
    public function html()
    {
        return $this->builder()
            ->setTableId('invoicesdatatable-table')
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
            Column::computed('invoice_no')
                ->title('Invoice')
                ->className('text-left align-middle'),

            // Column::make('sale.customer_name')
            //     ->title('Customer name')
            //     ->className('text-left align-middle'),

            Column::make('amount')
                ->title('Amount')
                ->className('text-left align-middle'),

            Column::make('balance')
                ->title('Amount due')
                ->className('text-left align-middle'),

                Column::make('customer_name')
                ->title('Customer Name')
                ->className('text-left align-middle'),

            Column::make('status')
                ->title('Status')
                ->className('text-left align-middle'),

            Column::make('created_at')
                ->title('Invoice date')
                ->className('text-left align-middle'),

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
    // protected function filename()
    // {
    //     return 'Invoices_' . date('YmdHis');
    // }
}
