<span role="button" class="btn btn-primary" data-toggle="modal" data-target="#discountModal">
    Client Recipting <i class="bi bi-pencil-square text-white"></i>
</span>
<div wire:ignore.self class="modal fade" tabindex="-1" role="dialog" aria-labelledby="discountModalLabel"
    aria-hidden="true" id="discountModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="discountModalLabel">
                    Payments
                    <br>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form  action="{{ route('sale-payments.sale-bulk') }}" method="POST">
                <div class="modal-body">
                    @csrf
                    <div class="form-row">

                        <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="customer_id">Customer <span class="text-danger">*</span></label>
                                    <select class="form-control" name="customer_id" id="customer_id" required>
                                        @foreach (\Modules\People\Entities\Customer::all() as $customer)
                                            <option value="{{ $customer->id }}">{{ $customer->customer_name }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="amount">Amount <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="amount" required
                                        value="">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="code">Cheque/Mpesa-code</label>
                                    <input type="text" class="form-control" name="code" value="">
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="date">Date</label>
                                    <input type="date" class="form-control" name="date" value="{{ now()->format('Y-m-d') }}">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="payment_method">Payment method <span class="text-danger">*</span></label>
                                        <select class="form-control" name="payment_method" id="status" required>
                                            <option value="Cash">Cash</option>
                                            <option value="Credit Card">Credit Card</option>
                                            <option value="Bank Transfer">Bank Transfer</option>
                                            <option value="Cheque">Cheque</option>
                                            <option value="Mpesa">M-pesa</option>
                                            <option value="Other">Other</option>
                                        </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>

        </div>
    </div>
</div>
