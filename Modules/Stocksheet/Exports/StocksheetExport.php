<?php

namespace Modules\Stocksheet\Exports;

use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithTitle;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class StocksheetExport implements FromCollection, WithHeadings, WithMapping, WithTitle, ShouldAutoSize
{
    use Exportable;

    protected $data;
    protected $title;

    public function __construct($data, $title = 'Stock Sheet')
    {
        $this->data = $data;
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
            'Quantity',
            'Actual Quantity'
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
            $product->product_quantity,
            '' // Actual quantity field (will be empty in the Excel file)
        ];
    }

    public function title(): string
    {
        return $this->title;
    }
}
