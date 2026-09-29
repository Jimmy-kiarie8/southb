<?php

namespace App\Http\Livewire\Sale;

use App\Services\SalePaymentService;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Livewire\Component;
use Modules\People\Entities\Customer;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleBulkPayment;
use Modules\Sale\Entities\SalePayment;

class ClientBalance extends Component
{
    public $customers;
    public $customer_id = '';
    public $start_date;
    public $end_date;
    public $status = '';

    public $selected = [];
    public $amounts = [];
    public $lump_sum;
    public $payment_date;
    public $payment_method = 'Cash';
    public $code;
    public $note;

    public $paymentMethods = ['Cash', 'Mpesa', 'Cheque', 'KCB', 'Equity', 'PDQ'];

    public function mount($customers)
    {
        $this->customers = $customers;
        $this->start_date = today()->subDays(30)->format('Y-m-d');
        $this->end_date = today()->format('Y-m-d');
        $this->payment_date = today()->format('Y-m-d');
    }

    public function updated($property)
    {
        if (in_array($property, ['customer_id', 'start_date', 'end_date', 'status'])) {
            $this->resetAllocation();
        }
    }

    public function updatedSelected()
    {
        $sales = $this->unpaidSales()->keyBy('id');
        $this->selected = array_values(array_filter($this->selected, fn ($id) => $sales->has($id)));

        foreach ($sales as $id => $sale) {
            if (!in_array($id, $this->selected)) {
                unset($this->amounts[$id]);
            } elseif (empty($this->amounts[$id])) {
                $this->amounts[$id] = (int) $sale->due_amount;
            }
        }
    }

    public function toggleAll()
    {
        $sales = $this->unpaidSales();

        if (count($this->selected) === $sales->count()) {
            $this->resetAllocation();
            return;
        }

        $this->selected = $sales->pluck('id')->all();
        foreach ($sales as $sale) {
            if (empty($this->amounts[$sale->id])) {
                $this->amounts[$sale->id] = (int) $sale->due_amount;
            }
        }
    }

    public function updatedAmounts($value, $key)
    {
        if ($value !== '' && $value !== null && !in_array($key, $this->selected)) {
            $this->selected[] = (int) $key;
        }
    }

    public function autoAllocate(SalePaymentService $service)
    {
        $this->validate(['lump_sum' => 'required|integer|min:1'], [], ['lump_sum' => 'lump sum']);

        $sales = $this->unpaidSales();

        if (!empty($this->selected)) {
            $sales = $sales->whereIn('id', $this->selected);
        }

        $allocations = $service->allocate((float) $this->lump_sum, $sales);

        $this->amounts = array_map('intval', $allocations);
        $this->selected = array_keys($allocations);
    }

    public function save(SalePaymentService $service)
    {
        abort_if(Gate::denies('access_sale_payments'), 403);

        $this->validate([
            'customer_id' => 'required|exists:customers,id',
            'payment_date' => 'required|date',
            'payment_method' => 'required|string|max:255',
            'code' => 'nullable|string|max:255',
            'note' => 'nullable|string|max:1000',
            'lump_sum' => 'nullable|integer|min:1',
            'amounts.*' => 'nullable|integer|min:0',
        ], [], ['amounts.*' => 'amount']);

        $allocations = collect($this->amounts)
            ->only($this->selected)
            ->map(fn ($amount) => (int) $amount)
            ->filter(fn ($amount) => $amount > 0);

        $total = $allocations->sum();

        if ($total <= 0) {
            $this->addError('amounts', 'Enter an amount for at least one selected sale.');
            return;
        }

        if ($this->lump_sum && $total > (int) $this->lump_sum) {
            $this->addError('lump_sum', 'Allocated total (' . format_currency($total) . ') is more than the lump sum.');
            return;
        }

        $customer = Customer::findOrFail($this->customer_id);
        $failed = false;

        DB::transaction(function () use ($service, $customer, $allocations, $total, &$failed) {
            $sales = Sale::where($this->forCustomer($customer))
                ->whereIn('id', $allocations->keys())
                ->lockForUpdate()
                ->get()
                ->keyBy('id');

            foreach ($allocations as $sale_id => $amount) {
                $sale = $sales->get($sale_id);
                if (!$sale || $amount > $sale->due_amount) {
                    $reference = $sale ? $sale->reference : "#{$sale_id}";
                    $this->addError('amounts.' . $sale_id, "Amount for {$reference} is more than its due amount.");
                    $failed = true;
                    return;
                }
            }

            $bulk = SaleBulkPayment::create([
                'client_id' => $customer->id,
                'payment_method' => $this->payment_method,
                'amount' => $total,
                'code' => $this->code,
                'date' => $this->payment_date,
            ]);

            $note = collect([$this->code, $this->note])->filter()->implode(' - ');

            foreach ($allocations as $sale_id => $amount) {
                $service->applyToSale($sales->get($sale_id), $amount, [
                    'date' => $this->payment_date,
                    'reference' => $bulk->reference,
                    'note' => $note,
                    'payment_method' => $this->payment_method,
                ]);
            }

            session()->flash('message', 'Payment ' . $bulk->reference . ' of ' . format_currency($total) . ' recorded.');
        });

        if ($failed) {
            return;
        }

        $this->resetAllocation();
        $this->reset(['lump_sum', 'code', 'note']);
    }

    public function render()
    {
        $customer = $this->customer_id ? Customer::find($this->customer_id) : null;

        return view('livewire.sale.client-balance', [
            'customer' => $customer,
            'sales' => $customer ? $this->unpaidSales() : collect(),
            'statement' => $customer ? $this->statement($customer) : null,
            'allocated' => collect($this->amounts)->only($this->selected)->map(fn ($a) => (int) $a)->sum(),
        ]);
    }

    private function resetAllocation()
    {
        $this->selected = [];
        $this->amounts = [];
        $this->resetErrorBag();
    }

    private function unpaidSales()
    {
        $customer = Customer::find($this->customer_id);

        if (!$customer || !$this->start_date || !$this->end_date) {
            return collect();
        }

        return Sale::where($this->forCustomer($customer))
            ->where('due_amount', '>', 0)
            ->whereDate('date', '>=', $this->start_date)
            ->whereDate('date', '<=', $this->end_date)
            ->when($this->status, fn ($query) => $query->where('payment_status', $this->status))
            ->orderBy('date')
            ->orderBy('id')
            ->get();
    }

    private function statement(Customer $customer)
    {
        if (!$this->start_date || !$this->end_date) {
            return null;
        }

        $start = Carbon::parse($this->start_date)->startOfDay();

        $opening = Sale::where($this->forCustomer($customer))->whereDate('date', '<', $start)->sum('total_amount')
            - SalePayment::whereDate('date', '<', $start)->whereHas('sale', $this->forCustomer($customer))->sum('amount');

        $sales = Sale::where($this->forCustomer($customer))
            ->whereDate('date', '>=', $this->start_date)
            ->whereDate('date', '<=', $this->end_date)
            ->sum('total_amount');

        $payments = SalePayment::whereDate('date', '>=', $this->start_date)
            ->whereDate('date', '<=', $this->end_date)
            ->whereHas('sale', $this->forCustomer($customer))
            ->sum('amount');

        return [
            'opening' => $opening,
            'sales' => $sales,
            'payments' => $payments,
            'closing' => $opening + $sales - $payments,
            'outstanding' => Sale::where($this->forCustomer($customer))->where('due_amount', '>', 0)->sum('due_amount'),
        ];
    }

    /**
     * Sales belong to a customer by customer_id; clientcode is only used for older sales that have no customer_id.
     */
    private function forCustomer($customer)
    {
        return function ($query) use ($customer) {
            $query->where('customer_id', $customer->id)
                ->orWhere(function ($q) use ($customer) {
                    $q->whereNull('customer_id')->where('clientcode', $customer->code);
                });
        };
    }
}
