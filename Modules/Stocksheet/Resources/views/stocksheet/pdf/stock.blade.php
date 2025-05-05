<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Stock Sheet</title>
    <style type="text/css">
        @page {
            margin: 40px;
        }

        body {
            margin: 0px;
            background: #fff;
        }

        * {
            font-family: Verdana, Arial, sans-serif;
        }

        a {
            color: #fff;
            text-decoration: none;
        }

        table {
        }

        tfoot tr td {
            font-weight: bold;
        }

        .invoice table {
            margin: 15px;
        }

        .invoice h3 {
            margin-left: 15px;
        }


        .information .logo {
            margin: 5px;
        }

        .information table {
            padding: 10px;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 0, 0, 0.05);
        }

        .table-dark.table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(255, 255, 255, 0.05);
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
        }

        .page-break {
            page-break-after: always;
        }

        .table thead {
            display: table-header-group;
            vertical-align: middle;
            border-color: inherit;
        }

        .table tr {
            display: table-row;
            vertical-align: inherit;
            border-color: inherit;
        }

        .table tbody {
            display: table-row-group;
            vertical-align: middle;
            border-color: inherit;
        }

        .table td,
        .table th {
            padding: .25rem;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
            font-size: 12px;
        }

        th {
            text-align: inherit;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 0, 0, 0.05);
        }

        .table-dark.table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(255, 255, 255, 0.05);
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
        }
    </style>

</head>

<body>

    <div>
        <div class="information">
            <table width="100%">
                <tr>
                    <td align="left">
                        <img src="{{ public_path(env('LOGO')) }}" alt="{{ $company->company_name }}" style="width:200px;">
                    </td>
                    <td align="right" style="width: 40%;">
                        <h3>{{ isset($report_title) ? $report_title : date('D d M Y') . ' Stock Sheet' }}</h3> <br>
                        <small>{{ $company->company_name }}</small> <br>
                        <small>{{ $company->company_phone }}</small> <br>
                        <address>{{ $company->company_email }}</address> <br>
                        <address>{{ $company->company_address }}</address> <br>
                        </pre>
                    </td>
                </tr>
            </table>
        </div>
        <div class="invoice">
            <hr style="color: rgba(0,0,0,.12)" />
            <table width="100%" class="table table-striped">
                <thead style="text-align: left">
                    <tr>
                        <th>#</th>
                        <th>Product Name</th>
                        <th>Code</th>
                        <th>Quantity</th>
                        <th>Actual Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($data as $key => $product)
                    <tr>
                        <td>{{ $key + 1 }}</td>
                        <td>{{ $product->product_name }}</td>
                        <td>{{ $product->product_code }}</td>
                        <td>{{ $product->product_quantity }}</td>
                        <td>____________________</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

        <div class="information" style="position: absolute; bottom: 0;">
            <table width="100%" class="table table-striped">
                <tr>
                    <td align="left" style="width: 50%;">
                        {{-- &copy; {{ date('Y') }} {{ $company->name }} - All rights reserved. --}}
                    </td>
                    <td align="right" style="width: 50%;">
                       <a href="www.amrosab.com" style="color: #212529" target="_blank">www.amrosab.com</a>
                       {{-- <a href="{{ $company->website }}" style="color: #212529" target="_blank">{{ $company->website }}</a> --}}
                    </td>
                </tr>

            </table>
        </div>
    </div>

</body>

</html>
