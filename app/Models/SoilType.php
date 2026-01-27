<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SoilType extends Model
{
    protected $guarded = [];

    // Otomatis convert JSON di database menjadi Array PHP
    protected $casts = [
        'recommended_crops' => 'array',
    ];
}