# Rut Casfer — Profile Execution & Verification Report

**Date:** 2026-11-07  
**Entity:** Rut Casfer (Rut Senil Fernández Castillo)  
**Slug:** `rut-casfer`  
**Artist UUID:** `61976174-16a2-470f-9ba9-89505211baf8`  
**Spotify Artist ID:** `0CkHahekIuZg4OKHdXB8L9`  

---

## 1. Summary of Actions

1. **Artist Profile Creation:**
   - Created solo artist profile in `artists` with `status = 'draft'` per the Dominican Artist Creation Policy and `docs/ARTIST_PROFILE_WORKFLOW.md`.
   - Verified personal name fields: `first_name: 'Rut'`, `middle_name: 'Senil'`, `last_name: 'Fernández'`, `second_last_name: 'Castillo'`.
   - Populated `sort_name: 'Casfer, Rut'`, `stage_name: 'Rut Casfer'`.
   - Origin set to Santo Domingo (`birth_place: 'Santo Domingo'`, `province: 'Distrito Nacional'`).
   - Role & occupations: `type: 'solo_artist'`, `gender: 'female'`, `primary_role: 'singer'`, `occupations: ['singer', 'songwriter']`, `instruments: ['voice']`.
   - Genre hygiene enforced: `primary_genre: 'worship'`, `genres: []` (no repeating primary genre).
   - Social accounts normalized: Instagram (`rutcasferoficial`), Facebook (`rutsenil.fernandezcastillo.9`).
   - Spotify ID resolved and populated: `0CkHahekIuZg4OKHdXB8L9` (Rut Casfer on Spotify, also verified duo Rut & Darwin `2JAp6pXGl8BBwGuloDZEsG`).
   - Aliases populated: `['Rut Senil Fernández Castillo', 'Ruth Fernandez']`.

2. **Bilingual Editorial Documents (Schema v1):**
   - Published English biography (`id: 2e2e0f7a-8cc1-4fdf-9421-b385549f68f3`, `revision: 1`, `status = 'published'`) per Gate B exception.
   - Published Spanish biography (`id: 3cfa616b-9f5a-47fb-b2d7-fb1beb2790ca`, `revision: 1`, `status = 'published'`) per Gate B exception.
   - Validated schema compliance via `validateEditorialDocument` (0 errors).
   - Set legacy compatibility mirrors in `artists.bio_en` and `artists.bio_es`.

3. **Entity References & Link Resolution:**
   - Populated 2 relation rows in `editorial_entity_references`:
     - 1 occurrence in English pointing to `En El Cielo Worship` (`dff9c83a-bfab-4185-9339-864691626871`).
     - 1 occurrence in Spanish pointing to `En El Cielo Worship` (`dff9c83a-bfab-4185-9339-864691626871`).
   - Because En El Cielo Worship is published in the catalog, both links resolve publicly with active links.
   - Darwin Jiménez is not yet in the catalog, so his name remains unlinked plain text per governance rules.

4. **Editorial Integrity Report:**
   - Blocking findings: 0
   - Warning findings: 0
   - Informational findings: 2 (`legacy_compatibility_mismatch` between Markdown bold markers and TipTap bold paragraphs)

---

## 2. Manifest of Exact Field Values

| Field | Value | Source / Rule |
|---|---|---|
| `id` | `61976174-16a2-470f-9ba9-89505211baf8` | Fresh UUID v4 |
| `name` | `Rut Casfer` | Artistic name / Dossier |
| `stage_name` | `Rut Casfer` | Canonical billing |
| `sort_name` | `Casfer, Rut` | Standard personal sorting |
| `first_name` | `Rut` | Self-presented profile name |
| `middle_name` | `Senil` | Self-presented profile name |
| `last_name` | `Fernández` | Paternal surname |
| `second_last_name` | `Castillo` | Maternal surname |
| `slug` | `rut-casfer` | Requested slug |
| `type` | `solo_artist` | Solo worship vocalist |
| `gender` | `female` | Self-description ("mujer apasionada") |
| `primary_role` | `singer` | Vocalist |
| `occupations` | `['singer', 'songwriter']` | Credit roles |
| `instruments` | `['voice']` | Vocalist |
| `primary_genre` | `worship` | Core genre |
| `genres` | `[]` | Governance hygiene |
| `artist_tags` | `['christian']` | Religious classification |
| `birth_place` | `Santo Domingo` | Self-presented profiles |
| `province` | `Distrito Nacional` | Provincial alignment |
| `disambiguation` | `Dominican Christian worship singer` | Sourced context |
| `status` | `draft` | Dominican Artist Creation Policy |
| `has_image` | `false` | Awaiting photo upload by editor |
| `spotify` | `0CkHahekIuZg4OKHdXB8L9` | Verified Spotify Artist ID |
| `instagram` | `rutcasferoficial` | Official handle |
| `facebook` | `rutsenil.fernandezcastillo.9` | Official personal profile handle |
| `youtube` | `null` | No personal channel found |
| `aliases` | `['Rut Senil Fernández Castillo', 'Ruth Fernandez']` | Sourced naming variations |
