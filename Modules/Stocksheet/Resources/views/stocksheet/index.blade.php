@extends('layouts.app')

@section('title', 'Stock sheet')

@section('third_party_stylesheets')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/dataTables.bootstrap4.min.css">
@endsection

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item active">Stock sheet</li>
    </ol>
@endsection

@section('content')
    @php
        $directory = public_path('stockreports');
        $files = File::glob($directory . '/*.pdf');
        $latestFiles = array_slice(array_reverse($files), 0, 8);
    @endphp

    @php
        $directory = public_path('stocklevels');
        $fileL = File::glob($directory . '/*.pdf');
        $latestFileL = array_slice(array_reverse($fileL), 0, 8);
    @endphp

    @php
        $directory = public_path('closingstock');
        if (File::exists($directory)) {
            $fileC = File::glob($directory . '/*.pdf');
            $latestFileC = array_slice(array_reverse($fileC), 0, 8);
        } else {
            $latestFileC = [];
        }
    @endphp


    <div class="container-fluid">

        <div class="accordion accordion-flush" id="accordionFlushExample">

            <div>
                <div class="row">
                    <div class="col-4">


                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseOne" aria-expanded="false"
                                    aria-controls="flush-collapseOne"
                                    style="border: 1px solid #dedede;border-radius: 10px;padding: 10px;background: #fff;">
                                    Latest Generated Stock sheets
                                </button>
                            </h2>
                            <div id="flush-collapseOne" class="accordion-collapse collapse"
                                data-bs-parent="#accordionFlushExample"
                                style="border: 1px solid #dedede;border-radius: 10px;padding: 10px;background: #fff;">
                                <div class="accordion-body">


                                    <div class="list-group">
                                        @foreach ($latestFiles as $file)
                                            @php
                                                $filename = basename($file);
                                                $fileUrl = asset("stockreports/{$filename}"); // Removed 'pos/public/'
                                            @endphp
                                            <a href="{{ $fileUrl }}" class="list-group-item list-group-item-action"
                                                target="_blank">
                                                {{ $filename }}
                                            </a>
                                        @endforeach
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-4">

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    style="border: 1px solid #dedede;border-radius: 10px;padding: 10px;background: #fff;"
                                    data-bs-target="#flush-collapseTwo" aria-expanded="false"
                                    aria-controls="flush-collapseTwo">
                                    Latest Generated Stock Level
                                </button>
                            </h2>
                            <div id="flush-collapseTwo" class="accordion-collapse collapse"
                                data-bs-parent="#accordionFlushExample"
                                style="border: 1px solid #dedede;border-radius: 10px;padding: 10px;background: #fff;">
                                <div class="accordion-body">


                                    <div class="list-group">
                                        @foreach ($latestFileL as $file)
                                            @php
                                                $filename = basename($file);
                                                $fileUrl = asset("stocklevels/{$filename}"); // Removed 'pos/public/'
                                            @endphp
                                            <a href="{{ $fileUrl }}" class="list-group-item list-group-item-action"
                                                target="_blank">
                                                {{ $filename }}
                                            </a>
                                        @endforeach
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    style="border: 1px solid #dedede;border-radius: 10px;padding: 10px;background: #fff;"
                                    data-bs-target="#flush-collapseThree" aria-expanded="false"
                                    aria-controls="flush-collapseThree">
                                    Latest Generated Closing Stock
                                </button>
                            </h2>
                            <div id="flush-collapseThree" class="accordion-collapse collapse"
                                data-bs-parent="#accordionFlushExample"
                                style="border: 1px solid #dedede;border-radius: 10px;padding: 10px;background: #fff;">
                                <div class="accordion-body">
                                    <div class="list-group">
                                        @if(count($latestFileC) > 0)
                                            @foreach ($latestFileC as $file)
                                                @php
                                                    $filename = basename($file);
                                                    $fileUrl = asset("closingstock/{$filename}");
                                                @endphp
                                                <a href="{{ $fileUrl }}" class="list-group-item list-group-item-action"
                                                    target="_blank">
                                                    {{ $filename }}
                                                </a>
                                            @endforeach
                                        @else
                                            <div class="text-center">No closing stock reports generated yet.</div>
                                        @endif
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <form class="form-row" action="{{ route('stocksheet.index') }}" method="GET">
                            {{-- @csrf --}}
                            <div class="col-md-3">
                                <select class="form-control" name="location_id" id="location_id"
                                    wire:change="selectLocation($event.target.value)">
                                    <option value="" {{ request('location_id') == '' ? 'selected' : '' }}>
                                        All</option>
                                    @foreach (\Modules\Branch\Entities\Branch::all() as $location)
                                        <option value="{{ $location->id }}"
                                            {{ request('location_id') == $location->id ? 'selected' : '' }}>
                                            {{ $location->name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" name="as_of_date" id="as_of_date"
                                    value="{{ request('as_of_date', '') }}" placeholder="Stock as of date">
                                <small class="form-text text-muted">Stock as of date (e.g., 2024-12-31)</small>
                            </div>
                            <button class="btn btn-primary" type="submit">Filter <i class="bi bi-search"></i></button>
                        </form>
                        <br>
                        {{--
                            <button class="btn btn-primary">
                                Create Stock Sheet <i class="bi bi-plus"></i>
                            </button> --}}

                        <div>
                            <div class="row">
                                <div class="col-2">

                                    <form action="{{ route('stocksheet.sheet') }}" method="POST">
                                        @csrf
                                        <input type="hidden" name="location_id" value="{{ request('location_id') }}">
                                        <input type="hidden" name="as_of_date" value="{{ request('as_of_date') }}">
                                        <div class="btn-group">
                                            <button class="btn btn-primary" type="submit">
                                                <i class="bi bi-file-earmark-pdf"></i> Stock sheet
                                            </button>
                                            <button class="btn btn-success" type="submit" name="format" value="excel">
                                                <i class="bi bi-file-earmark-excel"></i> Excel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-2">

                                    <form action="{{ route('stocksheet.level') }}" method="POST">
                                        @csrf
                                        <input type="hidden" name="location_id" value="{{ request('location_id') }}">
                                        <input type="hidden" name="as_of_date" value="{{ request('as_of_date') }}">
                                        <div class="btn-group">
                                            <button class="btn btn-primary" type="submit">
                                                <i class="bi bi-file-earmark-pdf"></i> Stock Level
                                            </button>
                                            <button class="btn btn-success" type="submit" name="format" value="excel">
                                                <i class="bi bi-file-earmark-excel"></i> Excel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-2">
                                    <form action="{{ route('stocksheet.closing') }}" method="POST">
                                        @csrf
                                        <input type="hidden" name="location_id" value="{{ request('location_id') }}">
                                        <input type="hidden" name="as_of_date" value="{{ request('as_of_date') }}">
                                        <div class="btn-group">
                                            <button class="btn btn-success" type="submit">
                                                <i class="bi bi-file-earmark-pdf"></i> Closing Stock
                                            </button>
                                            <button class="btn btn-info" type="submit" name="format" value="excel">
                                                <i class="bi bi-file-earmark-excel"></i> Excel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>




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
