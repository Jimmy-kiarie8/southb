<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quotation Details</title>
    <link rel="stylesheet" href="{{ public_path('b3/bootstrap.min.css') }}">
</head>
<style>
    td {
        font-size: 12px !important;
    }
</style>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12">
            <div style="text-align: center;">
                <img width="130" src="{{ public_path('images/logo/logo.png') }}" alt="Logo">
                <b style="">
                    <br>
                    <span>Reference::</span> <strong>{{ $quotation->reference }}</strong>
                </b>
            </div>
            <div class="card">
                <div class="card-body">

                <div class="card">
                    <div class="card-body">

                        <!-- Aligning Company Info, Customer Info, and Invoice Info -->
                        <table width="100%" cellpadding="10">
                            <tr>
                                <td align="left" width="33%">
                                    <b style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Company Info:
                                    </b>
                                    <div><strong>{{ settings()->company_name }}</strong></div>
                                    <div>{{ settings()->company_address }}</div>
                                    <div>Email: {{ settings()->company_email }}</div>
                                    <div>Phone: {{ settings()->company_phone }}</div>
                                    <div>PIN: {{ env('KRA_PIN') }}</div>
                                </td>

                                <td align="center" width="33%">
                                    <b style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Customer Info:
                                    </b>
                                    <div><strong>{{ $customer->customer_name }}</strong></div>
                                    <div>{{ $customer->address }}</div>
                                    {{-- <div>Email: {{ $customer->customer_email }}</div>
                                    <div>Phone: {{ $customer->customer_phone }}</div> --}}
                                    <div>Pin: {{ $customer->pin }}</div>
                                </td>

                                <td align="right" width="33%">
                                    <b style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Quotation Info:
                                    </b>
                                    <div>Quote No: <strong>{{ $quotation->reference }}</strong></div>
                                    <div>Date: {{ \Carbon\Carbon::parse($quotation->date)->format('d M, Y') }}</div>
                                    <div>Status: <strong>{{ $quotation->status }}</strong></div>
                                    <div>VAT Type: <strong>{{ $quotation->is_tax_inclusive ? 'Inclusive' : 'Exclusive' }}</strong></div>
                                </td>
                            </tr>
                        </table>

                        </div>

                        </div>


                    </div>

                </div>

                    <div class="table-responsive-sm" style="margin-top: 30px;">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th class="align-middle">Product</th>
                                <th class="align-middle">Unit Price</th>
                                <th class="align-middle">Quantity</th>
                                {{-- <th class="align-middle">Discount</th> --}}
                                {{-- <th class="align-middle">Tax</th> --}}
                                <th class="align-middle">Total</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($quotation->quotationDetails as $item)
                                <tr>
                                    <td class="align-middle">
                                        {{ $item->product_name }} <br>
                                        <small>
                                                ({{ $item->product_code }})
                                            </small>
                                    </td>

                                    <td class="align-middle">{{ format_currency($item->unit_price) }}</td>

                                    <td class="align-middle">
                                        {{ $item->quantity }}
                                    </td>

                                    {{-- <td class="align-middle">
                                        {{ format_currency($item->product_discount_amount) }}
                                    </td>

                                    <td class="align-middle">
                                        {{ format_currency($item->product_tax_amount) }}
                                    </td> --}}

                                    <td class="align-middle">
                                        {{ format_currency($item->unit_price * $item->quantity) }}
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-xs-4 col-xs-offset-8">
                            <table class="table">
                                <tbody>
                                {{-- <tr>
                                    <td class="left"><strong>Discount ({{ $quotation->discount_percentage }}%)</strong></td>
                                    <td class="right">{{ format_currency($quotation->discount_amount) }}</td>
                                </tr>--}}
                                <tr>
                                    <td class="left"><strong>Net Total</strong></td>
                                    <td class="right">
                                        {{ format_currency($quotation->total_amount) }}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="left"><strong>Tax</strong></td>
                                    <td class="right">
                                        {{ format_currency($quotation->total_amount*1.16 - $quotation->total_amount) }}
                                    </td>
                                </tr>
                                 {{-- <tr>
                                    <td class="left"><strong>Shipping)</strong></td>
                                    <td class="right">{{ format_currency($quotation->shipping_amount) }}</td>
                                </tr> --}}
                                <tr>
                                    <td class="left"><strong>Total</strong></td>
                                    <td class="right"><strong>
                                        {{ format_currency($quotation->total_amount*1.16) }}

                                    </strong>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    {{-- <div class="row" style="margin-top: 25px;">
                        <div class="col-xs-12">
                            <p style="font-style: italic;text-align: center">{{ settings()->company_name }} &copy; {{ date('Y') }}</p>
                        </div>
                    </div> --}}


        <!-- Footer at the bottom -->
        <div class="footer" style="height: 45px"> </div>
        <hr>

        <div>
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
            </div>
            <br>


            {{-- <b>Please check the above products if suitable for your intended use before offloading. If any claim it
                should be mentioned on the delivery note and signed by both parties, No claims will be taken later on if
                not mentioned on delivery note.</b>  --}}
            <br>
            <hr>
            <b>Above merchandise received in good condition</b>
            <hr>
            <div>
                <p>Received By____________ Signature________</p>
            </div>
        </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
