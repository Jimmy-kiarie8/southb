<?php

namespace App\Http\Livewire;

use Livewire\Component;
use Modules\People\Entities\Customer;

class CustomerPayment extends Component
{
    public $amount, $customer_id;

    public function render()
    {
        return view('livewire.customer-payment');
    }

    // public function updatePayment()
    // {
    //     $customer = Customer::find($this->customer_id);

    //     dd($customer);
    // }

    public function submit()
    {
        // Perform any necessary actions to update the payment
        $this->updatePayment($this->amount);

        // Show a success message
        session()->flash('message', 'Payment updated successfully!');
    }

    public function updatePayment()
    {
        dd('777777777777');
        // Your code to update the payment
    }

}
