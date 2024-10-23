<?php

namespace App\Http\Livewire;

use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Request;
use Livewire\Component;
use Modules\People\Entities\Customer;
use Modules\Product\Entities\Product;
use Modules\Purchase\Entities\Purchase;
use Modules\Sale\Entities\Sale;

class ProductCart extends Component
{

    public $listeners = ['productSelected', 'discountModalRefresh'];

    public $cart_instance;
    public $global_discount;
    public $global_tax;
    public $shipping;
    public $quantity;
    public $check_quantity;
    public $discount_type;
    public $item_discount;
    public $data;
    public $price;
    public $cart_total;
    // public $sale_type;
    public $sale_type = [];
    public $sale_id;
    public $purchase_id;

    public $customer_id;
    public $customer_email;

    public $total_amount;
    public function mount($cartInstance, $data = null, $sale_id = null, $purchase_id = null)
    {
        $this->cart_instance = $cartInstance;
        $this->cart_total = 0;
        $this->sale_id = $sale_id;
        $this->purchase_id = $purchase_id;

        // Initialize with default values
        $this->global_discount = 0;
        $this->global_tax = 16;
        $this->shipping = 0.00;
        $this->check_quantity = [];
        $this->quantity = [];
        $this->discount_type = [];
        $this->item_discount = [];

        // Handle editing existing data
        if ($data) {
            $this->data = $data;
            $this->global_discount = $data->discount_percentage;
            $this->global_tax = $data->tax_percentage;
            $this->shipping = $data->shipping_amount;

            $cart_items = Cart::instance($this->cart_instance)->content();

            foreach ($cart_items as $cart_item) {
                $this->check_quantity[$cart_item->id] = [$cart_item->options->stock];
                $this->quantity[$cart_item->id] = $cart_item->qty;

                // Ensure unit price is properly set
                $this->price[$cart_item->id] = $cart_item->options->unit_price;

                // Handle discount settings
                $this->discount_type[$cart_item->id] = $cart_item->options->product_discount_type;
                if ($cart_item->options->product_discount_type == 'fixed') {
                    $this->item_discount[$cart_item->id] = $cart_item->options->product_discount;
                } elseif ($cart_item->options->product_discount_type == 'percentage') {
                    $this->item_discount[$cart_item->id] = round(100 * ($cart_item->options->product_discount / $cart_item->price));
                }

                // Update cart item with correct price and options
                Cart::instance($this->cart_instance)->update($cart_item->rowId, [
                    'price' => $cart_item->options->unit_price,
                    'options' => array_merge($cart_item->options->toArray(), [
                        'unit_price' => $cart_item->options->unit_price,
                        'sub_total' => $cart_item->options->unit_price * $cart_item->qty
                    ])
                ]);
            }

            // Recalculate totals after loading items
            $this->calculateTotals();
        }

        // Load specific items if editing sale or purchase
        if ($this->sale_id) {
            $this->loadSaleItems();
            $this->calculateTotals();
        }
        if ($this->purchase_id) {
            $this->loadPurchaseItems();
            $this->calculateTotals();
        }
    }

    public function render()
    {
        $cart_items = Cart::instance($this->cart_instance)->content();

        return view('livewire.product-cart', [
            'cart_items' => $cart_items
        ]);
    }


    public function updatedCustomerId($value)
    {
        if ($value) {
            $customer = Customer::find($value);
            $this->customer_email = $customer ? $customer->customer_email : null;
        } else {
            $this->customer_email = null;
        }
    }


    public function loadSaleItems()
    {
        if (!$this->sale_id) return;

        $sale = Sale::findOrFail($this->sale_id);

        foreach ($sale->saleDetails as $saleDetail) {
            $product = Product::findOrFail($saleDetail->product_id);

            $this->addProductToCart($product, $saleDetail->quantity, $saleDetail->price);
        }
    }

    public function loadPurchaseItems()
    {
        if (!$this->purchase_id) return;

        $purchase = Purchase::findOrFail($this->purchase_id);

        foreach ($purchase->purchaseDetails as $purchaseDetail) {
            $product = Product::findOrFail($purchaseDetail->product_id);

            $this->addProductToCart($product, $purchaseDetail->quantity, $purchaseDetail->price);
        }
    }

    private function addProductToCart($product, $quantity, $price)
    {
        $cart = Cart::instance($this->cart_instance);

        $cart->add([
            'id'      => $product->id,
            'name'    => $product->product_name,
            'qty'     => $quantity,
            'price'   => $price,
            'weight'  => 1,
            'options' => [
                'product_discount'      => 0.00,
                'product_discount_type' => 'fixed',
                'sub_total'             => $price * $quantity,
                'code'                  => $product->product_code,
                'stock'                 => $product->product_quantity,
                'unit'                  => $product->product_unit,
                'product_tax'           => $this->calculate($product)['product_tax'],
                'unit_price'            => $price,
            ]
        ]);

        $this->check_quantity[$product->id] = $product->product_quantity;
        $this->quantity[$product->id] = $quantity;
        $this->discount_type[$product->id] = 'fixed';
        $this->item_discount[$product->id] = 0;
    }


    public function productSelected($product)
    {
        $cart = Cart::instance($this->cart_instance);
        // dd($this->cart_instance);

        $exists = $cart->search(function ($cartItem, $rowId) use ($product) {
            return $cartItem->id == $product['id'];
        });

        if ($exists->isNotEmpty()) {
            session()->flash('message', 'Product exists in the cart!');

            return;
        }

        $price = 0;

        if ($this->cart_instance == 'purchase') {
            if (env('WHOLESALE_RETAIL')) {
                $price = $this->calculate($product)['wholesale_price'];
            } else {
                $price = $this->calculate($product)['cost_price'];
            }
        } else {

            if (env('WHOLESALE_RETAIL')) {
                $price = $this->calculate($product)['wholesale_price'];
            } else {
                $price = $this->calculate($product)['price'];
            }
        }

        $cart->add([
            'id'      => $product['id'],
            'name'    => $product['product_name'],
            'qty'     => 1,
            'price'   => $price,
            'weight'  => 1,
            'options' => [
                'product_discount'      => 0.00,
                'product_discount_type' => 'fixed',
                'sub_total'             => $this->calculate($product)['sub_total'],
                'code'                  => $product['product_code'],
                'moq'                  => $product['moq'],
                'stock'                 => $product['product_quantity'],
                'unit'                  => $product['product_unit'],
                'product_tax'           => $this->calculate($product)['product_tax'],
                'unit_price'            => ($this->cart_instance == 'purchase' || $this->cart_instance == 'lpo') ? $this->calculate($product)['product_cost'] :  $this->calculate($product)['unit_price'],
                'wholesale_price'       => $this->calculate($product)['wholesale_price'],
            ]
        ]);
        $this->sale_type[$product['id']] = 'Wholesale'; // Set a default value if needed

        $this->check_quantity[$product['id']] = $product['product_quantity'];
        $this->quantity[$product['id']] = 1;
        $this->discount_type[$product['id']] = 'fixed';
        $this->item_discount[$product['id']] = 0;
    }

    public function removeItem($row_id)
    {
        Cart::instance($this->cart_instance)->remove($row_id);

        $totals = $this->calculateTotals();
        $this->total_amount = $totals['total_with_shipping'];
    }

    public function updatedGlobalTax()
    {
        Cart::instance($this->cart_instance)->setGlobalTax((int)$this->global_tax);
    }

    public function updatedGlobalDiscount()
    {
        Cart::instance($this->cart_instance)->setGlobalDiscount((int)$this->global_discount);
    }

    public function updateQuantity($row_id, $product_id)
    {
        $cart_items = Cart::instance('sale')->content();

        $this->emit('cartUpdated'); // If you're using events


        $product = Product::select('id', 'moq', 'product_name')->find($product_id);
        if ($this->cart_instance == 'sale' || $this->cart_instance == 'purchase_return') {
            if ($product->moq) {
                if ((int)$product->moq > $this->quantity[$product_id]) {
                    // Log::alert("Bellow");
                    session()->flash('message', $product->product_name . ' is below MOQ!');
                    // return;
                }
            }
        }


        Cart::instance($this->cart_instance)->update($row_id, $this->quantity[$product_id]);

        $cart_item = Cart::instance($this->cart_instance)->get($row_id);


        $cart_total = 0;
        $cart_items = Cart::instance($this->cart_instance)->content();

        foreach ($cart_items as $item) {
            $cart_total += $item->options->unit_price * $item->qty;
        }

        $this->cart_total = $cart_total;

        Cart::instance($this->cart_instance)->update($row_id, [
            // 'unit_price' => $price,
            // 'price' => $price,
            'options' => [
                'sub_total'             => $cart_item->price * $cart_item->qty,
                'code'                  => $cart_item->options->code,
                'stock'                 => $cart_item->options->stock,
                'unit'                  => $cart_item->options->unit,
                'product_tax'           => $cart_item->options->product_tax,
                'wholesale_price'       => $cart_item->options->wholesale_price,
                // 'unit_price'            => $price,
                'unit_price'            => $cart_item->options->unit_price,
                'product_discount'      => $cart_item->options->product_discount,
                'product_discount_type' => $cart_item->options->product_discount_type,
            ]
        ]);

        // $this->recalculateSubtotal($row_id);


        $totals = $this->calculateTotals();
        $this->total_amount = $totals['total_with_shipping'];
    }

    public function updatePrice($row_id, $product_id)
    {

        // Cart::instance($this->cart_instance)->update($row_id, $this->quantity[$price]);

        $cart_item = Cart::instance($this->cart_instance)->get($row_id);

        $product = Product::find($product_id);

        $price = $this->price[$product_id];
        // dd($row_id, $price, $product_id);
        if ($product) {
            $buying_price = $product->product_cost;
            if ($buying_price > (int) $price && $this->cart_instance === 'sale') {
                session()->flash('message', 'Selling price is less than buying price.');
                return;
            }
        }

        Cart::instance($this->cart_instance)->update($row_id, [
            'unit_price' => $price,
            'price' => $price,
            'options' => [
                'sub_total'             => $cart_item->unit_price * $cart_item->qty,
                'code'                  => $cart_item->options->code,
                'stock'                 => $cart_item->options->stock,
                'unit'                  => $cart_item->options->unit,
                'product_tax'           => $cart_item->options->product_tax,
                'unit_price'            => $price,
                'product_discount'      => $cart_item->options->product_discount,
                'product_discount_type' => $cart_item->options->product_discount_type,
            ]
        ]);
        // $this->recalculateSubtotal($row_id);

        $totals = $this->calculateTotals();
        $this->total_amount = $totals['total_with_shipping'];
    }

    public function calculateTotals()
    {
        // Get total including tax
        $total_with_shipping = Cart::instance($this->cart_instance)->total() + (float)$this->shipping;

        // Extract tax amount from total (16% VAT)
        $tax = $total_with_shipping - ($total_with_shipping / 1.16);

        // Calculate net total (total minus tax)
        $netTotal = $total_with_shipping - $tax;

        return [
            'netTotal' => $netTotal,
            'tax' => $tax,
            'total_with_shipping' => $total_with_shipping
        ];
    }

    public function updatedDiscountType($value, $name)
    {
        $this->item_discount[$name] = 0;
    }

    public function discountModalRefresh($product_id, $row_id)
    {
        $this->updateQuantity($row_id, $product_id);
    }

    public function setProductDiscount($row_id, $product_id)
    {
        $cart_item = Cart::instance($this->cart_instance)->get($row_id);

        if ($this->discount_type[$product_id] == 'fixed') {
            Cart::instance($this->cart_instance)
                ->update($row_id, [
                    'price' => ($cart_item->price + $cart_item->options->product_discount) - $this->item_discount[$product_id]
                ]);

            $discount_amount = $this->item_discount[$product_id];

            $this->updateCartOptions($row_id, $product_id, $cart_item, $discount_amount);
        } elseif ($this->discount_type[$product_id] == 'percentage') {
            $discount_amount = ($cart_item->price + $cart_item->options->product_discount) * ($this->item_discount[$product_id]);

            Cart::instance($this->cart_instance)
                ->update($row_id, [
                    'price' => ($cart_item->price + $cart_item->options->product_discount) - $discount_amount
                ]);

            $this->updateCartOptions($row_id, $product_id, $cart_item, $discount_amount);
        }

        session()->flash('discount_message' . $product_id, 'Discount added to the product!');
    }

    public function calculate($product)
    {
        $price = 0;
        $unit_price = 0;
        $product_tax = 0;
        $sub_total = 0;
        $wholesale_price = 0;

        if ($product['product_tax_type'] == 1) {
            $price = $product['product_price'] + ($product['product_price'] * ($product['product_order_tax'] / 100));
            $unit_price = $product['product_price'];
            $product_tax = $product['product_price'] * ($product['product_order_tax'] / 100);
            $sub_total = $product['product_price'] + ($product['product_price'] * ($product['product_order_tax'] / 100));
            $wholesale_price = $product['wholesale_price'] + ($product['wholesale_price'] * ($product['product_order_tax'] / 100));
            $cost_price = $product['product_cost'] + ($product['product_cost'] * ($product['product_order_tax'] / 100));
            $product_cost = $product['product_cost'];
        } elseif ($product['product_tax_type'] == 2) {
            $price = $product['product_price'];
            // $unit_price = $product['product_price'] - ($product['product_price'] * ($product['product_order_tax']/100));
            $unit_price = $product['product_price'];
            $product_tax = $product['product_price'] * ($product['product_order_tax'] / 100);
            $sub_total = $product['product_price'];
            $wholesale_price = $product['wholesale_price'];
            $cost_price = $product['product_cost'];
            $product_cost = $product['product_cost'];
        } else {
            $price = $product['product_price'];
            $unit_price = $product['product_price'];
            $product_cost = $product['product_cost'];
            $product_tax = 0.00;
            $sub_total = $product['product_price'];
            $wholesale_price = $product['wholesale_price'];
            $cost_price = $product['product_cost'];
        }

        return ['price' => $price, 'wholesale_price' => $wholesale_price, 'unit_price' => $unit_price, 'product_tax' => $product_tax, 'sub_total' => $sub_total, 'product_cost' => $product_cost, 'cost_price' => $cost_price];
    }

    public function updateCartOptions($row_id, $product_id, $cart_item, $discount_amount)
    {
        Cart::instance($this->cart_instance)->update($row_id, ['options' => [
            'sub_total'             => $cart_item->price * $cart_item->qty,
            'code'                  => $cart_item->options->code,
            'stock'                 => $cart_item->options->stock,
            'unit'                  => $cart_item->options->unit,
            'product_tax'           => $cart_item->options->product_tax,
            'unit_price'            => $cart_item->options->unit_price,
            'product_discount'      => $discount_amount,
            'product_discount_type' => $this->discount_type[$product_id],
        ]]);
    }

    public function updateSaleType($rowId, $newSaleType)
    {
        $cart = Cart::instance($this->cart_instance);

        $cartItem = $cart->get($rowId);

        if ($cartItem) {
            $product = Product::find($cartItem->id);

            if ($product) {
                if ($newSaleType === 'Wholesale') {
                    $price = $this->calculate($product)['wholesale_price'];
                } else {
                    $price = $this->calculate($product)['price'];
                }

                $cart->update($rowId, [
                    'price' => $price,
                ]);

                $this->updateCartTotals();
            }
        }
    }

    public function updateCartTotals()
    {
        $cart_total = 0;
        $cart_items = Cart::instance($this->cart_instance)->content();

        foreach ($cart_items as $item) {
            $cart_total += $item->options->unit_price * $item->qty;
        }

        $this->cart_total = $cart_total;
    }

    public function recalculateSubtotal($rowId)
    {
        $cart = Cart::instance($this->cart_instance);
        $cartItem = $cart->get($rowId);

        if ($cartItem) {
            $subtotal = $cartItem->qty * $cartItem->price;
            $options = $cartItem->options;
            $options['sub_total'] = $subtotal;

            $cart->update($rowId, ['options' => $options]);
        }

        $this->updateCartTotals();
    }
}
