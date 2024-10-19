@extends('layouts.app')

@section('title', 'Products')

@section('third_party_stylesheets')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/dataTables.bootstrap4.min.css">
@endsection

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item active">Products</li>
    </ol>
@endsection

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">


                        <a href="{{ route('products.create') }}" class="btn btn-primary">
                            Add Product <i class="bi bi-plus"></i>
                        </a>

                        <form class="form-row" action="{{ route('product.lowstock') }}" method="POST" target="_blank">
                            @csrf
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="supplier_id">Supplier <span class="text-danger">*</span></label>
                                    <select class="form-control" name="supplier_id" id="supplier_id" required>
                                        <option value="0" selected>All</option>
                                        @foreach (\Modules\People\Entities\Supplier::all() as $supplier)
                                            <option value="{{ $supplier->id }}">{{ $supplier->supplier_name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit" style="margin-top: 30px;">
                                    Below Reorder Level <i class="bi bi-plus"></i>
                                </button>
                            </div>
                        </div>
                        </form>

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
