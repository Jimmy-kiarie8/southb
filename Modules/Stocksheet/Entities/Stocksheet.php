<?php

namespace Modules\Stocksheet\Entities;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Product\Entities\Product;
use Oddvalue\LaravelDrafts\Concerns\HasDrafts;

class Stocksheet extends Model
{
    use HasFactory, HasDrafts;

    protected $fillable = ['reference', 'product_id', 'system_qty', 'actual_qty', 'is_published'];

    protected static function newFactory()
    {
    }

    public static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $number = Stocksheet::max('id') + 1;
            $model->reference = make_reference_id('ST', $number);
        });
    }

    /**
     * Get the product that owns the Stocksheet
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function getCreatedAtAttribute($value) {
        return Carbon::parse($value)->format('D d M Y H:i');
    }
}
