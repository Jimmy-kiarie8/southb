<?php

namespace Modules\Sale\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Carbon;

class SalePayment extends Model
{

    use HasFactory, SoftDeletes;

    protected $guarded = [];
    protected $with = ['sale'];

    public function sale() {
        return $this->belongsTo(Sale::class, 'sale_id', 'id');
    }

    public function setAmountAttribute($value) {
        $this->attributes['amount'] = $value;
    }

    public function getAmountAttribute($value) {
        return $value;
    }

    // public function getDateAttribute($value) {
    //     return Carbon::parse($value)->format('d M, Y');
    // }

    public function scopeBySale($query) {
        return $query->where('sale_id', request()->route('sale_id'));
    }

    /**
     * Get the bulk that owns the SalePayment
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function bulk(): BelongsTo
    {
        return $this->belongsTo(SaleBulkPayment::class, 'reference', 'reference');
    }
}
