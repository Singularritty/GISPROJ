<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Zone;
use App\Models\SoilType;
use App\Models\RainfallLevel;
use Illuminate\Support\Facades\DB;


class MapController extends Controller
{
      public function index()
{
    // Ambil zona pertanian dan potong dengan boundary Bandung
    $zones = DB::select("
        SELECT
            z.id,
            z.name,
            z.description,
            z.weight,
            z.soil_type,
            z.rainfall_avg,
            z.final_score,
            z.recommended_crops,
            ST_AsGeoJSON(
                ST_Intersection(
                    ST_GeomFromGeoJSON(z.polygon),
                    b.geom
                )
            ) AS polygon
        FROM zones z
        JOIN bandung_boundary b
          ON ST_Intersects(ST_GeomFromGeoJSON(z.polygon), b.geom)
    ");

    $zoneFeatures = collect($zones)->map(function ($z) {
        return [
            "type" => "Feature",
            "properties" => [
                "id" => $z->id,
                "name" => $z->name,
                "description" => $z->description,
                "weight" => $z->weight,
                "soil_type" => $z->soil_type,
                "rainfall_avg" => $z->rainfall_avg,
                "final_score" => (float) $z->final_score,
                "recommended_crops" => $z->recommended_crops
                    ? explode(',', $z->recommended_crops)
                    : [],
            ],
            "geometry" => json_decode($z->polygon),
        ];
    });

    // Ambil boundary Bandung
    $boundaries = DB::select("
        SELECT 
            id,
            name_2 as name,
            ST_AsGeoJSON(geom) as geom
        FROM bandung_boundary
    ");

    $boundaryFeatures = collect($boundaries)->map(function ($b) {
        return [
            "type" => "Feature",
            "properties" => [
                "id" => $b->id,
                "name" => $b->name,
                "type" => "boundary"
            ],
            "geometry" => json_decode($b->geom),
        ];
    });

    return [
        "type" => "FeatureCollection",
        "features" => array_merge($zoneFeatures->toArray(), $boundaryFeatures->toArray())
    ];
}
}