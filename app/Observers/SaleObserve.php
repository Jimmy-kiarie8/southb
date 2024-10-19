<?php

namespace App\Observers;

use Illuminate\Support\Facades\Log;
use Modules\Sale\Entities\Sale;

class SaleObserve
{
    /**
     * Handle the Sale "created" event.
     *
     * @param  \App\Models\Sale  $sale
     * @return void
     */
    public function created(Sale $sale)
    {
        // $data = $sale->saleDetails;

        // $order = Sale::with('saleDetails')->find($sale->id);

        // dd($order);

        // foreach($order->saleDetails as $saleDetails) {
        //     dd($saleDetails);
        // }
        // dd(2);


        // if ($sale->total_amount == 0) {
        //     # code...
        // }
    }

    /**
     * Handle the Sale "updated" event.
     *
     * @param  \App\Models\Sale  $sale
     * @return void
     */
    public function updated(Sale $sale)
    {
        //
    }

    /**
     * Handle the Sale "deleted" event.
     *
     * @param  \App\Models\Sale  $sale
     * @return void
     */
    public function deleted(Sale $sale)
    {
        //
    }

    /**
     * Handle the Sale "restored" event.
     *
     * @param  \App\Models\Sale  $sale
     * @return void
     */
    public function restored(Sale $sale)
    {
        //
    }

    /**
     * Handle the Sale "force deleted" event.
     *
     * @param  \App\Models\Sale  $sale
     * @return void
     */
    public function forceDeleted(Sale $sale)
    {
        //
    }
}
