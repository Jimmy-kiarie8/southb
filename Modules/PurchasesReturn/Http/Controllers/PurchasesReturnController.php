<?php

namespace Modules\PurchasesReturn\Http\Controllers;

use Modules\PurchasesReturn\DataTables\PurchaseReturnsDataTable;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Modules\Branch\Entities\ProductBranch;
use Modules\People\Entities\Supplier;
use Modules\Product\Entities\Product;
use Modules\Purchase\Entities\Purchase;
use Modules\PurchasesReturn\Entities\PurchaseReturn;
use Modules\PurchasesReturn\Entities\PurchaseReturnDetail;
use Modules\PurchasesReturn\Entities\PurchaseReturnPayment;
use Modules\PurchasesReturn\Http\Requests\StorePurchaseReturnRequest;
use Modules\PurchasesReturn\Http\Requests\UpdatePurchaseReturnRequest;

class PurchasesReturnController extends Controller
{

    public function index(PurchaseReturnsDataTable $dataTable)
    {
        abort_if(Gate::denies('access_purchase_returns'), 403);

        return $dataTable->render('purchasesreturn::index');
    }

    public function create(Request $request)
    {
        abort_if(Gate::denies('create_purchase_returns'), 403);

        Cart::instance('purchase_return')->destroy();



        $purchase_id = $request->input('purchase_id');
        $purchase = $purchase_id ? Purchase::findOrFail($purchase_id) : null;

        return view('purchasesreturn::create', compact('purchase_id', 'purchase'));
    }


    public function store(StorePurchaseReturnRequest $request)
    {
        DB::transaction(function () use ($request) {
            $due_amount = $request->total_amount - $request->paid_amount;
            $location_id = ($request->location_id) ? $request->location_id : Auth::user()->branch_id;

            if ($due_amount == $request->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            $purchase_return = PurchaseReturn::create([
                'date' => $request->date,
                'supplier_id' => $request->supplier_id,
                'supplier_name' => Supplier::findOrFail($request->supplier_id)->supplier_name,
                'tax_percentage' => ($request->tax_percentage) ? $request->tax_percentage : 0,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'paid_amount' => $request->paid_amount,
                'purchase_id' => $request->id,
                'total_amount' => $request->total_amount,
                'due_amount' => $due_amount,
                'status' => $request->status,
                'payment_status' => $payment_status,
                'payment_method' => $request->payment_method,
                'note' => $request->note,
                'tax_amount' => Cart::instance('purchase_return')->tax(),
                'discount_amount' => Cart::instance('purchase_return')->discount(),
            ]);

            foreach (Cart::instance('purchase_return')->content() as $cart_item) {
                PurchaseReturnDetail::create([
                    'purchase_return_id' => $purchase_return->id,
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

                    $product_branch = ProductBranch::where('product_id', $cart_item->id)->where('branch_id', $location_id)->first();

                    $quantity = ($product_branch) ? $product_branch->quantity - $cart_item->qty : 1;


                    if ($product_branch) {
                        $product_branch->update([
                            'quantity' => $quantity
                        ]);
                    }
                }
            }

            Cart::instance('purchase_return')->destroy();

            if ($purchase_return->paid_amount > 0) {
                PurchaseReturnPayment::create([
                    'date'               => $request->date,
                    'reference'          => 'INV/' . $purchase_return->reference,
                    'amount'             => $purchase_return->paid_amount,
                    'purchase_return_id' => $purchase_return->id,
                    'payment_method'     => $request->payment_method
                ]);
            }
        });

        toast('Purchase Return Created!', 'success');

        return redirect()->route('purchase-returns.index');
    }


    public function show(PurchaseReturn $purchase_return)
    {
        abort_if(Gate::denies('show_purchase_returns'), 403);

        $supplier = Supplier::findOrFail($purchase_return->supplier_id);

        return view('purchasesreturn::show', compact('purchase_return', 'supplier'));
    }


    public function edit(PurchaseReturn $purchase_return)
    {
        abort_if(Gate::denies('edit_purchase_returns'), 403);

        $purchase_return_details = $purchase_return->purchaseReturnDetails;

        Cart::instance('purchase_return')->destroy();

        $cart = Cart::instance('purchase_return');

        foreach ($purchase_return_details as $purchase_return_detail) {
            $cart->add([
                'id'      => $purchase_return_detail->product_id,
                'name'    => $purchase_return_detail->product_name,
                'qty'     => $purchase_return_detail->quantity,
                'price'   => $purchase_return_detail->price,
                'weight'  => 1,
                'options' => [
                    'product_discount' => $purchase_return_detail->product_discount_amount,
                    'product_discount_type' => $purchase_return_detail->product_discount_type,
                    'sub_total'   => $purchase_return_detail->sub_total,
                    'code'        => $purchase_return_detail->product_code,
                    'stock'       => Product::findOrFail($purchase_return_detail->product_id)->product_quantity,
                    'product_tax' => $purchase_return_detail->product_tax_amount,
                    'unit_price'  => $purchase_return_detail->unit_price
                ]
            ]);
        }

        return view('purchasesreturn::edit', compact('purchase_return'));
    }


    public function update(UpdatePurchaseReturnRequest $request, PurchaseReturn $purchase_return)
    {
        DB::transaction(function () use ($request, $purchase_return) {
            $due_amount = $request->total_amount - $request->paid_amount;

            if ($due_amount == $request->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            foreach ($purchase_return->purchaseReturnDetails as $purchase_return_detail) {
                if ($purchase_return->status == 'Shipped' || $purchase_return->status == 'Completed') {
                    $product = Product::findOrFail($purchase_return_detail->product_id);
                    $product->update([
                        'product_quantity' => $product->product_quantity + $purchase_return_detail->quantity
                    ]);
                }
                $purchase_return_detail->delete();
            }

            $purchase_return->update([
                'date' => $request->date,
                'reference' => $request->reference,
                'supplier_id' => $request->supplier_id,
                'supplier_name' => Supplier::findOrFail($request->supplier_id)->supplier_name,
                'tax_percentage' => ($request->tax_percentage) ? $request->tax_percentage : 0,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'paid_amount' => $request->paid_amount,
                'total_amount' => $request->total_amount,
                'due_amount' => $due_amount,
                'status' => $request->status,
                'payment_status' => $payment_status,
                'payment_method' => $request->payment_method,
                'note' => $request->note,
                'tax_amount' => Cart::instance('purchase_return')->tax(),
                'discount_amount' => Cart::instance('purchase_return')->discount(),
            ]);
            $location_id = ($request->location_id) ? $request->location_id : Auth::user()->branch_id;

            foreach (Cart::instance('purchase_return')->content() as $cart_item) {
                PurchaseReturnDetail::create([
                    'purchase_return_id' => $purchase_return->id,
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


                    $product_branch = ProductBranch::where('product_id', $cart_item->id)->where('branch_id', $location_id)->first();

                    $quantity = ($product_branch) ? $product_branch->quantity - $cart_item->qty : 1;


                    if ($product_branch) {
                        $product_branch->update([
                            'quantity' => $quantity
                        ]);
                    }
                }
            }

            Cart::instance('purchase_return')->destroy();
        });

        toast('Purchase Return Updated!', 'info');

        return redirect()->route('purchase-returns.index');
    }


    public function destroy(PurchaseReturn $purchase_return)
    {
        abort_if(Gate::denies('delete_purchase_returns'), 403);

        $purchase_return->delete();

        toast('Purchase Return Deleted!', 'warning');

        return redirect()->route('purchase-returns.index');
    }
}
