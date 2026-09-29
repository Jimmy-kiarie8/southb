<div>
    @if (session()->has('message'))
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            {{ session('message') }}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    @endif

    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <div class="form-row">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Client <span class="text-danger">*</span></label>
                                <select wire:model="customer_id" class="form-control">
                                    <option value="">Select client</option>
                                    @foreach ($customers as $c)
                                        <option value="{{ $c->id }}">{{ $c->customer_name }} {{ $c->code ? '(' . $c->code . ')' : '' }}</option>
                                    @endforeach
                                </select>
                                @error('customer_id')
                                    <span class="text-danger mt-1">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>Start Date <span class="text-danger">*</span></label>
                                <input wire:model="start_date" type="date" class="form-control">
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>End Date <span class="text-danger">*</span></label>
                                <input wire:model="end_date" type="date" class="form-control">
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="form-group">
                                <label>Status</label>
                                <select wire:model="status" class="form-control">
                                    <option value="">All outstanding</option>
                                    <option value="Unpaid">Unpaid</option>
                                    <option value="Partial">Partial</option>
                                    <option value="Credit">Credit</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    @if ($customer && $statement)
        <div class="row">
            @foreach ([
                'Opening Balance' => $statement['opening'],
                'Sales in Period' => $statement['sales'],
                'Payments in Period' => $statement['payments'],
                'Closing Balance' => $statement['closing'],
                'Outstanding (Listed)' => $sales->sum('due_amount'),
                'Outstanding (All Dates)' => $statement['outstanding'],
            ] as $label => $value)
                <div class="col-md-4 col-lg-2">
                    <div class="card border-0 shadow-sm mb-3">
                        <div class="card-body p-3">
                            <div class="text-muted small">{{ $label }}</div>
                            <div class="h5 mb-0 font-weight-bold">{{ format_currency($value) }}</div>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>

        <div class="row">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-body position-relative">
                        <div wire:loading.flex
                            class="position-absolute justify-content-center align-items-center"
                            style="top:0;right:0;left:0;bottom:0;background-color: rgba(255,255,255,0.5);z-index: 99;">
                            <div class="spinner-border text-primary" role="status">
                                <span class="sr-only">Loading...</span>
                            </div>
                        </div>
                        <h6 class="mb-3">Unpaid Sales</h6>
                        @error('amounts')
                            <div class="alert alert-danger py-2">{{ $message }}</div>
                        @enderror
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped text-center mb-0">
                                <thead>
                                    <tr>
                                        <th>
                                            <input type="checkbox" wire:click="toggleAll"
                                                @checked($sales->count() && count($selected) === $sales->count())>
                                        </th>
                                        <th>Date</th>
                                        <th>Reference</th>
                                        <th>Total</th>
                                        <th>Paid</th>
                                        <th>Due</th>
                                        <th>Status</th>
                                        <th style="width: 160px;">Pay</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($sales as $sale)
                                        <tr wire:key="sale-{{ $sale->id }}">
                                            <td>
                                                <input type="checkbox" wire:model="selected" value="{{ $sale->id }}">
                                            </td>
                                            <td>{{ \Carbon\Carbon::parse($sale->date)->format('d M, Y') }}</td>
                                            <td>
                                                <a href="{{ route('sales.show', $sale->id) }}" target="_blank">{{ $sale->reference }}</a>
                                            </td>
                                            <td>{{ format_currency($sale->total_amount) }}</td>
                                            <td>{{ format_currency($sale->paid_amount) }}</td>
                                            <td>{{ format_currency($sale->due_amount) }}</td>
                                            <td>
                                                <span class="badge {{ $sale->payment_status == 'Partial' ? 'badge-warning' : 'badge-danger' }}">
                                                    {{ $sale->payment_status }}
                                                </span>
                                            </td>
                                            <td>
                                                <input wire:model.lazy="amounts.{{ $sale->id }}" type="number" min="0"
                                                    max="{{ (int) $sale->due_amount }}" step="1"
                                                    class="form-control form-control-sm @error('amounts.' . $sale->id) is-invalid @enderror">
                                                @error('amounts.' . $sale->id)
                                                    <span class="text-danger small">{{ $message }}</span>
                                                @enderror
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="8">
                                                <span class="text-success">No unpaid sales in this date range.</span>
                                            </td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <h6 class="mb-3">Record Payment for {{ $customer->customer_name }}</h6>
                        <form wire:submit.prevent="save">
                            <div class="form-group">
                                <label>Payment Date <span class="text-danger">*</span></label>
                                <input wire:model.defer="payment_date" type="date" class="form-control">
                                @error('payment_date')
                                    <span class="text-danger mt-1">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Payment Method <span class="text-danger">*</span></label>
                                <select wire:model.defer="payment_method" class="form-control">
                                    @foreach ($paymentMethods as $method)
                                        <option value="{{ $method }}">{{ $method }}</option>
                                    @endforeach
                                </select>
                                @error('payment_method')
                                    <span class="text-danger mt-1">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Code / Reference</label>
                                <input wire:model.defer="code" type="text" class="form-control" placeholder="e.g. Mpesa code or cheque no.">
                                @error('code')
                                    <span class="text-danger mt-1">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Note</label>
                                <textarea wire:model.defer="note" class="form-control" rows="2"></textarea>
                                @error('note')
                                    <span class="text-danger mt-1">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Lump Sum</label>
                                <div class="input-group">
                                    <input wire:model.defer="lump_sum" type="number" min="1" step="1" class="form-control">
                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-outline-primary" wire:click="autoAllocate">
                                            <span wire:target="autoAllocate" wire:loading class="spinner-border spinner-border-sm"></span>
                                            Auto allocate
                                        </button>
                                    </div>
                                </div>
                                <small class="text-muted">Spread across the ticked sales (or all listed), oldest first.</small>
                                @error('lump_sum')
                                    <div class="text-danger mt-1">{{ $message }}</div>
                                @enderror
                            </div>

                            <table class="table table-sm mb-3">
                                <tr>
                                    <th>Allocated</th>
                                    <td class="text-right">{{ format_currency($allocated) }}</td>
                                </tr>
                                @if ($lump_sum)
                                    <tr>
                                        <th>Unallocated</th>
                                        <td class="text-right {{ $lump_sum - $allocated < 0 ? 'text-danger' : '' }}">
                                            {{ format_currency((int) $lump_sum - $allocated) }}
                                        </td>
                                    </tr>
                                @endif
                                <tr>
                                    <th>Balance After Payment</th>
                                    <td class="text-right">{{ format_currency($statement['outstanding'] - $allocated) }}</td>
                                </tr>
                            </table>

                            <button type="submit" class="btn btn-primary btn-block" @disabled($allocated <= 0)>
                                <span wire:target="save" wire:loading class="spinner-border spinner-border-sm"></span>
                                <i wire:target="save" wire:loading.remove class="bi bi-check"></i>
                                Save Payment
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    @endif
</div>
