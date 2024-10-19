<?php

namespace Modules\Quotation\Entities;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Modules\People\Entities\Supplier;

class Lpo extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function lpoDetails() {
        return $this->hasMany(LpoDetail::class, 'lpo_id', 'id');
    }

    public function supplier() {
        return $this->belongsTo(Supplier::class, 'supplier_id', 'id');
    }

    public static function boot() {
        parent::boot();

        static::creating(function ($model) {
            $number = Quotation::max('id') + 1;
            $model->reference = make_reference_id('LPO', $number);
        });
    }

    public function getDateAttribute($value) {
        return Carbon::parse($value)->format('d M, Y');
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
