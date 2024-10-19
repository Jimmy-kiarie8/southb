<?php

namespace App\DataTables;

use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Modules\Branch\Entities\Branch;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class BranchDataTable extends DataTable
{
    public function dataTable($query) {
        return datatables()
            ->eloquent($query)

            // ->addColumn('action', function ($data) {
            //     return view('user::users.partials.actions', compact('data'));
            // })

            ->addColumn('name', function ($data) {
                return $data->name;
            })
            ->addColumn('location', function ($data) {
                return $data->location;
            })
            ->rawColumns(['name']);
    }

    public function query(Branch $model) {
        return $model->newQuery();
    }


    public function html() {
        return $this->builder()
            ->setTableId('branches-table')
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

    protected function getColumns() {
        return [
            Column::make('name')
                ->className('text-center align-middle'),

            Column::make('location')
                ->className('text-center align-middle'),

            Column::make('created_at')
                ->visible(false)
        ];
    }

}
