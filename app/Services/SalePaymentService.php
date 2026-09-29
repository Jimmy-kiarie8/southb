<?php

namespace App\Services;

use Illuminate\Support\Collection;
use Modules\Invoice\Entities\Invoice;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SalePayment;

class SalePaymentService
{
    /**
     * Record a payment against a single sale and update the sale and its invoice.
     * Expects to run inside a DB transaction.
     */
    public function applyToSale(Sale $sale, float $amount, array $data): SalePayment
    {
        $payment = SalePayment::create([
            'date' => $data['date'],
            'reference' => $data['reference'],
            'amount' => $amount,
            'note' => $data['note'] ?? null,
            'sale_id' => $sale->id,
            'customer_code' => $sale->clientcode,
            'payment_method' => $data['payment_method'],
        ]);

        $due_amount = $sale->due_amount - $amount;

        if ($due_amount == $sale->total_amount) {
            $payment_status = 'Unpaid';
        } elseif ($due_amount > 0) {
            $payment_status = 'Partial';
        } else {
            $payment_status = 'Paid';
        }

        $sale->update([
            'paid_amount' => $sale->paid_amount + $amount,
            'due_amount' => $due_amount,
            'payment_status' => $payment_status,
        ]);

        $invoice = Invoice::where('sale_id', $sale->id)->first();

        if ($invoice) {
            $invoice->balance -= $amount;
            $invoice->status = ($invoice->balance <= 0) ? 'Paid' : 'Partially paid';
            $invoice->save();
        }

        return $payment;
    }

    /**
     * Split an amount across sales, oldest first, never exceeding each sale's due amount.
     *
     * @return array<int, float> sale id => amount
     */
    public function allocate(float $amount, Collection $sales): array
    {
        $allocations = [];

        foreach ($sales->sortBy([['date', 'asc'], ['id', 'asc']]) as $sale) {
            if ($amount <= 0) {
                break;
            }

            $to_pay = min($amount, (float) $sale->due_amount);

            if ($to_pay > 0) {
                $allocations[$sale->id] = $to_pay;
                $amount -= $to_pay;
            }
        }

        return $allocations;
    }
}
