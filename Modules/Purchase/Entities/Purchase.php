<?php

namespace Modules\Purchase\Entities;

use App\Models\Scopes\PurchaseScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Auth;
use Modules\Branch\Entities\Branch;

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

        static::addGlobalScope(new PurchaseScope);

        static::creating(function ($model) {
            $number = Purchase::max('id') + 1;
            $model->reference = make_reference_id('PR', $number);
            // $model->user_id = Auth::id();
            $model->location_id = Auth::user()->branch_id;
        });
    }

    public function scopeCompleted($query) {
        return $query->where('status', 'Completed');
    }

    /**
     * Get the branch that owns the Purchase
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class, 'branch_id');
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
