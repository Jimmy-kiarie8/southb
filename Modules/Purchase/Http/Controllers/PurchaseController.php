<?php

namespace Modules\Purchase\Http\Controllers;

use Modules\Purchase\DataTables\PurchaseDataTable;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Modules\Branch\Entities\ProductBranch;
use Modules\People\Entities\Supplier;
use Modules\Product\Entities\Product;
use Modules\Purchase\Entities\Purchase;
use Modules\Purchase\Entities\PurchaseDetail;
use Modules\Purchase\Entities\PurchasePayment;
use Modules\Purchase\Http\Requests\StorePurchaseRequest;
use Modules\Purchase\Http\Requests\UpdatePurchaseRequest;

class PurchaseController extends Controller
{

    public function index(PurchaseDataTable $dataTable)
    {
        abort_if(Gate::denies('access_purchases'), 403);

        return $dataTable->render('purchase::index');
    }


    public function create()
    {
        abort_if(Gate::denies('create_purchases'), 403);

        Cart::instance('purchase')->destroy();

        return view('purchase::create');
    }


    public function store(StorePurchaseRequest $request)
    {
        // $request->validate([
        //     'array_field' => 'exists:table,column',
        // ]);

        // return $request->all();

        // if ($request->stock_type != 'opening') {
        //     $request->validate([
        //         'supplier_id' => 'required|numeric',
        //     ]);
        // }



        // dd($cart_total);
        // return $request->all();


        if (count(Cart::instance('purchase')->content()) < 1) {
            return redirect()->back()->withErrors(['Please select a product']);;
        }

        // return Cart::instance('purchase')->content();
        DB::transaction(function () use ($request) {

            $cart_total = 0;
            $cart_items = Cart::instance('purchase')->content();

            foreach ($cart_items as $item) {
                $cart_total += $item->price * $item->qty;
            }


            $due_amount = $cart_total - $request->paid_amount;
            if ($due_amount == $cart_total) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            $purchase = Purchase::create([
                'date' => $request->date,
                'supplier_id' => $request->supplier_id,
                'location_id' => $request->location_id,
                'supplier_name' => ($request->supplier_id) ? Supplier::findOrFail($request->supplier_id)->supplier_name : 'Opening Stock',
                'tax_percentage' => $request->tax_percentage,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'paid_amount' => $request->paid_amount,
                'total_amount' => $cart_total,
                // 'total_amount' => $request->total_amount,
                'due_amount' => $due_amount,
                'status' => $request->status,
                'payment_status' => $payment_status,
                'is_openingstock' => ($request->stock_type == 'receipt') ? false : true,
                'payment_method' => $request->payment_method,
                'note' => $request->note,
                'tax_amount' => Cart::instance('purchase')->tax(),
                'discount_amount' => Cart::instance('purchase')->discount(),
            ]);


            foreach (Cart::instance('purchase')->content() as $cart_item) {
                $saleType = 'Retail';

                if (env('WHOLESALE_RETAIL')) {
                    $saleType = $request->saleType[$cart_item->id];
                }

                if ($saleType == 'Wholesale') {
                    $product = Product::findOrFail($cart_item->id);
                    $factor = $product->factor;

                    if ($factor) {
                        $sell_qty = ($cart_item->qty * (int)$factor);
                        $unit_price = $cart_item->price / (int)$factor;
                    }
                } else {
                    $sell_qty = $cart_item->qty;
                    $unit_price = $cart_item->options->unit_price;
                }
                PurchaseDetail::create([
                    'reference' => $purchase->reference,
                    'purchase_id' => $purchase->id,
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

                if ($request->status == 'Completed') {
                    $product = Product::findOrFail($cart_item->id);
                    $product->update([
                        'product_quantity' => $product->product_quantity + $cart_item->qty
                    ]);

                    $product_branch = ProductBranch::where('product_id', $cart_item->id)->where('branch_id', $request->location_id)->first();


                    if ($saleType == 'Wholesale') {
                        $product = Product::findOrFail($cart_item->id);
                        $factor = $product->factor;

                        if ($factor) {
                            $quantity = $product->product_quantity + ($cart_item->qty * (int)$factor);
                        }
                    } else {
                        $quantity = $product->product_quantity + $cart_item->qty;
                    }

                    if ($product_branch) {
                        $product_branch->update([
                            'quantity' => $quantity
                        ]);
                    } else {
                        $product_branch = new ProductBranch;
                        $product_branch->quantity($cart_item->qty, $cart_item->id, $request->location_id);
                    }
                }
            }

            Cart::instance('purchase')->destroy();

            if ($purchase->paid_amount > 0) {
                PurchasePayment::create([
                    'date' => $request->date,
                    'reference' => 'INV/' . $purchase->reference,
                    'amount' => $purchase->paid_amount,
                    'purchase_id' => $purchase->id,
                    'payment_method' => $request->payment_method
                ]);
            }
        });

        toast('Purchase Created!', 'success');

        return redirect()->route('purchases.index');
    }


    public function show(Purchase $purchase)
    {
        abort_if(Gate::denies('show_purchases'), 403);

        $supplier = Supplier::find($purchase->supplier_id);

        return view('purchase::show', compact('purchase', 'supplier'));
    }


    public function edit(Purchase $purchase)
    {
        abort_if(Gate::denies('edit_purchases'), 403);

        $purchase_details = $purchase->purchaseDetails;

        Cart::instance('purchase')->destroy();

        $cart = Cart::instance('purchase');

        foreach ($purchase_details as $purchase_detail) {
            $cart->add([
                'id'      => $purchase_detail->product_id,
                'name'    => $purchase_detail->product_name,
                'qty'     => $purchase_detail->quantity,
                'price'   => $purchase_detail->price,
                'weight'  => 1,
                'options' => [
                    'product_discount' => $purchase_detail->product_discount_amount,
                    'product_discount_type' => $purchase_detail->product_discount_type,
                    'sub_total'   => $purchase_detail->sub_total,
                    'code'        => $purchase_detail->product_code,
                    'stock'       => Product::findOrFail($purchase_detail->product_id)->product_quantity,
                    'product_tax' => $purchase_detail->product_tax_amount,
                    'unit_price'  => $purchase_detail->unit_price
                ]
            ]);
        }

        return view('purchase::edit', compact('purchase'));
    }


    public function update(UpdatePurchaseRequest $request, Purchase $purchase)
    {
        DB::transaction(function () use ($request, $purchase) {
            $due_amount = $request->total_amount - $request->paid_amount;
            if ($due_amount == $request->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            foreach ($purchase->purchaseDetails as $purchase_detail) {
                if ($purchase->status == 'Completed') {
                    $product = Product::findOrFail($purchase_detail->product_id);
                    $product->update([
                        'product_quantity' => $product->product_quantity - $purchase_detail->quantity
                    ]);
                }
                $purchase_detail->delete();
            }

            $purchase->update([
                'date' => $request->date,
                'reference' => $request->reference,
                'supplier_id' => $request->supplier_id,
                'supplier_name' => Supplier::findOrFail($request->supplier_id)->supplier_name,
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
                'tax_amount' => Cart::instance('purchase')->tax(),
                'discount_amount' => Cart::instance('purchase')->discount(),
            ]);

            foreach (Cart::instance('purchase')->content() as $cart_item) {
                PurchaseDetail::create([
                    'purchase_id' => $purchase->id,
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

                if ($request->status == 'Completed') {
                    $product = Product::findOrFail($cart_item->id);
                    $product->update([
                        'product_quantity' => $product->product_quantity + $cart_item->qty
                    ]);


                    $product_branch = ProductBranch::where('product_id', $cart_item->id)->where('branch_id', $request->location_id)->first();

                    if ($product_branch) {
                        $product_branch->update([
                            'quantity' => $product->product_quantity + $cart_item->qty
                        ]);
                    } else {
                        $product_branch = new ProductBranch;
                        $product_branch->quantity($cart_item->qty, $cart_item->id, $request->location_id);
                    }
                }
            }

            Cart::instance('purchase')->destroy();
        });

        toast('Purchase Updated!', 'info');

        return redirect()->route('purchases.index');
    }


    public function destroy(Purchase $purchase)
    {
        abort_if(Gate::denies('delete_purchases'), 403);

        $purchase->delete();

        toast('Purchase Deleted!', 'warning');

        return redirect()->route('purchases.index');
    }
}
