
<div>
    <div>
        @if (session()->has('message'))
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <div class="alert-body">
                    <span>{{ session('message') }}</span>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
            </div>
        @endif
        <div class="table-responsive position-relative">
            <div wire:loading.flex class="col-12 position-absolute justify-content-center align-items-center"
                style="top:0;right:0;left:0;bottom:0;background-color: rgba(255,255,255,0.5);z-index: 99;">
                <div class="spinner-border text-primary" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>

            <br>


            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th class="align-middle">#</th>
                        <th class="align-middle">Product</th>
                        <th class="align-middle">Net Unit Price</th>
                        @if (env('WHOLESALE_RETAIL'))
                            <th class="align-middle">Wholesale Price</th>
                        <th class="align-middle">Sale Type</th>
                        @endif
                        <th class="align-middle">Edit Price</th>
                        <th class="align-middle">Stock</th>
                        <th class="align-middle">Quantity</th>
                        <th class="align-middle">Discount</th>
                        <th class="align-middle">Tax</th>
                        <th class="align-middle">Sub Total</th>
                        <th class="align-middle">Action</th>
                    </tr>
                </thead>
                <tbody>
                    @if ($cart_items->isNotEmpty())
                        @php
                            $i = 0;
                        @endphp
                        @foreach ($cart_items as $cart_item)
                            @php
                                $i += 1;
                            @endphp
                            <tr>
                                <td> {{ $i }}</td>
                                <td class="align-middle">
                                    {{ $cart_item->name }} <br>
                                    <span class="badge badge-success">
                                        {{ $cart_item->options->code }}
                                    </span>
                                    @include('livewire.includes.product-cart-modal')
                                </td>

                                <td class="align-middle">{{ format_currency($cart_item->options->unit_price) }}</td>


                                @if (env('WHOLESALE_RETAIL'))
                                    <td class="align-middle">{{ format_currency($cart_item->options->wholesale_price) }}</td>
                                    <td class="align-middle">
                                        <div class="form-check">
                                            <input class="form-check-input"
                                                   type="radio"
                                                   name="saleType[{{ $cart_item->id }}]"
                                                   wire:model="sale_type.{{ $cart_item->id }}"
                                                   value="Retail"
                                                   wire:change="updateSaleType('{{ $cart_item->rowId }}', 'Retail')">
                                            <label class="form-check-label">Retail</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input"
                                                   type="radio"
                                                   name="saleType[{{ $cart_item->id }}]"
                                                   wire:model="sale_type.{{ $cart_item->id }}"
                                                   value="Wholesale"
                                                   wire:change="updateSaleType('{{ $cart_item->rowId }}', 'Wholesale')">
                                            <label class="form-check-label">Wholesale</label>
                                        </div>
                                    </td>
                                @endif

                                <td class="align-middle">
                                    @include('livewire.includes.unit-price')
                                </td>
                                <td class="align-middle text-center">
                                    <span
                                        class="badge badge-info">{{ $cart_item->options->stock . ' ' . $cart_item->options->unit }}</span>
                                </td>

                                <td class="align-middle">
                                    @include('livewire.includes.product-cart-quantity')
                                </td>

                                <td class="align-middle">
                                    {{ format_currency($cart_item->options->product_discount) }}
                                </td>

                                <td class="align-middle">
                                    {{ format_currency($cart_item->options->product_tax) }}
                                </td>

                                <td class="align-middle">
                                    {{-- {{ format_currency($cart_item->options->sub_total) }} --}}

                                    {{ $cart_item->options->unit_price * $cart_item->qty }}
                                </td>

                                <td class="align-middle text-center">
                                    <a href="#" wire:click.prevent="removeItem('{{ $cart_item->rowId }}')">
                                        <i class="bi bi-x-circle font-2xl text-danger"></i>
                                    </a>
                                </td>
                            </tr>
                        @endforeach
                    @else
                        <tr>
                            <td colspan="8" class="text-center">
                                <span class="text-danger">
                                    Please search & select products!
                                </span>
                            </td>
                        </tr>
                    @endif
                </tbody>
            </table>
        </div>
    </div>

    <div class="row justify-content-md-end">
        <div class="col-md-4">
            <div class="table-responsive">
                <table class="table table-striped">
                    <tr>
                        <th>Order Tax ({{ $global_tax }}%)</th>
                        <td>(+) {{ format_currency(Cart::instance($cart_instance)->total() * 0.16) }}</td>
                        {{-- <td>(+) {{ format_currency(Cart::instance($cart_instance)->tax()) }}</td> --}}
                    </tr>
                    <tr>
                        <th>Discount ({{ $global_discount }}%)</th>
                        <td>(-) {{ format_currency(Cart::instance($cart_instance)->discount()) }}</td>
                    </tr>
                    <tr>
                        <th>Shipping</th>
                        <input type="hidden" value="{{ $shipping }}" name="shipping_amount">
                        <td>(+) {{ format_currency($shipping) }}</td>
                    </tr>

                    @if ($cart_instance != 'purchase')
                        <tr id="total_amount">
                            <th>Grand Total</th>
                            @php
                                $total_with_shipping = Cart::instance($cart_instance)->total() + (float) $shipping;
                            @endphp
                            <th>
                                (=) {{ format_currency($total_with_shipping) }}
                            </th>
                        </tr>
                    @else
                        <tr id="total_amount">
                            <th>Grand Total</th>

                            @php
                                $total_with_shipping = Cart::instance($cart_instance)->total() + (float) $shipping;
                            @endphp
                            <th>
                                (=) {{ format_currency($total_with_shipping) }}
                                {{-- (=) {{ format_currency($total_with_shipping) }} --}}
                            </th>
                        </tr>
                    @endif



                </table>
            </div>
        </div>
    </div>
    {{-- @if ($cart_instance != 'purchase') --}}
    <input type="hidden" name="total_amount" value="{{ $total_with_shipping }}">
    {{-- @endif --}}

    <div class="form-row">
        <div class="col-lg-4">
            <div class="form-group">
                <label for="tax_percentage">Order Tax (%)</label>
                <input wire:model.lazy="global_tax" type="number" class="form-control" name="tax_percentage"
                    min="0" max="100" value="{{ $global_tax }}" required>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="form-group">
                <label for="discount_percentage">Discount (%)</label>
                <input wire:model.lazy="global_discount" type="number" class="form-control" name="discount_percentage"
                    min="0" max="100" value="{{ $global_discount }}" required>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="form-group">
                <label for="shipping_amount">Shipping</label>
                <input wire:model.lazy="shipping" type="number" class="form-control" name="shipping_amount"
                    min="0" value="0" required step="0.01">
            </div>
        </div>
    </div>
</div>
