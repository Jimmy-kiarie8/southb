<?php

namespace Modules\Product\Http\Controllers;

use App\Http\Resources\ProductResource;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Storage;
use Modules\Product\Entities\Category;
use Modules\Product\Entities\Product;
use Modules\Product\Http\Requests\StoreProductRequest;

class ProductApiController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index()
    {
        return ProductResource::collection(Product::take(30)->orderBy('product_name', 'DESC')->get());
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('product::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request) {
        // public function store(StoreProductRequest $request) {
        // return $request->all();


        $request->validate([
            'product_name' => ['required', 'string', 'max:255'],
            'product_code' => ['required', 'string', 'max:255', 'unique:products,product_code'],
            'product_barcode_symbology' => ['required', 'string', 'max:255'],
            'product_unit' => ['required', 'string', 'max:255'],
            // 'product_quantity' => ['required', 'integer', 'min:1'],
            'product_cost' => ['required', 'numeric', 'max:2147483647'],
            'product_price' => ['required', 'numeric', 'max:2147483647'],
            'product_stock_alert' => ['required', 'integer', 'min:0'],
            'product_order_tax' => ['nullable', 'integer', 'min:0', 'max:100'],
            'product_tax_type' => ['nullable', 'integer'],
            'product_note' => ['nullable', 'string', 'max:1000'],
            'category_id' => ['required', 'integer']
        ]);

        // Product::create($request->all());
        Product::create([
            'product_name' => $request->product_name,
            'product_code' => $request->product_code,
            'product_barcode_symbology' => $request->product_barcode_symbology,
            'product_unit' => $request->product_unit,
            'product_cost' => $request->product_cost,
            'product_price' => $request->product_price,
            'product_stock_alert' => $request->product_stock_alert,
            'product_order_tax' => $request->product_order_tax,
            'product_tax_type' => $request->product_tax_type,
            'product_note' => $request->product_note,
            'category_id' => $request->category_id
        ]);

        // if ($request->has('document')) {
        //     foreach ($request->input('document', []) as $file) {
        //         $product->addMedia(Storage::path('temp/dropzone/' . $file))->toMediaCollection('images');
        //     }
        // }


        return response()->json([
            'message' => 'Product created!'
        ], 200);
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('product::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('product::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        // return $request->all();

        Product::find($id)->update([
            'product_name' => $request->product_name,
            'product_code' => $request->product_code,
            'product_barcode_symbology' => $request->product_barcode_symbology,
            'product_unit' => $request->product_unit,
            'product_cost' => $request->product_cost,
            'product_price' => $request->product_price,
            'product_stock_alert' => $request->product_stock_alert,
            'product_order_tax' => $request->product_order_tax,
            'product_tax_type' => $request->product_tax_type,
            'product_note' => $request->product_note,
            'category_id' => $request->category_id
        ]);



        return response()->json([
            'message' => 'Product updated!'
        ], 200);
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

    public function scan($code)
    {
        $product = Product::where('product_code', $code)->first();
        if (!$product) {
            abort(422, 'Product code not found');
        }
        return $product;
    }

    public function search($search)
    {
        $product = Product::where('product_code', 'LIKE',"%{$search}%")->orWhere('product_name', 'LIKE',"%{$search}%")->paginate(30);
        if (!$product) {
            abort(422, 'Product code not found');
        }
        return $product;
    }

    public function categories()
    {
        return Category::all();
    }
}
