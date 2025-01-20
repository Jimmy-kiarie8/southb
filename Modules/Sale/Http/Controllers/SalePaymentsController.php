<?php

namespace Modules\Sale\Http\Controllers;

use App\Exports\PaymentExport;
use Modules\Sale\DataTables\SalePaymentsDataTable;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Log;
use Maatwebsite\Excel\Facades\Excel;
use Modules\Invoice\Entities\Invoice;
use Modules\People\Entities\Customer;
use Modules\Sale\DataTables\SaleBulkPaymentsDataTable;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleBulkPayment;
use Modules\Sale\Entities\SalePayment;

class SalePaymentsController extends Controller
{

    public function index($sale_id, SalePaymentsDataTable $dataTable)
    {
        abort_if(Gate::denies('access_sale_payments'), 403);

        $sale = Sale::find($sale_id);

        if (!$sale) {
            $sale = Sale::where('reference', $sale_id)->firstOrFail();
        }

        return $dataTable->render('sale::payments.index', compact('sale'));
    }


    public function create($sale_id)
    {
        abort_if(Gate::denies('access_sale_payments'), 403);


        $sale = Sale::find($sale_id);

        if (!$sale) {
            $sale = Sale::where('reference', $sale_id)->firstOrFail();
        }
        return view('sale::payments.create', compact('sale'));
    }


    public function store(Request $request)
    {
        abort_if(Gate::denies('access_sale_payments'), 403);

        $request->validate([
            'date' => 'required|date',
            'reference' => 'required|string|max:255',
            'amount' => 'required|numeric',
            'note' => 'nullable|string|max:1000',
            'sale_id' => 'required',
            'payment_method' => 'required|string|max:255'
        ]);

        DB::transaction(function () use ($request) {
            $sale = Sale::findOrFail($request->sale_id);
            SalePayment::create([
                'date' => $request->date,
                'reference' => $request->reference,
                'amount' => $request->amount,
                'note' => $request->note,
                'sale_id' => $request->sale_id,
                'customer_code' => $sale->clientcode,
                'payment_method' => $request->payment_method
            ]);


            $due_amount = $sale->due_amount - $request->amount;

            if ($due_amount == $sale->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            $sale->update([
                'paid_amount' => ($sale->paid_amount + $request->amount),
                'due_amount' => $due_amount,
                'payment_status' => $payment_status
            ]);

            $invoice = Invoice::where('sale_id', $request->sale_id)->first();

            if ($invoice) {
                $invoice->balance -= $request->amount;
                $invoice->status = ($invoice->balance == 0) ? 'Paid' : 'Partially paid';
                $invoice->save();
            }
        });

        toast('Sale Payment Created!', 'success');

        return redirect()->route('sales.index');
    }


    public function edit($sale_id, SalePayment $salePayment)
    {
        abort_if(Gate::denies('access_sale_payments'), 403);

        $sale = Sale::findOrFail($sale_id);

        return view('sale::payments.edit', compact('salePayment', 'sale'));
    }


    public function update(Request $request, SalePayment $salePayment)
    {
        abort_if(Gate::denies('access_sale_payments'), 403);

        $request->validate([
            'date' => 'required|date',
            'reference' => 'required|string|max:255',
            'amount' => 'required|numeric',
            'note' => 'nullable|string|max:1000',
            'sale_id' => 'required',
            'payment_method' => 'required|string|max:255'
        ]);

        DB::transaction(function () use ($request, $salePayment) {
            $sale = $salePayment->sale;

            $due_amount = ($sale->due_amount + $salePayment->amount) - $request->amount;

            if ($due_amount == $sale->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            $sale->update([
                'paid_amount' => (($sale->paid_amount - $salePayment->amount) + $request->amount),
                'due_amount' => $due_amount,
                'payment_status' => $payment_status
            ]);

            $salePayment->update([
                'date' => $request->date,
                'reference' => $request->reference,
                'amount' => $request->amount,
                'note' => $request->note,
                'sale_id' => $request->sale_id,
                'payment_method' => $request->payment_method
            ]);


            $invoice = Invoice::where('sale_id', $request->sale_id)->first();

            if ($invoice) {
                $invoice->balance -= $request->amount;
                $invoice->status = ($invoice->balance == 0) ? 'Paid' : 'Partially paid';
                $invoice->save();
            }
        });

        toast('Sale Payment Updated!', 'info');

        return redirect()->route('sales.index');
    }


    public function destroy(SalePayment $salePayment)
    {
        abort_if(Gate::denies('access_sale_payments'), 403);

        // $salePayment->delete();

        DB::beginTransaction();

        try {
            $sale = Sale::where('id', $salePayment->sale_id)->latest()->first();
            if ($sale) {
                $sale->amount = $salePayment->amount;
                $sale->paid_amount -= $sale->paid_amount;
                $sale->due_amount +=  $sale->due_amount;
                $sale->save();
            }
            $salePayment->delete();
            DB::commit();
            toast('Sale Payment Deleted!', 'warning');

            return redirect()->route('sales.index');
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }

    public function payment(Request $request)
    {

        $request->validate([
            'start_date' => 'required|date|before:end_date',
            'end_date'   => 'required|date|after:start_date',
            'payments'   => 'required|string'
        ]);

        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $payment_type = $request->payment_type;
        $payments = $request->payments;


        return Excel::download(new PaymentExport($start_date, $end_date, $payment_type, $payments), 'payment.xlsx');
    }

    public function sale_bulk(Request $request)
    {
        // return $request->all();
        $amount = $request->amount;
        $customer = Customer::find($request->customer_id);
        $sales = Sale::where('due_amount', '>', 0)->where('clientcode', $customer->code)->orderBy('id', 'ASC')->get();

        $sale_payment = SaleBulkPayment::create([
            'client_id' => $request->customer_id,
            'payment_method' => $request->payment_method,
            'amount' => $request->amount,
            'code' => $request->code,
            'date' => $request->date
        ]);
        foreach ($sales as $sale) {
            $new_amount = $amount;
            $to_pay = $sale->due_amount;
            $amount -= $to_pay;
            if ($amount < 0) {
                $to_pay = $new_amount;
            }
            if ($to_pay > 0) {

                $data = [
                    'date' => $request->date,
                    'reference' => $sale_payment->reference,
                    // 'reference' => $sale->reference,
                    'amount' => $to_pay,
                    'note' => '',
                    'sale_id' => $sale->id,
                    'payment_method' => $request->payment_method
                ];
                $this->store(new Request($data));
            }
        }
        toast('Sale Payment Updated!', 'success');
        return redirect()->route('sales.index');
    }


    public function bulkIndex(SaleBulkPaymentsDataTable $dataTable)
    {
        abort_if(Gate::denies('access_sale_payments'), 403);
        return $dataTable->render('sale::payments.bulk');
    }

    public function bulkShow($id)
    {
        $payment = SaleBulkPayment::with(['payments' => function ($q) {
            $q->with(['sale']);
        }, 'customer'])->find($id);

        return view('sale::payments.bulk-show', compact('payment'));
    }


    public function reversePayment($id)
    {

        $saleBulkPayment = SaleBulkPayment::with('payments')->find($id);
        // Retrieve the SalePayment records associated with the SaleBulkPayment
        $salePayments = $saleBulkPayment->payments;

        // Loop through the SalePayment records and update the sales
        foreach ($salePayments as $salePayment) {
            $sale = $salePayment->sale;
            // Calculate the amount to be reversed based on the payment and the sale details
            $reversedAmount = $salePayment->amount;
            // $reversedAmount = min($salePayment->amount_paid, $sale->paid_amount);
            // Subtract the reversed amount from the paid_amount
            $sale->paid_amount -= $reversedAmount;
            // Update the due_amount by adding the reversed amount
            $sale->due_amount += $reversedAmount;
            $sale->payment_status = ($sale->paid_amount > 0) ? 'Partial' : 'Unpaid';
            $sale->save();

            // Delete the SalePayment record
            $salePayment->delete();
        }

        // Delete the SaleBulkPayment and associated SalePayment records
        $saleBulkPayment->delete();

        toast('Sale Payment Reversed!', 'success');
        return redirect()->route('sale-payments.bulkIndex');
    }
}
