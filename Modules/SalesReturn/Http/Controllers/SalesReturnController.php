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
            $due_amount = $request->total_amount - $request->paid_amount;
            $location_id = $request->location_id ?? Auth::user()->branch_id;

            $payment_status = $this->determinePaymentStatus($due_amount, $request->total_amount);

            $sale_return = $this->createSaleReturn($request, $due_amount, $payment_status);

            $this->processSaleReturnItems($sale_return, $request->status, $location_id, $request->sale_id);

            $this->handleSaleReturnPayment($sale_return, $request);

            $this->updateOriginalSale($request->sale_id, $sale_return);
            $sale = Sale::findOrFail($request->sale_id);
            $this->recalculateSaleTotals($sale);

            Cart::instance('sale_return')->destroy();
        });

        toast('Sale Return Created!', 'success');
        return redirect()->route('sale-returns.index');
    }

    // ... (other methods remain the same)

    private function processSaleReturnItems($sale_return, $status, $location_id, $sale_id)
    {
        $sale = Sale::findOrFail($sale_id);

        foreach (Cart::instance('sale_return')->content() as $cart_item) {
            $this->createSaleReturnDetail($sale_return, $cart_item);

            if ($status == 'Completed') {
                $this->updateStock($cart_item->id, $cart_item->qty, $location_id, 'add');
                $this->updateSaleDetail($sale, $cart_item);
            }
        }
    }

    private function updateSaleDetail($sale, $cart_item)
    {
        $sale_detail = $sale->saleDetails()
            ->where('product_id', $cart_item->id)
            ->first();

        if ($sale_detail) {
            $new_quantity = max(0, $sale_detail->quantity - $cart_item->qty);
            $new_sub_total = $new_quantity * $sale_detail->price;

            $sale_detail->update([
                'quantity' => $new_quantity,
                'sub_total' => $new_sub_total,
            ]);

            if ($new_quantity == 0) {
                $sale_detail->delete();
            }
        }
    }

    private function recalculateSaleTotals($sale)
    {
        $total_amount = $sale->saleDetails->sum('sub_total');
        $tax_amount = $total_amount * ($sale->tax_percentage / 100);
        $discount_amount = $total_amount * ($sale->discount_percentage / 100);
        $shipping_amount = $sale->shipping_amount;
        $new_status = $sale->saleDetails->isEmpty() ? 'Returned' : 'Partial Return';

        $sale->update([
            'total_amount' => $total_amount + $tax_amount - $discount_amount + $shipping_amount,
            'tax_amount' => $tax_amount,
            'status' => $new_status,
            'discount_amount' => $discount_amount,
            'due_amount' => max(0, $sale->total_amount - $sale->paid_amount),
        ]);
    }

    private function updateOriginalSale($sale_id, $sale_return)
    {
        $sale = Sale::findOrFail($sale_id);

        $new_status = $sale->saleDetails->isEmpty() ? 'Returned' : 'Partial Return';

        $sale->update([
            'status' => $new_status,
            'total_amount' => $sale->total_amount - $sale_return->total_amount,
            'paid_amount' => $sale->paid_amount - $sale_return->paid_amount,
            'due_amount' => max(0, $sale->due_amount - $sale_return->total_amount),
        ]);

        $this->updateSalePaymentStatus($sale);
    }

    private function updateSalePaymentStatus($sale)
    {
        if ($sale->due_amount <= 0) {
            $sale->payment_status = 'Paid';
        } elseif ($sale->due_amount < $sale->total_amount) {
            $sale->payment_status = 'Partial';
        } else {
            $sale->payment_status = 'Unpaid';
        }
        $sale->save();
    }

    private function determinePaymentStatus($due_amount, $total_amount)
    {
        if ($due_amount == $total_amount) {
            return 'Unpaid';
        } elseif ($due_amount > 0) {
            return 'Partial';
        } else {
            return 'Paid';
        }
    }

    private function createSaleReturn($request, $due_amount, $payment_status)
    {
        return SaleReturn::create([
            'date' => $request->date,
            'customer_id' => $request->customer_id,
            'customer_name' => Customer::findOrFail($request->customer_id)->customer_name,
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
            'tax_amount' => Cart::instance('sale_return')->tax(),
            'discount_amount' => Cart::instance('sale_return')->discount(),
            'sale_id' => $request->sale_id,
        ]);
    }


    private function createSaleReturnDetail($sale_return, $cart_item)
    {
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
    }

    private function updateStock($product_id, $quantity, $location_id, $operation = 'add')
    {
        $product = Product::findOrFail($product_id);
        $product_branch = ProductBranch::where('product_id', $product_id)
            ->where('branch_id', $location_id)
            ->first();

        if ($operation === 'add') {
            $product->product_quantity += $quantity;
            if ($product_branch) {
                $product_branch->quantity += $quantity;
            }
        } else {
            $product->product_quantity -= $quantity;
            if ($product_branch) {
                $product_branch->quantity -= $quantity;
            }
        }

        $product->save();
        if ($product_branch) {
            $product_branch->save();
        }
    }

    private function handleSaleReturnPayment($sale_return, $request)
    {
        if ($sale_return->paid_amount > 0) {
            SaleReturnPayment::create([
                'date' => $request->date,
                'reference' => 'INV/' . $sale_return->reference,
                'amount' => $sale_return->paid_amount,
                'sale_return_id' => $sale_return->id,
                'payment_method' => $request->payment_method
            ]);
        }
    }

    private function updateOriginalSaleStatus($sale_id)
    {
        Sale::find($sale_id)->update(['status' => 'Returned']);
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
