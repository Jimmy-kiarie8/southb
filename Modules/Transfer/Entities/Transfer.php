<?php

namespace Modules\Transfer\Entities;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Modules\Branch\Entities\Branch;
use Modules\Product\Entities\Product;

class Transfer extends Model
{
    use HasFactory;

    protected $fillable = [
        'reference', 'product_id', 'location_from', 'location_to', 'quantity', 'received', 'status'
    ];

    // protected static function newFactory()
    // {
    //     return \Modules\Transfer\Database\factories\TransferFactory::new();
    // }

    /**
     * The products that belong to the Transfer
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function products(): BelongsToMany
    {
        return $this->belongsToMany(Product::class, 'product_transfers', 'transfer_id', 'product_id')->withPivot('quantity');
    }

    public function transfer($data)
    {
        Transfer::create([
            'reference' => $data['reference'],
            'location_from' => $data['location_from'],
            'location_to' => $data['location_to'],
            'received' => true,
            'status' => $data['status']
        ]);
    }

    /**
     * Get the location that owns the Transfer
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function location(): BelongsTo
    {
        return $this->belongsTo(Branch::class, 'location_to');
    }
    /**
     * Get the location that owns the Transfer
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function from_location(): BelongsTo
    {
        return $this->belongsTo(Branch::class, 'location_from');
    }

    public function getCreatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('D d M Y H:i');
    }

    public static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $number = Transfer::max('id') + 1;
            $model->reference = make_reference_id('TR', $number);
        });
    }
}
