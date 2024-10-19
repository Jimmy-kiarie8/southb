<?php

namespace Modules\Sale\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Modules\Sale\Entities\CloseDay;
use Illuminate\Support\Facades\Gate;
use Modules\Sale\DataTables\CloseDataTable;
use Modules\Sale\Entities\SalePayment;

class CloseDayController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
     public function index(CloseDataTable $dataTable)
     {
         abort_if(Gate::denies('access_sales'), 403);

         return $dataTable->render('sale::close.index');
     }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        abort_if(Gate::denies('create_sales'), 403);
        return view('sale::close.create');
    }


    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function store(Request $request)
    {
        // return $request->all();
        // $results = DB::table('sale_payments')->whereDate('date', today())->select('payment_method', DB::raw('SUM(amount) as total'))
        //         ->groupBy('payment_method')
        //         ->get();

        // return $results;

        $user_id = Auth::id();
        $total = $request->closing_cash - $request->opening_cash;

        $data = [
            'reference' => 'COD',
            'total_sales' => SalePayment::sum('amount'),
            'total' => $total,
            'user_id' => $user_id,
            'cb1' => $request->cb1,
            'cash' => $request->cash,
            'cb2' => $request->cb2,
            'kcb' => $request->kcb,
            'equity' => $request->equity,
            'credit_paid' => $request->credit_paid,
            'cheque' => $request->cheque,
            'date' => ($request->date) ? $request->date : now(),
            'credit' => $request->credit
        ];


        // foreach ($results as  $item) {
        //     if ($item->payment_method == 'Cash') {
        //         $data['cash'] = $item->total;
        //     } elseif ($item->payment_method == 'CB1 153549') {
        //         $data['cb1'] = $item->total;
        //     } elseif ($item->payment_method == 'CB2 153550') {
        //         $data['cb2'] = $item->total;
        //     } elseif ($item->payment_method == 'KCB') {
        //         $data['kcb'] = $item->total;
        //     } elseif ($item->payment_method == 'EQUITY') {
        //         $data['equity'] = $item->total;
        //     } elseif ($item->payment_method == 'CHEQUE') {
        //         $data['cheque'] = $item->total;
        //     } elseif ($item->payment_method == 'CREDIT') {
        //         $data['credit'] = $item->total;
        //     }
        // }
        CloseDay::create($data);
    }


    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {

    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
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
