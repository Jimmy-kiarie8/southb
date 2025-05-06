@extends('layouts.app')

@section('title', 'Create Sale')

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item"><a href="{{ route('sales.index') }}">Sales</a></li>
        <li class="breadcrumb-item active">Add</li>
    </ol>
@endsection

@section('content')
    <div class="container-fluid mb-4">
        <div class="row">
            <div class="col-12">
                <livewire:search-product />
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        @include('utils.alerts')
                        <form id="sale-form" action="{{ route('sales.store') }}" method="POST">
                            @csrf

                            <div class="form-row">
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="reference">Reference <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="reference" required readonly
                                            value="INVOICE">
                                    </div>
                                </div>

                                <livewire:customer-details />



                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="location_id">Location <span class="text-danger">*</span></label>
                                        <select class="form-control" name="location_id" id="location_id" required>
                                            @foreach (\Modules\Branch\Entities\Branch::all() as $location)
                                                <option value="{{ $location->id }}">{{ $location->name }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="from-group">
                                        <div class="form-group">
                                            <label for="date">Date <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" name="date" required
                                                value="{{ \Carbon\Carbon::now()->format('Y-m-d') }}">
                                        </div>
                                    </div>
                                </div>



                                {{-- <div class="col-lg-3">
                                    <div class="from-group">
                                        <div class="form-group">
                                            <label for="date">Delivery Note Number</label>
                                            <input type="text" class="form-control" name="order_no">
                                        </div>
                                    </div>
                                </div> --}}
                            </div>

                            <livewire:product-cart :cartInstance="'sale'" />

                            <div class="form-row">
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label for="status">Status <span class="text-danger">*</span></label>
                                        <select class="form-control" name="status" id="status" required>
                                            <option value="Completed">Completed</option>
                                            <option value="Pending">Pending</option>
                                            <option value="Shipped">Shipped</option>
                                        </select>
                                    </div>
                                </div>
{{--
                                <div class="col-lg-4">
                                    <label for="is_tax_inclusive">Tax Inclusive</label>
                                    <input type="checkbox" name="is_tax_inclusive" id="is_tax_inclusive"
                                        class="form-control">
                                </div> --}}

                                <div class="col-lg-4">
                                    <label for="payment_method">Payment Method</label>
                                    <select wire:model="payment_method" id="payment_method" class="form-control"
                                        name="payment_method">
                                        <option value="Cash" selected>Cash</option>
                                        <option value="Mpesa">Mpesa</option>
                                        <option value="Bank">Bank</option>
                                        <option value="Cheque">Cheque</option>
                                        <option value="Credit">Credit</option>
                                    </select>
                                </div>


                                <div class="col-lg-4">
                                    <label for="total_amount">Amount paid</label>
                                    <input type="text" name="total_amount" class="form-control" value="0"
                                        id="">
                                </div>

                                <div class="col-lg-4">
                                    <label for="total_amount">CU Invoice Number</label>
                                    <input type="text" name="cu_inv_no" class="form-control" value="0"
                                        id="">
                                </div>

                                {{--
                                <div class="col-lg-12">
                                    <div id="error-message" class="alert alert-danger" role="alert"></div>
                                </div> --}}

                            </div>

                            <div class="form-group">
                                <label for="note">Note (If Needed)</label>
                                <textarea name="note" id="note" rows="5" class="form-control"></textarea>
                            </div>




                            <div class="mt-3">
                                <button type="submit" class="btn btn-primary" id="submitBtn">
                                    Create Sale <i class="bi bi-check"></i>
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>



    </div>
@endsection

@push('page_scripts')
    <script src="{{ asset('js/jquery-mask-money.js') }}"></script>
    {{-- <script>
        $(document).ready(function() {
            $('#paid_amount').maskMoney({
                prefix: '{{ settings()->currency->symbol }}',
                thousands: '{{ settings()->currency->thousand_separator }}',
                decimal: '{{ settings()->currency->decimal_separator }}',
                allowZero: true,
            });

            $('#getTotalAmount').click(function() {
                $('#paid_amount').maskMoney('mask', {{ Cart::instance('sale')->total() }});
            });

            $('#sale-form').submit(function() {
                var paid_amount = $('#paid_amount').maskMoney('unmasked')[0];
                $('#paid_amount').val(paid_amount);
            });
        });
    </script> --}}

    <script>
        // Get the form element and payment amount inputs
        const form = document.getElementById('checkout-form');
        const cashPaidAmount = document.getElementById('cash_paid_amount');
        const bankPaidAmount = document.getElementById('bank_paid_amount');
        const mpesaPaidAmount = document.getElementById('mpesa_paid_amount');
        const chequePaidAmount = document.getElementById('cheque_paid_amount');
        // const creditPaidAmount = document.getElementById('credit_paid_amount');

        // Add an event listener to the payment amount inputs
        cashPaidAmount.addEventListener('input', validatePaymentAmounts);
        bankPaidAmount.addEventListener('input', validatePaymentAmounts);
        mpesaPaidAmount.addEventListener('input', validatePaymentAmounts);
        chequePaidAmount.addEventListener('input', validatePaymentAmounts);
        // creditPaidAmount.addEventListener('input', validatePaymentAmounts);

        // Define a function to validate the payment amounts
        function validatePaymentAmounts() {
            // Get the payment amounts and total amount
            const cashPaidAmountValue = parseInt(cashPaidAmount.value);
            const bankPaidAmountValue = parseInt(bankPaidAmount.value);
            const mpesaPaidAmountValue = parseInt(mpesaPaidAmount.value);
            const chequePaidAmountValue = parseInt(chequePaidAmount.value);
            // const creditPaidAmountValue = parseInt(creditPaidAmount.value);

            const cartTotal = document.getElementById('total_amount').lastElementChild.textContent.trim();
            const numericValue = Number(cartTotal.replace(/[^\d.-]/g, ''));


            // console.log({{ Cart::instance('sale')->total() }});
            // const totalAmount = (document.getElementById('total_amount').value);
            // console.log("🚀 ~ file: create.blade.php:475 ~ validatePaymentAmounts ~ totalAmount:", totalAmount)

            // const numericString = totalAmount.replace(/,/g, '').replace('KSH', '');
            // const numericValue = parseInt(numericString);

            const errorDiv = document.getElementById('error-message');

            // Calculate the payment amount total
            const paymentAmountTotal = cashPaidAmountValue + bankPaidAmountValue + mpesaPaidAmountValue +
                chequePaidAmountValue
            // + creditPaidAmountValue;


            // console.log("🚀 ~ file: checkout-modal.blade.php:377 ~ validatePaymentAmounts ~ paymentAmountTotal:", paymentAmountTotal)
            // console.log("🚀 ~ file: checkout-modal.blade.php:377 ~ validatePaymentAmounts ~ numericValue:", numericValue)


            // Check if the payment amount total is the same as the total amount
            if (paymentAmountTotal !== numericValue) {
                // Disable the form submission button
                // form.querySelector('button[type="submit"]').disabled = true;
                const button = document.getElementById('submitBtn');
                button.disabled = true;
                // Display an error message to the user
                errorDiv.innerText =
                    'Payment amount total does not match total amount. Please check your payment amounts and try again.';
            } else {
                errorDiv.innerText = '';
                const button = document.getElementById('submitBtn');
                button.disabled = false;
                // Enable the form submission button
                // form.querySelector('button[type="submit"]').disabled = false;

                // Clear any error messages
                cashPaidAmount.setCustomValidity('');
            }
        }
    </script>
@endpush
