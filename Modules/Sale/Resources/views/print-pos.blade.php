<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{{ settings()->company_name }}</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        * {
            font-size: 15px;
            line-height: 18px;
            font-family: 'Ubuntu', sans-serif;
        }

        h2 {
            font-size: 16px;
        }

        td,
        th,
        tr,
        table {
            border-collapse: collapse;
        }

        tr {
            border-bottom: 1px dashed #ddd;
        }

        td,
        th {
            padding: 7px 0;
            width: 50%;
        }

        table {
            width: 100%;
        }

        tfoot tr th:first-child {
            text-align: left;
        }

        .centered {
            text-align: center;
            align-content: center;
        }

        small {
            font-size: 10px;
        }

        p {
            font-size: 14px;

        }

        @media print {
            * {
                font-size: 14px;
                line-height: 20px;
            }

            td,
            th {
                padding: 5px 0;
            }

            .hidden-print {
                display: none !important;
            }

            tbody::after {
                content: '';
                display: block;
                page-break-after: always;
                page-break-inside: auto;
                page-break-before: avoid;
            }
        }
    </style>
</head>

<body>

    <div style="max-width:400px;margin:0 auto">
        <div id="receipt-data">
            <div class="centered">
                KWA NDEGE
                <h2 style="margin-bottom: 5px">{{ settings()->company_name }}</h2>

                <strong>Cash Sale</strong>
                <br>
                <small>{{ $sale->created_at }}</small>



            </div>
            <img src="{{ $sale->barcode }}" style="width: 190px; height: 30px">
            <p>
                Date: {{ \Carbon\Carbon::parse($sale->date)->format('d M, Y') }}<br>
                Receipt No: {{ $sale->reference }}<br>
                Name: {{ $sale->customer_name }}
            </p>
            @foreach ($sale->saleDetails as $saleDetail)
            <div style="border-bottom: 1px solid #999">
                    <b style="font-size: 10px;">{{ $saleDetail->product_name }}: </b>
                    <br>
                    <small>({{ $saleDetail->quantity }} x {{ format_currency($saleDetail->price) }}) = Sh {{ ($saleDetail->sub_total) }}</small>

                </td>
                </div>
        @endforeach
            <table class="table-data">
                <tbody>



                    @if ($sale->tax_percentage)
                        <tr>
                            <th colspan="2" style="text-align:left">Tax ({{ $sale->tax_percentage }}%)</th>
                            <th style="text-align:right">{{ format_currency($sale->tax_amount) }}</th>
                        </tr>
                    @endif
                    @if ($sale->discount_percentage)
                        <tr>
                            <th colspan="2" style="text-align:left">Discount ({{ $sale->discount_percentage }}%)
                            </th>
                            <th style="text-align:right">{{ format_currency($sale->discount_amount) }}</th>
                        </tr>
                    @endif
                    @if ($sale->shipping_amount)
                        <tr>
                            <th colspan="2" style="text-align:left">Shipping</th>
                            <th style="text-align:right">{{ format_currency($sale->shipping_amount) }}</th>
                        </tr>
                    @endif


                    <tr>
                        <th colspan="2" style="text-align:left">Grand Total</th>
                        <th style="text-align:right">{{ format_currency($sale->total_amount) }}</th>
                    </tr>
                    @foreach ($sale->salePayments as $salePayment)
                        <tr>
                            <th colspan="2" style="text-align:left">{{ $salePayment->payment_method }}</th>
                            <th style="text-align:right">{{ format_currency($salePayment->amount) }}</th>
                        </tr>
                    @endforeach


                    @if ($sale->tax_charge)
                        <tr>
                            <th colspan="2" style="text-align:left">Net Total</th>
                            <th style="text-align:right">{{ format_currency($sale->total_amount - $sale->tax_charge) }}
                            </th>
                        </tr>
                        <tr>
                            <th colspan="2" style="text-align:left">VAT</th>
                            <th style="text-align:right">{{ format_currency($sale->tax_charge) }}</th>
                        </tr>
                    @endif


                    @if ($sale->change_amount > 0)
                        <tr>
                            <th colspan="2" style="text-align:left">Change</th>
                            <th style="text-align:right">{{ format_currency($sale->change_amount) }}</th>
                        </tr>
                    @endif
                </tbody>
            </table>
            <table>
                <tbody>
                    <tr style="background-color:#ddd;">
                        <td class="centered" style="padding: 5px;">
                            Amount paid
                        </td>
                        <td class="centered" style="padding: 5px;">
                            {{ format_currency($sale->paid_amount) }}
                        </td>
                    </tr>

                    <tr style="border-bottom: 0;">
                        <td class="centered" colspan="3">
                            <div style="margin-top: 0px;">
                                {{-- {!! \Milon\Barcode\Facades\DNS1DFacade::getBarcodeSVG($sale->reference, 'C128', 1, 25, 'black', true) !!} --}}

                                <b>Glad to be at your service!</b>
                                <br>
                                Served by: <b>{{ Auth::user()->name }}</b>
                            </div>
                            <hr>

                        </td>
                    </tr>
                </tbody>
            </table>

        </div>
    </div>

</body>

</html>
