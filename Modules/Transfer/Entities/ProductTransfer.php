<?php

namespace Modules\Transfer\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ProductTransfer extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id',
        'transfer_id',
        'quantity'
    ];


    // protected static function newFactory()
    // {
    //     return \Modules\Transfer\Database\factories\ProductTransferFactory::new();
    // }
}
