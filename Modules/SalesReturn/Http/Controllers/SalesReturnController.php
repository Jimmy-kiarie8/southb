<?php

namespace Modules\SalesReturn\Http\Controllers;

use Modules\SalesReturn\DataTables\SaleReturnsDataTable;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Modules\Branch\Entities\ProductBranch;
use Modules\People\Entities\Customer;
use Modules\Product\Entities\Product;
use Modules\Sale\Entities\Sale;
use Modules\SalesReturn\Entities\SaleReturn;
use Modules\SalesReturn\Entities\SaleReturnDetail;
use Modules\SalesReturn\Entities\SaleReturnPayment;
use Modules\SalesReturn\Http\Requests\StoreSaleReturnRequest;
use Modules\SalesReturn\Http\Requests\UpdateSaleReturnRequest;

class SalesReturnController extends Controller
{

    public function index(SaleReturnsDataTable $dataTable)
    {
        abort_if(Gate::denies('access_sale_returns'), 403);

        return $dataTable->render('salesreturn::index');
    }


    public function create(Request $request)
    {
        abort_if(Gate::denies('create_sale_returns'), 403);

        Cart::instance('sale_return')->destroy();

        $sale_id = $request->input('sale_id');
        $sale = $sale_id ? Sale::findOrFail($sale_id) : null;

        return view('salesreturn::create', compact('sale_id', 'sale'));
    }

    public function store(StoreSaleReturnRequest $request)
    {
        DB::transaction(function () use ($request) {
            $location_id = $request->location_id ?? Auth::user()->branch_id;
            $customer = Customer::findOrFail($request->customer_id);
            $sale = Sale::findOrFail($request->sale_id);

            $saleReturn = $this->createSaleReturn($request, $customer, $sale);

            $this->processSaleReturnItems($saleReturn, $request, $location_id);

            $this->updateSaleStatus($sale);

            $this->createSaleReturnPayment($saleReturn, $request);

            Cart::instance('sale_return')->destroy();
        });

        toast('Sale Return Created!', 'success');
        return redirect()->route('sale-returns.index');
    }

    private function createSaleReturn($request, $customer, $sale)
    {
        $dueAmount = $request->total_amount - $request->paid_amount;
        $paymentStatus = $this->determinePaymentStatus($dueAmount, $request->total_amount);

        return SaleReturn::create([
            'date' => $request->date,
            'customer_id' => $customer->id,
            'customer_name' => $customer->customer_name,
            'tax_percentage' => $request->tax_percentage,
            'discount_percentage' => $request->discount_percentage,
            'shipping_amount' => $request->shipping_amount,
            'paid_amount' => $request->paid_amount,
            'total_amount' => $request->total_amount,
            'due_amount' => $dueAmount,
            'status' => $request->status,
            'payment_status' => $paymentStatus,
            'payment_method' => $request->payment_method,
            'note' => $request->note,
            'tax_amount' => Cart::instance('sale_return')->tax(),
            'discount_amount' => Cart::instance('sale_return')->discount(),
            'sale_id' => $sale->id,
        ]);
    }

    private function determinePaymentStatus($dueAmount, $totalAmount)
    {
        if ($dueAmount == $totalAmount) {
            return 'Unpaid';
        } elseif ($dueAmount > 0) {
            return 'Partial';
        } else {
            return 'Paid';
        }
    }

    private function processSaleReturnItems($saleReturn, $request, $locationId)
    {
        foreach (Cart::instance('sale_return')->content() as $cartItem) {
            $this->createSaleReturnDetail($saleReturn, $cartItem);

            if ($request->status == 'Completed') {
                $this->updateProductStock($cartItem, $locationId);
            }
        }
    }

    private function createSaleReturnDetail($saleReturn, $cartItem)
    {
        SaleReturnDetail::create([
            'sale_return_id' => $saleReturn->id,
            'product_id' => $cartItem->id,
            'product_name' => $cartItem->name,
            'product_code' => $cartItem->options->code,
            'quantity' => $cartItem->qty,
            'price' => $cartItem->price,
            'unit_price' => $cartItem->options->unit_price,
            'sub_total' => $cartItem->options->sub_total,
            'product_discount_amount' => $cartItem->options->product_discount,
            'product_discount_type' => $cartItem->options->product_discount_type,
            'product_tax_amount' => $cartItem->options->product_tax,
        ]);
    }

    private function updateProductStock($cartItem, $locationId)
    {
        $product = Product::findOrFail($cartItem->id);
        $product->increment('product_quantity', $cartItem->qty);

        $productBranch = ProductBranch::firstOrCreate(
            ['product_id' => $cartItem->id, 'branch_id' => $locationId],
            ['quantity' => 0]
        );
        $productBranch->increment('quantity', $cartItem->qty);
    }

    private function updateSaleStatus($sale)
    {
        $sale->update(['status' => 'Returned']);
    }

    private function createSaleReturnPayment($saleReturn, $request)
    {
        if ($saleReturn->paid_amount > 0) {
            SaleReturnPayment::create([
                'date' => $request->date,
                'reference' => 'INV/' . $saleReturn->reference,
                'amount' => $saleReturn->paid_amount,
                'sale_return_id' => $saleReturn->id,
                'payment_method' => $request->payment_method
            ]);
        }
    }

    public function store1(StoreSaleReturnRequest $request)
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

            $sale_return = SaleReturn::create([
                'date' => $request->date,
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
                'tax_amount' => Cart::instance('sale_return')->tax(),
                'discount_amount' => Cart::instance('sale_return')->discount(),
                'sale_id' => $request->sale_id,
            ]);

            foreach (Cart::instance('sale_return')->content() as $cart_item) {
                SaleReturnDetail::create([
                    'sale_return_id' => $sale_return->id,
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



                    $product_branch = ProductBranch::where('product_id', $cart_item->id)->where('branch_id', $location_id)->first();

                    $quantity = ($product_branch) ? $product_branch->quantity + $cart_item->qty : 1;


                    if ($product_branch) {
                        $product_branch->update([
                            'quantity' => $quantity
                        ]);
                    }
                }
            }

            Cart::instance('sale_return')->destroy();

            if ($sale_return->paid_amount > 0) {
                SaleReturnPayment::create([
                    'date' => $request->date,
                    'reference' => 'INV/' . $sale_return->reference,
                    'amount' => $sale_return->paid_amount,
                    'sale_return_id' => $sale_return->id,
                    'payment_method' => $request->payment_method
                ]);
            }

            Sale::find($request->sale_id)->update(['status' => 'Returned']);
        });

        toast('Sale Return Created!', 'success');

        return redirect()->route('sale-returns.index');
    }


    public function show(SaleReturn $sale_return)
    {
        abort_if(Gate::denies('show_sale_returns'), 403);

        $customer = Customer::findOrFail($sale_return->customer_id);

        return view('salesreturn::show', compact('sale_return', 'customer'));
    }


    public function edit(SaleReturn $sale_return)
    {
        abort_if(Gate::denies('edit_sale_returns'), 403);

        $sale_return_details = $sale_return->saleReturnDetails;

        Cart::instance('sale_return')->destroy();

        $cart = Cart::instance('sale_return');

        foreach ($sale_return_details as $sale_return_detail) {
            $cart->add([
                'id'      => $sale_return_detail->product_id,
                'name'    => $sale_return_detail->product_name,
                'qty'     => $sale_return_detail->quantity,
                'price'   => $sale_return_detail->price,
                'weight'  => 1,
                'options' => [
                    'product_discount' => $sale_return_detail->product_discount_amount,
                    'product_discount_type' => $sale_return_detail->product_discount_type,
                    'sub_total'   => $sale_return_detail->sub_total,
                    'code'        => $sale_return_detail->product_code,
                    'stock'       => Product::findOrFail($sale_return_detail->product_id)->product_quantity,
                    'product_tax' => $sale_return_detail->product_tax_amount,
                    'unit_price'  => $sale_return_detail->unit_price
                ]
            ]);
        }

        return view('salesreturn::edit', compact('sale_return'));
    }


    public function update(UpdateSaleReturnRequest $request, SaleReturn $sale_return)
    {
        DB::transaction(function () use ($request, $sale_return) {
            $location_id = ($request->location_id) ? $request->location_id : Auth::user()->branch_id;
            $due_amount = $request->total_amount - $request->paid_amount;

            if ($due_amount == $request->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            foreach ($sale_return->saleReturnDetails as $sale_return_detail) {
                if ($sale_return->status == 'Completed') {
                    $product = Product::findOrFail($sale_return_detail->product_id);
                    $product->update([
                        'product_quantity' => $product->product_quantity - $sale_return_detail->quantity
                    ]);
                }
                $sale_return_detail->delete();
            }

            $sale_return->update([
                'date' => $request->date,
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
                'tax_amount' => Cart::instance('sale_return')->tax(),
                'discount_amount' => Cart::instance('sale_return')->discount(),
            ]);

            foreach (Cart::instance('sale_return')->content() as $cart_item) {
                SaleReturnDetail::create([
                    'sale_return_id' => $sale_return->id,
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
                }



                $product_branch = ProductBranch::where('product_id', $cart_item->id)->where('branch_id', $location_id)->first();

                $quantity = ($product_branch) ? $product_branch->quantity + $cart_item->qty : 1;


                if ($product_branch) {
                    $product_branch->update([
                        'quantity' => $quantity
                    ]);
                }
            }

            Cart::instance('sale_return')->destroy();
        });

        toast('Sale Return Updated!', 'info');

        return redirect()->route('sale-returns.index');
    }


    public function destroy(SaleReturn $sale_return)
    {
        abort_if(Gate::denies('delete_sale_returns'), 403);

        $sale_return->delete();

        toast('Sale Return Deleted!', 'warning');

        return redirect()->route('sale-returns.index');
    }
}
