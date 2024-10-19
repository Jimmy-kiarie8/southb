<?php

namespace Modules\Sale\Entities;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class CloseDay extends Model
{
    use HasFactory;

    protected $fillable = ['total', 'cb1', 'cb2', 'kcb', 'equity', 'cash', 'credit_paid', 'credit', 'cheque', 'total_sales', 'date'];


    public static function boot() {
        parent::boot();

        static::creating(function ($model) {
            $number = CloseDay::max('id') + 1;
            $model->reference = make_reference_id('COD', $number);
        });
    }

    public function getCreatedAtAttribute($value) {
        return Carbon::parse($value)->format('Y-m-d');
        // return Carbon::parse($value)->format('D d M Y H:i');
    }

}
