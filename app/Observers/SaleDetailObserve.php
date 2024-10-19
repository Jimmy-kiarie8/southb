<?php

namespace App\Observers;

use Modules\Sale\Entities\SaleDetails;

class SaleDetailObserve
{
    /**
     * Handle the SaleDetail "created" event.
     *
     * @param  \App\Models\SaleDetail  $saleDetail
     * @return void
     */
    public function created(SaleDetails $saleDetail)
    {

    }

    /**
     * Handle the SaleDetail "updated" event.
     *
     * @param  \App\Models\SaleDetail  $saleDetail
     * @return void
     */
    public function updated(SaleDetails $saleDetail)
    {
        //
    }

    /**
     * Handle the SaleDetail "deleted" event.
     *
     * @param  \App\Models\SaleDetail  $saleDetail
     * @return void
     */
    public function deleted(SaleDetails $saleDetail)
    {
        //
    }

    /**
     * Handle the SaleDetail "restored" event.
     *
     * @param  \App\Models\SaleDetail  $saleDetail
     * @return void
     */
    public function restored(SaleDetails $saleDetail)
    {
        //
    }

    /**
     * Handle the SaleDetail "force deleted" event.
     *
     * @param  \App\Models\SaleDetail  $saleDetail
     * @return void
     */
    public function forceDeleted(SaleDetails $saleDetail)
    {
        //
    }
}
