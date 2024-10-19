<span role="button" class="btn btn-primary" data-toggle="modal">
    {{-- <span wire:click="$emitSelf('discountModalRefresh', '{{ $cart_item->id }}', '{{ $cart_item->rowId }}')" role="button" class="badge badge-warning pointer-event" data-toggle="modal" data-target="#discountModal{{ $cart_item->id }}"> --}}
    Client Recipting <i class="bi bi-pencil-square text-white"></i>
</span>
<div wire:ignore.self class="modal fade" tabindex="-1" role="dialog" aria-labelledby="discountModalLabel" aria-hidden="true">
    {{-- <div wire:ignore.self class="modal fade" id="discountModal{{ $cart_item->id }}" tabindex="-1" role="dialog" aria-labelledby="discountModalLabel" aria-hidden="true"> --}}
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="discountModalLabel">
                    Payments
                    <br>
                    <span class="badge badge-success">
                        {{-- {{ $cart_item->options->code }} --}}
                    </span>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form  method="POST">
                {{-- <form wire:submit.prevent="setProductDiscount('{{ $cart_item->rowId }}', '{{ $cart_item->id }}')" method="POST"> --}}
                <div class="modal-body">
                    <livewire:customer-payment/>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
