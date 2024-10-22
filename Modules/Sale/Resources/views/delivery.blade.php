<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Delivery Note</title>
    <link rel="stylesheet" href="{{ public_path('b3/bootstrap.min.css') }}">

</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12">
                <div style="text-align: center; margin-bottom: 25px;">
                    <img width="180" src="{{ public_path('images/logo/logo.png') }}" alt="Logo">
                    <h4 style="margin-bottom: 20px;">
                        <span>Delivery Note No:</span> <strong>{{ $sale->reference }}</strong>
                    </h4>
                </div>

                <div class="card">
                    <div class="card-body">

                        <!-- Aligning Company Info, Customer Info, and Invoice Info -->
                        <table width="100%" cellpadding="10">
                            <tr>
                                <td align="left" width="33%">
                                    <h4 style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Company Info:
                                    </h4>
                                    <div><strong>{{ settings()->company_name }}</strong></div>
                                    <div>{{ settings()->company_address }}</div>
                                    <div>Email: {{ settings()->company_email }}</div>
                                    <div>Phone: {{ settings()->company_phone }}</div>
                                    <div>PIN: {{ env('KRA_PIN') }}</div>
                                </td>

                                <td align="center" width="33%">
                                    <h4 style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Customer Info:
                                    </h4>
                                    <div><strong>{{ $customer->customer_name }}</strong></div>
                                    <div>{{ $customer->address }}</div>
                                    {{-- <div>Email: {{ $customer->customer_email }}</div>
                                    <div>Phone: {{ $customer->customer_phone }}</div> --}}
                                    <div>Pin: {{ $customer->pin }}</div>
                                </td>

                                <td align="right" width="33%">
                                    <h4 style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Invoice Info:
                                    </h4>
                                    <div>Invoice: <strong>INV/{{ $sale->reference }}</strong></div>
                                    <div>Date: {{ \Carbon\Carbon::parse($sale->date)->format('d M, Y') }}</div>
                                    <div>Status: <strong>{{ $sale->status }}</strong></div>
                                    <div>Payment Status: <strong>{{ $sale->payment_status }}</strong></div>
                                </td>
                            </tr>
                        </table>

                        <!-- Sale Details Table -->
                        <div class="table-responsive-sm" style="margin-top: 30px;">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Quantity</th>
                                        <th>Particulars</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($sale->saleDetails as $item)
                                        <tr>
                                            <td>{{ $item->quantity }}</td>
                                            <td>{{ $item->product_name }}<br><span
                                                    class="badge badge-success">{{ $item->product_code }}</span></td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>

                        <!-- Summary Section -->
                        <div class="row">
                            <div class="col-xs-4 col-xs-offset-8">
                                <table class="table">
                                    <tbody>
                                        {{-- <tr>
                                            <td align="left"><strong>Discount
                                                    ({{ $sale->discount_percentage }}%)</strong></td>
                                            <td align="right">{{ format_currency($sale->discount_amount) }}</td>
                                        </tr> --}}
{{--
                                        @if (env('TAX_APPLY'))
                                            <tr>
                                                <td align="left"><strong>Tax ({{ $sale->tax_percentage }}%)</strong>
                                                </td>
                                                <td align="right">{{ format_currency($sale->tax_amount) }}</td>
                                            </tr>
                                        @endif --}}
                                        {{-- <tr>
                                            <td align="left"><strong>Shipping</strong></td>
                                            <td align="right">{{ format_currency($sale->shipping_amount) }}</td>
                                        </tr> --}}
                                        {{-- <tr>
                                            <td align="left"><strong>Grand Total</strong></td>
                                            <td align="right">
                                                <strong>{{ format_currency($sale->total_amount) }}</strong>
                                            </td>
                                        </tr> --}}
                                    </tbody>
                                </table>
                            </div>
                        </div>


                    </div>

                </div>
            </div>
        </div>

        <!-- Footer at the bottom -->
        <div class="footer" style="height: 100px"> </div>
        <hr>

        <div style="float: right">
            <h2>Terms & Conditions</h2>
            <ul>
                <li>Pricing are subject to 16% VAT</li>
                <li>Errors and omissions exempted</li>
                <li>All prices quoted are absolutely confidential</li>
                <li>Delivery 2 days after receiving the LPO</li>
                <li>Payment cash on collection or delivery</li>
                <li>Prices are subject to change without prior notice.</li>
            </ul>
            <br>

            <hr>
            <b>Above merchadise received in good condtion</b>
            <hr>
            <div>
                <p>Delivered By______________________ Signature______________</p>
            </div>
            <br>

            <div>
                <p>Received By______________________ Signature______________</p>
            </div>
        </div>
    </div>
</body>

</html>
