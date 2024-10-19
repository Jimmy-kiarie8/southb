<?php

namespace Modules\Product\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Category extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function products() {
        return $this->hasMany(Product::class, 'category_id', 'id');
    }
    protected static function boot()
    {
        parent::boot();


        if (env('CODE_GENERATE')) {
            static::creating(function ($model) {
                $number = Category::max('id') + 1;
                $model->category_code = product_code('HD', $number);
            });
        }


    }
}
