<?php

namespace Modules\SalesReturn\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class SaleReturn extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function saleReturnDetails() {
        return $this->hasMany(SaleReturnDetail::class, 'sale_return_id', 'id');
    }

    public function saleReturnPayments() {
        return $this->hasMany(SaleReturnPayment::class, 'sale_return_id', 'id');
    }

    public static function boot() {
        parent::boot();

        static::creating(function ($model) {
            $number = SaleReturn::max('id') + 1;
            $model->reference = make_reference_id('SLRN', $number);;
        });
    }

    public function scopeCompleted($query) {
        return $query->where('status', 'Completed');
    }

    public function getShippingAmountAttribute($value) {
        return $value;
    }

    public function getPaidAmountAttribute($value) {
        return $value;
    }

    public function getTotalAmountAttribute($value) {
        return $value;
    }

    public function getDueAmountAttribute($value) {
        return $value;
    }

    public function getTaxAmountAttribute($value) {
        return $value;
    }

    public function getDiscountAmountAttribute($value) {
        return $value;
    }
}