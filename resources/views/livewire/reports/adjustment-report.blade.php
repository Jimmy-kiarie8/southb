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

                        </div>
                        <!-- <div class="form-row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label>Location</label>
                                    <select class="form-control" wire:model.defer="location_id" name="location_id"
                                        id="location_id">
                                        <option value="">Select</option>
                                        @foreach (\Modules\Branch\Entities\Branch::all() as $location)
                                            <option value="{{ $location->id }}">{{ $location->name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div> -->
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
                                <th>Product</th>
                                <th>Date</th>
                                <th>Reference</th>
                                <th>Type</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($adjustments as $adjustment)
                                <tr>
                                    <td>{{ $adjustment->product->product_name }}</td>
                                    <td>{{ \Carbon\Carbon::parse($adjustment->date)->format('d M, Y') }}</td>
                                    <td>{{ $adjustment->adjustment->reference }}</td>
                                    <td>{{ $adjustment->type }}</td>
                                    <td>{{ $adjustment->quantity }}</td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="8">
                                        <span class="text-danger">No Sales Data Available!</span>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                    {{-- <div @class(['mt-3' => $adjustment->hasPages()])>
                        {{ $adjustment->links() }}
                    </div> --}}
                </div>
            </div>
        </div>
    </div>
</div>
