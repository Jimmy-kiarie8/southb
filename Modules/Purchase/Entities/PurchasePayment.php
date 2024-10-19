<?php

namespace Modules\Purchase\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Carbon;

class PurchasePayment extends Model
{
    use HasFactory, SoftDeletes;

    protected $guarded = [];
    protected $with = ['purchase'];

    public function purchase() {
        // return $this->belongsTo(Purchase::class, 'reference', 'reference');
        return $this->belongsTo(Purchase::class, 'purchase_id', 'id');
    }

    // public function setAmountAttribute($value) {
    //     $this->attributes['amount'] = $value;
    // }

    // public function getAmountAttribute($value) {
    //     return $value;
    // }

    // public function getDateAttribute($value) {
    //     return Carbon::parse($value)->format('d M, Y');
    // }

    public function scopeByPurchase($query) {
        return $query->where('purchase_id', request()->route('purchase_id'));
    }


    public function purchaseBulkPayment()
    {
        return $this->belongsTo(PurchaseBulkPayment::class, 'reference', 'reference');
    }
}
