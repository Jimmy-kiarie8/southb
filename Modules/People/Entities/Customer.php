<?php

namespace Modules\People\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SaleBulkPayment;

class Customer extends Model
{

    use HasFactory;

    protected $guarded = [];

    protected static function newFactory() {
        return \Modules\People\Database\factories\CustomerFactory::new();
    }

    /**
     * Get all of the sales for the Customer
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function sales(): HasMany
    {
        return $this->hasMany(Sale::class, 'customer_id');
    }

    /**
     * Get all of the payments for the Customer
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function payments(): HasMany
    {
        return $this->hasMany(SaleBulkPayment::class, 'client_id');
    }


    public static function boot() {
        parent::boot();
        static::creating(function ($model) {
            $number = Customer::max('id') + 1;
            $model->code = make_reference_id('CL', $number);
        });
    }

}
