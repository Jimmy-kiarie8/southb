<div>
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <form wire:submit.prevent="generateReport">
                        <div class="form-row">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Start Date <span class="text-danger">*</span></label>
                                    <input wire:model.defer="start_date" type="date" class="form-control"
                                        name="start_date">
                                    @error('start_date')
                                        <span class="text-danger mt-1">{{ $message }}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>End Date <span class="text-danger">*</span></label>
                                    <input wire:model.defer="end_date" type="date" class="form-control"
                                        name="end_date">
                                    @error('end_date')
                                        <span class="text-danger mt-1">{{ $message }}</span>
                                    @enderror
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Payments</label>
                                    <select wire:model="payments" class="form-control" name="payments">
                                        <option value="">Select Payments</option>
                                        <option value="sale">Sales</option>
                                        <option value="sale_return">Sale Returns</option>
                                        <option value="purchase">Purchase</option>
                                        <option value="purchase_return">Purchase Returns</option>
                                    </select>
                                    @error('payments')
                                        <span class="text-danger mt-1">{{ $message }}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Payment Method</label>
                                    {{-- <select wire:model.defer="payment_method" class="form-control"
                                        name="payment_method">
                                        <option value="">Select Payment Method</option>
                                        <option value="Cash">Cash</option>
                                        <option value="Credit Card">Credit Card</option>
                                        <option value="Bank Transfer">Bank Transfer</option>
                                        <option value="Cheque">Cheque</option>
                                        <option value="Other">Other</option>
                                    </select> --}}
                                    <select  wire:model.defer="payment_method" class="form-control" name="payment_method" id="payment_method" required>
                                        <option value="Cash">Cash</option>
                                        <option value="CB1 153549">CB1 (153549)</option>
                                        <option value="CB2 153550">CB2 (153550)</option>
                                        <option value="KCB">KCB</option>
                                        <option value="MPESA">MPESA</option>
                                        <option value="Credit" selected>Credit</option>
                                        <option value="Equity">Equity</option>
                                        <option value="Cheque">Cheque</option>
                                    </select>
                                </div>
                            </div>

                            @if ($payments == 'purchase')
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Supplier</label>
                                        <select wire:model="supplier_id" class="form-control" name="supplier_id">
                                            <option value="">Select Supplier</option>
                                            @foreach (\Modules\People\Entities\Supplier::all() as $supplier)
                                                <option value="{{ $supplier->id }}">{{ $supplier->supplier_name }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            @endif
                            @if ($payments == 'sale')
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Customer</label>
                                        <select wire:model="customer_id" class="form-control" name="customer_id">
                                            <option value="">Select Customer</option>
                                            @foreach (\Modules\People\Entities\Customer::where('customer_phone', '!=', null)->get() as $customer)
                                                <option value="{{ $customer->code }}">{{ $customer->customer_name }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            @endif
                        </div>
                        <div class="form-group mb-0">
                            <button type="submit" class="btn btn-primary">
                                <span wire:target="generateReport" wire:loading class="spinner-border spinner-border-sm"
                                    role="status" aria-hidden="true"></span>
                                <i wire:target="generateReport" wire:loading.remove class="bi bi-shuffle"></i>
                                Filter Report
                            </button>
                            <button class="btn btn-primary" wire:click="export">
                                <span wire:target="export" wire:loading class="spinner-border spinner-border-sm"
                                    role="status" aria-hidden="true"></span>
                                <i wire:target="export" wire:loading.remove class="bi bi-file-earmark-excel-fill"></i>
                                Download Report
                            </button>

                            <button class="btn btn-primary" wire:click="pdf">
                                <span wire:target="export" wire:loading class="spinner-border spinner-border-sm"
                                    role="status" aria-hidden="true"></span>
                                <i wire:target="export" wire:loading.remove class="bi bi-file-pdf"></i>
                                Download PDF
                            </button>
                            {{-- <button class="btn btn-primary"  wire:click="pdf">
                                <span wire:target="export" wire:loading class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                                <i wire:target="export" wire:loading.remove class="bi bi-file-pdf"></i>
                                Download PDF
                            </button> --}}
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    @if ($information->isNotEmpty())
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <table class="table table-bordered table-striped text-center mb-0">
                            <div wire:loading.flex
                                class="col-12 position-absolute justify-content-center align-items-center"
                                style="top:0;right:0;left:0;bottom:0;background-color: rgba(255,255,255,0.5);z-index: 99;">
                                <div class="spinner-border text-primary" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </div>
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    {{-- <th>Reference</th> --}}
                                    <th>{{ ucwords(str_replace('_', ' ', $payments)) }}</th>
                                    <th>Total</th>
                                    <th>Payment Method</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($information as $data)
                                    <tr>
                                        <td>{{ \Carbon\Carbon::parse($data->date)->format('d M, Y') }}</td>
                                        <td>{{ $data->reference }}</td>
                                        {{-- <td>
                                        @if ($payments == 'sale')
                                            {{ $data->sale->reference }}
                                        @elseif($payments == 'purchase')
                                            {{ $data->purchase->reference }}
                                        @elseif($payments == 'sale_return')
                                            {{ $data->saleReturn->reference }}
                                        @elseif($payments == 'purchase_return')
                                            {{ $data->purchaseReturn->reference }}
                                        @endif
                                    </td> --}}
                                        <td>{{ format_currency($data->amount) }}</td>
                                        <td>{{ $data->payment_method }}</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="8">
                                            <span class="text-danger">No Data Available!</span>
                                        </td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                        <div @class(['mt-3' => $information->hasPages()])>
                            {{ $information->links() }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    @else
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="alert alert-warning mb-0">
                            No Data Available!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    @endif
</div>
