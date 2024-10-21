<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreCustomerProductRequest;
use App\Http\Requests\UpdateCustomerProductRequest;
use App\Models\CustomerProduct;

class CustomerProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\StoreCustomerProductRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreCustomerProductRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\CustomerProduct  $customerProduct
     * @return \Illuminate\Http\Response
     */
    public function show(CustomerProduct $customerProduct)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\CustomerProduct  $customerProduct
     * @return \Illuminate\Http\Response
     */
    public function edit(CustomerProduct $customerProduct)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateCustomerProductRequest  $request
     * @param  \App\Models\CustomerProduct  $customerProduct
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateCustomerProductRequest $request, CustomerProduct $customerProduct)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\CustomerProduct  $customerProduct
     * @return \Illuminate\Http\Response
     */
    public function destroy(CustomerProduct $customerProduct)
    {
        //
    }
}
