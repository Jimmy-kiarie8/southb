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
                                    <select class="form-control" wire:model.defer="user_id" name="user_id"
                                        id="user_id">
                                        <option value="">Select</option>
                                        @foreach (\App\Models\User::all() as $user)
                                            <option value="{{ $user->id }}">{{ $user->name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group mb-0">
                                <button type="submit" class="btn btn-primary">
                                    <span wire:target="generateReport" wire:loading
                                        class="spinner-border spinner-border-sm" role="status"
                                        aria-hidden="true"></span>
                                    <i wire:target="generateReport" wire:loading.remove class="bi bi-shuffle"></i>
                                    Filter Report
                                </button>

                                {{-- <button class="btn btn-primary" wire:click="export">
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
                                </button> --}}
                            </div>
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
                            <tr>
                                <th>Date</th>
                                <th>Reference</th>
                                <th>Customer</th>
                                <th>Total</th>
                                <th>Payment Method</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($sales as $sale)
                                <tr>
                                    <td>{{ \Carbon\Carbon::parse($sale->date)->format('d M, Y') }}</td>
                                    <td>{{ $sale->reference }}</td>
                                    <td>{{ $sale->customer_name }}</td>

                                    <td>{{ format_currency($sale->amount) }}</td>
                                    <td>
                                        {{ $sale->payment_method }}
                                    </td>
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
                            @foreach ($results as $item)
                                <tr>
                                    <th colspan="3"></th>
                                    <th>{{ $item->payment_method }}</th>
                                    <th>{{ format_currency($item->total) }}</th>
                                </tr>
                            @endforeach
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
