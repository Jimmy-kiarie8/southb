<div>
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <form wire:submit.prevent="generateReport">
                        <div class="form-row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label>Start Date <span class="text-danger">*</span></label>
                                    <input wire:model.defer="start_date" type="date" class="form-control"
                                        name="start_date">
                                    @error('start_date')
                                        <span class="text-danger mt-1">{{ $message }}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label>End Date <span class="text-danger">*</span></label>
                                    <input wire:model.defer="end_date" type="date" class="form-control"
                                        name="end_date">
                                    @error('end_date')
                                        <span class="text-danger mt-1">{{ $message }}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label>User</label>
                                    <select wire:model.defer="user_id" class="form-control" name="user_id">
                                        @foreach (\App\Models\User::orderBy('name', 'Asc')->get() as $user)
                                            <option value="{{ $user->id }}">{{ $user->name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label>Items</label>
                                    <select wire:model.defer="product_id" class="form-control" name="product_id">
                                        <option value="" selected>All</option>
                                        @foreach (\Modules\Product\Entities\Product::orderBy('product_name', 'Asc')->get() as $product)
                                            <option value="{{ $product->id }}">{{ $product->product_name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mb-0">
                            <button type="submit" class="btn btn-primary">
                                <span wire:target="generateReport" wire:loading class="spinner-border spinner-border-sm"
                                    role="status" aria-hidden="true"></span>
                                <i wire:target="generateReport" wire:loading.remove class="bi bi-shuffle"></i>
                                Filter Report
                            </button>

                            <button class="btn btn-primary" wire:click="pdf">
                                <span wire:target="pdf" wire:loading class="spinner-border spinner-border-sm"
                                    role="status" aria-hidden="true"></span>
                                <i wire:target="pdf" wire:loading.remove class="bi bi-file-pdf"></i>
                                Download PDF
                            </button>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <br>

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
                            <tr style="text-align: left">
                                <th>Date</th>
                                <th>Order No.</th>
                                <th>Product</th>
                                <th>Product code</th>
                                <th>Quantity</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($sales as $sale)
                                <tr style="text-align: left">
                                    <td>{{ \Carbon\Carbon::parse($sale->created_at)->format('dS M, Y H:i:s') }}</td>
                                    <td>{{ $sale->sale->reference }}</td>
                                    <td>{{ $sale->product_name }}</td>
                                    <td>{{ $sale->product_code }}</td>
                                    <td>{{ $sale->quantity }}</td>
                                    <td>{{ format_currency($sale->price) }}</td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="8">
                                        <span class="text-danger">No Sales Data Available!</span>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>

                        <tfoot>
                            <tr>
                                <th colspan="3"></th>
                                <th>Total Qty</th>
                                <th>{{ $count }}</th>
                            </tr>
                        </tfoot>
                    </table>
                    <div @class(['mt-3' => $sales->hasPages()])>
                        {{ $sales->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
