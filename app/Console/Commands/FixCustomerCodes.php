<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class FixCustomerCodes extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'sales:fix-customer-codes {--apply : Write the changes (default is a dry run)}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Re-link invoice clientcode and payment customer_code to the customer set on the invoice (customer_id)';

    public function handle()
    {
        $apply = (bool) $this->option('apply');

        $this->info($apply ? 'APPLY MODE: changes will be written.' : 'DRY RUN: no changes will be written. Use --apply to write.');

        $sales = $this->mismatchedSales();
        $this->line('');
        $this->info('Invoices whose clientcode does not match their customer: ' . $sales->count() . ' (KSH ' . number_format($sales->sum('total_amount'), 2) . ')');
        if ($sales->isNotEmpty()) {
            $this->table(
                ['Sale ID', 'Date', 'Invoice', 'Customer', 'Old code', 'New code', 'Amount'],
                $sales->map(fn ($s) => [$s->id, $s->date, $s->reference, $s->customer_name, $s->clientcode ?? 'NULL', $s->new_code, number_format($s->total_amount, 2)])
            );
        }

        $payments = $this->mismatchedPayments($sales);
        $this->line('');
        $this->info('Payments whose customer_code does not match their invoice: ' . $payments->count() . ' (KSH ' . number_format($payments->sum('amount'), 2) . ')');
        if ($payments->isNotEmpty()) {
            $this->table(
                ['Payment ID', 'Date', 'Reference', 'Invoice', 'Customer', 'Old code', 'New code', 'Amount'],
                $payments->map(fn ($p) => [$p->id, $p->date, $p->reference, $p->sale_reference, $p->customer_name, $p->customer_code ?? 'NULL', $p->new_code, number_format($p->amount, 2)])
            );
        }

        $this->reportAnomalies();

        if (!$apply) {
            return 0;
        }

        $fixedAt = now();

        // The first original code is kept if a row is fixed more than once, so sales:revert-customer-codes always restores the true original.
        DB::transaction(function () use ($sales, $payments, $fixedAt) {
            foreach ($sales as $sale) {
                DB::table('sales')->where('id', $sale->id)->update([
                    'clientcode_before_fix' => DB::raw('IF(code_fixed_at IS NULL, clientcode, clientcode_before_fix)'),
                    'code_fixed_at' => DB::raw('COALESCE(code_fixed_at, ' . DB::getPdo()->quote($fixedAt) . ')'),
                    'clientcode' => $sale->new_code,
                ]);
            }
            foreach ($payments as $payment) {
                DB::table('sale_payments')->where('id', $payment->id)->update([
                    'customer_code_before_fix' => DB::raw('IF(code_fixed_at IS NULL, customer_code, customer_code_before_fix)'),
                    'code_fixed_at' => DB::raw('COALESCE(code_fixed_at, ' . DB::getPdo()->quote($fixedAt) . ')'),
                    'customer_code' => $payment->new_code,
                ]);
            }
        });

        $this->line('');
        $this->info("Updated {$sales->count()} invoices and {$payments->count()} payments.");

        return 0;
    }

    private function mismatchedSales()
    {
        return DB::table('sales')
            ->join('customers', 'customers.id', '=', 'sales.customer_id')
            ->whereNull('sales.deleted_at')
            ->whereNotNull('customers.code')
            ->whereRaw('NOT (sales.clientcode <=> customers.code)')
            ->orderBy('sales.date')
            ->get([
                'sales.id', 'sales.date', 'sales.reference', 'sales.clientcode', 'sales.total_amount',
                'customers.customer_name', 'customers.code as new_code',
            ]);
    }

    /**
     * Payments are compared against the invoice's code as it will be after the invoice fix.
     */
    private function mismatchedPayments($mismatchedSales)
    {
        $newSaleCodes = $mismatchedSales->pluck('new_code', 'id');

        return DB::table('sale_payments')
            ->join('sales', 'sales.id', '=', 'sale_payments.sale_id')
            ->leftJoin('customers', 'customers.id', '=', 'sales.customer_id')
            ->whereNull('sale_payments.deleted_at')
            ->orderBy('sale_payments.date')
            ->get([
                'sale_payments.id', 'sale_payments.date', 'sale_payments.reference', 'sale_payments.amount',
                'sale_payments.customer_code', 'sale_payments.sale_id',
                'sales.reference as sale_reference', 'sales.clientcode as sale_code',
                DB::raw('COALESCE(customers.customer_name, sales.customer_name) as customer_name'),
            ])
            ->map(function ($p) use ($newSaleCodes) {
                $p->new_code = $newSaleCodes[$p->sale_id] ?? $p->sale_code;
                return $p;
            })
            ->filter(fn ($p) => $p->new_code !== null && $p->customer_code !== $p->new_code)
            ->values();
    }

    private function reportAnomalies()
    {
        $noCustomer = DB::table('sales')
            ->leftJoin('customers', 'customers.id', '=', 'sales.customer_id')
            ->whereNull('sales.deleted_at')
            ->whereNull('customers.id')
            ->orderBy('sales.date')
            ->get(['sales.id', 'sales.date', 'sales.reference', 'sales.customer_id', 'sales.clientcode', 'sales.customer_name', 'sales.total_amount']);

        $this->line('');
        $this->warn('Needs manual review - invoices with no valid customer_id (not changed): ' . $noCustomer->count());
        if ($noCustomer->isNotEmpty()) {
            $this->table(
                ['Sale ID', 'Date', 'Invoice', 'customer_id', 'clientcode', 'Name', 'Amount'],
                $noCustomer->map(fn ($s) => [$s->id, $s->date, $s->reference, $s->customer_id ?? 'NULL', $s->clientcode ?? 'NULL', $s->customer_name, number_format($s->total_amount, 2)])
            );
        }

        $paymentTotals = DB::table('sale_payments')
            ->whereNull('deleted_at')
            ->groupBy('sale_id')
            ->select('sale_id', DB::raw('SUM(amount) as paid'));

        $mismatchedTotals = DB::table('sales')
            ->leftJoinSub($paymentTotals, 'pt', 'pt.sale_id', '=', 'sales.id')
            ->whereNull('sales.deleted_at')
            ->where(function ($q) {
                $q->whereRaw('COALESCE(pt.paid, 0) <> COALESCE(sales.paid_amount, 0)')
                    ->orWhereRaw('COALESCE(pt.paid, 0) > sales.total_amount');
            })
            ->orderBy('sales.date')
            ->get(['sales.id', 'sales.date', 'sales.reference', 'sales.customer_name', 'sales.total_amount', 'sales.paid_amount', DB::raw('COALESCE(pt.paid, 0) as payments')]);

        $this->line('');
        $this->warn('Needs manual review - invoices where recorded payments differ from paid_amount or exceed the total (not changed): ' . $mismatchedTotals->count());
        if ($mismatchedTotals->isNotEmpty()) {
            $this->table(
                ['Sale ID', 'Date', 'Invoice', 'Customer', 'Total', 'paid_amount', 'Sum of payments'],
                $mismatchedTotals->map(fn ($s) => [$s->id, $s->date, $s->reference, $s->customer_name, number_format($s->total_amount, 2), number_format((float) $s->paid_amount, 2), number_format($s->payments, 2)])
            );
        }
    }
}
