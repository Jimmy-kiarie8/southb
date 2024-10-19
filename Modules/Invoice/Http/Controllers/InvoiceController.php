<?php

namespace Modules\Invoice\Http\Controllers;

use Illuminate\Support\Facades\Gate;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Invoice\DataTables\InvoicesDataTable;
use Modules\Invoice\Entities\Invoice;

class InvoiceController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(InvoicesDataTable $dataTable)
    {
        // abort_if(Gate::denies('access_invoices'), 403);
        // return Invoice::all();
        return $dataTable->render('invoice::invoices.index');
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('invoice::invoices.create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        abort_if(Gate::denies('create_invoices'), 403);

        $request->validate([
            'invoice_no' => 'required|unique:invoices,invoice_id,',
            'amount' => 'required',
            'balance' => 'required',
            'sale_id' => 'required',
            'user_id' => 'required'
        ]);

        Invoice::create([
            'invoice_no' => $request->invoice_no,
            'amount' => $request->amount,
            'balance' => $request->balance,
            'sale_id' => $request->sale_id,
            'user_id' => $request->user_id
        ]);

        toast('Invoice Created!', 'success');
        return redirect()->route('invoice-payment.index');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('invoice::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('invoice::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        abort_if(Gate::denies('access_invoices'), 403);

        $request->validate([
            'invoice_no' => 'required|unique:invoices,invoice_id,' . $id,
            'amount' => 'required',
            'balance' => 'required',
            'sale_id' => 'required',
            'user_id' => 'required'
        ]);

        Invoice::findOrFail($id)->update([
            'invoice_no' => $request->invoice_no,
            'amount' => $request->amount,
            'balance' => $request->balance,
            'sale_id' => $request->sale_id,
            'user_id' => $request->user_id
        ]);

        toast('Invoice Updated!', 'info');

        return redirect()->route('invoices.index');
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {

        abort_if(Gate::denies('access_invoices'), 403);

        $invoice = Invoice::findOrFail($id);

        // if ($invoice->products()->isNotEmpty()) {
        //     return back()->withErrors('Can\'t delete beacuse there are products associated with this invoice.');
        // }

        $invoice->delete();

        toast('Invoice Deleted!', 'warning');

        return redirect()->route('invoices.index');
    }
}
