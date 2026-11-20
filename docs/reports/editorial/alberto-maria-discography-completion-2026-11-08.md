# Alberto María — Discography Execution Report

**Date:** 2026-11-08  
**Artist:** Alberto María («El Muchacho de la Salsa»)  
**Artist ID:** `a935395f-0c7a-4f24-a541-486279c2efa3`  
**Slug:** `alberto-maria`  
**Manifest Reference:** `docs/reports/editorial/alberto-maria-discography-manifest-2026-11-07.md`

---

## 1. Summary of Actions Taken

- **Release Groups / Releases:** 10 sencillos oficiales solistas insertados.
- **Recordings:** 10 grabaciones únicas (0 grabaciones sin clasificar).
- **Tracks:** 10 pistas (`track_number = 1`, `disc_number = 1`).
- **Clasificación canónica:** `genre_id: 5` (Salsa), `subgenre_id: 27` (Salsa Dominicana), `recording_context: 'secular'`.
- **Cover Art Pipeline:** 10 carátulas oficiales descargadas y procesadas con Sharp:
  - Originales JPEG en `cover-art-originals/{release_id}.jpg`.
  - Variantes WebP 300px/150px en `cover-art/{size}/{release_id}.webp`.
  - Marcado `has_cover_image = true` en cada lanzamiento.

---

## 2. Inventory Verification

| Año | Fecha | Título | UPC | Duración | Portada |
|---|---|---|---|:---:|---|
| 2019 | 2019-01-22 | *Por Ella* (ft. Yiyo Sarante) | `197190185416` | 4:29 (269s) | Sí |
| 2019 | 2019-02-11 | *Con La Misma Piedra* | `197190151794` | 4:12 (252s) | Sí |
| 2019 | 2019-05-28 | *Tu Me Pides Que Te Olvide* | `197190206036` | 3:41 (221s) | Sí |
| 2019 | 2019-09-17 | *Sigue Tu Vida* | `197190151930` | 3:53 (233s) | Sí |
| 2020 | 2020-06-14 | *Sopa De Caracol* | `197190165470` | 3:37 (217s) | Sí |
| 2021 | 2021-05-04 | *La Envidia* | `197190150285` | 4:21 (261s) | Sí |
| 2022 | 2022-03-17 | *Tan Adentro De Mi Alma* | `197190187380` | 3:47 (227s) | Sí |
| 2022 | 2022-04-29 | *Me Llamas (Remix)* | `198003728431` | 4:21 (261s) | Sí |
| 2023 | 2023-07-07 | *No Hay Sombra (En Vivo)* | `197190300505` | 4:07 (247s) | Sí |
| 2024 | 2024-04-19 | *Tu Carcel* | `198391719752` | 3:43 (223s) | Sí |

- **Integridad relacional:** Claves foráneas y unicidad de slug validadas.
- **Compilación TypeScript:** Sin errores (`tsc --noEmit` código 0).
