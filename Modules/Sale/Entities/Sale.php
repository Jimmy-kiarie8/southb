<?php

namespace Modules\Sale\Entities;

use App\Models\Scopes\SalesScope;
// use App\Observers\SaleObserve;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Modules\Branch\Entities\Branch;
use Modules\Invoice\Entities\Invoice;
use Modules\People\Entities\Customer;
use Modules\Product\Entities\Product;

class Sale extends Model
{
    use HasFactory, SoftDeletes;

    protected $guarded = [];
    // protected $appends = ['tax_charge'];

    public function saleDetails() {
        return $this->hasMany(SaleDetails::class, 'sale_id', 'id');
        // return $this->hasMany(SaleDetails::class, 'reference', 'reference');
    }

    public function salePayments() {
        return $this->hasMany(SalePayment::class, 'sale_id', 'id');
    }

    public function invoice() {
        return $this->hasOne(Invoice::class, 'sale_id');
    }


    /**
     * The products that belong to the Branch
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function products(): BelongsToMany
    {
        // return $this->belongsToMany(Product::class, 'sale_details','product_code', 'product_code');
        return $this->belongsToMany(Sale::class, 'sale_details', 'product_id', 'sale_id');
        // return $this->belongsToMany(Product::class, 'product_id', 'sale_id');
    }

    /**
     * Get the customer that owns the Sale
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
    public static function boot() {
        parent::boot();
        static::addGlobalScope(new SalesScope);

        static::creating(function ($model) {
            DB::transaction(function() use ($model) {
                $number = DB::table('sales')->lockForUpdate()->max('id') + 1;
                $model->reference = make_reference_id('SL', $number);
                $model->user_id = Auth::id();
            });
        });

        static::deleting(function ($product) {
            if ($product->product_quantity > 0) {
                throw new \Exception('Cannot delete sale with quantity');
            }
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

    public function getCreatedAtAttribute($value) {
        return Carbon::parse($value)->format('Y-m-d H:I:s');
        // return Carbon::parse($value)->format('D d M Y H:i');
    }




    // public function getTaxChargeAttribute($value) {
    //     return $this->saleDetails()->sum('price') * (16/116);
    //     // return $this->saleDetails()->sum('product_tax_amount') * (16/116);
    //     // return $this->saleDetails()->sum('product_tax_amount') * (100*16/116);
    // }


    /**
     * Get the branch that owns the User
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class, 'branch_id');
    }

}
