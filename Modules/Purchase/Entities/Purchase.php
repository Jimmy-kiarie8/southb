<?php

namespace Modules\Purchase\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Purchase extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function purchaseDetails() {
        // return $this->hasMany(PurchaseDetail::class, 'purchase_id', 'id');
        return $this->hasMany(PurchaseDetail::class, 'reference', 'reference');
    }


    public function purchasePayments() {
        // return $this->hasMany(PurchasePayment::class, 'reference', 'reference');
        return $this->hasMany(PurchasePayment::class, 'purchase_id', 'id');
    }

    public static function boot() {
        parent::boot();

        static::creating(function ($model) {
            $number = Purchase::max('id') + 1;
            $model->reference = make_reference_id('PR', $number);
        });
    }

    public function scopeCompleted($query) {
        return $query->where('status', 'Completed');
    }

    // public function getShippingAmountAttribute($value) {
    //     return $value;
    // }

    // public function getPaidAmountAttribute($value) {
    //     return $value;
    // }

    // public function getTotalAmountAttribute($value) {
    //     return $value;
    // }

    // public function getDueAmountAttribute($value) {
    //     return $value;
    // }

    // public function getTaxAmountAttribute($value) {
    //     return $value;
    // }

    // public function getDiscountAmountAttribute($value) {
    //     return $value;
    // }
}
