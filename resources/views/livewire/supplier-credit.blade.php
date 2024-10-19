<span role="button" class="btn btn-primary" data-toggle="modal" data-target="#credit">
    CD Note <i class="bi bi-pencil-square text-white"></i>
</span>
<div wire:ignore.self class="modal fade" tabindex="-1" role="dialog" aria-labelledby="creditLabel"
    aria-hidden="true" id="credit">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="creditLabel">
                    Credit Note
                    <br>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form  action="{{ route('sale-payments.purchase-bulk') }}" method="POST">

                <input type="hidden" name="type" value="credit">
                <div class="modal-body">
                    @csrf
                    <div class="form-row">

                        <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="supplier_id">Supplier <span class="text-danger">*</span></label>
                                    <select class="form-control" name="supplier_id" id="supplier_id" required>
                                        @foreach (\Modules\People\Entities\Supplier::all() as $supplier)
                                            <option value="{{ $supplier->id }}">{{ $supplier->supplier_name }}
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
                        {{-- <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="code">Cheque/Mpesa-code</label>
                                    <input type="text" class="form-control" name="code" value="">
                                </div>
                            </div>
                        </div> --}}
                        <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="date">Date</label>
                                    <input type="date" class="form-control" name="date" value="{{ now()->format('Y-m-d') }}">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12" style="display: none">
                            <div class="from-group">
                                <div class="form-group">
                                        <select class="form-control" name="payment_method" id="status" >
                                            <option value="Credit" selected>Credit Card</option>
                                        </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12">
                            <div class="from-group">
                                <div class="form-group">
                                    <label for="code">Notes</label>
                                    <textarea name="notes" class="form-control" id="" cols="5" rows="3"></textarea>
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
