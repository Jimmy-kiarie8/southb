<?php

namespace Modules\Quotation\Http\Controllers;

use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Gate;
use Modules\Product\Entities\Product;
use Modules\Quotation\Entities\Lpo;

class LpoSalesController extends Controller
{

    public function __invoke(Lpo $quotation) {
        abort_if(Gate::denies('create_quotation_sales'), 403);

        $quotation_details = $quotation->lpoDetails;

        // dd($quotation_details);

        Cart::instance('purchases')->destroy();

        $cart = Cart::instance('purchases');

        foreach ($quotation_details as $quotation_detail) {
            $cart->add([
                'id'      => $quotation_detail->product_id,
                'name'    => $quotation_detail->product_name,
                'qty'     => $quotation_detail->quantity,
                'price'   => $quotation_detail->price,
                'weight'  => 1,
                'options' => [
                    'product_discount' => $quotation_detail->product_discount_amount,
                    'product_discount_type' => $quotation_detail->product_discount_type,
                    'sub_total'   => $quotation_detail->sub_total,
                    'code'        => $quotation_detail->product_code,
                    'stock'       => Product::findOrFail($quotation_detail->product_id)->product_quantity,
                    'product_tax' => $quotation_detail->product_tax_amount,
                    'unit_price'  => $quotation_detail->unit_price
                ]
            ]);
        }

        return view('quotation::lpo.lpo-sales.create', [
            'lpo_id' => $quotation->id,
            'sale' => $quotation
        ]);
    }
}
