<?php

namespace Modules\Stocksheet\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Product\Entities\Product;
use Modules\Setting\Entities\Setting;
use Modules\Stocksheet\DataTables\StocksheetDataTable;
use Modules\Stocksheet\Entities\Stocksheet;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class StocksheetController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(StocksheetDataTable $dataTable)
    {
        return $dataTable->render('stocksheet::stocksheet.index');
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('stocksheet::stocksheet.create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        // return $request->all();
        $stock = Stocksheet::where('product_id', $request->product_id)->whereDate('created_at', Carbon::today())->first();

        if ($stock) {
            $stock->updateAsDraft([
                'system_qty' => $request->system_qty,
                'actual_qty' => $request->actual_qty
            ]);
        } else {
            $data = [
                'reference' => 'REF',
                'product_id' => $request->product_id,
                'system_qty' => $request->system_qty,
                'actual_qty' => $request->actual_qty
            ];

            if ($request->type == 'post') {
                Stocksheet::create($data);
            } else {
                Stocksheet::createDraft($data);
            }
        }
    }

    public function publish($id)
    {
        Stocksheet::find($id)->update(['is_published' => true, 'published_at' => now()]);
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('stocksheet::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('stocksheet::edit');
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
        Stocksheet::find($id)->delete();

        return redirect()->route('stocksheet.index');
    }


    // public function getStocksheet()
    // {

    //     $data = Product::setEagerLoads([])->with(['branches', 'supplier'])->select('id', 'product_name', 'product_code')->take(500)->get();
    //     $company = Setting::first();
    //     $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock', ['data' => $data, 'company' =>  $company]);
    //     return $pdf->stream('stocksheet.pdf.stock');
    // }
    public function getStocksheet(Request $request)
    {
        $perPage = 500;
        $page = 1;
        $company = Setting::first();
        $directory = public_path('stockreports');
        $asOfDate = $request->as_of_date ? Carbon::parse($request->as_of_date)->format('Y-m-d') : Carbon::now()->format('Y-m-d');

        if (!File::exists($directory)) {
            File::makeDirectory($directory, 0755, true);
        }

        $timestamp = date('Ymd_His'); // Get the current date in 'YYYYMMDD_HHMMSS' format

        do {
            $query = Product::setEagerLoads([])
                ->with(['branches', 'supplier'])
                ->select('id', 'product_name', 'product_code', 'product_quantity', 'product_cost', 'product_price', 'product_unit', 'created_at')
                ->skip(($page - 1) * $perPage)
                ->take($perPage);

            // Apply location filter if provided
            if ($request->location_id) {
                $location_id = $request->location_id;
                $query = $query->whereHas('branches', function($q) use ($location_id) {
                    $q->where('branch_id', $location_id);
                });
            }

            $data = $query->get();

            // Process each product to calculate accurate stock based on purchase and sale dates
            if ($asOfDate) {
                foreach ($data as $product) {
                    // First, check if the product existed before the as_of_date
                    $productCreationDate = Carbon::parse($product->created_at);
                    if ($productCreationDate->gt(Carbon::parse($asOfDate))) {
                        // Product was created after the as_of_date, set quantity to 0
                        $product->product_quantity = 0;
                        continue;
                    }

                    // Get all purchase details for this product up to the as_of_date
                    $purchaseQuantity = DB::table('purchase_details')
                        ->join('purchases', 'purchases.id', '=', 'purchase_details.purchase_id')
                        ->where('purchase_details.product_id', $product->id)
                        ->where('purchases.status', 'Completed')
                        ->whereDate('purchases.date', '<=', $asOfDate)
                        ->sum('purchase_details.quantity');

                    // Get all sale details for this product up to the as_of_date
                    $saleQuantity = DB::table('sale_details')
                        ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
                        ->where('sale_details.product_id', $product->id)
                        ->whereDate('sales.date', '<=', $asOfDate)
                        ->sum('sale_details.quantity');

                    // Calculate the product quantity as of the specified date
                    $product->product_quantity = $purchaseQuantity - $saleQuantity;

                    // If quantity is negative, set to 0 (might happen due to data inconsistencies)
                    if ($product->product_quantity < 0) {
                        $product->product_quantity = 0;
                    }
                }
            }

            if ($data->isEmpty()) {
                break; // No more data, exit the loop
            }

            $dateInfo = $asOfDate ? '_asof_' . Carbon::parse($asOfDate)->format('Ymd') : '';
            $reportTitle = $asOfDate ? "Stock Sheet as of " . Carbon::parse($asOfDate)->format('d M Y') : date('D d M Y') . ' Stock Sheet';

            $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock', [
                'data' => $data,
                'company' => $company,
                'report_title' => $reportTitle
            ]);

            $pdfPath = $directory . '/' . 'St_stocksheet' . $dateInfo . '_page_' . $page . '_' . $timestamp . '.pdf'; // Filename with timestamp
            $pdf->save($pdfPath); // Save the PDF in the stockreports directory

            $page++;
        } while (true);

        toast('Stock Sheet PDF Generated! Please check on `Latest Generated Stock Level` below', 'success');

        return redirect()->back();
    }


    public function stocklevel(Request $request)
    {
        $perPage = 500;
        $page = 1;
        $company = Setting::first();
        $directory = public_path('stocklevels');
        $timestamp = date('Ymd_His'); // Get the current date in 'YYYYMMDD_HHMMSS' format

        Log::info($request->as_of_date);
        $asOfDate = $request->as_of_date ? Carbon::parse($request->as_of_date)->format('Y-m-d') : Carbon::now()->format('Y-m-d');

        if (!File::exists($directory)) {
            File::makeDirectory($directory, 0755, true);
        }

        do {
            $query = Product::setEagerLoads([])
                ->with(['branches', 'supplier'])
                ->skip(($page - 1) * $perPage)
                ->take($perPage);

            // Apply location filter if provided
            if ($request->location_id) {
                $location_id = $request->location_id;
                $query = $query->whereHas('branches', function($q) use ($location_id) {
                    $q->where('branch_id', $location_id);
                });
            }

            $data = $query->get();

            // Process each product to calculate accurate stock based on purchase and sale dates
            if ($asOfDate) {
                foreach ($data as $product) {
                    // First, check if the product existed before the as_of_date
                    $productCreationDate = Carbon::parse($product->created_at);
                    if ($productCreationDate->gt(Carbon::parse($asOfDate))) {
                        // Product was created after the as_of_date, set quantity to 0
                        $product->product_quantity = 0;
                        continue;
                    }

                    // Get all purchase details for this product up to the as_of_date
                    $purchaseQuantity = DB::table('purchase_details')
                        ->join('purchases', 'purchases.id', '=', 'purchase_details.purchase_id')
                        ->where('purchase_details.product_id', $product->id)
                        ->where('purchases.status', 'Completed')
                        ->whereDate('purchases.date', '<=', $asOfDate)
                        ->sum('purchase_details.quantity');

                    // Get all sale details for this product up to the as_of_date
                    $saleQuantity = DB::table('sale_details')
                        ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
                        ->where('sale_details.product_id', $product->id)
                        ->whereDate('sales.date', '<=', $asOfDate)
                        ->sum('sale_details.quantity');

                    // Calculate the product quantity as of the specified date
                    $product->product_quantity = $purchaseQuantity - $saleQuantity;

                    // If quantity is negative, set to 0 (might happen due to data inconsistencies)
                    if ($product->product_quantity < 0) {
                        $product->product_quantity = 0;
                    }
                }
            }

            $total = 0;
            foreach ($data as $key => $value) {
                $total += $value->product_quantity * $value->product_cost;
            }

            if ($data->isEmpty()) {
                break; // No more data, exit the loop
            }

            $dateInfo = $asOfDate ? '_asof_' . Carbon::parse($asOfDate)->format('Ymd') : '';
            $reportTitle = $asOfDate ? "Stock Level as of " . Carbon::parse($asOfDate)->format('d M Y') : date('D d M Y') . ' Stock Level';

            $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock-levels', [
                'data' => $data,
                'company' => $company,
                'total' => $total,
                'report_title' => $reportTitle
            ]);

            $pdfPath = $directory . '/' . 'stocklevel' . $dateInfo . '_page_' . $page . '_' . $timestamp . '.pdf'; // Filename with timestamp
            $pdf->save($pdfPath); // Save the PDF in the stockreports directory

            $page++;
        } while (true);

        toast('Stock Level PDF Generated! Please check on `Latest Generated Stock Level` below', 'success');

        return redirect()->back();
    }

    public function closingStock(Request $request)
    {
        $perPage = 500;
        $page = 1;
        $company = Setting::first();
        $directory = public_path('closingstock');
        $timestamp = date('Ymd_His');
        $asOfDate = $request->as_of_date ? Carbon::parse($request->as_of_date)->format('Y-m-d') : Carbon::now()->format('Y-m-d');
        $reportTitle = "Closing Stock as of " . Carbon::parse($asOfDate)->format('d M Y');

        Log::alert($request->all());
        Log::info($asOfDate);


        if (!File::exists($directory)) {
            File::makeDirectory($directory, 0755, true);
        }

        do {
            $query = Product::setEagerLoads([])
                ->with(['branches', 'supplier'])
                ->skip(($page - 1) * $perPage)
                ->take($perPage);

            // Apply location filter if provided
            if ($request->location_id) {
                $location_id = $request->location_id;
                $query = $query->whereHas('branches', function($q) use ($location_id) {
                    $q->where('branch_id', $location_id);
                });
            }

            $data = $query->get();

            // Process each product to calculate accurate stock based on purchase and sale dates
            foreach ($data as $product) {
                // First, check if the product existed before the as_of_date
                $productCreationDate = Carbon::parse($product->created_at);
                if ($productCreationDate->gt(Carbon::parse($asOfDate))) {
                    // Product was created after the as_of_date, set quantity to 0
                    $product->product_quantity = 0;
                    continue;
                }

                // Get all purchase details for this product up to the as_of_date
                $purchaseQuantity = DB::table('purchase_details')
                    ->join('purchases', 'purchases.id', '=', 'purchase_details.purchase_id')
                    ->where('purchase_details.product_id', $product->id)
                    ->where('purchases.status', 'Completed')
                    ->whereDate('purchases.created_at', '<=', $asOfDate)
                    ->sum('purchase_details.quantity');

                // Get all sale details for this product up to the as_of_date
                $saleQuantity = DB::table('sale_details')
                    ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
                    ->where('sale_details.product_id', $product->id)
                    ->whereDate('sales.created_at', '<=', $asOfDate)
                    ->sum('sale_details.quantity');

                // Calculate the product quantity as of the specified date
                $product->product_quantity = $purchaseQuantity - $saleQuantity;

                // If quantity is negative, set to 0 (might happen due to data inconsistencies)
                if ($product->product_quantity < 0) {
                    $product->product_quantity = 0;
                }
            }

            $total = 0;
            foreach ($data as $key => $value) {
                $total += $value->product_quantity * $value->product_cost;
            }

            if ($data->isEmpty()) {
                break; // No more data, exit the loop
            }

            $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock-levels', [
                'data' => $data,
                'company' => $company,
                'total' => $total,
                'report_title' => $reportTitle
            ]);

            $pdfPath = $directory . '/' . 'closing_stock_' . Carbon::parse($asOfDate)->format('Ymd') . '_page_' . $page . '_' . $timestamp . '.pdf';
            $pdf->save($pdfPath);

            $page++;
        } while (true);

        toast('Closing Stock PDF Generated for ' . Carbon::parse($asOfDate)->format('d M Y') . '! Please check below', 'success');

        return redirect()->back();
    }

    public function filter(Request $request)
    {
        return $request->all();
    }
}
