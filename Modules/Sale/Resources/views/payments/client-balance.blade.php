@extends('layouts.app')

@section('title', 'Balance Client Statement')

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item"><a href="{{ route('sale-payments.bulkIndex') }}">Receipts</a></li>
        <li class="breadcrumb-item active">Balance Client Statement</li>
    </ol>
@endsection

@section('content')
    <div class="container-fluid">
        <livewire:sale.client-balance :customers="\Modules\People\Entities\Customer::orderBy('customer_name')->get()" />
    </div>
@endsection
