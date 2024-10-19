<div>
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <form wire:submit.prevent="generateReport">
                        <div class="form-row">
                            <div class="form-row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Locations</label>
                                        <select class="form-control" name="branch_id" id="branch_id" required
                                            wire:change="selectLocation($event.target.value)">
                                            <option value="">Select</option>
                                            @foreach (\Modules\Branch\Entities\Branch::all() as $location)
                                                <option value="{{ $location->id }}">{{ $location->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group mb-0">
                                <button type="submit" class="btn btn-primary">
                                    <span wire:target="generateReport" wire:loading
                                        class="spinner-border spinner-border-sm" role="status"
                                        aria-hidden="true"></span>
                                    <i wire:target="generateReport" wire:loading.remove class="bi bi-shuffle"></i>
                                    Filter Report
                                </button>
                                <button class="btn btn-primary" wire:click="export">
                                    <span wire:target="export" wire:loading class="spinner-border spinner-border-sm"
                                        role="status" aria-hidden="true"></span>
                                    <i wire:target="export" wire:loading.remove
                                        class="bi bi-file-earmark-excel-fill"></i>
                                    Download Report
                                </button>
                                <button class="btn btn-primary" wire:click="pdf">
                                    <span wire:target="export" wire:loading class="spinner-border spinner-border-sm"
                                        role="status" aria-hidden="true"></span>
                                    <i wire:target="export" wire:loading.remove class="bi bi-file-pdf"></i>
                                    Download PDF
                                </button>
                            </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    {{-- <table class="table table-bordered table-striped text-center mb-0">
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
                                <th>Reference</th>
                                <th>Customer</th>
                                <th>Status</th>
                                <th>Total</th>
                                <th>Paid</th>
                                <th>Due</th>
                                <th>Payment Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($products as $product)
                                <tr>
                                    <td>{{ \Carbon\Carbon::parse($product->date)->format('d M, Y') }}</td>
                                    <td>{{ $product->reference }}</td>
                                    <td>{{ $product->customer_name }}</td>
                                    <td>
                                        @if ($product->status == 'Pending')
                                            <span class="badge badge-info">
                                                {{ $product->status }}
                                            </span>
                                        @elseif ($product->status == 'Shipped')
                                            <span class="badge badge-primary">
                                                {{ $product->status }}
                                            </span>
                                        @else
                                            <span class="badge badge-success">
                                                {{ $product->status }}
                                            </span>
                                        @endif
                                    </td>
                                    <td>{{ format_currency($product->total_amount) }}</td>
                                    <td>{{ format_currency($product->paid_amount) }}</td>
                                    <td>{{ format_currency($product->due_amount) }}</td>
                                    <td>
                                        @if ($product->payment_status == 'Partial')
                                            <span class="badge badge-warning">
                                                {{ $product->payment_status }}
                                            </span>
                                        @elseif ($product->payment_status == 'Paid')
                                            <span class="badge badge-success">
                                                {{ $product->payment_status }}
                                            </span>
                                        @else
                                            <span class="badge badge-danger">
                                                {{ $product->payment_status }}
                                            </span>
                                        @endif

                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="8">
                                        <span class="text-danger">No Sale Return Data Available!</span>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table> --}}
                    {{-- <div @class(['mt-3' => $products->hasPages()])>
                        {{ $products->links() }}
                    </div> --}}
                </div>
            </div>
        </div>
    </div>
</div>
