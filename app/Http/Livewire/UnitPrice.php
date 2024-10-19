<?php

namespace App\Http\Livewire;

use Livewire\Component;
use Gloudemans\Shoppingcart\Facades\Cart;

class UnitPrice extends Component
{
    public function render()
    {
        return view('livewire.unit-price');
    }



    public function updateQuantity($row_id, $product_id) {
        if  ($this->cart_instance == 'sale' || $this->cart_instance == 'purchase_return') {
            // if ($this->check_quantity[$product_id] < $this->quantity[$product_id]) {
            //     session()->flash('message', 'The requested quantity is not available in stock.');
            //     return;
            // }
        }

        Cart::instance($this->cart_instance)->update($row_id, $this->quantity[$product_id]);

        $cart_item = Cart::instance($this->cart_instance)->get($row_id);

        Cart::instance($this->cart_instance)->update($row_id, [
            'options' => [
                'sub_total'             => $cart_item->price * $cart_item->qty,
                'code'                  => $cart_item->options->code,
                'stock'                 => $cart_item->options->stock,
                'unit'                  => $cart_item->options->unit,
                'product_tax'           => $cart_item->options->product_tax,
                'unit_price'            => $cart_item->options->unit_price,
                'product_discount'      => $cart_item->options->product_discount,
                'product_discount_type' => $cart_item->options->product_discount_type,
            ]
        ]);
    }
}
