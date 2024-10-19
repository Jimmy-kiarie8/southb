<?php

namespace Modules\Branch\Entities;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Modules\Product\Entities\Product;
use Modules\Sale\Entities\Sale;
use Modules\Transfer\Entities\Transfer;

class Branch extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'location'];

    // protected static function newFactory()
    // {
    //     return \Modules\Branch\Database\factories\BranchFactory::new();
    // }

    /**
     * Get all of the users for the Branch
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function users(): HasMany
    {
        return $this->hasMany(User::class, 'branch_id');
    }

    /**
     * Get all of the sales for the Branch
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function sales(): HasMany
    {
        return $this->hasMany(Sale::class, 'branch_id');
    }

    /**
     * The products that belong to the Branch
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function products(): BelongsToMany
    {
        return $this->belongsToMany(Product::class, 'product_id', 'branch_id');
    }

    /**
     * Get all of the transfers for the Branch
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function transfers(): HasMany
    {
        return $this->hasMany(Transfer::class, 'location_from');
    }
    /**
     * Get all of the transfers for the Branch
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function location_to(): HasMany
    {
        return $this->hasMany(Transfer::class, 'location_to');
    }
}
