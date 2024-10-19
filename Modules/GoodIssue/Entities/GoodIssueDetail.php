<?php

namespace Modules\GoodIssue\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Modules\Product\Entities\Product;


class GoodIssueDetail extends Model
{
    use HasFactory, SoftDeletes;

    protected $guarded = [];

    protected $with = ['product'];

    public function product() {
        // return $this->belongsTo(Product::class, 'reference', 'id');
        return $this->belongsTo(Product::class, 'product_id', 'id');
    }

    public function sale() {
        // return $this->belongsTo(Sale::class, 'reference', 'id');
        return $this->belongsTo(GoodIssue::class, 'goodissue_id', 'id');
    }

    public function getPriceAttribute($value) {

        return $value;
    }

    public function getUnitPriceAttribute($value) {
        return $value;
    }

    public function getSubTotalAttribute($value) {
        return $value;
    }

    public function getProductDiscountAmountAttribute($value) {
        return $value;
    }

    public function getProductTaxAmountAttribute($value) {
        return $value;
    }
}
