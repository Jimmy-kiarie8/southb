<div>
    <div class="card border-0 shadow-sm">
        <div class="card-body">
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

                <div class="position-relative">
                    <div class="card mb-0 border-0 shadow-sm">
                        <div class="card-header">
                            <h1 class="text-primary text-center" style="font-weight: bolder">
                                {{-- {{ (format_currency(Cart::instance($cart_instance)->total() + (float) $shipping)) }} --}}
                                {{ format_currency(ceil(Cart::instance($cart_instance)->total() + (float) $shipping)) }}

                            </h1>
                        </div>
                        <div class="card-body">
                            <div class="form-group mb-0">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <button wire:loading.attr="disabled" wire:click="process" type="button"
                                            class="btn btn-pill btn-primary">
                                            <i class="bi bi-person-plus"></i>
                                        </button>
                                    </div>
                                    <input wire:keydown.escape="resetQuery" wire:model.debounce.500ms="query"
                                        type="text" class="form-control" wire:model="customer_id"
                                        placeholder="Type customer name or phone...." style="    height: 47px;">
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

                    @if (!empty($query))
                        @if ($search_results->isNotEmpty())
                            <div class="card position-absolute mt-1" style="z-index: 2;left: 0;right: 0;border: 0;">
                                <div class="card-body shadow">
                                    <ul class="list-group list-group-flush">
                                        @foreach ($search_results as $result)
                                            <li class="list-group-item list-group-item-action">
                                                <a wire:click="resetQuery({{ $result }})"
                                                    wire:click.prevent="selectCustomer({{ $result }})"
                                                    href="#">
                                                    {{ $result->customer_name }} | {{ $result->customer_email }}
                                                </a>
                                            </li>
                                        @endforeach
                                        @if ($search_results->count() >= $how_many)
                                            <li class="list-group-item list-group-item-action text-center">
                                                <a wire:click.prevent="loadMore" class="btn btn-primary btn-sm"
                                                    href="#">
                                                    Load More <i class="bi bi-arrow-down-circle"></i>
                                                </a>
                                            </li>
                                        @endif
                                    </ul>
                                </div>
                            </div>
                        @endif
                    @endif
                </div>
                <div class="table-responsive">

                    <table class="table">
                        <thead>
                            <tr class="text-center">
                                <th class="align-middle">Product</th>
                                <th class="align-middle">Cost Price</th>
                                <th class="align-middle">Price</th>
                                <th class="align-middle">Quantity</th>
                                <th class="align-middle">Subtotal</th>
                                <th class="align-middle">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if ($cart_items->isNotEmpty())

                                @foreach ($cart_items as $cart_item)
                                    <tr>
                                        <td class="align-middle">
                                            {{ $cart_item->name }} <br>
                                            <span class="badge badge-success">
                                                {{ $cart_item->options->code }}
                                            </span>
                                            @include('livewire.includes.product-cart-modal')
                                        </td>


                                        <td class="align-middle">
                                            {{ format_currency($cart_item->options->product_cost) }}
                                        </td>
                                        <td class="align-middle">
                                            @if ($sale_type == 'Wholesale' && env('WHOLESALE_RETAIL'))
                                                {{ format_currency($cart_item->options->wholesale_price) }}
                                            @else
                                                {{ format_currency($cart_item->price) }}
                                            @endif
                                        </td>

                                        <td class="align-middle">
                                            @include('livewire.includes.product-cart-quantity')
                                        </td>

                                        <td class="align-middle">

                                            @if ($sale_type == 'Wholesale' && env('WHOLESALE_RETAIL'))
                                                {{ format_currency($cart_item->options->wholesale_price * $cart_item->qty) }}
                                            @else
                                                {{ format_currency($cart_item->price * $cart_item->qty) }}
                                            @endif
                                        </td>

                                        <td class="align-middle text-center">
                                            <a href="#"
                                                wire:click.prevent="removeItem('{{ $cart_item->rowId }}')">
                                                <i class="bi bi-x-circle font-2xl text-danger"></i> Remove
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

            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <tr>
                                <th>Order Tax ({{ $global_tax }}%)</th>
                                <td>(+) {{ format_currency(Cart::instance($cart_instance)->tax()) }}</td>
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
                            <tr class="text-primary">
                                <th>Grand Total</th>
                                @php
                                    $total_with_shipping = Cart::instance($cart_instance)->total() + (float) $shipping;
                                @endphp
                                <th>
                                    (=) {{ format_currency(ceil($total_with_shipping)) }}
                                </th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label for="tax_percentage">Order Tax (%)</label>
                        <input wire:model.lazy="global_tax" type="number" class="form-control" min="0"
                            max="100" value="{{ $global_tax }}" required>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="form-group">
                        <label for="discount_percentage">Discount (%)</label>
                        <input wire:model.lazy="global_discount" type="number" class="form-control" min="0"
                            max="100" value="{{ $global_discount }}" required>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="form-group">
                        <label for="shipping_amount">Shipping</label>
                        <input wire:model.lazy="shipping" type="number" class="form-control" min="0"
                            value="0" required step="0.01">
                    </div>
                </div>

                <div>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for="payments">Payment Methods</label>
                            @foreach ($paymentMethods as $index => $method)
                                <div class="payment-method mb-3">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <select wire:model="paymentMethods.{{ $index }}.type"
                                                class="form-control payment-method-select">
                                                <option value="Cash">Cash</option>
                                                <option value="Mpesa">Mpesa</option>
                                                <option value="Cheque">Cheque</option>
                                                <option value="KCB">KCB</option>
                                                <option value="Equity">Equity</option>
                                                <option value="PDQ">PDQ</option>
                                                <option value="Credit">Credit</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <input type="number"
                                                wire:model="paymentMethods.{{ $index }}.amount"
                                                class="form-control paid-amount" placeholder="Amount" step="0.01"
                                                min="0">
                                        </div>
                                        <div class="col-md-4">
                                            @if ($index === 0)
                                                <button type="button" wire:click="addPaymentMethod"
                                                    class="btn btn-success">+</button>
                                            @else
                                                <button type="button"
                                                    wire:click="removePaymentMethod({{ $index }})"
                                                    class="btn btn-danger">-</button>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </div>

                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for="paid_amount">Total Paid Amount*</label>
                            <input id="paid_amount" wire:model="paid_amount" type="number" class="form-control"
                                min="0" step="0.01" readonly>
                        </div>
                    </div>
                </div>


                @if (env('WHOLESALE_RETAIL'))
                    <div class="col-lg-6">
                        <label for="sale_type">Sale type</label>
                        <select wire:model="sale_type" id="sale_type" class="form-control">
                            <option value="Retail" selected>Retail</option>
                            <option value="Wholesale">Wholesale</option>
                        </select>
                    </div>
                @endif


            </div>


            <div class="form-group d-flex justify-content-center flex-wrap mb-0">

                {{-- <form id="checkout-form" action="{{ route('app.pos.store') }}" method="POST" style="width: 100%;"> --}}
                <form id="checkout-form" action="{{ route('app.pos.store') }}" method="POST" style="width: 100%;">

                    @csrf
                    <div class="modal-body">
                        @if (session()->has('checkout_message'))
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <div class="alert-body">
                                    <span>{{ session('checkout_message') }}</span>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                            </div>
                        @endif
                        <div class="row">
                            <div class="col-lg-12">
                                <input type="hidden" value="{{ $customer_id }}" name="customer_id">
                                <input type="hidden" value="{{ $global_tax }}" name="tax_percentage">
                                <input type="hidden" value="{{ $global_discount }}" name="discount_percentage">
                                <input type="hidden" value="{{ $shipping }}" name="shipping_amount">
                                <input type="hidden" value="{{ $payment_method }}" name="payment_method">
                                <input type="hidden" value="{{ $sale_type }}" name="sale_type">
                                <input type="hidden" value="{{ $paid_amount }}" name="paid_amount">
                                <input type="hidden" value="{{ json_encode($paymentMethods) }}"
                                    name="paymentMethods">
                                <input id="total_amount" type="hidden" class="form-control" name="total_amount"
                                    value="{{ Cart::instance($cart_instance)->total() + (float) $shipping }}" readonly
                                    required>

                                <label for="note">Note (If Needed)</label>
                                <textarea name="note" id="note" rows="5" class="form-control"></textarea>

                                <br>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button wire:click="resetCart" type="button" class="btn btn-pill btn-danger mr-3"><i
                                class="bi bi-x"></i> Reset</button>
                        <button type="submit" id="submit-btn" class="btn btn-primary">Complete Sale</button>
                    </div>
                </form>



            </div>
        </div>
    </div>
    <iframe id="pdf-iframe" style="display:none;"></iframe>

    @include('livewire.pos.includes.customer-create')

</div>



<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('checkout-form');
        const submitBtn = document.getElementById('submit-btn');
        const pdfIframe = document.getElementById('pdf-iframe');

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            submitBtn.disabled = true;
            submitBtn.innerHTML = 'Processing...';

            fetch(form.action, {
                    method: 'POST',
                    body: new FormData(form),
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.blob();
                })
                .then(blob => {
                    // Create a Blob URL for the PDF
                    const url = URL.createObjectURL(blob);

                    // Set the iframe's source to the Blob URL
                    pdfIframe.src = url;

                    const handlePrintClose = () => {
                        // Clear the form data
                        form.reset();

                        // Clear Livewire properties using Livewire hooks
                        @this.call('resetCart');
                        @this.call('resetCustomer');
                        @this.call('resetPaymentMethods');

                        // Reset the form state
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = 'Complete Sale';
                    };

                    let isPrintCommandExecuted = false;

                    pdfIframe.onload = function() {
                        if (!isPrintCommandExecuted) {
                            // Print the PDF once it's loaded in the iframe
                            pdfIframe.contentWindow.print();
                            isPrintCommandExecuted = true;

                            // Track when the print dialog is closed
                            let isPrintDialogOpen = true;
                            const checkPrintDialog = () => {
                                if (document.hasFocus() && isPrintDialogOpen) {
                                    isPrintDialogOpen = false;
                                    handlePrintClose();
                                    window.removeEventListener('focus', checkPrintDialog);
                                } else {
                                    setTimeout(checkPrintDialog, 500);
                                }
                            };

                            window.addEventListener('focus', checkPrintDialog);
                        }
                    };
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while processing the sale.');
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = 'Complete Sale';
                });
        });
    });
</script>
