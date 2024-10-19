<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Modules\Purchase\Entities\PurchasePayment;
use Modules\PurchasesReturn\Entities\PurchaseReturnPayment;
use Modules\Sale\Entities\SalePayment;
use Modules\SalesReturn\Entities\SaleReturnPayment;

class PaymentExport implements FromQuery, WithHeadings, WithMapping
{
    use Exportable;

    public function __construct($start_date, $end_date, $payment_method, $payments)
    {
        $this->start_date = $start_date;
        $this->end_date = $end_date;
        $this->payment_method = $payment_method;
        $this->payments = $payments;
    }

    public function headings(): array
    {
        return [
           ['Date', 'Reference', 'Order number', 'Customer name', 'Amount', 'Payment method','Payment status', 'Comments']
        ];
    }

    public function map($payment): array
    {
        return [
            $payment->date,
            $payment->reference,
            $payment->sale->reference,
            $payment->sale->customer_name,
            $payment->sale->amount,
            $payment->payment_method,
            $payment->sale->payment_status,
            $payment->note
        ];
    }

    public function query()
    {

        if ($this->payments == 'sale') {
            $query = SalePayment::query()->with('sale');
        } elseif ($this->payments == 'sale_return') {
            $query = SaleReturnPayment::query()->with('saleReturn');
        } elseif ($this->payments == 'purchase') {
            $query = PurchasePayment::query()->with('purchase');
        } elseif ($this->payments == 'purchase_return') {
            $query = PurchaseReturnPayment::query()->with('purchaseReturn');
        } else {
            $query = null;
        }

        $query = ($query) ? $query : SalePayment::query();

        $query = $query->when($this->start_date, function ($query) {
            return $query->whereDate('date', '>=', $this->start_date);
        })
        ->when($this->end_date, function ($query) {
            return $query->whereDate('date', '<=', $this->end_date);
        })
        ->when($this->payment_method, function ($query) {
            return $query->where('payment_method', $this->payment_method);
        });
        // dd($query->get());
        return  $query;
    }
}
