# Alberth Hernández — Discography Execution Report

**Date:** 2026-11-08  
**Artist:** Alberth Hernández («El Príncipe del Merengue»)  
**Artist ID:** `ead1053c-ff65-4da7-bc59-2b23c01b95bc`  
**Slug:** `alberth-hernandez`  
**Manifest Reference:** `docs/reports/editorial/alberth-hernandez-discography-manifest-2026-11-07.md`

---

## 1. Summary of Actions Taken

- **Release Groups / Releases:** 4 insertados
  1. *«Esta Bueno Santo Domingo»* (2023, Álbum, 10 pistas, UPC `707337780260`)
  2. *«Te Cambio Todo Por Amor»* (2024, Álbum, 12 pistas, Rondon Music, UPC `198342252451`)
  3. *«Me Huele a Navidad»* (2025, Sencillo, 1 pista, PAHMUSIC, UPC `199502843236`)
  4. *«Caravana De Navidad»* (2025, Álbum, 11 pistas, PAHMUSIC, UPC `199891205530`)
- **Recordings:** 33 grabaciones únicas (0 grabaciones sin género asignado).
  - Merengue: `genre_id = 1`, `subgenre_id = 15` (Merengue de Orquesta).
  - Bolero: *«Aquellos Boleros (Popurri)»* (`genre_id = 58`).
- **Tracks:** 34 pistas (la pista 10 de *Caravana De Navidad* reutiliza limpiamente la grabación canónica del sencillo *Me Huele a Navidad*).
- **Cover Art Pipeline:** 4 paquetes de arte procesados con Sharp: originales JPEG en `cover-art-originals/{release_id}.jpg` y variantes WebP 300px/150px en `cover-art`, con `has_cover_image = true` en cada lanzamiento.

---

## 2. Inventory Verification

| Año | Título | Tipo | Pistas | Sello / Distribuidor | UPC | Portada |
|---|---|---|---|---|---|---|
| 2023 | *Esta Bueno Santo Domingo* | Álbum | 10 | Sueños Records Distribución | 707337780260 | Sí |
| 2024 | *Te Cambio Todo Por Amor* | Álbum | 12 | Rondon Music Enterprises Srl | 198342252451 | Sí |
| 2025 | *Me Huele a Navidad* | Sencillo | 1 | PAHMUSIC RECORDS | 199502843236 | Sí |
| 2025 | *Caravana De Navidad* | Álbum | 11 | PAHMUSIC RECORDS | 199891205530 | Sí |

- **Integridad relacional:** 100% de claves foráneas verificadas.
- **Compilación TypeScript:** Sin errores (`tsc --noEmit` código 0).
