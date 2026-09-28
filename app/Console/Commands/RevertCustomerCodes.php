<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class RevertCustomerCodes extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'sales:revert-customer-codes
        {--apply : Write the changes (default is a dry run)}
        {--since= : Only revert rows fixed at or after this date/time, e.g. "2026-09-28 13:00"}
        {--sale=* : Only revert these sale IDs (and their payments)}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Restore invoice clientcode and payment customer_code to the values saved by sales:fix-customer-codes';

    public function handle()
    {
        $apply = (bool) $this->option('apply');
        $since = $this->option('since');
        $saleIds = array_filter((array) $this->option('sale'));

        $this->info($apply ? 'APPLY MODE: changes will be written.' : 'DRY RUN: no changes will be written. Use --apply to write.');

        $sales = DB::table('sales')
            ->whereNotNull('code_fixed_at')
            ->when($since, fn ($q) => $q->where('code_fixed_at', '>=', $since))
            ->when($saleIds, fn ($q) => $q->whereIn('id', $saleIds))
            ->orderBy('date')
            ->get(['id', 'date', 'reference', 'customer_name', 'clientcode', 'clientcode_before_fix', 'code_fixed_at', 'total_amount']);

        $payments = DB::table('sale_payments')
            ->join('sales', 'sales.id', '=', 'sale_payments.sale_id')
            ->whereNotNull('sale_payments.code_fixed_at')
            ->when($since, fn ($q) => $q->where('sale_payments.code_fixed_at', '>=', $since))
            ->when($saleIds, fn ($q) => $q->whereIn('sale_payments.sale_id', $saleIds))
            ->orderBy('sale_payments.date')
            ->get([
                'sale_payments.id', 'sale_payments.date', 'sale_payments.reference', 'sales.reference as sale_reference',
                'sale_payments.customer_code', 'sale_payments.customer_code_before_fix', 'sale_payments.code_fixed_at', 'sale_payments.amount',
            ]);

        $this->line('');
        $this->info('Invoices to restore: ' . $sales->count());
        if ($sales->isNotEmpty()) {
            $this->table(
                ['Sale ID', 'Date', 'Invoice', 'Customer', 'Current code', 'Restore to', 'Fixed at', 'Amount'],
                $sales->map(fn ($s) => [$s->id, $s->date, $s->reference, $s->customer_name, $s->clientcode ?? 'NULL', $s->clientcode_before_fix ?? 'NULL', $s->code_fixed_at, number_format($s->total_amount, 2)])
            );
        }

        $this->line('');
        $this->info('Payments to restore: ' . $payments->count());
        if ($payments->isNotEmpty()) {
            $this->table(
                ['Payment ID', 'Date', 'Reference', 'Invoice', 'Current code', 'Restore to', 'Fixed at', 'Amount'],
                $payments->map(fn ($p) => [$p->id, $p->date, $p->reference, $p->sale_reference, $p->customer_code ?? 'NULL', $p->customer_code_before_fix ?? 'NULL', $p->code_fixed_at, number_format($p->amount, 2)])
            );
        }

        if (!$apply) {
            return 0;
        }

        DB::transaction(function () use ($sales, $payments) {
            DB::table('sales')->whereIn('id', $sales->pluck('id'))->update([
                'clientcode' => DB::raw('clientcode_before_fix'),
                'clientcode_before_fix' => null,
                'code_fixed_at' => null,
            ]);
            DB::table('sale_payments')->whereIn('id', $payments->pluck('id'))->update([
                'customer_code' => DB::raw('customer_code_before_fix'),
                'customer_code_before_fix' => null,
                'code_fixed_at' => null,
            ]);
        });

        $this->line('');
        $this->info("Restored {$sales->count()} invoices and {$payments->count()} payments.");
        $this->warn('Note: saving a restored invoice through the app will re-sync its code from its customer.');

        return 0;
    }
}
