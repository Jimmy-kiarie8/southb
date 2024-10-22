<?php

namespace App\Http\Livewire;

use Livewire\Component;
use Modules\People\Entities\Customer;

class CustomerDetails extends Component
{
    public $customer_id;
    public $pin;

    public function updatedCustomerId($value)
    {
        if ($value) {
            $customer = Customer::find($value);
            $this->pin = $customer ? $customer->pin : null;
        } else {
            $this->pin = null;
        }
    }

    public function render()
    {
        return view('livewire.customer-details', [
            'customers' => Customer::all(),
        ]);
    }
}
