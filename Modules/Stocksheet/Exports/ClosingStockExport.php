<?php

namespace Modules\Stocksheet\Exports;

use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithTitle;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithCustomStartCell;
use Maatwebsite\Excel\Concerns\WithStyles;
use Maatwebsite\Excel\Events\AfterSheet;
use Maatwebsite\Excel\Events\BeforeExport;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ClosingStockExport implements FromCollection, WithHeadings, WithMapping, WithTitle, ShouldAutoSize, WithStyles, WithCustomStartCell
{
    use Exportable;

    protected $data;
    protected $title;
    protected $total;
    protected $company;
    protected $asOfDate;

    public function __construct($data, $total, $company, $asOfDate, $title = 'Closing Stock')
    {
        $this->data = $data;
        $this->total = $total;
        $this->company = $company;
        $this->asOfDate = $asOfDate;
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
            $product->qty . ' ' . $product->product_unit,
            $product->qty * $product->product_cost
        ];
    }

    public function title(): string
    {
        return $this->title;
    }

    public function styles(Worksheet $sheet)
    {
        return [
            // Style the title row
            1 => ['font' => ['bold' => true, 'size' => 16]],
            // Style the company info
            2 => ['font' => ['bold' => true]],
            3 => ['font' => ['bold' => true]],
            // Style the headers row
            6 => ['font' => ['bold' => true]],
            // Last row with total
            $this->data->count() + 7 => ['font' => ['bold' => true]]
        ];
    }

    public function startCell(): string
    {
        return 'A1';
    }

    public function registerEvents(): array
    {
        return [
            BeforeExport::class => function(BeforeExport $event) {
                $event->writer->getProperties()
                    ->setTitle($this->title)
                    ->setSubject("Closing Stock Report")
                    ->setDescription("Closing Stock Report as of " . $this->asOfDate)
                    ->setCompany($this->company->company_name);
            },

            AfterSheet::class => function(AfterSheet $event) {
                // Add title and company information
                $event->sheet->setCellValue('A1', $this->title);
                $event->sheet->setCellValue('A2', $this->company->company_name);
                $event->sheet->setCellValue('A3', "Report Date: " . $this->asOfDate);

                // Add a total row at the bottom
                $lastRow = $this->data->count() + 7;
                $event->sheet->setCellValue('E' . $lastRow, 'Total');
                $event->sheet->setCellValue('G' . $lastRow, $this->total);
            },
        ];
    }
}
