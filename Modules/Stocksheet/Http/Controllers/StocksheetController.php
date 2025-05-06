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
use Maatwebsite\Excel\Facades\Excel;
use Modules\Stocksheet\Exports\StocksheetExport;
use Modules\Stocksheet\Exports\StockLevelExport;
use Modules\Stocksheet\Exports\ClosingStockExport;

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
        $format = $request->format ?? 'pdf'; // Default to PDF if no format is specified

        // Log::info('StockSheet request data:', $request->all());
        $asOfDate = $request->as_of_date ? Carbon::parse($request->as_of_date)->format('Y-m-d') : Carbon::now()->format('Y-m-d');
        // Log::info('StockSheet using as_of_date: ' . $asOfDate);

        // For Excel export, we'll collect all data across pages
        $allData = collect();

        if (!File::exists($directory)) {
            File::makeDirectory($directory, 0755, true);
        }

        $timestamp = date('Ymd_His'); // Get the current date in 'YYYYMMDD_HHMMSS' format
        // Log::info('Starting stocksheet generation with timestamp: ' . $timestamp);

        do {
            // Log::info('Processing stocksheet page: ' . $page);
            $query = Product::setEagerLoads([])
                ->with(['branches', 'supplier'])
                ->select('id', 'product_name', 'product_code', 'product_quantity', 'product_cost', 'product_price', 'product_unit', 'created_at')
                ->skip(($page - 1) * $perPage)
                ->take($perPage);

            // Apply location filter if provided
            if ($request->location_id) {
                $location_id = $request->location_id;
                // Log::info('Filtering stocksheet by location_id: ' . $location_id);
                $query = $query->whereHas('branches', function($q) use ($location_id) {
                    $q->where('branch_id', $location_id);
                });
            }

            // Get the original data
            $originalData = $query->get();
            // Log::info('Found ' . count($originalData) . ' products for stocksheet report');

            // Create a new collection to hold our modified data
            $data = collect();

            // Process each product to calculate accurate stock based on purchase and sale dates
            if ($asOfDate) {
                foreach ($originalData as $originalProduct) {
                    // Create a new product object by copying the original
                    $product = clone $originalProduct;

                    // Log::info('---------------------------------------------');
                    // Log::info('Processing product for stocksheet: ID=' . $product->id . ', Name=' . $product->product_name);
                    // Log::info('Original DB quantity: ' . $product->product_quantity);

                    // First, check if the product existed before the as_of_date
                    if ($product->created_at) {
                        $productCreationDate = Carbon::parse($product->created_at);
                    } else {
                        $productCreationDate = Carbon::parse('2024-06-01');
                    }

                    // Log::info('Product creation date: ' . $productCreationDate->format('Y-m-d') . ' vs as_of_date: ' . $asOfDate);

                    if ($productCreationDate->gt(Carbon::parse($asOfDate))) {
                        // Product was created after the as_of_date, set quantity to 0
                        // Log::info('Product was created after as_of_date, setting quantity to 0');
                        $product->product_quantity = 0;
                        $data->push($product);
                        continue;
                    }

                    // Get all purchase details for this product up to the as_of_date
                    $purchaseQuery = DB::table('purchase_details')
                        ->join('purchases', 'purchases.id', '=', 'purchase_details.purchase_id')
                        ->where('purchase_details.product_id', $product->id)
                        ->where('purchases.status', 'Completed')
                        ->whereDate('purchases.created_at', '<=', $asOfDate);

                    // Log the purchase query for debugging
                    // Log::info('Stocksheet purchase SQL: ' . $purchaseQuery->toSql());
                    // Log::info('Stocksheet purchase bindings: ' . json_encode($purchaseQuery->getBindings()));

                    // Execute the query and get the sum
                    $purchaseQuantity = $purchaseQuery->sum('purchase_details.quantity');
                    // Log::info('Stocksheet total purchased quantity: ' . $purchaseQuantity);

                    // Get all sale details for this product up to the as_of_date
                    $saleQuery = DB::table('sale_details')
                        ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
                        ->where('sale_details.product_id', $product->id)
                        ->whereDate('sales.created_at', '<=', $asOfDate);

                    // Log the sale query for debugging
                    // Log::info('Stocksheet sale SQL: ' . $saleQuery->toSql());
                    // Log::info('Stocksheet sale bindings: ' . json_encode($saleQuery->getBindings()));

                    // Execute the query and get the sum
                    $saleQuantity = $saleQuery->sum('sale_details.quantity');
                    // Log::info('Stocksheet total sold quantity: ' . $saleQuantity);

                    // Calculate the product quantity as of the specified date
                    $calculatedQuantity = $purchaseQuantity - $saleQuantity;
                    // Log::info('Stocksheet calculated quantity (purchases - sales): ' . $calculatedQuantity);

                    // If quantity is negative, set to 0 (might happen due to data inconsistencies)
                    if ($calculatedQuantity < 0) {
                        // Log::info('Stocksheet negative quantity detected, setting to 0');
                        $calculatedQuantity = 0;
                    }

                    // IMPORTANT: Actually replace the product quantity with calculated value
                    $product->product_quantity = $calculatedQuantity;

                    // Add this modified product to our new collection
                    $data->push($product);

                    // Log::info('Stocksheet final quantity set: ' . $product->product_quantity . ' calculatedQuantity: ' . $calculatedQuantity);
                }
            } else {
                // If no date filter, just use the original data
                $data = $originalData;
            }

            // Add to all data collection for Excel
            $allData = $allData->merge($data);

            if ($data->isEmpty()) {
                // Log::info('No more data for stocksheet, breaking the loop');
                break; // No more data, exit the loop
            }

            // If generating Excel, skip PDF generation
            if ($format === 'excel') {
                $page++;
                continue;
            }

            $dateInfo = $asOfDate ? '_asof_' . Carbon::parse($asOfDate)->format('Ymd') : '';
            $reportTitle = $asOfDate ? "Stock Sheet as of " . Carbon::parse($asOfDate)->format('d M Y') : date('D d M Y') . ' Stock Sheet';
            // Log::info('Stocksheet report title: ' . $reportTitle);

            $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock', [
                'data' => $data,
                'company' => $company,
                'report_title' => $reportTitle
            ]);

            $pdfPath = $directory . '/' . 'St_stocksheet' . $dateInfo . '_page_' . $page . '_' . $timestamp . '.pdf'; // Filename with timestamp
            // Log::info('Saving stocksheet PDF to: ' . $pdfPath);
            $pdf->save($pdfPath); // Save the PDF in the stockreports directory

            $page++;
            // Log::info('Moving to stocksheet page: ' . $page);
        } while (true);

        // If Excel format is requested, export the data
        if ($format === 'excel') {
            $reportTitle = $asOfDate ? "Stock Sheet as of " . Carbon::parse($asOfDate)->format('d M Y') : date('D d M Y') . ' Stock Sheet';
            $locationInfo = $request->location_id ? '_loc' . $request->location_id : '';
            $filename = 'stocksheet' . $locationInfo . '_' . Carbon::parse($asOfDate)->format('Ymd') . '.xlsx';

            return Excel::download(
                new StocksheetExport($allData, $reportTitle),
                $filename
            );
        }

        // Log::info('Stocksheet generation completed successfully');
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
        $format = $request->format ?? 'pdf'; // Default to PDF if no format is specified

        // Log::info($request->as_of_date);
        // Log::info('Request data for stocklevel:', $request->all());
        $asOfDate = $request->as_of_date ? Carbon::parse($request->as_of_date)->format('Y-m-d') : Carbon::now()->format('Y-m-d');
        // Log::info('Processed as_of_date: ' . $asOfDate);

        // For Excel export, we'll collect all data across pages
        $allData = collect();
        $totalValue = 0;

        if (!File::exists($directory)) {
            File::makeDirectory($directory, 0755, true);
        }

        do {
            // Log::info('Processing stocklevel page: ' . $page);
            $query = Product::setEagerLoads([])
                ->with(['branches', 'supplier'])
                ->skip(($page - 1) * $perPage)
                ->take($perPage);

            // Apply location filter if provided
            if ($request->location_id) {
                $location_id = $request->location_id;
                // Log::info('Filtering by location_id: ' . $location_id);
                $query = $query->whereHas('branches', function($q) use ($location_id) {
                    $q->where('branch_id', $location_id);
                });
            }

            // Get the original data
            $originalData = $query->get();
            // Log::info('Found ' . count($originalData) . ' products for stocklevel');

            // Create a new collection to hold our modified data
            $data = collect();

            // Process each product to calculate accurate stock based on purchase and sale dates
            if ($asOfDate) {
                foreach ($originalData as $originalProduct) {
                    // Create a new product object by copying the original
                    $product = clone $originalProduct;

                    // Log::info('---------------------------------------------');
                    // Log::info('Processing product for stocklevel: ID=' . $product->id . ', Name=' . $product->product_name);
                    // Log::info('Current DB quantity before calculation: ' . $product->product_quantity);

                    // First, check if the product existed before the as_of_date
                    if ($product->created_at) {
                        $productCreationDate = Carbon::parse($product->created_at);
                    } else {
                        $productCreationDate = Carbon::parse('2024-06-01');
                    }

                    // Log::info('Product creation date: ' . $productCreationDate->format('Y-m-d') . ' vs as_of_date: ' . $asOfDate);

                    if ($productCreationDate->gt(Carbon::parse($asOfDate))) {
                        // Product was created after the as_of_date, set quantity to 0
                        // Log::info('Product created after as_of_date, setting quantity to 0');
                        $product->product_quantity = 0;
                        $data->push($product);
                        continue;
                    }

                    // Get all purchase details for this product up to the as_of_date
                    $purchaseQuery = DB::table('purchase_details')
                        ->join('purchases', 'purchases.id', '=', 'purchase_details.purchase_id')
                        ->where('purchase_details.product_id', $product->id)
                        ->where('purchases.status', 'Completed')
                        ->whereDate('purchases.created_at', '<=', $asOfDate);

                    // Log::info('Purchase SQL: ' . $purchaseQuery->toSql());
                    // Log::info('Purchase bindings: ' . json_encode($purchaseQuery->getBindings()));

                    $purchaseQuantity = $purchaseQuery->sum('purchase_details.quantity');
                    // Log::info('Total purchased quantity: ' . $purchaseQuantity);

                    // Get all sale details for this product up to the as_of_date
                    $saleQuery = DB::table('sale_details')
                        ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
                        ->where('sale_details.product_id', $product->id)
                        ->whereDate('sales.created_at', '<=', $asOfDate);

                    // Log::info('Sale SQL: ' . $saleQuery->toSql());
                    // Log::info('Sale bindings: ' . json_encode($saleQuery->getBindings()));

                    $saleQuantity = $saleQuery->sum('sale_details.quantity');
                    // Log::info('Total sold quantity: ' . $saleQuantity);

                    // Calculate the product quantity as of the specified date
                    $calculatedQuantity = $purchaseQuantity - $saleQuantity;
                    // Log::info('Calculated quantity (purchases - sales): ' . $calculatedQuantity);

                    // If quantity is negative, set to 0 (might happen due to data inconsistencies)
                    if ($calculatedQuantity < 0) {
                        // Log::info('Negative quantity detected, setting to 0');
                        $calculatedQuantity = 0;
                    }

                    // IMPORTANT: Actually replace the product quantity with calculated value
                    $product->product_quantity = $calculatedQuantity;

                    // Add this modified product to our new collection
                    $data->push($product);

                    // Log::info('Final quantity set for stocklevel: ' . $product->product_quantity . ' calculatedQuantity: ' . $calculatedQuantity);
                }
            } else {
                // If no date filter, just use the original data
                $data = $originalData;
            }

            // Add to all data collection for Excel
            $allData = $allData->merge($data);

            $pageTotal = 0;
            foreach ($data as $value) {
                $pageTotal += $value->product_quantity * $value->product_cost;
            }
            $totalValue += $pageTotal;
            // Log::info('Stocklevel page ' . $page . ' total value: ' . $pageTotal);

            if ($data->isEmpty()) {
                // Log::info('No more data for stocklevel, breaking the loop');
                break; // No more data, exit the loop
            }

            // If generating Excel, skip PDF generation
            if ($format === 'excel') {
                $page++;
                continue;
            }

            $dateInfo = $asOfDate ? '_asof_' . Carbon::parse($asOfDate)->format('Ymd') : '';
            $reportTitle = $asOfDate ? "Stock Level as of " . Carbon::parse($asOfDate)->format('d M Y') : date('D d M Y') . ' Stock Level';
            // Log::info('Generated report title: ' . $reportTitle);

            $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock-levels', [
                'data' => $data,
                'company' => $company,
                'total' => $pageTotal,
                'report_title' => $reportTitle
            ]);

            $pdfPath = $directory . '/' . 'stocklevel' . $dateInfo . '_page_' . $page . '_' . $timestamp . '.pdf'; // Filename with timestamp
            // Log::info('Saving stocklevel PDF to: ' . $pdfPath);
            $pdf->save($pdfPath); // Save the PDF in the stockreports directory

            $page++;
            // Log::info('Moving to stocklevel page: ' . $page);
        } while (true);

        // If Excel format is requested, export the data
        if ($format === 'excel') {
            $reportTitle = $asOfDate ? "Stock Level as of " . Carbon::parse($asOfDate)->format('d M Y') : date('D d M Y') . ' Stock Level';
            $locationInfo = $request->location_id ? '_loc' . $request->location_id : '';
            $filename = 'stocklevel' . $locationInfo . '_' . Carbon::parse($asOfDate)->format('Ymd') . '.xlsx';

            return Excel::download(
                new StockLevelExport($allData, $totalValue, $reportTitle),
                $filename
            );
        }

        // Log::info('Stocklevel generation completed');
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
        $format = $request->format ?? 'pdf'; // Default to PDF if no format is specified
        $asOfDate = $request->as_of_date ? Carbon::parse($request->as_of_date)->format('Y-m-d') : Carbon::now()->format('Y-m-d');
        $reportTitle = "Closing Stock as of " . Carbon::parse($asOfDate)->format('d M Y');

        // Log::alert($request->all());
        // Log::info('Using as_of_date: ' . $asOfDate);

        // For Excel export, we'll collect all data across pages
        $allData = collect();
        $totalValue = 0;

        if (!File::exists($directory)) {
            File::makeDirectory($directory, 0755, true);
        }

        do {
            // Log::info('Processing page: ' . $page);
            $query = Product::setEagerLoads([])
                ->with(['branches', 'supplier'])
                ->skip(($page - 1) * $perPage)
                ->take($perPage);

            // Apply location filter if provided
            if ($request->location_id) {
                $location_id = $request->location_id;
                // Log::info('Filtering by location_id: ' . $location_id);
                $query = $query->whereHas('branches', function($q) use ($location_id) {
                    $q->where('branch_id', $location_id);
                });
            }

            // Get the original data
            $originalData = $query->get();
            // Log::info('Found ' . count($originalData) . ' products to process');

            // Create a new collection to hold our modified data
            $data = collect();

            foreach ($originalData as $originalProduct) {
                // Create a new product object by copying the original
                $product = clone $originalProduct;

                // Log::info('---------------------------------------------');
                // Log::info('Processing product: ID=' . $product->id . ', Name=' . $product->product_name . ', Code=' . $product->product_code);
                // Log::info('Current DB quantity: ' . $product->product_quantity);

                // First, check if the product existed before the as_of_date
                if ($product->created_at) {
                    $productCreationDate = Carbon::parse($product->created_at);
                } else {
                    $productCreationDate = Carbon::parse('2024-06-01');
                }

                // Log::info('Product creation date: ' . $productCreationDate->format('Y-m-d'));

                if ($productCreationDate->gt(Carbon::parse($asOfDate))) {
                    // Product was created after the as_of_date, set quantity to 0
                    // Log::info('Product created after as_of_date, setting quantity to 0');
                    $product->product_quantity = 0;
                    $data->push($product);
                    continue;
                }

                // Get all purchase details for this product up to the as_of_date
                $purchaseQuantity = DB::table('purchase_details')
                    ->join('purchases', 'purchases.id', '=', 'purchase_details.purchase_id')
                    ->where('purchase_details.product_id', $product->id)
                    ->where('purchases.status', 'Completed')
                    ->whereDate('purchases.created_at', '<=', $asOfDate);

                // Log the SQL query for debugging
                // Log::info('Purchase SQL: ' . $purchaseQuantity->toSql());
                // Log::info('Purchase bindings: ' . json_encode($purchaseQuantity->getBindings()));

                $purchaseQuantity = $purchaseQuantity->sum('purchase_details.quantity');
                // Log::info('Total purchased quantity: ' . $purchaseQuantity);

                // Get all sale details for this product up to the as_of_date
                $saleQuantity = DB::table('sale_details')
                    ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
                    ->where('sale_details.product_id', $product->id)
                    ->whereDate('sales.created_at', '<=', $asOfDate);

                // Log the SQL query for debugging
                // Log::info('Sale SQL: ' . $saleQuantity->toSql());
                // Log::info('Sale bindings: ' . json_encode($saleQuantity->getBindings()));

                $saleQuantity = $saleQuantity->sum('sale_details.quantity');
                // Log::info('Total sold quantity: ' . $saleQuantity);

                // Calculate the product quantity as of the specified date
                $calculatedQuantity = $purchaseQuantity - $saleQuantity;
                // Log::info('Calculated quantity (purchases - sales): ' . $calculatedQuantity);

                // If quantity is negative, set to 0 (might happen due to data inconsistencies)
                if ($calculatedQuantity < 0) {
                    // Log::info('Negative quantity detected, setting to 0');
                    $calculatedQuantity = 0;
                }

                // IMPORTANT: Actually replace the product quantity with calculated value
                $product->qty = $calculatedQuantity;

                // Add this modified product to our new collection
                $data->push($product);

                // Log::info('Final quantity set: ' . $product->product_quantity . ' calculatedQuantity: ' . $calculatedQuantity);
            }

            // Add to all data collection for Excel
            $allData = $allData->merge($data);

            $pageTotal = 0;
            foreach ($data as $value) {
                $pageTotal += $value->product_quantity * $value->product_cost;
            }
            $totalValue += $pageTotal;
            // Log::info('Page ' . $page . ' total value: ' . $pageTotal);

            if ($data->isEmpty()) {
                // Log::info('No more data, breaking the loop');
                break; // No more data, exit the loop
            }

            // If generating Excel, skip PDF generation
            if ($format === 'excel') {
                $page++;
                continue;
            }

            $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock-levels', [
                'data' => $data,
                'company' => $company,
                'total' => $pageTotal,
                'report_title' => $reportTitle
            ]);

            $pdfPath = $directory . '/' . 'closing_stock_' . Carbon::parse($asOfDate)->format('Ymd') . '_page_' . $page . '_' . $timestamp . '.pdf';
            // Log::info('Saving PDF to: ' . $pdfPath);
            $pdf->save($pdfPath);

            $page++;
            // Log::info('Moving to page: ' . $page);
        } while (true);

        // If Excel format is requested, export the data
        if ($format === 'excel') {
            $locationInfo = $request->location_id ? '_loc' . $request->location_id : '';
            $filename = 'closing_stock' . $locationInfo . '_' . Carbon::parse($asOfDate)->format('Ymd') . '.xlsx';

            return Excel::download(
                new ClosingStockExport($allData, $totalValue, $company, Carbon::parse($asOfDate)->format('d M Y'), $reportTitle),
                $filename
            );
        }

        // Log::info('Closing stock generation completed');
        toast('Closing Stock PDF Generated for ' . Carbon::parse($asOfDate)->format('d M Y') . '! Please check below', 'success');

        return redirect()->back();
    }

    public function filter(Request $request)
    {
        return $request->all();
    }

    /**
     * Debug product quantities for a specific product
     * Access via /stocksheet/debug-product?product_id=XXX&as_of_date=YYYY-MM-DD
     */
    public function debugProduct(Request $request)
    {
        if (!$request->has('product_id')) {
            return response()->json(['error' => 'No product ID provided']);
        }

        $productId = $request->product_id;
        $asOfDate = $request->as_of_date ? Carbon::parse($request->as_of_date)->format('Y-m-d') : Carbon::now()->format('Y-m-d');

        // Log::info('Debugging product ID: ' . $productId . ' as of date: ' . $asOfDate);

        // Get the product
        $product = Product::find($productId);

        if (!$product) {
            return response()->json(['error' => 'Product not found']);
        }

        $result = [
            'product_id' => $product->id,
            'product_name' => $product->product_name,
            'product_code' => $product->product_code,
            'current_quantity' => $product->product_quantity,
            'created_at' => $product->created_at,
            'as_of_date' => $asOfDate
        ];

        // Get all purchase details for this product up to the as_of_date
        $purchaseQuery = DB::table('purchase_details')
            ->join('purchases', 'purchases.id', '=', 'purchase_details.purchase_id')
            ->where('purchase_details.product_id', $product->id)
            ->where('purchases.status', 'Completed')
            ->whereDate('purchases.created_at', '<=', $asOfDate);

        $purchaseQuantity = $purchaseQuery->sum('purchase_details.quantity');

        // Get detailed purchase records
        $purchaseDetails = DB::table('purchase_details')
            ->join('purchases', 'purchases.id', '=', 'purchase_details.purchase_id')
            ->where('purchase_details.product_id', $product->id)
            ->where('purchases.status', 'Completed')
            ->whereDate('purchases.created_at', '<=', $asOfDate)
            ->select(
                'purchases.id as purchase_id',
                'purchases.reference',
                'purchases.created_at',
                'purchase_details.quantity',
                'purchase_details.unit_price'
            )
            ->get();

        // Get all sale details for this product up to the as_of_date
        $saleQuery = DB::table('sale_details')
            ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
            ->where('sale_details.product_id', $product->id)
            ->whereDate('sales.created_at', '<=', $asOfDate);

        $saleQuantity = $saleQuery->sum('sale_details.quantity');

        // Get detailed sale records
        $saleDetails = DB::table('sale_details')
            ->join('sales', 'sales.id', '=', 'sale_details.sale_id')
            ->where('sale_details.product_id', $product->id)
            ->whereDate('sales.created_at', '<=', $asOfDate)
            ->select(
                'sales.id as sale_id',
                'sales.reference',
                'sales.created_at',
                'sale_details.quantity',
                'sale_details.unit_price'
            )
            ->get();

        $calculatedQuantity = $purchaseQuantity - $saleQuantity;

        // Additional data
        $result['purchase_quantity'] = $purchaseQuantity;
        $result['sale_quantity'] = $saleQuantity;
        $result['calculated_quantity'] = $calculatedQuantity;
        $result['purchase_details'] = $purchaseDetails;
        $result['sale_details'] = $saleDetails;
        $result['purchase_query'] = $purchaseQuery->toSql();
        $result['purchase_bindings'] = $purchaseQuery->getBindings();
        $result['sale_query'] = $saleQuery->toSql();
        $result['sale_bindings'] = $saleQuery->getBindings();

        // Log::info('Debug result for product ' . $productId, $result);

        return response()->json($result);
    }
}
