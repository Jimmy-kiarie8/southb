@extends('layouts.app')

@section('title', 'Product Details')

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item"><a href="{{ route('transfer.index') }}">Transfer</a></li>
        <li class="breadcrumb-item active">Details</li>
    </ol>
@endsection

@section('content')
    <div class="container-fluid mb-4">
        <div class="row mb-3">
            <div class="col-md-12">
                {!! \Milon\Barcode\Facades\DNS1DFacade::getBarCodeSVG($transfer->reference, 'C39+', 2, 110) !!}
            </div>
        </div>
        <div class="row">
            <div class="col-lg-9">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped mb-0">
                                <tr>
                                    <th>Reference</th>
                                    <td>{{ $transfer->reference }}</td>
                                </tr>
                                <tr>
                                    <th>From</th>
                                    <td>{{ $transfer->from_location->location }}</td>
                                </tr>
                                <tr>
                                    <th>To</th>
                                    <td>{{ $transfer->location->location }}</td>
                                </tr>
                                <tr>
                                    <th>Status</th>
                                    <td>{{ $transfer->status }}</td>
                                </tr>
                                <tr>
                                    <th>Note</th>
                                    <td>{{ $transfer->product_note ?? 'N/A' }}</td>
                                </tr>
                            </table>
                        </div>
                        <br>
                        <br>
                        <h3>Product Locations</h3>

                        <table class="table table-bordered table-striped mb-0">
                            <thead>
                                <tr>
                                    <th>Product code</th>
                                    <th>Product name</th>
                                    <th>Quantity</th>
                                    <th>Created at</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($transfer->products as $item)
                                    <tr>
                                        <td>{{ $item->product_code }}</td>
                                        <td>{{ $item->product_name }}</td>
                                        <td>{{ $item->pivot->quantity }}</td>
                                        <td>{{ $item->created_at }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>



                </div>
            </div>

        </div>
    </div>
@endsection
