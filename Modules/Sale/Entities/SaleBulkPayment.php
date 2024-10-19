<?php

namespace Modules\Sale\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;
use Modules\People\Entities\Customer;

class SaleBulkPayment extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = ['amount', 'client_id', 'payment_method', 'code', 'date'];



    public static function boot() {
        parent::boot();

        static::creating(function ($model) {
            $number = SaleBulkPayment::max('id') + 1;
            $model->reference = make_reference_id('PY', $number);
            $model->user_id = Auth::id();
        });
    }

    /**
     * Get all of the payments for the SaleBulkPayment
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function payments(): HasMany
    {
        return $this->hasMany(SalePayment::class, 'reference', 'reference');
    }

    /**
     * Get the customer that owns the SaleBulkPayment
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class, 'client_id');
    }



}
