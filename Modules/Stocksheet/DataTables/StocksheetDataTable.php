<?php

namespace Modules\Stocksheet\DataTables;

use Modules\Product\Entities\Product;
use Modules\Stocksheet\Entities\Stocksheet;
use Nwidart\Modules\Publishing\Publisher;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class StocksheetDataTable extends DataTable
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
            ->eloquent($query)->with('category')
            ->addColumn('action', function ($data) {
                return view('product::products.partials.actions', compact('data'));
            })
            // ->addColumn('product_image', function ($data) {
            //     $url = $data->getFirstMediaUrl('images', 'thumb');
            //     return '<img src="' . $url . '" border="0" width="50" class="img-thumbnail" align="center"/>';
            // })
            ->addColumn('product_cost', function ($data) {
                return format_currency($data->product_cost);
            })
            ->addColumn('product_price', function ($data) {
                return format_currency($data->product_price);
            })
            ->addColumn('product_quantity', function ($data) {
                return $data->product_quantity . ' ' . $data->product_unit;
            })
            ->addColumn('product_stock_alert', function ($data) {
                return $data->product_stock_alert . ' ' . $data->product_unit;
            })
            ->rawColumns(['product_image']);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \Stocksheet $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    // public function query(Stocksheet $model)
    // {
    //     return $model->newQuery()->current()->with('product');
    // }


    public function query(Product $model)
    {
        return $model->newQuery()->with('category');
    }


    /**
     * Optional method if you want to use html builder.
     *
     * @return \Yajra\DataTables\Html\Builder
     */
    public function html()
    {
        return $this->builder()
            ->setTableId('stocksheetdatatable-table')
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
            // Column::computed('product_image')
            //     ->title('Image')
            //     ->className('text-left align-middle'),

            Column::make('category.category_name')
                ->title('Category')
                ->className('text-left align-middle'),

            Column::make('product_name')
                ->title('Name')
                ->className('text-left align-middle'),

            Column::make('product_code')
                ->title('Code')
                ->className('text-left align-middle'),

            Column::computed('product_cost')
                ->title('Cost')
                ->className('text-left align-middle'),

            Column::computed('product_price')
                ->title('Price')
                ->className('text-left align-middle'),

            Column::computed('product_quantity')
                ->title('Quantity')
                ->className('text-left align-middle'),


            Column::computed('product_stock_alert')
                ->title('Restock level')
                ->className('text-left align-middle'),

            Column::computed('action')
                ->exportable(false)
                ->printable(false)
                ->className('text-left align-middle'),

            Column::make('created_at')
                ->visible(false)
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
