<?php

namespace App\Http\Livewire;

use Illuminate\Support\Collection;
use Livewire\Component;
use Modules\Product\Entities\Product;

class SearchProduct extends Component
{
    public $listeners = ['locationChange'];

    public $query;
    public $search_results;
    public $how_many;
    public $loc;


    public function mount()
    {
        $this->loc = (request()->route()->getName() == "transfer.create") ? false : true;
        $this->query = '';
        $this->how_many = 5;
        $this->search_results = Collection::empty();
    }

    public function render()
    {
        return view('livewire.search-product');
    }

    public function updatedQuery1()
    {
        $this->search_results = Product::where('product_name', 'like', '%' . $this->query . '%')
            ->orWhere('product_code', 'like', '%' . $this->query . '%')
            ->take($this->how_many)->get();
    }

    public function updatedQuery()
    {
        // Perform your search logic here and update $search_results
        $products = Product::where('product_name', 'like', '%' . $this->query . '%')
            ->orWhere('product_code', 'like', '%' . $this->query . '%')
            ->get();


        if (count($products) === 1) {

            $product = Product::where('product_name', 'like', '%' . $this->query . '%')
                ->orWhere('product_code', 'like', '%' . $this->query . '%')
                ->first();
                $this->query = '';
            $this->emit('productSelected', $product);

        } else {
            $this->search_results = $products;

        }

        // Emit event after updating search results
        // $this->emit('searchResultsUpdated');
    }


    public function loadMore()
    {
        $this->how_many += 5;
        $this->updatedQuery();
    }

    public function resetQuery()
    {
        $this->query = '';
        $this->how_many = 5;
        $this->search_results = Collection::empty();
    }

    public function selectProduct($product)
    {
        $this->emit('productSelected', $product);
    }


    public function locationChange($data)
    {
        $this->loc = true;
    }
}
