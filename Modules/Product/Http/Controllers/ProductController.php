<?php

namespace Modules\Product\Http\Controllers;

use Carbon\Carbon;
use Modules\Product\DataTables\ProductDataTable;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Storage;
use Modules\Branch\Entities\ProductBranch;
use Modules\Product\Entities\Product;
use Modules\Product\Http\Requests\StoreProductRequest;
use Modules\Product\Http\Requests\UpdateProductRequest;
use Modules\Setting\Entities\Setting;
use Modules\Upload\Entities\Upload;
use Barryvdh\DomPDF\Facade\Pdf;

class ProductController extends Controller
{

    public function index(ProductDataTable $dataTable)
    {
        abort_if(Gate::denies('access_products'), 403);

        return $dataTable->render('product::products.index');
    }


    public function create()
    {
        abort_if(Gate::denies('create_products'), 403);

        return view('product::products.create');
    }


    public function store(StoreProductRequest $request)
    {
        // return $request->all();
        $product = Product::create($request->except('document'));

        if ($request->has('document')) {
            foreach ($request->input('document', []) as $file) {
                $product->addMedia(Storage::path('temp/dropzone/' . $file))->toMediaCollection('images');
            }
        }

        toast('Product Created!', 'success');

        $product_branch = new ProductBranch();
        $product_branch->quantity($request->product_quantity, $product->id, Auth::user()->branch_id);

        return redirect()->route('products.index');
    }


    public function show(Product $product)
    {
        abort_if(Gate::denies('show_products'), 403);

        $locations = $product->branches;
        return view('product::products.show', compact('product', 'locations'));
    }


    public function edit(Product $product)
    {
        abort_if(Gate::denies('edit_products'), 403);

        return view('product::products.edit', compact('product'));
    }


    public function update(UpdateProductRequest $request, Product $product)
    {
        $product->update($request->except('document'));

        if ($request->has('document')) {
            if (count($product->getMedia('images')) > 0) {
                foreach ($product->getMedia('images') as $media) {
                    if (!in_array($media->file_name, $request->input('document', []))) {
                        $media->delete();
                    }
                }
            }

            $media = $product->getMedia('images')->pluck('file_name')->toArray();

            foreach ($request->input('document', []) as $file) {
                if (count($media) === 0 || !in_array($file, $media)) {
                    $product->addMedia(Storage::path('temp/dropzone/' . $file))->toMediaCollection('images');
                }
            }
        }

        toast('Product Updated!', 'info');

        return redirect()->route('products.index');
    }


    public function destroy(Product $product)
    {
        abort_if(Gate::denies('delete_products'), 403);



        try {
            $product->delete();


            toast('Product Deleted!', 'warning');

            return redirect()->route('products.index');
            return redirect()->route('products.index')->with('success', 'Product deleted successfully');
        } catch (\Exception $e) {


            toast($e->getMessage(), 'warning');

            return redirect()->route('products.index');
            return redirect()->back()->with('error', $e->getMessage());
        }
    }

    public function stock(Request $request)
    {
        // return $request->all();
        $supplier_id = $request->supplier_id;
        $products = Product::setEagerLoads([])->when((int)$request->supplier_id != 0, function ($q) use($supplier_id) {
            return $q->where('supplier_id', $supplier_id);
        })->with('supplier')->get();


        $product_arr = [];
        $total_cost = 0;

        foreach ($products as $product) {
            // return $product;

            if ($product->available_qty < $product->product_stock_alert) {
                $product_arr[] = $product;
                $total_cost += ($product->product_stock_alert - $product->available_qty) * $product->product_cost;
            }
        }

        $company = Setting::first();
        // dd($company->site_logo);

        $pdf = PDF::loadView('product::products.pdf.lowstock', ['data' => $product_arr, 'company' =>  $company, 'total_cost' => $total_cost]);
        // ->option('header-html', $headerHtml)
        // ->setOption('header-spacing', '50')
        // ->setOption('margin-top', '30mm');
        // return view('product::products.pdf.lowstock')->with(['data' => $product_arr, 'company' =>  $company, 'total_cost' => $total_cost]);
        return $pdf->stream(Carbon::now() . '-sales.pdf');

        return $product_arr;
    }
}
