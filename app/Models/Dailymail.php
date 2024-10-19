<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dailymail extends Model
{
    use HasFactory;

    protected $fillable = ['last_job'];
}
