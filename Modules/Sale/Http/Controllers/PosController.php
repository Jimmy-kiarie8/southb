<?php

namespace Modules\Sale\Http\Controllers;

use App\Services\PaymentService;
use Barryvdh\DomPDF\Facade\Pdf;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Modules\Branch\Entities\ProductBranch;
use Modules\Invoice\Entities\Invoice;
use Modules\People\Entities\Customer;
use Modules\Product\Entities\Category;
use Modules\Product\Entities\Product;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleDetails;
use Modules\Sale\Entities\SalePayment;
use Milon\Barcode\DNS1D;

class PosController extends Controller
{

    public function index()
    {
        Cart::instance('sale')->destroy();

        $customers = Customer::all();
        $product_categories = Category::all();

        return view('sale::pos.index', compact('product_categories', 'customers'));
    }



    public function stk_push(Request $request, $id)
    {
        // return $request->all();
        // return $id;
        $sale = Sale::find($id);

        $payment = new PaymentService;
        return $payment->stk_push($request->phone, $sale);
    }

    public function payment_check($id)
    {
        return true;
    }

    public function payment($id)
    {
        $sale = Sale::findOrFail($id);

        return view('sale::pos.payment-confirm', compact('sale'));
    }

    public function store(Request $request)
    {
        // return $request->all();
        // Basic Validation
        $request->validate([
            'total_amount' => 'required|numeric|min:0',
            'paid_amount' => 'required|numeric|min:0',
            'location_id' => 'sometimes|nullable|numeric',
            'sale_type' => 'required|string',
            'payment_method' => 'required|string',
            'customer_id' => 'sometimes|nullable|numeric',
        ]);
        // Log::emergency($request->all());
        $paymentMethods = json_decode($request->input('paymentMethods'), true);



        DB::beginTransaction();

        try {
            // Lock the sales table to prevent concurrent insertions
            DB::table('sales')->lockForUpdate()->get();

            // Generate a unique reference
            $lastSale = Sale::orderBy('id', 'desc')->first();
            $number = $lastSale ? $lastSale->id + 1 : 1;
            $reference = make_reference_id('SL', $number);

            $total_amount = ceil($request->total_amount);
            $paid_amount = $request->paid_amount;

            // Ensure total_amount is set correctly
            if ($total_amount == 0) {
                foreach (Cart::instance('sale')->content() as $cart_item) {
                    $total_amount += $cart_item->price;
                }
            }

            // Determine due amount and change amount
            $due_amount = max(0, $total_amount - $paid_amount);
            $change_amount = max(0, $paid_amount - $total_amount);

            // Set location ID
            $location_id = $request->location_id ?? Auth::user()->branch_id;

            // Determine payment status
            if ($paid_amount == 0 || $request->payment_method === "Credit") {
                $payment_status = 'Credit';
            } elseif ($due_amount == $total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            // Handle customer information
            if (!$request->customer_id) {
                $customer_ = Customer::firstOrCreate(['customer_name' => 'Walkin']);
            } else {
                $customer_ = Customer::find($request->customer_id) ?: Customer::create([
                    'customer_name' => $request->customer_id,
                ]);
            }

            $customer_id = $customer_->id;
            $customer_name = $customer_->customer_name;
            $customer_code = $customer_->code;

            // Create Sale record
            $sale = Sale::create([
                'date' => now()->format('Y-m-d'),
                'reference' => $reference,
                'clientcode' => $customer_code,
                'customer_id' => $customer_id,
                'branch_id' => $location_id,
                'customer_name' => $customer_name,
                'tax_percentage' => $request->tax_percentage,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'paid_amount' => $paid_amount - $change_amount,
                'total_amount' => $total_amount,
                'change_amount' => $change_amount,
                'due_amount' => $due_amount,
                'status' => 'Completed',
                'payment_status' => $payment_status,
                'payment_method' => $request->payment_method,
                'note' => $request->note,
                'tax_amount' => Cart::instance('sale')->tax(),
                'discount_amount' => Cart::instance('sale')->discount(),
                'user_id' => Auth::id(),
            ]);

            // Handle credit sales with invoices
            if ($request->payment_method === "Credit") {
                $invoice = new Invoice();
                $invoice->invoice([
                    'invoice_no' => 'INV',
                    'amount' => $total_amount,
                    'balance' => $total_amount,
                    'sale_id' => $sale->id,
                    'customer_name' => $customer_name,
                    'user_id' => Auth::id(),
                ]);
            }

            // Create Sale Details and update product stock
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

                // Update product stock
                $product = Product::findOrFail($cart_item->id);
                $product->update([
                    'product_quantity' => $product->product_quantity - $cart_item->qty
                ]);

                // Update product branch stock
                $product_branch = ProductBranch::where('product_id', $cart_item->id)
                    ->where('branch_id', $location_id)
                    ->first();

                if ($product_branch) {
                    $product_branch->update([
                        'quantity' => $product_branch->quantity - $cart_item->qty
                    ]);
                }
            }

            if ($paid_amount > 0) {
                foreach ($paymentMethods as $method) {
                    SalePayment::create([
                        'date' => now(),
                        'reference' => 'INV/' . $sale->reference,
                        'amount' => $method['amount'],
                        'sale_id' => $sale->id,
                        'customer_code' => $customer_code,
                        'payment_method' => $method['type']
                    ]);
                }
            }

            // Clear the sale cart
            Cart::instance('sale')->destroy();

            DB::commit();

            // Display success toast and redirect to the sale PDF route
            toast('POS Sale Created!', 'success');


            // Generate the PDF

            // If it's an AJAX request, return the PDF directly
            if ($request->ajax()) {

                $sale->barcode = 'data:image/png;base64,' . DNS1D::getBarcodePNG($sale->reference, "C39");

                $pdf = Pdf::loadView('sale::print-pos', [
                    // $pdf = Pdf::loadView('sale::print-pos', [
                    'sale' => $sale,
                ])->setPaper('a7')
                    ->setOption('margin-top', 0)
                    ->setOption('margin-bottom', 0)
                    ->setOption('margin-left', 0)
                    ->setOption('margin-right', 0);

                return $pdf->download('sale-' . $sale->reference . '.pdf');
            }

            // Fallback for non-AJAX requests
            // return $pdf->download('receipt.pdf');
            return redirect()->route('sales.pos.pdf', $sale->id);
        } catch (\Exception $e) {
            DB::rollBack();
            // Log the error and show an error message
            Log::error('Sale creation failed: ' . $e->getMessage());
            toast('Error creating sale. Please try again.', 'error');
            return back();
        }
    }
}
