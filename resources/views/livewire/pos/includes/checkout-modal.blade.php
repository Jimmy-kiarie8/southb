<div class="modal fade" id="checkoutModal" tabindex="-1" role="dialog" aria-labelledby="checkoutModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="checkoutModalLabel">
                    <i class="bi bi-cart-check text-primary"></i> Confirm Sale
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="checkout-form" action="{{ route('app.pos.store') }}" method="POST">
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
                        <div class="col-lg-7">
                            <input type="hidden" value="{{ $customer_id }}" name="customer_id">
                            <input type="hidden" value="{{ $global_tax }}" name="tax_percentage">
                            <input type="hidden" value="{{ $global_discount }}" name="discount_percentage">
                            <input type="hidden" value="{{ $shipping }}" name="shipping_amount">
                            <div class="form-row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label for="total_amount">Total Amount <span
                                                class="text-danger">*</span></label>
                                        <input id="total_amount" type="text" class="form-control" name="total_amount"
                                            value="{{ $total_amount }}" readonly required>
                                    </div>
                                </div>


                                {{-- <div class="col-lg-6">
                                    <div class="form-group">
                                        <label for="paid_amount">Received Amount </label>
                                        <input id="paid_amount" type="text" class="form-control" name="paid_amount"
                                            value="{{ $total_amount }}">
                                    </div>
                                </div> --}}
                            </div>
                            {{-- <div class="form-group">
                                <label for="payment_method">Payment Method <span class="text-danger">*</span></label>
                                <select class="form-control" name="payment_method" id="payment_method" required disabled>
                                    <option value="Cash">Cash</option>
                                    <option value="CB1">CB1 (153549)</option>
                                    <option value="CB2">CB2 (153550)</option>
                                    <option value="KCB">KCB</option>
                                    <option value="MPESA">MPESA</option>
                                    <option value="Credit">Credit</option>
                                </select>
                            </div> --}}

                            <div class="form-group">
                                <label for="note">Note (If Needed)</label>
                                <textarea name="note" id="note" rows="5" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <tr>
                                        <th>Total Products</th>
                                        <td>
                                            <span class="badge badge-success">
                                                {{ Cart::instance($cart_instance)->count() }}
                                            </span>
                                        </td>
                                    </tr>
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
                                            (=) {{ format_currency($total_with_shipping) }}
                                        </th>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    {{-- Payments --}}
                    <div class="form-row">


                        <div class="col-lg-6">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="payment_method">Payment Method <span
                                            class="text-danger">*</span></label>
                                    <select class="form-control" name="payment_method" id="payment_method" required
                                        disabled>
                                        <option value="Cash" selected>Cash</option>
                                    </select>

                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="cash_paid_amount">Amount Received <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input id="cash_paid_amount" type="number" class="form-control"
                                        name="cash_paid_amount" value="0">
                                    <div class="input-group-append">
                                        <button id="getTotalAmount" class="btn btn-primary" type="button">
                                            <i class="bi bi-check-square"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="col-lg-6">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="payment_method">Payment Method <span
                                            class="text-danger">*</span></label>
                                    <select class="form-control" name="payment_method" id="payment_method" required
                                        disabled>
                                        <option value="Bank" selected>Bank</option>
                                    </select>

                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="bank_paid_amount">Amount Received <span
                                        class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input id="bank_paid_amount" type="number" class="form-control"
                                        name="bank_paid_amount" value="0">
                                    <div class="input-group-append">
                                        <button id="getTotalAmount" class="btn btn-primary" type="button">
                                            <i class="bi bi-check-square"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="col-lg-6">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="payment_method">Payment Method <span
                                            class="text-danger">*</span></label>
                                    <select class="form-control" name="payment_method" id="payment_method" required
                                        disabled>
                                        <option value="MPESA" selected>MPESA</option>
                                    </select>

                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="mpesa_paid_amount">Amount Received <span
                                        class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input id="mpesa_paid_amount" type="number" class="form-control"
                                        name="mpesa_paid_amount" value="0">
                                    <div class="input-group-append">
                                        <button id="getTotalAmount" class="btn btn-primary" type="button">
                                            <i class="bi bi-check-square"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="payment_method">Payment Method <span
                                            class="text-danger">*</span></label>
                                    <select class="form-control" name="payment_method" id="payment_method" required
                                        disabled>
                                        <option value="Cheque" selected>Cheque</option>
                                    </select>

                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="cheque_paid_amount">Amount Received <span
                                        class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input id="cheque_paid_amount" type="number" class="form-control"
                                        name="cheque_paid_amount" value="0">
                                    <div class="input-group-append">
                                        <button id="getTotalAmount" class="btn btn-primary" type="button">
                                            <i class="bi bi-check-square"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="payment_method">Payment Method <span
                                            class="text-danger">*</span></label>
                                    <select class="form-control" name="payment_method" id="payment_method" required
                                        disabled>
                                        <option value="Credit" selected>Credit</option>
                                    </select>

                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="credit_paid_amount">Amount Received <span
                                        class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input id="credit_paid_amount" type="number" class="form-control"
                                        name="credit_paid_amount" value="0">
                                    <div class="input-group-append">
                                        <button id="getTotalAmount" class="btn btn-primary" type="button">
                                            <i class="bi bi-check-square"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12">
                            <div id="error-message" class="alert alert-danger" role="alert"></div>
                        </div>
                    </div>
                    {{-- Payments --}}

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" id="submit-btn" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>


    </div>
</div>


@push('page_scripts')
    <script>
        // Get the form element and payment amount inputs
        const form = document.getElementById('checkout-form');
        const cashPaidAmount = document.getElementById('cash_paid_amount');
        const bankPaidAmount = document.getElementById('bank_paid_amount');
        const mpesaPaidAmount = document.getElementById('mpesa_paid_amount');
        const chequePaidAmount = document.getElementById('cheque_paid_amount');
        const creditPaidAmount = document.getElementById('credit_paid_amount');

        // Add an event listener to the payment amount inputs
        cashPaidAmount.addEventListener('input', validatePaymentAmounts);
        bankPaidAmount.addEventListener('input', validatePaymentAmounts);
        mpesaPaidAmount.addEventListener('input', validatePaymentAmounts);
        chequePaidAmount.addEventListener('input', validatePaymentAmounts);
        creditPaidAmount.addEventListener('input', validatePaymentAmounts);

        // Define a function to validate the payment amounts
        function validatePaymentAmounts() {
            // Get the payment amounts and total amount
            const cashPaidAmountValue = parseInt(cashPaidAmount.value);
            const bankPaidAmountValue = parseInt(bankPaidAmount.value);
            const mpesaPaidAmountValue = parseInt(mpesaPaidAmount.value);
            const chequePaidAmountValue = parseInt(chequePaidAmount.value);
            const creditPaidAmountValue = parseInt(creditPaidAmount.value);
            const totalAmount = (document.getElementById('total_amount').value);

            const numericString = totalAmount.replace(/,/g, '').replace('KSH', '');
            const numericValue = parseInt(numericString);

            const errorDiv = document.getElementById('error-message');

            // Calculate the payment amount total
            const paymentAmountTotal = cashPaidAmountValue + bankPaidAmountValue + mpesaPaidAmountValue +
                chequePaidAmountValue + creditPaidAmountValue;




            // Check if the payment amount total is the same as the total amount
            if (paymentAmountTotal !== numericValue) {
                // Disable the form submission button
                form.querySelector('button[type="submit"]').disabled = true;

                // Display an error message to the user
                errorDiv.innerText =
                    'Payment amount total does not match total amount. Please check your payment amounts and try again.';
            } else {
                errorDiv.innerText = '';

                // Enable the form submission button
                form.querySelector('button[type="submit"]').disabled = false;

                // Clear any error messages
                cashPaidAmount.setCustomValidity('');
            }
        }
    </script>
@endpush
