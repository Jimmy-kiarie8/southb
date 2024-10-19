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

        if (!File::exists($directory)) {
            File::makeDirectory($directory, 0755, true);
        }

        $timestamp = date('Ymd_His'); // Get the current date in 'YYYYMMDD_HHMMSS' format

        do {
            $data = Product::setEagerLoads([])
                ->with(['branches', 'supplier'])
                ->select('id', 'product_name', 'product_code')
                ->skip(($page - 1) * $perPage)
                ->take($perPage)
                ->get();

            if ($data->isEmpty()) {
                break; // No more data, exit the loop
            }

            $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock', ['data' => $data, 'company' => $company]);
            $pdfPath = $directory . '/' . 'St_stocksheet_page_' . $page . '_' . $timestamp . '.pdf'; // Filename with timestamp
            $pdf->save($pdfPath); // Save the PDF in the stockreports directory

            $page++;
        } while (true);

        toast('Stock Sheet PDF Generated! Please check on `Latest Generated Stock Level` below', 'success');

        return redirect()->back();
    }


    public function stocklevel()
    {
        $perPage = 500;
        $page = 1;
        $company = Setting::first();
        $directory = public_path('stocklevels');
        $timestamp = date('Ymd_His'); // Get the current date in 'YYYYMMDD_HHMMSS' format

        if (!File::exists($directory)) {
            File::makeDirectory($directory, 0755, true);
        }

        do {
            $data = Product::setEagerLoads([])
                ->with(['branches', 'supplier'])
                ->skip(($page - 1) * $perPage)
                ->take($perPage)
                ->get();

            $total = 0;
            foreach ($data as $key => $value) {
                $total += $value->product_quantity * $value->product_cost;
            }

            if ($data->isEmpty()) {
                break; // No more data, exit the loop
            }

            $pdf = PDF::loadView('stocksheet::stocksheet.pdf.stock-levels', ['data' => $data, 'company' => $company, 'total' => $total]);
            $pdfPath = $directory . '/' . 'stocklevel_page_' . $page . '_' . $timestamp . '.pdf'; // Filename with timestamp
            // $pdfPath = $directory . '/' . 'St' . 'stocklevel_page_' . $page . '.pdf';
            $pdf->save($pdfPath); // Save the PDF in the stockreports directory

            $page++;
        } while (true);

        toast('Stock Level PDF Generated! Please check on `Latest Generated Stock Level` below', 'success');

        return redirect()->back();
    }

    public function filter(Request $request)
    {
        return $request->all();
    }
}
