<div class="col-lg-3">
    <div class="form-group">
        <label for="customer_id">Customer</label>
        <select class="form-control" wire:model="customer_id" name="customer_id" id="customer_id">
            <option value="">Select</option>
            @foreach ($customers as $customer)
                <option value="{{ $customer->id }}">{{ $customer->customer_name }}</option>
            @endforeach
        </select>
    </div>

    {{-- Show customer email when selected --}}
    @if($pin)
        <div class="mt-3">
            <div>{{ $pin }}</div>
        </div>
    @endif
</div>
