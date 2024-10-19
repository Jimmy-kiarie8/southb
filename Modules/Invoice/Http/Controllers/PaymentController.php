<?php

namespace Modules\Invoice\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Invoice\DataTables\InvoicesPaymentDataTable;
use Modules\Invoice\Entities\Invoice;
use Modules\Invoice\Entities\InvoicePayment;

class PaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(InvoicesPaymentDataTable $dataTable, Request $request)
    {
        // return $request->all();
        if ($request->invoice_no) {
            // filter by invoice
        }
        return $dataTable->render('invoice::payments.index');
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create($invoice_no)
    {
        $invoice = Invoice::where('invoice_no',$invoice_no)->first();
        return view('invoice::payments.create', compact('invoice'));
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        // return $request->all();
        $invoice = Invoice::where('invoice_no', $request->reference)->first();
        $invoice->balance -= $request->amount;
        $invoice->status = ($invoice->balance == 0) ? 'Paid' : 'Partially paid';
        $invoice->save();

        InvoicePayment::create([
            'reference' => 'REF',
            'invoice_id' => $invoice->id,
            'amount' => $request->amount,
            'notes' => $request->notes,
        ]);
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
        // $invoice = Invoice::where('invoice_no',$id)->first();
        // $invoice->balance =

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
