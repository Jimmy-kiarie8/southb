<?php

namespace Modules\Invoice\Entities;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class InvoicePayment extends Model
{
    use HasFactory;

    protected $fillable = ['invoice_id','amount','notes'];

    protected static function newFactory()
    {

    }


    public static function boot() {
        parent::boot();

        static::creating(function ($model) {
            $number = Invoice::max('id') + 1;
            $model->invoice_no = make_reference_id('RCT', $number);
        });
    }

    /**
     * Get the invoice that owns the Invoice
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function invoice(): BelongsTo
    {
        return $this->belongsTo(Invoice::class, 'invoice_id');
    }


    public function getCreatedAtAttribute($value) {
        return Carbon::parse($value)->format('D d M Y H:i');
    }
}
