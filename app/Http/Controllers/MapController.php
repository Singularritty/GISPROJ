<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Zone;
use App\Models\SoilType;
use App\Models\RainfallLevel;

class MapController extends Controller
{
      public function index()
    {
        $features = Zone::all()->map(function ($zone) {

            return [
                "type" => "Feature",

                "properties" => [
                    "id" => $zone->id,
                    "name" => $zone->name,
                    "description" => $zone->description,
                    "weight" => $zone->weight,
                    "color" => $zone->color,

                    "soil_type" => $zone->soil_type ?? "-",
                    "rainfall_avg" => $zone->rainfall_avg ?? 0,
                    "final_score" => $zone->final_score ?? 0,

                    // array crops agar tidak undefined di FE
                    "recommended_crops" => $zone->recommended_crops
                        ? explode(',', $zone->recommended_crops)
                        : [],
                ],

                "geometry" => is_string($zone->polygon)
                    ? json_decode($zone->polygon)
                    : $zone->polygon
            ];
        });

        return [
            "type" => "FeatureCollection",
            "features" => $features
        ];
    }
}