<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Modules\Sale\Entities\Sale;

class SaleExport implements FromQuery, WithHeadings, WithMapping
{
    use Exportable;

    public function __construct($customers,$start_date,$end_date,$customer_id,$sale_status,$payment_status)
    {
        $this->customers = $customers;
        $this->start_date = $start_date;
        $this->end_date = $end_date;
        $this->customer_id = $customer_id;
        $this->sale_status = $sale_status;
        $this->payment_status = $payment_status;

    }

    public function headings(): array
    {
        return [
           ['Date', 'Reference', 'Customer name', 'Status', 'Total', 'Paid', 'Due', 'Payment status', 'Comments']
        ];
    }

    public function map($sale): array
    {
        return [
            $sale->date,
            $sale->reference,
            $sale->customer_name,
            $sale->status,
            $sale->total_amount,
            $sale->paid_amount,
            $sale->due_amount,
            $sale->payment_status,
            $sale->note
        ];
    }

    public function query()
    {
        $query =  Sale::whereDate('date', '>=', $this->start_date)
        ->whereDate('date', '<=', $this->end_date)
        ->when($this->customer_id, function ($query) {
            return $query->where('customer_id', $this->customer_id);
        })
        ->when($this->sale_status, function ($query) {
            return $query->where('status', $this->sale_status);
        })
        ->when($this->payment_status, function ($query) {
            return $query->where('payment_status', $this->payment_status);
        })
        ->orderBy('date', 'desc');

        // dd($query->get());
        return  $query;
    }
}
