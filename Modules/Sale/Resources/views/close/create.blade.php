@extends('layouts.app')

@section('title', 'Create Sale')

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item"><a href="{{ route('close.index') }}">End Of Day</a></li>
        <li class="breadcrumb-item active">Add</li>
    </ol>
@endsection

@section('content')
    <div class="container-fluid mb-4">
        <div class="row mt-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        @include('utils.alerts')
                        <form id="sale-form" action="{{ route('close.store') }}" method="POST">
                            @csrf

                            <div class="form-row">
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="reference">Reference <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="reference" required readonly
                                            value="COD">
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="date">Date <span class="text-danger">*</span></label>
                                        <input type="date" class="form-control" name="date" required
                                            value="{{ date('Y-m-d') }}">
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="cash">Cash </label>
                                        <input type="text" class="form-control" name="cash" required
                                            value="0">
                                    </div>
                                </div>


                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="cb1">CB1 </label>
                                        <input type="text" class="form-control" name="cb1" required
                                            value="0">
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="cb2">CB2 </label>
                                        <input type="text" class="form-control" name="cb2" required
                                            value="0">
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="kcb">KCB </label>
                                        <input type="text" class="form-control" name="kcb" required
                                            value="0">
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="equity">Equity </label>
                                        <input type="text" class="form-control" name="equity" required
                                            value="0">
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="mpesa">Mpesa </label>
                                        <input type="text" class="form-control" name="mpesa" required
                                            value="0">
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="credit">Credit </label>
                                        <input type="text" class="form-control" name="credit" required
                                            value="0">
                                    </div>
                                </div>


                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="credit_paid">Credit Paid Cash</label>
                                        <input type="text" class="form-control" name="credit_paid" required
                                            value="0">
                                    </div>
                                </div>
                            </div>


                            <div class="mt-3">
                                <button type="submit" class="btn btn-primary">
                                    Create <i class="bi bi-check"></i>
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>



    </div>
@endsection
