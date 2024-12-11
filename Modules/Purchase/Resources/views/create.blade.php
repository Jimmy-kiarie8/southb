@extends('layouts.app')

@section('title', 'Create Purchase')

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item"><a href="{{ route('purchases.index') }}">Purchases</a></li>
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
                        <form id="purchase-form" action="{{ route('purchases.store') }}" method="POST">
                            @csrf

                            <div class="form-row">

                                <div class="col-md-12">
                                    <div class="form-check form-check-inline">

                                        <input class="form-check-input" type="radio" name="stock_type"
                                            id="flexRadioDefault1" value="receipt" wire:model="stockType" checked>
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            Receipt from supplier
                                        </label>
                                    </div>
                                    <div class="form-check  form-check-inline">
                                        <input class="form-check-input" type="radio" name="stock_type"
                                            id="flexRadioDefault2" value="opening" wire:model="stockType">
                                        <label class="form-check-label" for="flexRadioDefault2">
                                            Opening stock
                                        </label>
                                    </div>



                                </div>


                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="reference">Reference <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="reference" required readonly
                                            value="PR">
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="from-group">
                                        <div class="form-group">
                                            <label for="supplier_id">Supplier</label>
                                            <select class="form-control" name="supplier_id" id="supplier_id" wire:ignore
                                                style="display:block">
                                                <option value="">Select</option>
                                                @foreach (\Modules\People\Entities\Supplier::all() as $supplier)
                                                    <option value="{{ $supplier->id }}">{{ $supplier->supplier_name }}
                                                    </option>
                                                @endforeach
                                            </select>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
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
                                                value="{{ now()->format('Y-m-d') }}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <livewire:product-cart :cartInstance="'purchase'" />

                            <div class="form-row">
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label for="status">Status <span class="text-danger">*</span></label>
                                        <select class="form-control" name="status" id="status" required>
                                            <option value="Completed">Completed</option>
                                            <option value="Pending">Pending</option>
                                            <option value="Ordered">Ordered</option>
                                        </select>
                                    </div>
                                </div>



                                <!-- New Checkbox for Input in Dollars -->
                                <div class="col-lg-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" id="is_dollars" name="is_dollars">
                                        <label class="form-check-label" for="is_dollars">Input in Dollars?</label>
                                    </div>
                                </div>

                                <!-- New Input for Conversion Rate -->
                                <div class="col-lg-4" id="conversion-rate-field" style="display:none;">
                                    <div class="form-group">
                                        <label for="conversion_rate">Conversion Rate (1 USD = ?)</label>
                                        <input type="text" class="form-control" id="conversion_rate"
                                            name="conversion_rate" placeholder="e.g., 110" value="1">
                                    </div>
                                </div>




                                <div class="col-lg-4">
                                    <div class="from-group">
                                        <div class="form-group">
                                            <label for="payment_method">Payment Method <span
                                                    class="text-danger">*</span></label>
                                            <select class="form-control" name="payment_method" id="payment_method"
                                                required>
                                                <option value="Cash">Cash</option>
                                                <option value="Credit Card">Credit Card</option>
                                                <option value="Bank Transfer">Bank Transfer</option>
                                                <option value="Cheque">Cheque</option>
                                                <option value="Credit">Credit</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                {{-- <div class="col-lg-4">
                                    <div class="form-group">
                                        <label for="paid_amount">Amount Paid <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <input id="paid_amount" type="text" class="form-control"
                                                name="paid_amount" value="0" required>
                                            <div class="input-group-append">
                                                <button id="getTotalAmount" class="btn btn-primary" type="button">
                                                    <i class="bi bi-check-square"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div> --}}


                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label for="paid_amount">Amount Paid <span
                                                    class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <input type="text" class="form-control"
                                                    name="paid_amount" value="0" required>
                                                <div class="input-group-append">
                                                    <button id="getTotalAmount" class="btn btn-primary" type="button">
                                                        <i class="bi bi-check-square"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                            </div>

                            <div class="form-group">
                                <label for="note">Note (If Needed)</label>
                                <textarea name="note" id="note" rows="5" class="form-control"></textarea>
                            </div>

                            <div class="mt-3">
                                <button type="submit" class="btn btn-primary">
                                    Create Purchase <i class="bi bi-check"></i>
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
    <script>
        $(document).ready(function() {
            $('#paid_amount').maskMoney({
                prefix: '{{ settings()->currency->symbol }}',
                thousands: '{{ settings()->currency->thousand_separator }}',
                decimal: '{{ settings()->currency->decimal_separator }}',
                allowZero: true,
            });

            $('#getTotalAmount').click(function() {
                $('#paid_amount').maskMoney('mask', {{ Cart::instance('purchase')->total() }});
            });

            $('#purchase-form').submit(function() {
                var paid_amount = $('#paid_amount').maskMoney('unmasked')[0];
                $('#paid_amount').val(paid_amount);
            });
        });
    </script>

    <script>
        window.addEventListener('stockType', function(event) {
            console.log("🚀 ~ file: create.blade.php:184 ~ window.addEventListener ~ event", event)
            var supplierSelect = document.getElementById("supplier_id");
            if (event.detail.value == "opening") {
                supplierSelect.style.display = "none";
            } else {
                supplierSelect.style.display = "block";
            }
        });



        $(document).ready(function() {
            // Initialize maskMoney for currency input
            $('#paid_amount').maskMoney({
                prefix: '{{ settings()->currency->symbol }}',
                thousands: '{{ settings()->currency->thousand_separator }}',
                decimal: '{{ settings()->currency->decimal_separator }}',
                allowZero: true,
            });

            // Event listener for "Get Total Amount" button
            $('#getTotalAmount').click(function() {
                $('#paid_amount').maskMoney('mask', {{ Cart::instance('purchase')->total() }});
            });

            // Handle form submission
            $('#purchase-form').submit(function() {
                var paid_amount = $('#paid_amount').maskMoney('unmasked')[0];

                // If the checkbox for dollars is checked, convert the amount
                if ($('#is_dollars').is(':checked')) {
                    var conversion_rate = parseFloat($('#conversion_rate').val());
                    paid_amount = paid_amount * conversion_rate;
                }

                // Update the paid amount value with the converted amount
                $('#paid_amount').val(paid_amount);
            });

            // Toggle visibility of the conversion rate input
            $('#is_dollars').change(function() {
                if ($(this).is(':checked')) {
                    $('#conversion-rate-field').show();
                } else {
                    $('#conversion-rate-field').hide();
                }
            });
        });
    </script>
@endpush
