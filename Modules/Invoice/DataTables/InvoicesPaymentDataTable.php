<?php

namespace Modules\Invoice\DataTables;

use Modules\Invoice\Entities\Invoice;
use Modules\Invoice\Entities\InvoicePayment;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class InvoicesPaymentDataTable extends DataTable
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
            ->eloquent($query)->with('invoice')
            ->addColumn('action', function ($data) {
                return view('invoice::payments.partials.actions', compact('data'));
            })
            ->addColumn('invoice_id', function ($data) {
                return $data->invoice_id;
            })
            ->addColumn('amount', function ($data) {
                return format_currency($data->amount);
            })
            ->addColumn('invoice.status', function ($invoice) {
                // dd($data->invoice->status);
                $data = $invoice->invoice;
                return view('invoice::invoices.partials.status', compact('data'));
            })
            ->addColumn('notes', function ($data) {
                return $data->notes;
            })
            ->rawColumns(['invoice_id']);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \InvoicePayment $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query(InvoicePayment $model)
    {
        // dd(request()->invoice_no);

        $invoice = Invoice::where('invoice_no', request()->invoice_no)->first();
        $model = $model->newQuery()->with('invoice');

        if (request()->invoice_no) {
            $model =  $model->where('invoice_id', $invoice->id);
        }

        return $model;

    }

    /**
     * Optional method if you want to use html builder.
     *
     * @return \Yajra\DataTables\Html\Builder
     */
    public function html()
    {
        return $this->builder()
            ->setTableId('invoicespaymentdatatable-table')
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

            Column::make('invoice.invoice_no')
                ->title('Invoice no')
                ->className('text-left align-middle'),

            Column::make('amount')
                ->title('Amount')
                ->className('text-left align-middle'),

            Column::make('invoice.status')
                ->title('Invoice status')
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
    // protected function filename()
    // {
    //     return 'InvoicesPayment_' . date('YmdHis');
    // }
}
