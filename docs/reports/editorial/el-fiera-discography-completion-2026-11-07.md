# El Fiera — Discography Completion & Verification Report

**Date:** 2026-11-07  
**Entity:** El Fiera (Johan Daniel García Saldaña)  
**Artist UUID:** `92169757-a877-433f-9dcf-5f8a5ad90d3f`  
**Slug:** `el-fiera`  
**Scope:** Complete catalog ingestion from official streaming & digital distributor metadata (Spotify, Apple Music, iTunes, DistroKid, Villano Music Records / Diskover Distribution).  
**Authority:** Explicit editor instruction ("Create his disco please").  

---

## 1. Summary of Ingested Catalog

- **Releases Created:** 15 (14 digital singles + 1 6-track EP)
- **Distinct Recordings Created:** 17
- **Track Placements Created:** 20
- **Release Artist Relations Created:** 15 (`role = 'primary'`)
- **Recording Credits Created:** 17 (`role = 'lead_performer'`)
- **Cover Artwork Uploaded:** 15 high-resolution originals (`cover-art-originals/{id}.jpg`) and 30 WebP variants (`cover-art/300px/{id}.webp` and `cover-art/150px/{id}.webp`), with `releases.has_cover_image = true` on all 15 releases.
- **Recording Reuse & Version Integrity:**
  - The 6-track EP *«MÁS DEMBOW»* (released 2025-12-19) reuses the exact master recordings of its previously issued singles:
    - Track 2: *«Me voy rulay»* (ISRC `QZZ7W2436730`)
    - Track 3: *«Chukiteo»* (ISRC `QT3F22460673`)
    - Track 6: *«UN DOMINGO»* (ISRC `QZDA72512960`)
  - No redundant duplicate recordings were created for these appearances.

---

## 2. Release & Track Manifest

| # | Date | Type | Title | Tracks | UPC / Barcode | Label / Distributor |
|---|---|---|---|---|---|---|
| 1 | 2017-07-10 | Single | *Más loco que jackas* | 1 | `199095764888` | Villano Music Records |
| 2 | 2024-12-09 | Single | *A 200 Y PICO* | 1 | `199096757476` | Villano Music Records |
| 3 | 2024-12-23 | Single | *Me voy rulay* | 1 | `199095393477` | Villano Music Records |
| 4 | 2025-01-02 | Single | *Chukiteo* | 1 | `199092849649` | Villano Music Records |
| 5 | 2025-01-28 | Single | *UN DOMINGO* | 1 | `199086152847` | Villano Music Records |
| 6 | 2025-02-06 | Single | *TRAP 2025* | 1 | `199084644825` | Villano Music Records |
| 7 | 2025-02-21 | Single | *EL FIERA - FAVELA* | 1 | `199080670187` | Villano Music Records |
| 8 | 2025-02-22 | Single | *EL FIERA - DINERO* | 1 | `199080669341` | Villano Music Records |
| 9 | 2025-02-24 | Single | *EL FIERA - NEBULEO* | 1 | `199080668832` | Villano Music Records |
| 10 | 2025-02-25 | Single | *JHOANSITO BO & EL FIERA - PROBLEMAS* | 1 | `199080667651` | Villano Music Records |
| 11 | 2025-04-09 | Single | *3 Flow en 1 (Freestyle)* | 1 | `199340687313` | Villano Music Records |
| 12 | 2025-05-27 | Single | *EL FIERA - FENÓMENO* | 1 | `199328739805` | Villano Music Records |
| 13 | 2025-07-10 | Single | *TATARA* | 1 | `199517224723` | Villano Music Records |
| 14 | 2025-12-19 | EP | *MÁS DEMBOW* | 6 | `729771376335` | Villano Music Records \| Diskover Distribution |
| 15 | 2026-10-24 | Single | *Contacto* | 1 | `729771549333` | Villano Music Records \| Diskover Distribution |

---

## 3. Detailed Tracklist for EP *«MÁS DEMBOW»*

1. **MÁS DEMBOW** (100s) — ISRC `ES75E2526829` (New recording, `subgenre_id: 42` Dembow)
2. **Me voy rulay** (216s) — ISRC `QZZ7W2436730` (Reused master recording from 2024 single)
3. **Chukiteo** (127s) — ISRC `QT3F22460673` (Reused master recording from 2025 single)
4. **MAMI CHULA** (182s) — ISRC `ES75E2526830` (New recording, `subgenre_id: 42` Dembow)
5. **DEPATILLATE** (151s) — ISRC `ES75E2526831` (New recording, `subgenre_id: 42` Dembow)
6. **UN DOMINGO** (163s) — ISRC `QZDA72512960` (Reused master recording from 2025 single)

---

## 4. Genre Classification & Standards

- **Taxonomy Assignment:**
  - All 17 recordings assigned `genre_id: 10` (`urbano`).
  - Dembow tracks (*«Me voy rulay»*, *«Chukiteo»*, *«UN DOMINGO»*, *«MÁS DEMBOW»*, *«MAMI CHULA»*, *«DEPATILLATE»*, *«TATARA»*) assigned `subgenre_id: 42` (`urban-dembow`).
  - Latin trap tracks (*«TRAP 2025»*, *«FAVELA»*, *«DINERO»*, *«NEBULEO»*, *«PROBLEMAS»*, *«3 Flow en 1»*, *«FENÓMENO»*, *«A 200 Y PICO»*, *«Contacto»*, *«Más loco que jackas»*) assigned `subgenre_id: 44` (`urban-trap`).
- **Context:** All set to `recording_context = 'secular'`.

---

## 5. Verification & Compliance

- **Storage Pipeline:** All 15 releases processed with Sharp and uploaded:
  - `cover-art-originals/{release_id}.jpg`
  - `cover-art/300px/{release_id}.webp`
  - `cover-art/150px/{release_id}.webp`
  - `has_cover_image` verified `true` across all 15 releases in `releases`.
- **TypeScript Compilation:** Clean compile (`tsc --noEmit` exited `0`).
- **Supabase Security Policy:** Strict compliance; zero modifications to RLS policies, grants, functions, or auth settings.
