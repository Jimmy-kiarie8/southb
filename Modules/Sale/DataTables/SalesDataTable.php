<?php

namespace Modules\Sale\DataTables;

use Modules\Sale\Entities\Sale;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class SalesDataTable extends DataTable
{

    public function dataTable($query) {
        return datatables()
            ->eloquent($query)
            ->addColumn('total_amount', function ($data) {
                return format_currency($data->total_amount);
            })
            ->addColumn('paid_amount', function ($data) {
                return format_currency($data->paid_amount);
            })
            ->addColumn('due_amount', function ($data) {
                return format_currency($data->due_amount);
            })
            ->addColumn('status', function ($data) {
                return view('sale::partials.status', compact('data'));
            })
            ->addColumn('payment_status', function ($data) {
                return view('sale::partials.payment-status', compact('data'));
            })
            ->addColumn('action', function ($data) {
                return view('sale::partials.actions', compact('data'));
            });
    }

    public function query(Sale $model) {
        $status = request('payment_status');
        return $model->orderBy('date', 'DESC')->when($status, function ($q) use($status) {
            return $q->where('payment_status', $status);
        })->newQuery();
    }

    public function html() {
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

    protected function getColumns() {
        return [
            Column::make('reference')
                ->className('text-left align-middle'),

            // Column::make('order_no')
            //     ->title('D Note No.')
            //     ->className('text-left align-middle'),

            Column::make('customer_name')
                ->title('Customer')
                ->className('text-left align-middle'),

            Column::make('date')
            // Column::make('created_at')
                ->title('Date'),
            Column::computed('status')
                ->className('text-left align-middle'),

            Column::computed('total_amount')
                ->className('text-left align-middle'),

            Column::computed('paid_amount')
                ->className('text-left align-middle'),

            Column::computed('due_amount')
                ->className('text-left align-middle'),

            Column::computed('payment_status')
                ->className('text-left align-middle'),

            Column::computed('cu_inv_no')
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
