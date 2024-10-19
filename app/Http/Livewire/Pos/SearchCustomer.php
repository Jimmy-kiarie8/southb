<?php

namespace App\Http\Livewire\Pos;

use Illuminate\Database\Eloquent\Collection;
use Livewire\Component;
use Livewire\WithPagination;
use Modules\People\Entities\Customer;

class SearchCustomer extends Component
{
    use WithPagination;

    public $query;
    public $search_results;
    public $how_many;
    public $customer;

    public function mount() {
        $this->query = '';
        $this->how_many = 5;
        $this->search_results = Collection::empty();
    }

    public function render() {
        return view('livewire.pos.search-customer');
    }

    public function updatedQuery() {
        // dd($this->search_results, $this->query);
        $this->search_results = Customer::where('customer_name', 'LIKE','%' . $this->query . '%')->orWhere('customer_phone', 'LIKE', '%' . $this->query . '%')->take($this->how_many)->get();
    }

    public function loadMore() {
        $this->how_many += 5;
        $this->updatedQuery();
    }

    public function resetQuery($customer) {
        // dd($customer);
        $this->query = $customer['customer_name'];
        $this->how_many = 5;
        $this->search_results = Collection::empty();
        // $this->search_results = Collection::empty();
    }

    public function selectCustomer($customer) {
        // dd($customer);
        $this->customer = $customer;
        // $this->emit('customerSelected', $customer);

    }


    public function process() {
        $this->dispatchBrowserEvent('showCustomerModal');
    }
}
