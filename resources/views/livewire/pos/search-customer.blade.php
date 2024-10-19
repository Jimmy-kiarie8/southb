<div class="position-relative">
    <div class="card mb-0 border-0 shadow-sm">
        <div class="card-body">
            <div class="form-group mb-0">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <div class="input-group-text">

                            <button wire:loading.attr="disabled" wire:click="process" type="button"
                                class="btn btn-pill btn-primary">
                                <i class="bi bi-person-plus"></i>
                            </button>
                        </div>
                    </div>
                    <input wire:keydown.escape="resetQuery" wire:model.debounce.500ms="query" type="text" class="form-control" wire:model.defer="customer_id" placeholder="Type customer name or phone....">
                </div>
            </div>
        </div>
    </div>

    <div wire:loading class="card position-absolute mt-1 border-0" style="z-index: 1;left: 0;right: 0;">
        <div class="card-body shadow">
            <div class="d-flex justify-content-center">
                <div class="spinner-border text-primary" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
        </div>
    </div>

    @if(!empty($query))
        {{-- <div wire:click="resetQuery" class="position-fixed w-100 h-100" style="left: 0; top: 0; right: 0; bottom: 0;z-index: 1;"></div> --}}
        @if($search_results->isNotEmpty())
            <div class="card position-absolute mt-1" style="z-index: 2;left: 0;right: 0;border: 0;">
                <div class="card-body shadow">
                    <ul class="list-group list-group-flush">
                        @foreach($search_results as $result)
                            <li class="list-group-item list-group-item-action">
                                <a wire:click="resetQuery({{ $result }})" wire:click.prevent="selectCustomer({{ $result }})" href="#">
                                    {{ $result->customer_name }} | {{ $result->customer_email }}
                                </a>
                            </li>
                        @endforeach
                        @if($search_results->count() >= $how_many)
                             <li class="list-group-item list-group-item-action text-center">
                                 <a wire:click.prevent="loadMore" class="btn btn-primary btn-sm" href="#">
                                     Load More <i class="bi bi-arrow-down-circle"></i>
                                 </a>
                             </li>
                        @endif
                    </ul>
                </div>
            </div>
        @elseif ($customer)
        <div class="card position-absolute mt-1 border-0" style="z-index: 1;left: 0;right: 0;">
            <div class="card-body shadow">
                <div class="alert alert-warning mb-0">
                    Customer Found....
                </div>
            </div>
        </div>
        @else
        <div class="card position-absolute mt-1 border-0" style="z-index: 1;left: 0;right: 0;">
            <div class="card-body shadow">
                <div class="alert alert-warning mb-0">
                    No Customer Found....
                </div>
            </div>
        </div>
        @endif
    @endif
</div>
