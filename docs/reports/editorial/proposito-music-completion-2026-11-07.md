# Propósito Music — Profile Execution & Verification Report

**Date:** 2026-11-07  
**Entity:** Propósito Music  
**Slug:** `proposito-music`  
**Artist UUID:** `5114bae1-6735-48cc-bae8-13902759abdc`  
**Spotify Artist ID:** `7IOOpl3xUkiQwhUJfTAwHO`  
**Status:** `draft` (Artist) / `published` (Editorial Documents)  

---

## 1. Summary of Actions

1. **Artist Profile Creation:**
   - Created group artist profile in `artists` with `status = 'draft'` per the Dominican Artist Creation Policy (`GEMINI.md`) and `docs/ARTIST_PROFILE_WORKFLOW.md`.
   - Populated `name: 'Propósito Music'`, `stage_name: 'Propósito Music'`, `sort_name: 'Propósito Music'`.
   - Disambiguation: `"Dominican Pentecostal worship band and collective led by Samuel \"Sami\" Castillo"`.
   - Formation year: `2020` (official channel launched Jan 2020, debut single May 2020).
   - Origin & Province: Documented concerts and ministry base in `San Cristóbal` (`birth_place: 'San Cristóbal'`, `province: 'San Cristóbal'`), with church sessions recorded at Iglesia Fuente de Esperanza II in Santo Domingo Este.
   - Classification & Roles: `type: 'group'`, `primary_role: 'singer'`, `occupations: ['musician']`, `artist_tags: ['christian']`.
   - Genre hygiene enforced: `primary_genre: 'worship'`, `genres: []` (no repeating primary genre).
   - Social accounts normalized: Instagram (`proposito.music`), Facebook (`proposito.mg`), YouTube (`@propósitomusicoficial`).
   - Spotify ID resolved and populated: `7IOOpl3xUkiQwhUJfTAwHO` (Artist name "Propósito" on Spotify).
   - Aliases: `['Propósito', 'Proposito Music']`.

2. **Bilingual Editorial Documents (Schema v1):**
   - Published English biography (`id: cb9b5fa3-0dbd-427c-b29b-508acb555472`, `revision: 1`, `status = 'published'`) per Gate B exception.
   - Published Spanish biography (`id: 859838e0-6506-4404-9b81-ff857d871562`, `revision: 1`, `status = 'published'`) per Gate B exception.
   - Validated schema compliance via `validateEditorialDocument` (0 errors).
   - Formatted in accordance with `docs/EDITORIAL_BIOGRAPHY_FORMAT.md`: bold-only section titles, no heading nodes, guillemets for works and non-catalog entities, and legacy markdown mirrors in `artists.bio_en` and `artists.bio_es`.

3. **Entity References & Link Resolution:**
   - Populated 2 relation rows in `editorial_entity_references`:
     - 1 occurrence in English pointing to `Arianny Aquino` (`05004c74-e6e6-40b9-ac8f-77a20c5eca31`).
     - 1 occurrence in Spanish pointing to `Arianny Aquino` (`05004c74-e6e6-40b9-ac8f-77a20c5eca31`).
   - Collaborators not yet in catalog kept as unlinked plain text per governance: `Daniel Calveti`, `Yendy y Kairo`, `Elías Gross`, `Abigail Mateo`, `Ónice Mateo`, `Bryan Matos`, `April Jaspe`.

4. **Editorial Integrity Report:**
   - Documents audited: 2
   - Relations audited: 2
   - Blocking findings: 0
   - Warning findings: 0
   - Informational findings: 2 (`legacy_compatibility_mismatch` between plain Markdown bold lines and TipTap schema structure)

---

## 2. Manifest of Exact Field Values

| Field | Value | Source / Rule |
|---|---|---|
| `id` | `5114bae1-6735-48cc-bae8-13902759abdc` | Fresh UUID v4 |
| `name` | `Propósito Music` | Group name / Dossier |
| `stage_name` | `Propósito Music` | Canonical billing |
| `sort_name` | `Propósito Music` | Direct band sorting |
| `slug` | `proposito-music` | Requested slug |
| `status` | `draft` | Dominican Artist Creation Policy |
| `type` | `group` | Band / collective |
| `primary_role` | `singer` | Valid role dictionary entry |
| `occupations` | `['musician']` | General musical collective role |
| `primary_genre` | `worship` | Valid genre dictionary entry |
| `genres` | `[]` | Rule: never duplicate `primary_genre` |
| `artist_tags` | `['christian']` | Subgenre / market tag |
| `birth_place` | `San Cristóbal` | Concert and home base |
| `province` | `San Cristóbal` | Matched Dominican province |
| `formation_year`| `2020` | Launch of project and first release |
| `has_image` | `false` | Awaiting editorial photo upload |
| `spotify` | `7IOOpl3xUkiQwhUJfTAwHO` | Spotify catalog artist ID |
| `instagram` | `proposito.music` | Verified handle |
| `facebook` | `proposito.mg` | Verified handle |
| `youtube` | `@propósitomusicoficial` | Verified official artist channel |
| `aliases` | `['Propósito', 'Proposito Music']` | Alternate billings |
| `disambiguation`| `Dominican Pentecostal worship band and collective led by Samuel "Sami" Castillo` | Clarifying summary |

---

## 3. Verification & Build Integrity

- **Database Rows:**
  - `artists`: 1 inserted row (`proposito-music`)
  - `editorial_documents`: 2 inserted rows (`cb9b5fa3-0dbd-427c-b29b-508acb555472`, `859838e0-6506-4404-9b81-ff857d871562`)
  - `editorial_entity_references`: 2 inserted rows (`1d08d8bb-df74-4fcd-8e73-6900ab1fd879`, `5e3be933-a0ee-4fe2-ad22-c781642190c8`)
- **TypeScript Check:** `tsc --noEmit` exited with code 0 (clean build).
- **Integrity Check:** `buildEditorialIntegrityReport` returned 0 blocking and 0 warning errors.

---

## 4. Supabase Security & Production Policy Adherence

- Zero modifications to Supabase RLS, security policies, grants, auth settings, or keys.
- Draft artist status strictly preserved awaiting Frank's photo upload and publication action.
