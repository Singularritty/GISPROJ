<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MapController;
use App\Http\Controllers\Api\ZonesMapController;

// ===============================
// MAP / CHOROPLETH GEOJSON
// ===============================
Route::get('/zones-map', [MapController::class, 'index']);
