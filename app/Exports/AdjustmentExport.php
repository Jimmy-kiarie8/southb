<?php

namespace App\Exports;

use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Modules\Adjustment\Entities\AdjustedProduct;
use Modules\Sale\Entities\Sale;

class AdjustmentExport implements FromQuery, WithHeadings, WithMapping
{
    use Exportable;

    public $start_date, $end_date;

    public function __construct($start_date,$end_date)
    {
        $this->start_date = $start_date;
        $this->end_date = $end_date;

    }

    public function headings(): array
    {
        return [
           ['Product', 'Date', 'Reference', 'Type', 'Quantity']
        ];
    }

    public function map($adjustment): array
    {
        return [
            $adjustment->product->product_name,
            Carbon::parse($adjustment->created_at)->format('d-m-y'),
            $adjustment->adjustment->reference,
            $adjustment->type,
            $adjustment->quantity
        ];
    }

    public function query()
    {
        $query = AdjustedProduct::with(['adjustment'])->whereDate('created_at', '>=', $this->start_date)
            ->whereDate('created_at', '<=', $this->end_date)
            ->orderBy('created_at', 'desc');

        // dd($query->get());
        return  $query;
    }
}
