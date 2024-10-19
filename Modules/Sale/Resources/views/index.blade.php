@extends('layouts.app')

@section('title', 'Sales')

@section('third_party_stylesheets')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/dataTables.bootstrap4.min.css">
@endsection

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item active">Sales</li>
    </ol>
@endsection

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <a href="{{ route('sales.create') }}" class="btn btn-primary">
                            Add Sale <i class="bi bi-plus"></i>
                        </a>
                        <livewire:customer-payment/>


                        <form class="form-row" action="{{ route('sales.index') }}" method="GET">
                            {{-- @csrf --}}
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="payment_status">Payment status <span class="text-danger">*</span></label>
                                    <select class="form-control" name="payment_status" id="payment_status">
                                        <option value="" {{ request('payment_status') == '' ? 'selected' : '' }}>All</option>
                                        <option value="Unpaid" {{ request('payment_status') == 'Unpaid' ? 'selected' : '' }}>Unpaid</option>
                                        <option value="Paid" {{ request('payment_status') == 'Paid' ? 'selected' : '' }}>Paid</option>
                                        <option value="Credit" {{ request('payment_status') == 'Credit' ? 'selected' : '' }}>Credit</option>
                                        <option value="Partial" {{ request('payment_status') == 'Partial' ? 'selected' : '' }}>Partial</option>
                                    </select>

                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit" style="margin-top: 30px;">
                                        Filter <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>
                        </form>

                        {{-- <livewire:customer-payment/> --}}

                        <hr>

                        <div class="table-responsive">
                            {!! $dataTable->table() !!}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('page_scripts')
    {!! $dataTable->scripts() !!}
@endpush
