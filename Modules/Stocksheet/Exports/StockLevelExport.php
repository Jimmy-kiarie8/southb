<?php

namespace Modules\Stocksheet\Exports;

use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithTitle;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class StockLevelExport implements FromCollection, WithHeadings, WithMapping, WithTitle, ShouldAutoSize
{
    use Exportable;

    protected $data;
    protected $title;
    protected $total;

    public function __construct($data, $total, $title = 'Stock Level')
    {
        $this->data = $data;
        $this->total = $total;
        $this->title = $title;
    }

    public function collection()
    {
        return $this->data;
    }

    public function headings(): array
    {
        return [
            '#',
            'Product Name',
            'Code',
            'Cost Price',
            'Selling Price',
            'Quantity',
            'Value'
        ];
    }

    public function map($product): array
    {
        static $i = 0;
        $i++;

        return [
            $i,
            $product->product_name,
            $product->product_code,
            $product->product_cost,
            $product->product_price,
            $product->product_quantity . ' ' . $product->product_unit,
            $product->product_quantity * $product->product_cost
        ];
    }

    public function title(): string
    {
        return $this->title;
    }
}
