@extends('layouts.app')

@section('title', 'Sales Details')

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item"><a href="{{ route('sales.index') }}">Sales</a></li>
        <li class="breadcrumb-item active">Details</li>
    </ol>
@endsection

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header d-flex flex-wrap align-items-center">
                        <div>
                            Reference: <strong>{{ $payment->code }}</strong>
                        </div>
                        {{-- <a target="_blank" class="btn btn-sm btn-secondary mfs-auto mfe-1 d-print-none"
                            href="{{ route('sales.pdf', $payment->id) }}">
                            <i class="bi bi-printer"></i> Print
                        </a>
                        <a target="_blank" class="btn btn-sm btn-info mfe-1 d-print-none"
                            href="{{ route('sales.pdf', $payment->id) }}">
                            <i class="bi bi-save"></i> Save
                        </a> --}}
                    </div>
                    <div class="card-body">
                        <div class="row mb-4">
                            <div class="col-sm-4 mb-3 mb-md-0">
                                <h5 class="mb-2 border-bottom pb-2">Company Info:</h5>
                                <div><strong>{{ settings()->company_name }}</strong></div>
                                <div>{{ settings()->company_address }}</div>
                                <div>Email: {{ settings()->company_email }}</div>
                                <div>Phone: {{ settings()->company_phone }}</div>
                            </div>

                            @if ($payment->supplier)
                                <div class="col-sm-4 mb-3 mb-md-0">
                                    <h5 class="mb-2 border-bottom pb-2">Supplier Info:</h5>
                                    <div><strong>{{ $payment->supplier->supplier_name }}</strong></div>
                                    <div>{{ $payment->supplier->address }}</div>
                                    <div>Email: {{ $payment->supplier->supplier_email }}</div>
                                    <div>Phone: {{ $payment->supplier->supplier_phone }}</div>
                                </div>
                            @endif

                            <div class="col-sm-4 mb-3 mb-md-0">
                                <h5 class="mb-2 border-bottom pb-2">Payment Info:</h5>
                                <div>Reference No: <strong>{{ $payment->reference }}</strong></div>
                                <div>Date: {{ \Carbon\Carbon::parse($payment->date)->format('d M, Y') }}</div>
                                <div>
                                    Cheque/M-pesa code: <strong>{{ $payment->code }}</strong>
                                </div>
                                <div>
                                    Payment Method: <strong>{{ $payment->payment_method }}</strong>
                                </div>
                            </div>

                        </div>

                        <div class="table-responsive-sm">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th class="align-middle">Payment Ref.</th>
                                        <th class="align-middle">Order No.</th>
                                        <th class="align-middle">Supplier Name</th>
                                        <th class="align-middle">Total Amount</th>
                                        <th class="align-middle">Paid Amount</th>
                                        <th class="align-middle">Due Amount</th>
                                        <th class="align-middle">Payment Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($payment->payments as $item)
                                        <tr>
                                            <td class="align-middle"> {{ $item->reference }}</td>
                                            <td class="align-middle"> {{ $item->purchase->reference }}</td>
                                            <td class="align-middle"> {{ $item->purchase->supplier_name }}</td>
                                            <td class="align-middle">{{ format_currency($item->purchase->total_amount) }}</td>
                                            <td class="align-middle">{{ format_currency($item->purchase->paid_amount) }}</td>
                                            <td class="align-middle">{{ format_currency($item->purchase->due_amount) }}</td>
                                            <td class="align-middle">
                                                @if ($item->purchase->payment_status == 'Partial')
                                                    <span class="badge badge-warning">
                                                        {{ $item->purchase->payment_status }}
                                                    </span>
                                                @elseif ($item->purchase->payment_status == 'Paid')
                                                    <span class="badge badge-success">
                                                        {{ $item->purchase->payment_status }}
                                                    </span>
                                                @else
                                                    <span class="badge badge-danger">
                                                        {{ $item->purchase->payment_status }}
                                                    </span>
                                                @endif
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-lg-4 col-sm-5 ml-md-auto">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="left"><strong>Total Paid</strong></td>
                                            <td class="right">
                                                <strong>{{ format_currency($payment->amount) }}</strong></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
