<?php

namespace Modules\Purchase\Http\Controllers;

use Modules\Purchase\DataTables\PurchasePaymentsDataTable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Modules\People\Entities\Supplier;
use Modules\Purchase\DataTables\PurchaseBulkPaymentsDataTable;
use Modules\Purchase\Entities\Purchase;
use Modules\Purchase\Entities\PurchaseBulkPayment;
use Modules\Purchase\Entities\PurchasePayment;

class PurchasePaymentsController extends Controller
{

    public function index($purchase_id, PurchasePaymentsDataTable $dataTable)
    {
        abort_if(Gate::denies('access_purchase_payments'), 403);

        $purchase = Purchase::findOrFail($purchase_id);

        return $dataTable->render('purchase::payments.index', compact('purchase'));
    }


    public function create($purchase_id)
    {
        abort_if(Gate::denies('access_purchase_payments'), 403);

        $purchase = Purchase::findOrFail($purchase_id);

        return view('purchase::payments.create', compact('purchase'));
    }


    public function store(Request $request)
    {
        abort_if(Gate::denies('access_purchase_payments'), 403);

        $request->validate([
            'date' => 'required|date',
            'reference' => 'required|string|max:255',
            'amount' => 'required|numeric',
            'note' => 'nullable|string|max:1000',
            'purchase_id' => 'required',
            'payment_method' => 'required|string|max:255'
        ]);

        DB::transaction(function () use ($request) {
            PurchasePayment::create([
                'date' => $request->date,
                'supplier_id' => $request->supplier_id,
                'reference' => $request->reference,
                'amount' => $request->amount,
                'note' => $request->note,
                'purchase_id' => $request->purchase_id,
                'payment_method' => $request->payment_method
            ]);

            $purchase = Purchase::findOrFail($request->purchase_id);

            $due_amount = $purchase->due_amount - $request->amount;

            if ($due_amount == $purchase->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            $purchase->update([
                'paid_amount' => ($purchase->paid_amount + $request->amount),
                'due_amount' => $due_amount,
                'payment_status' => $payment_status
            ]);
        });

        toast('Purchase Payment Created!', 'success');

        return redirect()->route('purchases.index');
    }


    public function edit($purchase_id, PurchasePayment $purchasePayment)
    {
        abort_if(Gate::denies('access_purchase_payments'), 403);

        $purchase = Purchase::findOrFail($purchase_id);

        return view('purchase::payments.edit', compact('purchasePayment', 'purchase'));
    }


    public function update(Request $request, PurchasePayment $purchasePayment)
    {
        abort_if(Gate::denies('access_purchase_payments'), 403);
        $request->validate([
            'date' => 'required|date',
            'reference' => 'required|string|max:255',
            'amount' => 'required|numeric',
            'note' => 'nullable|string|max:1000',
            'purchase_id' => 'required',
            'payment_method' => 'required|string|max:255'
        ]);

        DB::transaction(function () use ($request, $purchasePayment) {
            $purchase = $purchasePayment->purchase;

            $due_amount = ($purchase->due_amount + $purchasePayment->amount) - $request->amount;

            if ($due_amount == $purchase->total_amount) {
                $payment_status = 'Unpaid';
            } elseif ($due_amount > 0) {
                $payment_status = 'Partial';
            } else {
                $payment_status = 'Paid';
            }

            $purchase->update([
                'paid_amount' => (($purchase->paid_amount - $purchasePayment->amount) + $request->amount),
                'due_amount' => $due_amount,
                'payment_status' => $payment_status
            ]);

            $purchasePayment->update([
                'date' => $request->date,
                'reference' => $request->reference,
                'amount' => $request->amount,
                'note' => $request->note,
                'purchase_id' => $request->purchase_id,
                'payment_method' => $request->payment_method
            ]);
        });

        toast('Purchase Payment Updated!', 'info');

        return redirect()->route('purchases.index');
    }


    public function destroy(PurchasePayment $purchasePayment)
    {
        abort_if(Gate::denies('access_purchase_payments'), 403);

        DB::beginTransaction();

        try {
            $purchase = Purchase::where('id', $purchasePayment->purchase_id)->latest()->first();
            if ($purchase) {
                $purchase->amount = $purchasePayment->amount;
                $purchase->paid_amount -= $purchase->paid_amount;
                $purchase->due_amount +=  $purchase->due_amount;
                $purchase->save();
            }
            $purchasePayment->delete();
            DB::commit();
            toast('Purchase Payment Deleted!', 'warning');
            return redirect()->route('purchases.index');
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }


    public function purchase_bulk(Request $request)
    {
        // return $request->all();
        $amount = $request->amount;
        $purchases = Purchase::where('due_amount', '>', 0)->where('supplier_id', $request->supplier_id)->orderBy('date', 'ASC')->get();

        $purchase_bulk = PurchaseBulkPayment::create([
            'supplier_id' => $request->supplier_id,
            'payment_method' => $request->payment_method,
            'amount' => $request->amount,
            'date' => $request->date,
            'code' => $request->code
        ]);



        if ($request->type == 'credit') {
            toast('Purchase Payment Updated!', 'success');
            return redirect()->route('purchases.index');
        }
        foreach ($purchases as $purchase) {
            $new_amount = $amount;
            $to_pay = $purchase->due_amount;
            $amount -= $to_pay;
            if ($amount < 0) {
                $to_pay = $new_amount;
            }
            if ($to_pay > 0) {
                $data = [
                    'date' => $request->date,
                    'reference' => $purchase_bulk->reference,
                    'amount' => $to_pay,
                    'supplier_id' => $request->supplier_id,
                    'note' => '',
                    'purchase_id' => $purchase->id,
                    'payment_method' => $request->payment_method
                ];
                $this->store(new Request($data));
            }
        }
        toast('Purchase Payment Updated!', 'success');
        return redirect()->route('purchases.index');
    }



    public function bulkIndex(PurchaseBulkPaymentsDataTable $dataTable)
    {
        // return PurchaseBulkPayment::with('supplier')->get();
        abort_if(Gate::denies('access_purchase_payments'), 403);
        return $dataTable->render('purchase::payments.bulk');
    }

    public function bulkShow($id)
    {
        $payment = PurchaseBulkPayment::with(['payments' => function ($q) {
            $q->with(['purchase']);
        }, 'supplier'])->find($id);

        return view('purchase::payments.bulk-show', compact('payment'));
    }


    public function reversePayment($id)
    {

        $purchaseBulkPayment = PurchaseBulkPayment::with('payments')->find($id);
        // Retrieve the purchasePayment records associated with the purchaseBulkPayment
        $purchasePayments = $purchaseBulkPayment->payments;

        // Loop through the purchasePayment records and update the sales
        foreach ($purchasePayments as $purchasePayment) {
            $purchase = $purchasePayment->purchase;
            // Calculate the amount to be reversed based on the payment and the purchase details
            $reversedAmount = $purchasePayment->amount;
            // $reversedAmount = min($purchasePayment->amount_paid, $purchase->paid_amount);
            // Subtract the reversed amount from the paid_amount
            $purchase->paid_amount -= $reversedAmount;
            // Update the due_amount by adding the reversed amount
            $purchase->due_amount += $reversedAmount;
            $purchase->payment_status = ($purchase->paid_amount > 0) ? 'Partial' : 'Unpaid';
            $purchase->save();

            // Delete the purchasePayment record
            $purchasePayment->delete();
        }

        // Delete the SaleBulkPayment and associated purchasePayment records
        $purchaseBulkPayment->delete();

        toast('Sale Payment Reversed!', 'success');
        return redirect()->route('sale-payments.bulkIndex');
    }
}
