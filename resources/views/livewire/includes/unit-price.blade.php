<form wire:submit.prevent="updatePrice('{{ $cart_item->rowId }}', '{{ $cart_item->id }}')">
    <div class="input-group">
        <input wire:model.defer="price.{{ $cart_item->id }}" style="min-width: 90px;max-width: 120px;" type="number"
            class="form-control" value="{{ $cart_item->unit_price }}" wire:change="updatePrice('{{ $cart_item->rowId }}', '{{ $cart_item->id }}')" >
        <div class="input-group-append">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-check"></i>
            </button>
        </div>
    </div>
</form>


{{--

<form wire:submit.prevent="updateQuantity('{{ $cart_item->rowId }}', '{{ $cart_item->id }}')">
    <div class="input-group">
        <input wire:model.defer="quantity.{{ $cart_item->id }}" wire:change="updatePrice('{{ $cart_item->rowId }}', '{{ $cart_item->id }}')" style="min-width: 40px;max-width: 90px;" type="number"
            class="form-control" value="{{ $cart_item->qty }}" min="0.01">
        <div class="input-group-append">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-check"></i>
            </button>
        </div>
    </div>
</form> --}}
