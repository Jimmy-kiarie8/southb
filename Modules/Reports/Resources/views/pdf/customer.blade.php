<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Sales Report</title>
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

        table {}

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

        address {
            font-size: 13px;
        }
    </style>

</head>

<body>

    <div>
        <div class="information">
            <table width="100%">
                <tr>
                    <td align="left">
                        <img src="{{ public_path('images/logo/logo.png') }}" alt="{{ $company->company_name }}"
                            style="width:180px;">
                    </td>
                    <td align="right" style="width: 40%;">
                        <b>Customer Statement</b> <br>
                        <strong>{{ $customer_name }}</strong><br>
                        <small>From <b>{{ $start_date }}</b> to <b>{{ $end_date }}</b></small> <br>
                        <small>{{ $company->company_name }}</small> <br>
                        <small>{{ $company->company_phone }}</small>
                        <address>{{ $company->company_email }}</address>
                        <address>{{ $company->company_address }}</address> <br>
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
                        <th>Date</th>
                        <th>Type</th>
                        <th>Order No.</th>
                        <th>Payment Ref</th>
                        {{-- <th>Customer name</th> --}}
                        <th>Debit</th>
                        <th>Credit</th>
                        <th>Balance</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="5"></td>
                        <td>Balance B/F</td>
                        <td>{{ format_currency($running_balance) }}</td>
                    </tr>
                    @php
                        $run_bal = $running_balance;
                    @endphp
                    @foreach ($data as $key => $report)
                        @php
                            if ($report->type == 'Sale') {
                                $run_bal += $report->total_amount;
                            } elseif ($report->type == 'Payment') {
                                $run_bal -= $report->amount;
                            }
                        @endphp
                        <tr>
                            <td> {{ $loop->iteration }}</td>
                            <td>{{ $report->date }}</td>
                            <td>{{ $report->type }}</td>
                            <td>{{ $report->reference }}</td>
                            <td>{{ $report->payment_code }}</td>
                            {{-- <td>{{ $report->customer_name }}</td> --}}
                            <td>{{ format_currency($report->total_amount) }}</td>
                            <td>
                                @if ($report->type == 'Sale')
                                    {{ format_currency(0) }}
                                @else
                                    {{ format_currency($report->paid_amount) }}
                                @endif
                            </td>
                            <td>{{ format_currency($run_bal) }}</td>
                        </tr>
                    @endforeach
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="4"></th>
                        <th>Sale Total</th>
                        <th colspan="3">{{ format_currency($sumSales) }}</th>
                    </tr>

                    <tr>
                        <th colspan="4"></th>
                        <th>Payment Total</th>
                        <th colspan="3">{{ format_currency($sumPayments) }}</th>
                    </tr>

                    <tr>
                        <th colspan="4"></th>
                        <th>Balance</th>
                        <th colspan="3">{{ format_currency($difference) }}</th>
                    </tr>
                    {{-- <tr>
                        <th colspan="4"></th>
                        <th>Cumulative Total</th>
                        <th colspan="3">{{ format_currency($cum_total) }}</th>
                    </tr> --}}
                </tfoot>
            </table>
        </div>

        <div class="information" style="position: absolute; bottom: 0;">
            <table width="100%" class="table table-striped">
                <tr>
                    <td align="left" style="width: 50%;">
                        {{-- &copy; {{ date('Y') }} {{ $company->name }} - All rights reserved. --}}
                    </td>
                    <td align="right" style="width: 50%;">
                        <a href="https://hillsdatatechnologies.co.ke" style="color: #212529"
                            target="_blank">hillsdatatechnologies.co.ke</a>
                        {{-- <a href="{{ $company->website }}" style="color: #212529" target="_blank">{{ $company->website }}</a> --}}
                    </td>
                </tr>

            </table>
        </div>
    </div>

</body>

</html>
