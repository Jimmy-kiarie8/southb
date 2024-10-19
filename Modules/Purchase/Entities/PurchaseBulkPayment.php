<?php

namespace Modules\Purchase\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Auth;
use Modules\People\Entities\Supplier;

class PurchaseBulkPayment extends Model
{
    use HasFactory;


    protected $fillable = ['amount', 'supplier_id', 'payment_method', 'code', 'date'];



    public static function boot() {
        parent::boot();

        static::creating(function ($model) {
            $number = PurchaseBulkPayment::max('id') + 1;
            $model->reference = make_reference_id('PY', $number);
            $model->user_id = Auth::id();
        });
    }

    public function payments()
    {
        return $this->hasMany(PurchasePayment::class, 'reference', 'reference');
    }


    /**
     * Get the customer that owns the SaleBulkPayment
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function supplier(): BelongsTo
    {
        return $this->belongsTo(Supplier::class, 'supplier_id');
    }
}
