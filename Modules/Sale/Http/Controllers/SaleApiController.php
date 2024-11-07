<?php

namespace Modules\Sale\Http\Controllers;

use App\Http\Resources\SaleResource;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Modules\Invoice\Entities\Invoice;
use Modules\People\Entities\Customer;
use Modules\Product\Entities\Product;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleDetails;
use Modules\Sale\Entities\SalePayment;
use Modules\Sale\Http\Requests\StorePosSaleRequest;

class SaleApiController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index()
    {
        return SaleResource::collection(Sale::with(['customer', 'saleDetails'])->take(20)->get());
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('sale::create');
    }


    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('sale::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('sale::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        //
    }

    public function cart(Request $request)
    {
        $cart_key = $request->cart_key;

        // return $request->all();

        // Cart::add($cart_key, $request->product, 1, 9.99, 550);
        return Cart::content();


    }

    public function store(Request $request) {
        // return $request->all();
        DB::transaction(function () use ($request) {
            $due_amount = $request->total_amount - $request->paid_amount;

            if ($request->paid_amount == 0) {
                $payment_status = 'Credit';
            }elseif ($due_amount == $request->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            $sale = Sale::create([
                'date' => now()->format('Y-m-d'),
                'reference' => 'PSL',
                'customer_id' => $request->customer_id,
                'customer_name' => Customer::findOrFail($request->customer_id)->customer_name,
                'tax_percentage' => ($request->tax_percentage) ? $request->tax_percentage : 0,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'paid_amount' => $request->paid_amount,
                'total_amount' => $request->total_amount,
                'due_amount' => $due_amount,
                'status' => 'Completed',
                'payment_status' => ($request->payment_method == "Credit") ? 'Unpaid' : $payment_status,
                'payment_method' => $request->payment_method,
                'note' => $request->note,
                'tax_amount' => 0,
                'discount_amount' => 0
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


            foreach ($request->cart as $cart_item) {
                SaleDetails::create([
                    'sale_id' => $sale->id,
                    'product_id' => $cart_item['id'],
                    'product_name' => $cart_item['product_name'],
                    'product_code' => $cart_item['product_code'],
                    'quantity' => $cart_item['cartQty'],
                    'price' => $cart_item['product_price'],
                    'unit_price' => 0,
                    'sub_total' => 0,
                    'product_discount_amount' => 0,
                    'product_discount_type' => 'fixed',
                    'product_tax_amount' => 0,
                ]);

                $product = Product::findOrFail($cart_item['id']);
                $product->update([
                    'product_quantity' => $product->product_quantity - $cart_item['cartQty']
                ]);
            }

            // Cart::instance('sale')->destroy();

            if ($sale->paid_amount > 0) {
                SalePayment::create([
                    'date' => now()->format('Y-m-d'),
                    'reference' => 'INV/'.$sale->reference,
                    'amount' => $sale->paid_amount,
                    'sale_id' => $sale->id,
                    'payment_method' => $request->payment_method
                ]);
            }
        });

        return response()->json([
            'message' => 'Order created!'
        ], 200);
    }
}
