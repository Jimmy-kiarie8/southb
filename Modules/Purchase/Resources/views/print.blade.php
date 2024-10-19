<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Purchase Details</title>
    <link rel="stylesheet" href="{{ public_path('b3/bootstrap.min.css') }}">
</head>
<body>
    <div class="container-fluid">
        <div style="text-align: center; margin-bottom: 25px;">
            <img width="180" src="{{ public_path('/images/logo/logo.png') }}" alt="Logo">
            <h4 style="margin-bottom: 20px;">
                <span>Reference::</span> <strong>{{ $purchase->reference }}</strong>
            </h4>
        </div>

        <table style="width: 100%; border-collapse: collapse;">
            <tr>
                <!-- Company Information -->
                <td style="vertical-align: top; padding: 10px; border-right: 1px solid #dddddd;">
                    <h4 style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Company Info:</h4>
                    <div><strong>{{ settings()->company_name }}</strong></div>
                    <div>{{ settings()->company_address }}</div>
                    <div>Email: {{ settings()->company_email }}</div>
                    <div>Phone: {{ settings()->company_phone }}</div>
                </td>

                <!-- Supplier Information -->
                <td style="vertical-align: top; padding: 10px; border-right: 1px solid #dddddd;">
                    <h4 style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Supplier Info:</h4>
                    @if ($supplier)
                        <div><strong>{{ $supplier->supplier_name }}</strong></div>
                        <div>{{ $supplier->address }}</div>
                        <div>Email: {{ $supplier->supplier_email }}</div>
                        <div>Phone: {{ $supplier->supplier_phone }}</div>
                    @endif
                </td>

                <!-- Invoice Information -->
                <td style="vertical-align: top; padding: 10px;">
                    <h4 style="border-bottom: 1px solid #dddddd; padding-bottom: 10px;">Invoice Info:</h4>
                    <div>Invoice: <strong>INV/{{ $purchase->reference }}</strong></div>
                    <div>Date: {{ \Carbon\Carbon::parse($purchase->date)->format('d M, Y') }}</div>
                    <div>Status: <strong>{{ $purchase->status }}</strong></div>
                    <div>Payment Status: <strong>{{ $purchase->payment_status }}</strong></div>
                </td>
            </tr>
        </table>

        <div style="margin-top: 30px;">
            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Net Unit Price</th>
                        <th>Quantity</th>
                        <th>Discount</th>
                        <th>Tax</th>
                        <th>Sub Total</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($purchase->purchaseDetails as $item)
                        <tr>
                            <td>
                                {{ $item->product_name }} <br>
                                <span class="badge badge-success">{{ $item->product_code }}</span>
                            </td>
                            <td>{{ format_currency($item->unit_price) }}</td>
                            <td>{{ $item->quantity }}</td>
                            <td>{{ format_currency($item->product_discount_amount) }}</td>
                            <td>{{ format_currency($item->product_tax_amount) }}</td>
                            <td>{{ format_currency($item->unit_price * $item->quantity) }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

        <div style="margin-top: 30px; text-align: right;">
            <table style="width: 100%; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <td><strong>Discount ({{ $purchase->discount_percentage }}%)</strong></td>
                        <td>{{ format_currency($purchase->discount_amount) }}</td>
                    </tr>
                    <tr>
                        <td><strong>Tax ({{ $purchase->tax_percentage }}%)</strong></td>
                        <td>{{ format_currency($purchase->tax_amount) }}</td>
                    </tr>
                    <tr>
                        <td><strong>Shipping</strong></td>
                        <td>{{ format_currency($purchase->shipping_amount) }}</td>
                    </tr>
                    <tr>
                        <td><strong>Grand Total</strong></td>
                        <td><strong>{{ format_currency($purchase->total_amount) }}</strong></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div style="margin-top: 25px; text-align: center;">
            <p style="font-style: italic;">{{ settings()->company_name }} &copy; {{ date('Y') }}.</p>
        </div>
    </div>
</body>


</html>
