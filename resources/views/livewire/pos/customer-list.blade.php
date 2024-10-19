<div>
    <div class="card border-0 shadow-sm mt-3">
        <div class="card-body">
            <div class="row position-relative">
                <div wire:loading.flex class="col-12 position-absolute justify-content-center align-items-center" style="top:0;right:0;left:0;bottom:0;background-color: rgba(255,255,255,0.5);z-index: 99;">
                    <div class="spinner-border text-primary" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
                @forelse($customers as $customer)
                    <div wire:click.prevent="selectCustomer({{ $customer }})" class="col-lg-4 col-md-6" style="cursor: pointer;">
                        <div class="card border-0 shadow h-100">

                            <div class="card-body">
                                <div class="mb-2">
                                    <h6 style="font-size: 13px;" class="card-title mb-0">{{ $customer->customer_name }}</h6>
                                    <span class="badge badge-success">
                                    {{ $customer->customer_email }}
                                </span>
                                </div>
                            </div>
                        </div>
                    </div>
                @empty
                    <div class="col-12">
                        <div class="alert alert-warning mb-0">
                            customers Not Found...
                        </div>
                    </div>
                @endforelse
            </div>
            {{-- <div @class(['mt-3' => $customers->hasPages()])>
                {{ $customers->links() }}
            </div> --}}
        </div>
    </div>
</div>
