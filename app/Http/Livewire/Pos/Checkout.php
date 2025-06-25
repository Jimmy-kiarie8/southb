<?php

namespace App\Http\Livewire\Pos;

use Gloudemans\Shoppingcart\Facades\Cart;
use Livewire\Component;
use Modules\People\Entities\Customer;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;
use Modules\Branch\Entities\ProductBranch;
use Modules\Product\Entities\Product;

class Checkout extends Component
{

    public $listeners = ['productSelected', 'discountModalRefresh', 'resetCart' => 'resetCart'];
    public $query;

    public $cart_instance;
    public $customers;
    public $global_discount;
    public $global_tax;
    public $shipping;
    public $quantity;
    public $check_quantity;
    public $discount_type;
    public $item_discount;
    public $data;
    public $customer_id;
    public $total_amount;
    public $payment_method;
    public $paid_amount;
    public $sale_type;

    public $customer_name;
    public $customer_email;
    public $customer_phone;
    public $city;
    public $country;
    public $address;
    public $paymentMethods = [];

    public $how_many;
    public $search_results;
    public $customer;

    public function mount($cartInstance, $customers)
    {
        $this->cart_instance = $cartInstance;
        $this->customers = $customers;
        $this->global_discount = 0;
        $this->global_tax = 0;
        $this->shipping = 0.00;
        $this->check_quantity = [];
        $this->quantity = [];
        $this->discount_type = [];
        $this->item_discount = [];
        $this->total_amount = 0;
        $this->payment_method = 'Cash';
        $this->paid_amount = 0;
        $this->sale_type = 'Retail';


        $this->query = '';
        $this->how_many = 5;
        $this->search_results = Collection::empty();


        $this->paymentMethods = [
            ['type' => 'Cash', 'amount' => 0]
        ];
    }



    public function addPaymentMethod()
    {
        $this->paymentMethods[] = ['type' => 'Cash', 'amount' => 0];
    }

    public function removePaymentMethod($index)
    {
        unset($this->paymentMethods[$index]);
        $this->paymentMethods = array_values($this->paymentMethods);
        $this->calculateTotalPaidAmount();
    }

    public function updatedPaymentMethods()
    {
        $this->calculateTotalPaidAmount();
    }

    private function calculateTotalPaidAmount()
    {
        $this->paid_amount = array_sum(array_column($this->paymentMethods, 'amount'));
    }


    public function hydrate()
    {
        $this->total_amount = $this->calculateTotal();
        $this->updatedCustomerId();
    }

    public function render()
    {
        $cart_items = Cart::instance($this->cart_instance)->content();

        return view('livewire.pos.checkout', [
            'cart_items' => $cart_items
        ]);
    }

    public function proceed()
    {
        // if ($this->customer_id != null) {
        $this->dispatchBrowserEvent('showCheckoutModal');
        // } else {
        //     session()->flash('message', 'Please Select Customer!');
        // }
    }

    public function process()
    {
        $this->dispatchBrowserEvent('showCustomerModal');
    }

    public function calculateTotal()
    {
        return Cart::instance($this->cart_instance)->total() + $this->shipping;
    }

    public function resetCart()
    {
        Log::info('resetCart method called');
        Cart::instance($this->cart_instance)->destroy();
    }

    public function resetCustomer()
    {
        $this->customer_id = null;
        $this->query = '';
        $this->search_results = Collection::empty();
    }

    public function resetPaymentMethods()
    {
        $this->paymentMethods = [['type' => 'Cash', 'amount' => 0]];
        $this->paid_amount = 0;
    }
    public function productSelected($product)
    {
        $cart = Cart::instance($this->cart_instance);

        // Check branch-specific quantity first
        $branch_id = Auth::user()->branch_id;
        $productBranch = ProductBranch::where('product_id', $product['id'])
                                      ->where('branch_id', $branch_id)
                                      ->first();

        $branch_quantity = $productBranch ? $productBranch->quantity : 0;

        if ($branch_quantity <= 0) {
            session()->flash('message', 'Product is out of stock in your branch!');
            return;
        }

        $exists = $cart->search(function ($cartItem, $rowId) use ($product) {
            return $cartItem->id == $product['id'];
        });

        if ($exists->isNotEmpty()) {
            $rowId = $exists->first()->rowId;

            // Check if adding one more exceeds branch quantity
            $current_qty = $exists->first()->qty;
            if ($current_qty + 1 > $branch_quantity) {
                session()->flash('message', 'Cannot add more of this product. Branch stock limit reached!');
                return;
            }

            $this->addQuantity($rowId, $product['id']);
            return;
        } else {
            $cart->add([
                'id'      => $product['id'],
                'name'    => $product['product_name'],
                'qty'     => 1,
                'price'   => ($this->sale_type == 'Wholesale') ? $this->calculate($product)['wholesale_price'] : $this->calculate($product)['price'],
                'weight'  => 1,
                'options' => [
                    'product_discount'      => 0.00,
                    'product_discount_type' => 'fixed',
                    'sub_total'             => $this->calculate($product)['sub_total'],
                    'code'                  => $product['product_code'],
                    'stock'                 => $branch_quantity, // Use branch quantity instead of global
                    'unit'                  => $product['product_unit'],
                    'product_tax'           => $this->calculate($product)['product_tax'],
                    'unit_price'            => $this->calculate($product)['unit_price'],
                    'product_cost'          => $this->calculate($product)['product_cost'],
                    'wholesale_price'       => $this->calculate($product)['wholesale_price'],
                ]
            ]);
        }

        $this->check_quantity[$product['id']] = $branch_quantity; // Use branch quantity
        $this->quantity[$product['id']] = 1;
        $this->discount_type[$product['id']] = 'fixed';
        $this->item_discount[$product['id']] = 0;
        $this->total_amount = $this->calculateTotal();
    }

    public function updateQuantity($row_id, $product_id)
    {
        if ($this->quantity[$product_id] < 0.001) {
            session()->flash('message', 'Invalid quantity.');
            return;
        }

        // Get branch-specific quantity
        $branch_id = Auth::user()->branch_id;
        $productBranch = ProductBranch::where('product_id', $product_id)
                                      ->where('branch_id', $branch_id)
                                      ->first();

        $branch_quantity = $productBranch ? $productBranch->quantity : 0;

        if ($branch_quantity < $this->quantity[$product_id]) {
            session()->flash('message', 'The requested quantity is not available in your branch stock.');
            return;
        }

        Cart::instance($this->cart_instance)->update($row_id, $this->quantity[$product_id]);

        $cart_item = Cart::instance($this->cart_instance)->get($row_id);

        Cart::instance($this->cart_instance)->update($row_id, [
            'options' => [
                'sub_total'             => $cart_item->price * $cart_item->qty,
                'code'                  => $cart_item->options->code,
                'stock'                 => $branch_quantity, // Update with branch quantity
                'unit'                  => $cart_item->options->unit,
                'product_tax'           => $cart_item->options->product_tax,
                'wholesale_price'       => $cart_item->options->wholesale_price,
                'unit_price'            => $cart_item->options->unit_price,
                'product_cost'          => $cart_item->options->product_cost,
                'product_discount'      => $cart_item->options->product_discount,
                'product_discount_type' => $cart_item->options->product_discount_type,
            ]
        ]);
    }

    public function addQuantity($row_id, $product_id)
    {
        // Get branch-specific quantity
        $branch_id = Auth::user()->branch_id;
        $productBranch = ProductBranch::where('product_id', $product_id)
                                      ->where('branch_id', $branch_id)
                                      ->first();

        $branch_quantity = $productBranch ? $productBranch->quantity : 0;

        $cart_item = Cart::instance($this->cart_instance)->get($row_id);
        $current_qty = $cart_item->qty;

        if ($current_qty + 1 > $branch_quantity) {
            session()->flash('message', 'Cannot add more of this product. Branch stock limit reached!');
            return;
        }

        Cart::instance($this->cart_instance)->update($row_id, ($this->quantity[$product_id]++));

        $cart_item = Cart::instance($this->cart_instance)->get($row_id);

        Cart::instance($this->cart_instance)->update($row_id, [
            'options' => [
                'sub_total'             => $cart_item->price * $cart_item->qty,
                'code'                  => $cart_item->options->code,
                'stock'                 => $branch_quantity, // Update with branch quantity
                'unit'                  => $cart_item->options->unit,
                'product_tax'           => $cart_item->options->product_tax,
                'wholesale_price'       => $cart_item->options->wholesale_price,
                'unit_price'            => $cart_item->options->unit_price,
                'product_cost'          => $cart_item->options->product_cost,
                'product_discount'      => $cart_item->options->product_discount,
                'product_discount_type' => $cart_item->options->product_discount_type,
            ]
        ]);
    }

    public function removeItem($row_id)
    {
        Cart::instance($this->cart_instance)->remove($row_id);
    }

    public function updatedGlobalTax()
    {
        Cart::instance($this->cart_instance)->setGlobalTax((int)$this->global_tax);
    }

    public function updatedGlobalDiscount()
    {
        Cart::instance($this->cart_instance)->setGlobalDiscount((int)$this->global_discount);
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
        // dd($row_id, $product_id, $this->item_discount[$product_id]);
        $product = Product::find($product_id);

        $price = $this->item_discount[$product_id];


        if ($product) {
            $buying_price = $product->product_cost;
            if ($buying_price > (int) $price) {
                session()->flash('message', 'Selling price is less than buying price.');
                return;
            }
        }


        $cart_item = Cart::instance($this->cart_instance)->get($row_id);

        if ($this->discount_type[$product_id] == 'fixed') {
            Cart::instance($this->cart_instance)
                ->update($row_id, [
                    'price' => $this->item_discount[$product_id]
                    // 'price' => ($cart_item->price + $cart_item->options->product_discount) - $this->item_discount[$product_id]
                ]);

            $discount_amount = $this->item_discount[$product_id];

            $this->updateCartOptions($row_id, $product_id, $cart_item, $discount_amount);
        } elseif ($this->discount_type[$product_id] == 'percentage') {
            $discount_amount = ($cart_item->price + $cart_item->options->product_discount) * ($this->item_discount[$product_id]);
            Cart::instance($this->cart_instance)
                ->update($row_id, [
                    // 'price' => $discount_amount
                    'price' => ($cart_item->price + $cart_item->options->product_discount) - $discount_amount
                ]);

            $this->updateCartOptions($row_id, $product_id, $cart_item, $discount_amount);
        }

        session()->flash('discount_message' . $product_id, 'Product Price updated!');
        // session()->flash('discount_message' . $product_id, 'Discount added to the product!');
    }

    public function calculate($product)
    {
        $price = 0;
        $unit_price = 0;
        $product_cost = 0;
        $product_tax = 0;
        $sub_total = 0;
        $wholesale_price = 0;

        if ($product['product_tax_type'] == 1) {
            $wholesale_price = $product['wholesale_price'] + ($product['wholesale_price'] * ($product['product_order_tax']));
            $price = $product['product_price'] + ($product['product_price'] * ($product['product_order_tax']));
            $unit_price = $product['product_price'];
            $product_cost = $product['product_cost'];
            $product_tax = $product['product_price'] * ($product['product_order_tax']);
            $sub_total = $product['product_price'] + ($product['product_price'] * ($product['product_order_tax']));
        } elseif ($product['product_tax_type'] == 2) {
            $wholesale_price = $product['wholesale_price'];
            $price = $product['product_price'];
            $unit_price = $product['product_price'] - ($product['product_price'] * ($product['product_order_tax']));
            $product_cost = $product['product_cost'];
            $product_tax = $product['product_price'] * ($product['product_order_tax']);
            $sub_total = $product['product_price'];
        } else {
            $price = $product['product_price'];
            $unit_price = $product['product_price'];
            $product_cost = $product['product_cost'];
            $wholesale_price = $product['wholesale_price'];
            $product_tax = 0.00;
            $sub_total = $product['product_price'];
        }

        return ['price' => $price, 'product_cost' => $product_cost, 'unit_price' => $unit_price, 'wholesale_price' => (int)$wholesale_price, 'product_tax' => $product_tax, 'sub_total' => $sub_total];
    }

    public function updateCartOptions($row_id, $product_id, $cart_item, $discount_amount)
    {
        Cart::instance($this->cart_instance)->update($row_id, ['options' => [
            'sub_total'             => $cart_item->price * $cart_item->qty,
            'code'                  => $cart_item->options->code,
            'stock'                 => $cart_item->options->stock,
            'unit'                 => $cart_item->options->unit,
            'product_tax'           => $cart_item->options->product_tax,
            'unit_price'            => $cart_item->options->unit_price,
            'product_cost'            => $cart_item->options->product_cost,
            'wholesale_price'            => $cart_item->options->wholesale_price,
            'product_discount'      => $discount_amount,
            'product_discount_type' => $this->discount_type[$product_id],
        ]]);
    }

    public function createCustomer()
    {
        $customer = Customer::create([
            'customer_name' => $this->customer_name,
            'customer_email' => $this->customer_email,
            'customer_phone' => $this->customer_phone,
            'city' => $this->city,
            'country' => $this->country,
            'address' => $this->address
        ]);
        $this->resetQuery($customer);
    }





    public function updatedQuery()
    {
        $this->search_results = Customer::where('customer_name', 'LIKE', '%' . $this->query . '%')->orWhere('customer_phone', 'LIKE', '%' . $this->query . '%')->take($this->how_many)->get();
    }

    public function loadMore()
    {
        $this->how_many += 5;
        $this->updatedQuery();
    }

    public function resetQuery($customer)
    {
        $this->customer_id = $customer['id'];
        $this->query = $customer['customer_name'];
        $this->how_many = 5;
        $this->search_results = Collection::empty();
    }

    public function selectCustomer($customer)
    {
        $this->customer = $customer;
    }
}
