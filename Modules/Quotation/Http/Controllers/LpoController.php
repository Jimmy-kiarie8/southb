<?php

namespace Modules\Quotation\Http\Controllers;

use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Modules\People\Entities\Customer;
use Modules\People\Entities\Supplier;
use Modules\Product\Entities\Product;
use Modules\Quotation\DataTables\LpoDataTable;
use Modules\Quotation\DataTables\QuotationsDataTable;
use Modules\Quotation\Entities\Lpo;
use Modules\Quotation\Entities\LpoDetail;
use Modules\Quotation\Entities\Quotation;
use Modules\Quotation\Entities\QuotationDetails;
use Modules\Quotation\Http\Requests\StoreLpoRequest;
use Modules\Quotation\Http\Requests\StoreQuotationRequest;
use Modules\Quotation\Http\Requests\UpdateLpoRequest;
use Modules\Quotation\Http\Requests\UpdateQuotationRequest;

class LpoController extends Controller
{

    public function index(LpoDataTable $dataTable) {
        abort_if(Gate::denies('access_quotations'), 403);

        return $dataTable->render('quotation::lpo.index');
    }


    public function create() {
        abort_if(Gate::denies('create_quotations'), 403);

        Cart::instance('lpo')->destroy();

        return view('quotation::lpo.create');
    }


    public function store(StoreLpoRequest $request) {
        DB::transaction(function () use ($request) {
            $lpo = Lpo::create([
                'date' => $request->date,
                'supplier_id' => $request->supplier_id,
                'supplier_name' => Supplier::findOrFail($request->supplier_id)->supplier_name,
                'tax_percentage' => ($request->tax_percentage) ? $request->tax_percentage : 0,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'total_amount' => $request->total_amount,
                'status' => $request->status,
                'note' => $request->note,
                'tax_amount' => Cart::instance('lpo')->tax(),
                'discount_amount' => Cart::instance('lpo')->discount(),
            ]);

            foreach (Cart::instance('lpo')->content() as $cart_item) {
                LpoDetail::create([
                    'lpo_id' => $lpo->id,
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

            Cart::instance('lpo')->destroy();
        });

        toast('LPO Created!', 'success');

        return redirect()->route('lpo.index');
    }


    public function show(Lpo $lpo) {
        abort_if(Gate::denies('show_quotations'), 403);

        $supplier = Supplier::findOrFail($lpo->supplier_id);

        return view('quotation::lpo.show', compact('lpo', 'supplier'));
    }


    public function edit(Lpo $lpo) {
        abort_if(Gate::denies('edit_quotations'), 403);

        $lpo_details = $lpo->lpoDetails;

        Cart::instance('lpo')->destroy();

        $cart = Cart::instance('lpo');

        foreach ($lpo_details as $lpo_detail) {
            $cart->add([
                'id'      => $lpo_detail->product_id,
                'name'    => $lpo_detail->product_name,
                'qty'     => $lpo_detail->quantity,
                'price'   => $lpo_detail->price,
                'weight'  => 1,
                'options' => [
                    'product_discount' => $lpo_detail->product_discount_amount,
                    'product_discount_type' => $lpo_detail->product_discount_type,
                    'sub_total'   => $lpo_detail->sub_total,
                    'code'        => $lpo_detail->product_code,
                    'stock'       => Product::findOrFail($lpo_detail->product_id)->product_quantity,
                    'product_tax' => $lpo_detail->product_tax_amount,
                    'unit_price'  => $lpo_detail->unit_price
                ]
            ]);
        }

        return view('quotation::lpo.edit', compact('lpo'));
    }


    public function update(UpdateLpoRequest $request, Lpo $lpo) {
        DB::transaction(function () use ($request, $lpo) {
            foreach ($lpo->lpoDetails as $lpo_detail) {
                $lpo_detail->delete();
            }

            $lpo->update([
                'date' => $request->date,
                'reference' => $request->reference,
                'supplier_id' => $request->supplier_id,
                'supplier_name' => Supplier::findOrFail($request->supplier_id)->supplier_name,
                'tax_percentage' => ($request->tax_percentage) ? $request->tax_percentage : 0,
                'discount_percentage' => $request->discount_percentage,
                'shipping_amount' => $request->shipping_amount,
                'total_amount' => $request->total_amount,
                'status' => $request->status,
                'note' => $request->note,
                'tax_amount' => Cart::instance('lpo')->tax(),
                'discount_amount' => Cart::instance('lpo')->discount(),
            ]);

            foreach (Cart::instance('lpo')->content() as $cart_item) {
                LpoDetail::create([
                    'lpo_id' => $lpo->id,
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

            Cart::instance('lpo')->destroy();
        });

        toast('LPO Updated!', 'info');

        return redirect()->route('lpo.index');
    }


    public function destroy(Lpo $lpo) {
        abort_if(Gate::denies('delete_quotations'), 403);

        $lpo->delete();

        toast('LPO Deleted!', 'warning');

        return redirect()->route('lpo.index');
    }


    public function grn(Request $request) {

    }
}
