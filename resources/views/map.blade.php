<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Peta Choropleth Kabupaten Bandung</title>

    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

    <style>
        body {
            margin: 0;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
            background: #f4f6f8;
        }

        header {
            padding: 14px 20px;
            background: #1f2937;
            color: #fff;
        }

        header h1 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
        }

        header p {
            margin: 4px 0 0;
            font-size: 13px;
            color: #d1d5db;
        }

        .layout {
            display: grid;
            grid-template-columns: 360px 1fr;
            height: calc(100vh - 64px);
        }

        .sidebar {
            background: #ffffff;
            border-right: 1px solid #e5e7eb;
            padding: 16px;
            overflow-y: auto;
        }

        .sidebar h2 {
            font-size: 16px;
            margin-bottom: 8px;
        }

        .filter {
            margin-bottom: 16px;
            padding: 12px;
            background: #f9fafb;
            border-radius: 6px;
        }

        .filter label {
            font-size: 13px;
            color: #374151;
            display: block;
            margin-bottom: 6px;
        }

        .filter input,
        .filter select {
            width: 100%;
        }

        .filter select[multiple] {
            height: 100px;
        }

        .stat {
            margin: 10px 0;
            font-size: 14px;
        }

        .stat b {
            display: inline-block;
            width: 140px;
            color: #374151;
        }

        #map {
            width: 100%;
            height: 100%;
        }

        .legend {
            background: white;
            padding: 10px;
            line-height: 18px;
            border-radius: 4px;
            font-size: 12px;
            box-shadow: 0 0 5px rgba(0,0,0,0.3);
        }

        .legend i {
            width: 20px;
            height: 12px;
            display: inline-block;
            margin-right: 6px;
        }
    </style>
</head>

<body>

<header>
    <h1>Peta Choropleth Kabupaten Bandung</h1>
    <p>Visualisasi zona pertanian berdasarkan skor lingkungan dan rekomendasi tanaman</p>
</header>

<div class="layout">
    <aside class="sidebar">
        <h2>Filter Zona</h2>

        <div class="filter">
            <label>Skor Minimum: <b><span id="scoreValue">0</span></b></label>
            <input type="range" id="scoreFilter" min="0" max="100" step="1" value="0">
        </div>

        <div class="filter">
            <label>Jenis Tanah</label>
            <select id="soilFilter">
                <option value="">Semua</option>
            </select>
        </div>

        <div class="filter">
            <label>Curah Hujan (mm)</label>
            <input type="number" id="rainMin" placeholder="Minimum">
            <input type="number" id="rainMax" placeholder="Maximum" style="margin-top:6px;">
        </div>

        <div class="filter">
            <label>Rekomendasi Tanaman</label>
            <select id="cropFilter" multiple>
                <!-- dynamic -->
            </select>
            <small style="color:#6b7280">Tahan Ctrl / Cmd untuk multi-select</small>
        </div>

        <hr>

        <div id="infoPanel">
            <h2>Informasi Zona</h2>
            <small>Klik salah satu wilayah pada peta</small>
        </div>
    </aside>

    <div id="map"></div>
</div>

<script>
    const map = L.map("map").setView([-7.05, 107.55], 11);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        maxZoom: 18
    }).addTo(map);

    const scoreFilter = document.getElementById("scoreFilter");
    const scoreValue = document.getElementById("scoreValue");
    const soilFilter = document.getElementById("soilFilter");
    const rainMinInput = document.getElementById("rainMin");
    const rainMaxInput = document.getElementById("rainMax");
    const cropFilter = document.getElementById("cropFilter");
    const infoPanel = document.getElementById("infoPanel");

    let geojsonData;
    let zoneLayer;
    let boundaryLayer;

    function getColor(score) {
        const s = Number(score) || 0;
        if (s >= 80) return '#16a34a';
        if (s >= 60) return '#84cc16';
        if (s >= 40) return '#facc15';
        if (s >= 20) return '#f97316';
        return '#dc2626';
    }

    function getSelectedCrops() {
        return Array.from(cropFilter.selectedOptions).map(o => o.value);
    }

    function renderBoundary() {
        if (boundaryLayer) {
            map.removeLayer(boundaryLayer);
        }

        boundaryLayer = L.geoJSON(geojsonData, {
            filter: feature => feature.properties.type === "boundary",
            style: {
                color: '#000',
                weight: 3,
                fillOpacity: 0,
                dashArray: '5, 5'
            }
        }).addTo(map);
    }

    function renderZones() {
        const minScore = Number(scoreFilter.value);
        const soil = soilFilter.value;
        const rainMin = Number(rainMinInput.value) || 0;
        const rainMax = Number(rainMaxInput.value) || Infinity;
        const selectedCrops = getSelectedCrops();

        if (zoneLayer) {
            map.removeLayer(zoneLayer);
        }

        zoneLayer = L.geoJSON(geojsonData, {
            filter: feature => {
                // Hanya render zones, skip boundary
                if (feature.properties.type === "boundary") return false;

                const p = feature.properties;
                const crops = Array.isArray(p.recommended_crops) ? p.recommended_crops : [];

                const cropMatch =
                    selectedCrops.length === 0 ||
                    crops.some(c => selectedCrops.includes(c));

                return (
                    p.final_score >= minScore &&
                    (!soil || p.soil_type === soil) &&
                    p.rainfall_avg >= rainMin &&
                    p.rainfall_avg <= rainMax &&
                    cropMatch
                );
            },

            style: feature => ({
                fillColor: getColor(feature.properties.final_score),
                color: '#333',
                weight: 2,
                fillOpacity: 0.6
            }),

            onEachFeature: (feature, layer) => {
                layer.on("click", () => {
                    const p = feature.properties;

                    const cropsList = Array.isArray(p.recommended_crops)
                        ? p.recommended_crops.map(c => `<li>${c}</li>`).join("")
                        : "<li>-</li>";

                    infoPanel.innerHTML = `
                        <h2>${p.name}</h2>
                        <small>${p.description}</small>
                        <hr>

                        <div class="stat"><b>Skor Zona</b> ${p.final_score}</div>
                        <div class="stat"><b>Tanah Dominan</b> ${p.soil_type}</div>
                        <div class="stat"><b>Curah Hujan</b> ${p.rainfall_avg}</div>

                        <div class="stat">
                            <b>Rekomendasi Tanaman</b>
                            <ul>${cropsList}</ul>
                        </div>
                    `;
                });

                layer.on("mouseover", e => {
                    e.target.setStyle({ weight: 4, fillOpacity: 0.75 });
                });

                layer.on("mouseout", e => {
                    zoneLayer.resetStyle(e.target);
                });
            }
        }).addTo(map);
    }

   fetch("/api/zones-map")
    .then(res => res.json())
    .then(data => {
        geojsonData = data;
        
        // Render boundary terlebih dahulu
        renderBoundary();
        
        // Render zones
        renderZones();
        map.fitBounds(L.geoJSON(data).getBounds());
        
        const soils = new Set();
        const crops = new Set();

        // Filter hanya zones untuk populate dropdown
        data.features.forEach(f => {
            if (f.properties.type === "boundary") return;
            
            if (f.properties.soil_type) {
                soils.add(f.properties.soil_type);
            }

            (f.properties.recommended_crops || []).forEach(c => crops.add(c));
        });

        soils.forEach(s => {
            const opt = document.createElement("option");
            opt.value = s;
            opt.textContent = s;
            soilFilter.appendChild(opt);
        });

        crops.forEach(c => {
            const opt = document.createElement("option");
            opt.value = c;
            opt.textContent = c;
            cropFilter.appendChild(opt);
        });

        renderZones();
        map.fitBounds(L.geoJSON(data).getBounds());

        renderZones();
        map.fitBounds(L.geoJSON(data).getBounds());
    });

    scoreFilter.addEventListener("input", () => {
        scoreValue.textContent = scoreFilter.value;
        renderZones();
    });

    soilFilter.addEventListener("change", renderZones);
    rainMinInput.addEventListener("input", renderZones);
    rainMaxInput.addEventListener("input", renderZones);
    cropFilter.addEventListener("change", renderZones);

    const scoreRanges = [
        { min: 80, max: 100, label: "Sangat Sesuai", color: "#16a34a" },
        { min: 60, max: 79, label: "Sesuai", color: "#84cc16" },
        { min: 40, max: 59, label: "Cukup Sesuai", color: "#facc15" },
        { min: 20, max: 39, label: "Kurang Sesuai", color: "#f97316" },
        { min: 0, max: 19, label: "Tidak Sesuai", color: "#dc2626" }
    ];

    const legend = L.control({ position: "bottomright" });

    legend.onAdd = function () {
        const div = L.DomUtil.create("div", "legend");
        let html = "<b>Legenda Zona (Skor)</b><br>";
        
        scoreRanges.forEach(range => {
            html += `<i style="background:${range.color}"></i> ${range.label} (${range.min}-${range.max})<br>`;
        });
        
        div.innerHTML = html;
        return div;
    };

    legend.addTo(map);
</script>

</body>
</html>
