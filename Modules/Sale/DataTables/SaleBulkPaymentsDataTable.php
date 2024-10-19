<?php

namespace Modules\Sale\DataTables;

use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleBulkPayment;
use Modules\Sale\Entities\SalePayment;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class SaleBulkPaymentsDataTable extends DataTable
{

    public function dataTable($query) {
        return datatables()
            ->eloquent($query)
            ->addColumn('amount', function ($data) {
                return format_currency($data->amount);
            })
            ->addColumn('customer', function ($data) {
                return $data->customer->customer_name;
            })
            ->addColumn('action', function ($data) {
                return view('sale::payments.partials.bulk-actions', compact('data'));
            });
    }

    public function query(SaleBulkPayment $model) {
        return $model->newQuery()->with('payments');
    }

    public function html() {
        return $this->builder()
            ->setTableId('sale-payments-table')
            ->columns($this->getColumns())
            ->minifiedAjax()
            ->dom("<'row'<'col-md-3'l><'col-md-5 mb-2'B><'col-md-4'f>> .
                                'tr' .
                                <'row'<'col-md-5'i><'col-md-7 mt-2'p>>")
            ->orderBy(5)
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
                ->className('align-middle text-left'),

            Column::make('reference')
                ->className('align-middle text-left'),

            Column::computed('amount')
                ->className('align-middle text-left'),

            Column::make('payment_method')
                ->className('align-middle text-left'),

            Column::make('customer')
                ->className('align-middle text-left'),

            Column::computed('action')
                ->exportable(false)
                ->printable(false)
                ->className('align-middle text-left'),

            Column::make('created_at')
                ->visible(false),
        ];
    }

    public function filename(): string
    {
        return 'SalePayments_' . date('YmdHis');
    }
}
