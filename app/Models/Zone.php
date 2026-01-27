<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Zone extends Model
{
    protected $table = 'zones';
    
    // Pastikan field koordinat ada di $fillable atau tidak di-guard
    protected $guarded = [];

    // Relasi ke curah hujan
    public function rainfallLevels()
    {
        return $this->hasMany(RainfallLevel::class);
    }

    // Ambil data curah hujan terbaru untuk pewarnaan peta saat ini
    public function latestRainfall()
    {
        return $this->hasOne(RainfallLevel::class)->latestOfMany();
    }
}
