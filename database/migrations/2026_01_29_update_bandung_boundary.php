<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Read geojson file
        $geojsonPath = database_path('seeders/bandung_boundary.geojson');
        $geojson = json_decode(file_get_contents($geojsonPath), true);

        // Clear existing boundary
        DB::statement('DELETE FROM bandung_boundary');

        // Insert features from geojson
        foreach ($geojson['features'] as $feature) {
            $properties = $feature['properties'];
            $geometry = json_encode($feature['geometry']);

            DB::statement(
                "INSERT INTO bandung_boundary (gid_2, gid_0, country, gid_1, name_1, nl_name_1, name_2, varname_2, nl_name_2, type_2, engtype_2, cc_2, hasc_2, geom)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ST_GeomFromGeoJSON(?))",
                [
                    $properties['GID_2'] ?? null,
                    $properties['GID_0'] ?? null,
                    $properties['COUNTRY'] ?? null,
                    $properties['GID_1'] ?? null,
                    $properties['NAME_1'] ?? null,
                    $properties['NL_NAME_1'] ?? null,
                    $properties['NAME_2'] ?? null,
                    $properties['VARNAME_2'] ?? null,
                    $properties['NL_NAME_2'] ?? null,
                    $properties['TYPE_2'] ?? null,
                    $properties['ENGTYPE_2'] ?? null,
                    $properties['CC_2'] ?? null,
                    $properties['HASC_2'] ?? null,
                    $geometry
                ]
            );
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement('DELETE FROM bandung_boundary');
    }
};
