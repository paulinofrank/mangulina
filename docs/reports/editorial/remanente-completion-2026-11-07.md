# R3MANENT3 (Ministerio Remanente) — Profile Execution & Verification Report

**Date:** 2026-11-07  
**Entity:** R3MANENT3 / Ministerio Remanente  
**Slug:** `remanente`  
**Artist UUID:** `cce4c9ef-f584-43ce-b0c9-bc346a5c70a5`  
**Spotify Artist ID:** `6AUI7QHW0mp1folDB6wihz`  
**Status:** `draft` (Artist) / `published` (Editorial Documents)  

---

## 1. Summary of Actions

1. **Artist Profile Creation:**
   - Created group artist profile in `artists` with `status = 'draft'` per the Dominican Artist Creation Policy (`GEMINI.md`) and `docs/ARTIST_PROFILE_WORKFLOW.md`.
   - Populated `name: 'R3MANENT3'`, `stage_name: 'R3MANENT3'`, `sort_name: 'R3MANENT3'`.
   - Disambiguation: `"Dominican youth worship band and church music ministry from Santo Domingo Este"`.
   - Formation year: `null` (founding year is undocumented in sources; earliest recorded release is March 2023).
   - Origin & Province: Documented home and recording base at Iglesia de la Alabanza del Señor Jesucristo in Alma Rosa / Ozama (`birth_place: 'Santo Domingo Este'`, `province: 'Santo Domingo'`).
   - Classification & Roles: `type: 'group'`, `primary_role: 'singer'`, `occupations: ['musician']`, `artist_tags: ['christian']`.
   - Genre hygiene enforced: `primary_genre: 'worship'`, `genres: []` (no repeating primary genre).
   - Social accounts normalized: Instagram (`r3manent3`), YouTube (`@remanente3`, canonical channel handle verified via official video metadata and channel title), Facebook (`null`, none official found).
   - Spotify ID resolved and verified: `6AUI7QHW0mp1folDB6wihz` (Spotify artist name "R3MANENT3", matching album *«La Reunión Live Experience»* and official singles).
   - Aliases: `['Ministerio Remanente', 'Ministerio de Adoración Remanente', 'R3manente', 'Remanente']`.

2. **Bilingual Editorial Documents (Schema v1):**
   - Published English biography (`id: a0940707-c246-4a96-a6d2-ae4b7f6f4f86`, `revision: 1`, `status = 'published'`) per Gate B exception.
   - Published Spanish biography (`id: 93b87858-00eb-43bd-a705-5a25e09515cc`, `revision: 1`, `status = 'published'`) per Gate B exception.
   - Validated schema compliance via `validateEditorialDocument` (0 errors).
   - Formatted in accordance with `docs/EDITORIAL_BIOGRAPHY_FORMAT.md`: bold-only section titles, no heading nodes, guillemets for works and non-catalog entities, and legacy markdown mirrors in `artists.bio_en` and `artists.bio_es`.

3. **Entity References & Link Resolution:**
   - Populated 4 relation rows in `editorial_entity_references`:
     - 2 occurrences in English:
       - `Madiel Lara` (`426d767e-4484-4fac-a9ba-215cbe23da4c`)
       - `Angel Brown` (`840b892d-a096-4258-82a9-e05a16eb2d2b`)
     - 2 occurrences in Spanish:
       - `Madiel Lara` (`426d767e-4484-4fac-a9ba-215cbe23da4c`)
       - `Angel Brown` (`840b892d-a096-4258-82a9-e05a16eb2d2b`)
   - Both target artists are published in Mangulina (`status = 'published'`) and resolve with active links.
   - Collaborators and featured guests not yet cataloged remain unlinked plain text per governance: `Rubio Music`, `Thelma Constant`, `Genesis Soto`, `Dannia Santana`, `Obed Medina`, `Eduardo Luna`, `Cristhian Cruz`, `Emely Jiménez`, `Javier Hernández`, `Haroel Reyes`, `Samuel Jimenez`, `Shirley Peña`, `Anthony Antigua`, `Eliz Terrero`, `Alex Zurdo`, `Gp Rymer`.

4. **Editorial Integrity Report:**
   - Documents audited: 2
   - Relations audited: 4
   - Blocking findings: 0
   - Warning findings: 0
   - Informational findings: 2 (`legacy_compatibility_mismatch` between plain Markdown bold lines and TipTap schema structure)

---

## 2. Manifest of Exact Field Values

| Field | Value | Source / Rule |
|---|---|---|
| `id` | `cce4c9ef-f584-43ce-b0c9-bc346a5c70a5` | Fresh UUID v4 |
| `name` | `R3MANENT3` | Stylized streaming / billing name |
| `stage_name` | `R3MANENT3` | Canonical billing |
| `sort_name` | `R3MANENT3` | Direct group sorting |
| `slug` | `remanente` | Requested slug |
| `status` | `draft` | Dominican Artist Creation Policy |
| `type` | `group` | Band / youth church ministry |
| `primary_role` | `singer` | Valid role dictionary entry |
| `occupations` | `['musician']` | General musical collective role |
| `primary_genre` | `worship` | Valid genre dictionary entry |
| `genres` | `[]` | Rule: never duplicate `primary_genre` |
| `artist_tags` | `['christian']` | Subgenre / market tag |
| `birth_place` | `Santo Domingo Este` | Base & recording venue (Alma Rosa / Ozama) |
| `province` | `Santo Domingo` | Matched Dominican province |
| `formation_year`| `null` | Undocumented founding year |
| `has_image` | `false` | Awaiting editorial photo upload |
| `spotify` | `6AUI7QHW0mp1folDB6wihz` | Spotify catalog artist ID |
| `instagram` | `r3manent3` | Verified handle |
| `facebook` | `null` | Unverified / none official found |
| `youtube` | `@remanente3` | Verified official channel handle |
| `aliases` | `['Ministerio Remanente', 'Ministerio de Adoración Remanente', 'R3manente', 'Remanente']` | Verified alternate forms |
| `disambiguation`| `Dominican youth worship band and church music ministry from Santo Domingo Este` | Clarifying summary |

---

## 3. Verification & Build Integrity

- **Database Rows:**
  - `artists`: 1 inserted row (`remanente`)
  - `editorial_documents`: 2 inserted rows (`a0940707-c246-4a96-a6d2-ae4b7f6f4f86`, `93b87858-00eb-43bd-a705-5a25e09515cc`)
  - `editorial_entity_references`: 4 inserted rows (`0598ae16-fc42-4bd9-aff0-7456772fe870`, `90b66f3c-d4f2-4ac6-8ff6-819835257f73`, `1dae3855-a6ae-4ddf-bb99-bff27eaf40c8`, `7e435a96-8858-4444-9d7a-4ed72ea61b3f`)
- **TypeScript Check:** `tsc --noEmit` exited with code 0 (clean build).
- **Integrity Check:** `buildEditorialIntegrityReport` returned 0 blocking and 0 warning errors.

---

## 4. Supabase Security & Production Policy Adherence

- Zero modifications to Supabase RLS, security policies, grants, auth settings, or keys.
- Draft artist status strictly preserved awaiting Frank's photo upload and publication action.
