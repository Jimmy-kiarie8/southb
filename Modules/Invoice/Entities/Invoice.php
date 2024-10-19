<?php

namespace Modules\Invoice\Entities;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Modules\Sale\Entities\Sale;

class Invoice extends Model
{
    use HasFactory;

    protected $fillable = ['invoice_no','amount','balance','sale_id','user_id'];

    protected static function newFactory()
    {

    }

    public static function boot() {
        parent::boot();

        static::creating(function ($model) {
            $number = Invoice::max('id') + 1;
            $model->invoice_no = make_reference_id('INV', $number);
        });
    }

    /**
     * Get the sale that owns the Invoice
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function sale(): BelongsTo
    {
        return $this->belongsTo(Sale::class, 'sale_id');
    }

    /**
     * Get all of the payments for the Invoice
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function payments(): HasMany
    {
        return $this->hasMany(InvoicePayment::class, 'invoice_id');
    }

    public function invoice($data)
    {
        Invoice::create($data);
    }
    
    public function getCreatedAtAttribute($value) {
        return Carbon::parse($value)->format('D d M Y H:i');
    }
}
