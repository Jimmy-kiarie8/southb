<?php

namespace Modules\Branch\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Support\Facades\Auth;

class ProductBranch extends Model
{
    use HasFactory;

protected $fillable = ['product_id', 'branch_id', 'quantity'];

    public function quantity($quantity, $id, $branch_id)
    {
        $product = ProductBranch::find($id);

        if ($product) {
           if($quantity){
            $product->increment('quantity', $quantity);
           }
            return;
        }
        $data = [
            'branch_id' => ($branch_id) ? $branch_id : 1,
            'product_id' => $id,
            'quantity' => ($quantity) ? $quantity : 0
        ];
        ProductBranch::create($data);
    }

}
