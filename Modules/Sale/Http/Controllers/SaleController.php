<?php

namespace Modules\Sale\Http\Controllers;

use Modules\Sale\DataTables\SalesDataTable;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Modules\Branch\Entities\ProductBranch;
use Modules\Invoice\Entities\Invoice;
use Modules\People\Entities\Customer;
use Modules\Product\Entities\Product;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleDetails;
use Modules\Sale\Entities\SalePayment;
use Modules\Sale\Http\Requests\StoreSaleRequest;
use Modules\Sale\Http\Requests\UpdateSaleRequest;

class SaleController extends Controller
{

    public function index(SalesDataTable $dataTable)
    {
        abort_if(Gate::denies('access_sales'), 403);
        // return request('payment_status');
        return $dataTable->render('sale::index');
    }


    public function create()
    {
        abort_if(Gate::denies('create_sales'), 403);

        Cart::instance('sale')->destroy();

        return view('sale::create');
    }


    public function store(StoreSaleRequest $request)
    {
        // return $request->all();

        $cart_items = Cart::instance('sale')->content();
        if (count($cart_items) < 1) {

            toast('Choose items!', 'error');

            return redirect()->route('sales.create')->withErrors('Choose itemss!');
        }

        DB::transaction(function () use ($request) {
            // $paid_amount =  $cash_paid_amount + $bank_paid_amount + $mpesa_paid_amount + $cheque_paid_amount;
            // $due_amount = $request->total_amount - $paid_amount;
            $location_id = ($request->location_id) ? $request->location_id : Auth::user()->branch_id;
            $paid_amount = $request->total_amount;

            $total_amount = 0;
            $cart_items = Cart::instance('sale')->content();

            foreach ($cart_items as $cart_item) {
                $total_amount += $cart_item->price * (int)$cart_item->qty;
            }
            $due_amount = $total_amount - $paid_amount;


            $payment_status = '';
            if ($request->payment_method === 'Credit' || $paid_amount == 0) {
                $paid_amount = 0;
                $due_amount = $total_amount;
                $payment_status = 'Credit';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }


            if (!$request->customer_id) {
                $customer_ =  Customer::first();

                if (!$customer_) {
                    $customer_ =  Customer::create([
                        'customer_name' => 'Walkin',
                    ]);
                }
                $customer_id =  $customer_->id;
                $customer_code =  $customer_->code;
                $customer_name =  $customer_->customer_name;
            } elseif (is_numeric($request->customer_id)) {
                $customer_id = $request->customer_id;
                $customer_ = Customer::findOrFail($request->customer_id);
                $customer_name = $customer_->customer_name;
                $customer_code =  $customer_->code;
            } else {
                $customer_id = null;
                $customer_name = $request->customer_id;
                if ($request->paid_amount == 0 || $request->payment_method == "Credit") {
                    $customer = Customer::create([
                        'customer_name'  => $request->customer_id,
                    ]);
                    $customer_id =  $customer->id;
                    $customer_code =  $customer->code;
                }
            }


            $sale = Sale::create([
                'date' => $request->date,
                'customer_id' => $customer_id,
                'branch_id' => $location_id,
                'clientcode' => $customer_code,
                'customer_name' => $customer_name,
                'tax_percentage' => $request->tax_percentage,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'paid_amount' => $paid_amount,
                'total_amount' => $total_amount,
                'due_amount' => $due_amount,
                'status' => $request->status,
                'payment_status' => $payment_status,
                // 'payment_status' => ($request->payment_method == "Credit") ? 'Unpaid' : $payment_status,
                'order_no' => $request->order_no,
                'payment_method' => $request->payment_method,
                'note' => $request->note,
                'tax_amount' => Cart::instance('sale')->tax(),
                'discount_amount' => Cart::instance('sale')->discount(),
            ]);

            if ($request->payment_method == "Credit") {
                // Create invoice
                $invoice = new Invoice();
                $data = [
                    'invoice_no' => 'INV',
                    'amount' => $request->total_amount,
                    'balance' => $request->total_amount,
                    'sale_id' => $sale->id,
                    'user_id' => Auth::id(),
                ];
                $invoice->invoice($data);
            }
            foreach (Cart::instance('sale')->content() as $cart_item) {
                $saleType = 'Retail';

                if (env('WHOLESALE_RETAIL')) {
                    $saleType = $request->saleType[$cart_item->id];
                }
                $factor= 1;
                $product_branch = ProductBranch::where('product_id', $cart_item->id)->where('branch_id', $location_id)->first();
                if ($saleType == 'Wholesale') {
                    $product = Product::findOrFail($cart_item->id);
                    $factor = $product->factor;

                    if ($factor) {
                        // $sell_qty = $cart_item->qty;
                        $sell_qty = ($cart_item->qty * (int)$factor);
                        $quantity = $product_branch->quantity - ($cart_item->qty * (int)$factor);
                    }
                    $unit_price = $cart_item->price / (int)$factor;
                } else {
                    $sell_qty = $cart_item->qty;
                    $quantity = ($product_branch) ? $product_branch->quantity - $cart_item->qty : 1;
                    $unit_price = $cart_item->options->unit_price;
                }
                SaleDetails::create([
                    'sale_id' => $sale->id,
                    'reference' => $sale->reference,
                    'product_id' => $cart_item->id,
                    'product_name' => $cart_item->name,
                    'product_code' => $cart_item->options->code,
                    'sale_type' => $saleType,
                    'quantity' => $sell_qty,
                    'price' => $unit_price,
                    'unit_price' => $unit_price,
                    'sub_total' => $unit_price * $sell_qty,
                    'product_discount_amount' => $cart_item->options->product_discount,
                    'product_discount_type' => $cart_item->options->product_discount_type,
                    'product_tax_amount' => $cart_item->options->product_tax,
                ]);

                // dd(Product::findOrFail($cart_item->id));

                if ($request->status == 'Shipped' || $request->status == 'Completed') {
                    $product = Product::findOrFail($cart_item->id);
                    $product->update([
                        'product_quantity' => $product->product_quantity - $cart_item->qty
                    ]);
                }




                if ($product_branch) {
                    $product_branch->update([
                        'quantity' => $quantity
                    ]);
                }
            }

            Cart::instance('sale')->destroy();

            if ($sale->paid_amount > 0) {
                SalePayment::create([
                    'date' => now(),
                    'reference' => 'INV/' . $sale->reference,
                    'amount' => $sale->paid_amount,
                    'sale_id' => $sale->id,
                    'customer_code' => $customer_code,
                    'payment_method' => $request->payment_method
                ]);
            }
        });

        toast('Sale Created!', 'success');

        return redirect()->route('sales.index');
    }


    public function show($id)
    {
        // abort_if(Gate::denies('show_sales'), 403);
        // DB::enableQueryLog();
        $sale = Sale::with('saleDetails')->find($id);

        if (count($sale->saleDetails) === 0) {
            // $sale = Sale::where($id);

            $saleDetails = SaleDetails::where('reference', $sale->reference)->get();
            $sale->saleDetails = $saleDetails;

            // $sale->transform(function($sale) use($saleDetails) {
            //     $sale->saleDetails = $saleDetails;
            //     return $sale;
            // });
            // $sale = Sale::with('saleDetails')->where('reference', $id)->firstOrFail();
        }

        // return $sale;


        // dd(DB::getQueryLog());

        $customer = Customer::find($sale->customer_id);

        if (!$customer) {
            $customer = Customer::where('customer_name', $sale->customer_name)->first();
        }

        return view('sale::show', compact('sale', 'customer'));

        // $sale = Sale::where('reference', $id)->first();
        // $customer = Customer::find($sale->customer_id);

        // $sale->saleDetails = SaleDetails::where('product_code', '!=', '')->where('reference', $id)->get();

        // // $sale->saleDetails = SaleDetails::where('product_code', $sale_details)->where('reference', $id)->get();

        // return view('sale::show', compact('sale', 'customer'));
        // dd($sale_details);

    }


    public function edit($id)
    {
        abort_if(Gate::denies('edit_sales'), 403);
        $sale = Sale::with('saleDetails')->find($id);

        if (!$sale) {
            $sale = Sale::with('saleDetails')->where('reference', $id)->firstOrFail();
        }

        // return $sale->saleDetails;

        $sale_details = $sale->saleDetails;

        Cart::instance('sale')->destroy();

        $cart = Cart::instance('sale');

        foreach ($sale_details as $sale_detail) {
            $pro = ($sale_detail->product_id) ? Product::find($sale_detail->product_id) :  Product::where('product_code', $sale_detail->product_code)->first();
            // dd($pro, $sale_detail);

            $product_quantity = $pro->product_quantity;

            if (!$product_quantity) {
                $product_quantity = 0;
            }

            $cart->add([
                'id'      => $pro->id,
                'name'    => $pro->product_name,
                'qty'     => $sale_detail->quantity,
                'price'   => $sale_detail->unit_price,
                'weight'  => 1,
                'options' => [
                    'product_discount' => ($sale_detail->product_discount_amount) ? $sale_detail->product_discount_amount : 0,
                    'product_discount_type' => $sale_detail->product_discount_type,
                    'sub_total'   => $sale_detail->sub_total,
                    'code'        => $sale_detail->product_code,
                    'stock'       => $product_quantity,
                    'product_tax' => $sale_detail->product_tax_amount,
                    'unit_price'  => $sale_detail->unit_price
                ]
            ]);
        }

        return view('sale::edit', compact('sale'));
    }


    public function update(UpdateSaleRequest $request, Sale $sale)
    {
        DB::transaction(function () use ($request, $sale) {

            $due_amount = $request->total_amount - $request->paid_amount;

            if ($due_amount == $request->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            foreach ($sale->saleDetails as $sale_detail) {
                if ($sale->status == 'Shipped' || $sale->status == 'Completed') {
                    $product = Product::findOrFail($sale_detail->product_id);
                    $product->update([
                        'product_quantity' => $product->product_quantity + $sale_detail->quantity
                    ]);
                }
                $sale_detail->delete();
            }

            $sale->update([
                'date' => now(),
                'reference' => $request->reference,
                'customer_id' => $request->customer_id,
                'customer_name' => Customer::findOrFail($request->customer_id)->customer_name,
                'tax_percentage' => $request->tax_percentage,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'paid_amount' => $request->paid_amount,
                'total_amount' => $request->total_amount,
                'due_amount' => $due_amount,
                'status' => $request->status,
                'payment_status' => $payment_status,
                'payment_method' => $request->payment_method,
                'note' => $request->note,
                'tax_amount' => Cart::instance('sale')->tax(),
                'discount_amount' => Cart::instance('sale')->discount(),
            ]);

            foreach (Cart::instance('sale')->content() as $cart_item) {
                SaleDetails::create([
                    'sale_id' => $sale->id,
                    'product_id' => $cart_item->id,
                    'product_name' => $cart_item->name,
                    'product_code' => $cart_item->options->code,
                    'quantity' => $cart_item->qty,
                    'price' => $cart_item->price,
                    'unit_price' => $cart_item->options->unit_price,
                    'sub_total' => $cart_item->options->sub_total,
                    'product_discount_amount' => $cart_item->options->product_discount,
                    'product_discount_type' => $cart_item->options->product_discount_type,
                    'product_tax_amount' => $cart_item->options->product_tax,
                ]);

                if ($request->status == 'Shipped' || $request->status == 'Completed') {
                    $product = Product::findOrFail($cart_item->id);
                    $product->update([
                        'product_quantity' => $product->product_quantity - $cart_item->qty
                    ]);
                }
            }

            Cart::instance('sale')->destroy();
        });

        toast('Sale Updated!', 'info');

        return redirect()->route('sales.index');
    }


    public function destroy(Sale $sale)
    {
        abort_if(Gate::denies('delete_sales'), 403);

        $sale->delete();

        toast('Sale Deleted!', 'warning');

        return redirect()->route('sales.index');
    }
}
