<?php

namespace Modules\Transfer\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Transfer\DataTables\TransferDataTable;
use Modules\Transfer\Entities\ProductTransfer;
use Modules\Transfer\Entities\Transfer;
use Gloudemans\Shoppingcart\Facades\Cart;
use Modules\Branch\Entities\ProductBranch;
use Modules\Product\Entities\Product;

class TransferController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(TransferDataTable $dataTable)
    {
        // return Transfer::with('products')->get();
        return $dataTable->render('transfer::transfer.index');
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('transfer::transfer.create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        if ($request->location_from == $request->location_to) {

            toast('Prease choose a different location on Location 2!', 'success');
            return redirect()->route('transfer.create');
        }
        $transfer = Transfer::create([
            'reference' => $request->reference,
            'location_from' =>  $request->location_from,
            'location_to' => $request->location_to,
            'received' => 0,
            'status' => $request->status
        ]);


        $products = Cart::instance('transfer')->content();

        foreach ($products as $product) {
            // dd($product);
            ProductTransfer::create([
                'product_id' => $product->id,
                'transfer_id' => $transfer->id,
                'quantity' => $product->qty
            ]);





            if ($request->status == 'Completed') {
                // $product = Product::findOrFail($product->id);
                // $product->update([
                //     'product_quantity' => $product->product_quantity + $product->qty
                // ]);

                $product_branch = ProductBranch::where('product_id', $product->id)->where('branch_id', $request->location_from)->first();
                $new_from = $product_branch->quantity - $product->qty;

                if ($product_branch) {
                    // $product_branch->update([
                    //     'quantity' => $new_from
                    // ]);
                    $product_branch->quantity = $new_from;
                    // dd($product_branch->quantity);
                    $product_branch->save();
                } else {
                    abort(422, 'Product ' . $product->product_name . ' does not exist');
                    $product_branch = new ProductBranch();
                    $product_branch->quantity($product->qty, $product->id);
                }


                $product_to = ProductBranch::where('product_id', $product->id)->where('branch_id', $request->location_to)->first();

                if ($product_to) {
                    $new_to = $product_to->quantity + $product->qty;
                    $product_to->update([
                        'quantity' => $new_to
                    ]);
                } else {
                    // $product_to = new ProductBranch();
                    // $product_to->quantity($product->qty, $product->id);


                    $data = [
                        'branch_id' => $request->location_to,
                        'product_id' => $product->id,
                        'quantity' => $product->qty
                    ];
                    ProductBranch::create($data);
                }
            }
        }

        Cart::instance('transfer')->destroy();
        toast('Transfer Created!', 'success');
        return redirect()->route('transfer.index');

    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
       $transfer = Transfer::with(['location', 'from_location', 'products' => function($q) {
        $q->setEagerLoads([]);
       }])->where('reference', $id)->first();
    //    $transfer = Transfer::with(['location', 'from_location', 'products' => function($q) {
    //     $q->setEagerLoads([]);
    //    }])->find($id);


        return view('transfer::transfer.show', compact('transfer'));
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('transfer::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        //
    }
}
