<?php

namespace Modules\Product\Entities;

use App\Models\Scopes\ProductScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;
use Modules\Branch\Entities\Branch;
use Modules\People\Entities\Supplier;
use Modules\Product\Notifications\NotifyQuantityAlert;
use Modules\Sale\Entities\Sale;
use Modules\Stocksheet\Entities\Stocksheet;
use Modules\Transfer\Entities\Transfer;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Spatie\MediaLibrary\MediaCollections\Models\Media;

class Product extends Model implements HasMedia
{

    use HasFactory, InteractsWithMedia, SoftDeletes;

    protected $guarded = [];
    protected $appends = ['available_qty', 'supplier_name'];

    protected $with = ['media', 'branches', 'supplier'];

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id', 'id');
    }

    public function registerMediaCollections(): void
    {
        $this->addMediaCollection('images')
            ->useFallbackUrl('/images/fallback_product_image.png');
    }

    public function registerMediaConversions(Media $media = null): void
    {
        $this->addMediaConversion('thumb')
            ->width(50)
            ->height(50);
    }


    /**
     * The branches that belong to the Product
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function sales(): BelongsToMany
    {
        // return $this->belongsToMany(Sale::class, 'sale_details', 'product_code', 'reference');
        return $this->belongsToMany(Sale::class, 'sale_details', 'product_id', 'sale_id');
    }

    /**
     * Get all of the stocksheet for the Product
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function stocksheet(): HasMany
    {
        return $this->hasMany(Stocksheet::class, 'product_id');
    }

    // public function setProductCostAttribute($value) {
    //     $this->attributes['product_cost'] = ($value);
    // }

    // public function getProductCostAttribute($value) {
    //     return ($value);
    // }

    // public function setProductPriceAttribute($value) {
    //     $this->attributes['product_price'] = ($value);
    // }

    // public function getProductPriceAttribute($value) {
    //     return ($value);
    // }

    /**
     * The branches that belong to the Product
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function branches(): BelongsToMany
    {
        return $this->belongsToMany(Branch::class, 'product_branches', 'product_id', 'branch_id')->withPivot('quantity');;
    }

    /**
     * Get the supplier that owns the Product
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function supplier(): BelongsTo
    {
        return $this->belongsTo(Supplier::class, 'supplier_id');
    }

    /**
     * The transfers that belong to the Product
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function transfers(): BelongsToMany
    {
        return $this->belongsToMany(Transfer::class, 'product_transfers', 'transfer_id', 'product_id');
    }

    public function getProductQuantityAttribute()
    {
        // $totalQty = $this->branches()->sum('quantity');
        // return $totalQty;

        $location_id = Auth::user()->branch_id;

        $totalQty = $this->branches()->when($location_id, function ($q) use ($location_id) {
            return $q->where('branches.id', $location_id);
        })
            ->sum('quantity');

        return $totalQty;
    }

    public function getSupplierNameAttribute()
    {
        $supplier = ($this->supplier) ? $this->supplier->supplier_name : '';
        return $supplier;
    }

    public function getAvailableQtyAttribute()
    {
        $location_id = request('location_id'); // Assuming 'location_id' is passed as a query parameter

        $totalQty = $this->branches()->when($location_id, function ($q) use ($location_id) {
            return $q->where('branches.id', $location_id);
        })
            ->sum('quantity');

        return $totalQty;
    }


    protected static function boot()
    {
        parent::boot();

        // static::addGlobalScope(new ProductScope);

        if (env('CODE_GENERATE')) {
            static::creating(function ($model) {
                $number = Product::max('id') + 1;
                $model->product_code = product_code('IT', $number);
            });
        }

        static::deleting(function ($product) {
            if ($product->product_quantity > 0) {
                throw new \Exception('Cannot delete product with quantity');
            }
            $relationMethods = ['sales'];

            foreach ($relationMethods as $relationMethod) {
                if ($product->$relationMethod()->count() > 0) {
                    throw new \Exception('Cannot delete product with sales');
                }
            }
        });
    }
}
