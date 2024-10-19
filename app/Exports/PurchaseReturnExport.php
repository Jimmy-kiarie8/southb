<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Modules\PurchasesReturn\Entities\PurchaseReturn;

class PurchaseReturnExport implements FromQuery, WithHeadings, WithMapping
{
    use Exportable;

    public function __construct($suppliers,$start_date,$end_date,$supplier_id,$purchase_return_status,$payment_status)
    {
        $this->suppliers = $suppliers;
        $this->start_date = $start_date;
        $this->end_date = $end_date;
        $this->supplier_id = $supplier_id;
        $this->purchase_return_status = $purchase_return_status;
        $this->payment_status = $payment_status;

    }

    public function headings(): array
    {
        return [
           ['Date', 'Reference', 'Supplier name', 'Status', 'Total', 'Paid', 'Due', 'Payment status', 'Comments']
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
        $query =  PurchaseReturn::whereDate('date', '>=', $this->start_date)
        ->whereDate('date', '<=', $this->end_date)
        ->when($this->supplier_id, function ($query) {
            return $query->where('supplier_id', $this->supplier_id);
        })
        ->when($this->purchase_return_status, function ($query) {
            return $query->where('status', $this->purchase_return_status);
        })
        ->when($this->payment_status, function ($query) {
            return $query->where('payment_status', $this->payment_status);
        })
        ->orderBy('date', 'desc');
        dd($query->get());
        return  $query;
    }
}
