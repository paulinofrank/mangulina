# Los Hijos del Rey — Profile Research and Editorial Report

**Date:** 2026-11-01  
**Scope:** Creation of the official profile for the iconic Dominican merengue orchestra **Los Hijos del Rey** in draft status (`artists.status = 'draft'`), with completed and validated published biographies in Spanish and English (`editorial_documents.status = 'published'`).  
**Governance:** Governed by `AGENTS.md`, `GEMINI.md`, `docs/ARTIST_PROFILE_WORKFLOW.md`, `docs/EDITORIAL_BIOGRAPHY_FORMAT.md`, and `docs/DATA_GOVERNANCE.md`. No discography imports, image uploads, public profile publication, or Supabase security modifications.

---

## 1. Sources Inspected

1. **Music Platforms & Catalogs:**
   - **Spotify:** Artist ID `2tjPWNqjIhDad2esOUUD7b` ("Los Hijos Del Rey", verified profile with core catalog albums including *Sergio Vargas y Los Hijos del Rey* [1986], *Auténticos* [1979], *Los Hijos del Rey Con Fernandito Villalona* [1979]). Alternative ID `6GzYE02GejB3ufs6CaW2Ou` (6,629 listeners) noted. Unrelated profile IDs rejected: `5CtQgJ02UuGKfEaR3VTH1A` (Christian ensemble) and `1Xr3BIazQOtFvQYm0pg4di` (Mexican cumbia group).
   - **MusicBrainz:** Group entity `e826fa8b-8ff0-443f-bb41-6e6eb36370fe` ("Los Hijos del Rey", Type: Group, Country: Dominican Republic, active 1970s–1980s).
   - **Discogs:** Artist ID `1205075` ("Los Hijos Del Rey"). Verified 84 releases across masters and original pressings:
     - 1977: *Los Hijos Del Rey Con Fernandito Villalona* (Karen Records, KLP 28)
     - 1978: *Fernandito & Raulín* (Karen Records, KLP 35) & *Los Hijos Del Rey* (Karen Records, KLP 40)
     - 1979: *New Life* (Combo Records) & *Auténticos* (Karen Records, KLP 43/47)
     - 1980: *Los Hijos Del Rey* (Karen Records, KLP 56, featuring Robert Jeand'or - «Yo Me Dominicanizo»)
     - 1981: *En Europa* (Karen Records) & *Reencuentro Con Raulín* (Karen Records)
     - 1984: *Los Hijos Del Rey* (Karen Records, KLP 84, featuring Sergio Vargas - «Banana», «Mi Amigo el Guardia»)
     - 1985: *En Movimiento* (Karen Records)
     - 1986: *Sergio Vargas y Los Hijos del Rey / La Quiero a Morir* (Karen Records, KLP 100)
     - 1987: *Sergio Vargas Y Los Hijos Del Rey* (Karen Records, KLP 107)
     - 1988: *Thony Medrano Y Los Hijos Del Rey* (Karen Records)

2. **Dominican Press & Historical Research:**
   - **Fausto Polanco** (*El Día*, author of *Merengueros*): Detailed historical chronicles on the foundation, management, and transition of Los Hijos del Rey; documents Wilfrido Vargas's original 7-piece combo concept and Tito Kenton's persuasion to build a full big band; the August 1976 debut at Estadio Olímpico opening for Fania All Stars; the roles of Cholo Brenes, Bonny Cepeda, Fernando Villalona, Raulín Rosendo, Dioni Fernández, and Sergio Vargas.
   - **Alexis Méndez** (*Radio Gladys Palmera*, *VinilMente*): Studies on the golden age of Dominican merengue in the 1970s and 1980s, highlighting the technical and visual transformation ushered in by Los Hijos del Rey and their balance between rural cadence and international lyrical repertoire («La Quiero a Morir»).
   - **Joseph Cáceres** (*Merengue y Más* / *ArteNacional*): Historical coverage of the 1978 and 1979 schisms, Bienvenido Rodríguez vs. Cholo Brenes/Ralph Mercado, the emergence of «Bonny con Kenton» / Los Kenton, and the transition of frontmen.
   - **El Nacional & El Caribe archives:** Articles on the cultural impact of Rafael «Cholo» Brenes as manager and talent incubator.

---

## 2. Identity and Database Checks

- Prior to creation, database query confirmed that "Los Hijos del Rey" did not exist in the `artists` table (`artists matches: []`).
- No duplicate records existed for slug `los-hijos-del-rey`, Spotify ID `2tjPWNqjIhDad2esOUUD7b`, or MBID `e826fa8b-8ff0-443f-bb41-6e6eb36370fe`.
- Verified existence and published status of all 13 reference targets in Mangulina's catalog:
  - `Wilfrido Vargas` (`2bc36959-dcce-4e10-9ecf-2cd418eaa489`)
  - `Fernando Villalona` (`bc310977-31a9-41bb-9af2-7d3a0d7fabdd`)
  - `Raulín Rosendo` (`faf3e4cb-808e-419c-87ff-5126eed85e73`)
  - `Bonny Cepeda` (`bc4db4c6-c96f-4eb7-af95-ac637785c5bf`)
  - `Los Kenton` (`dc89c826-c298-48c8-aa05-50e77d85264a`)
  - `July Mateo "Rasputín"` (`052b710d-e91f-41c6-94ac-480100f95f5b`)
  - `Rafael Solano` (`ba42e200-51b0-437b-99ac-1daf39ade337`)
  - `Los Beduinos` (`c2e192d4-f144-4f9a-8db4-b71f0cff391e`)
  - `Dioni Fernández y El Equipo` (`fb2c703f-5362-47dd-ada0-7c6d5e106f3b`)
  - `Johnny Pacheco` (`e005898c-4fcc-45da-b857-c6775e92fa52`)
  - `Carlos Alfredo Fatule` (`214e98cc-cac9-4473-9741-2a87481b0685`)
  - `Kaki Vargas` (`0a36ec1b-2de1-4890-95f2-57d6b19a1d69`)
  - `Sergio Vargas` (`059a9e99-5d11-433e-97b9-9c35e57908f1`)
- Entities and historical figures outside the database remain strictly in plain text or guillemets (e.g. Tito Kenton, Luis Kenton, Cholo Brenes, Bienvenido Rodríguez, Mateo San Martín, Robert Jeand'or, Diomedes Núñez, Orville Peña, Francis Cabrel, Luis Gómez-Escolar, Joe Nicolás).

---

## 3. Field Choices and Manifest Values

| Field | Persisted Value | Evidence & Governance Rule |
| :--- | :--- | :--- |
| `name` | `Los Hijos del Rey` | Historic canonical name across all master releases, press, and catalogs. |
| `sort_name` | `Hijos del Rey, Los` | Standard orchestra catalog sorting matching `Beduinos, Los` and `Kenton, Los`. |
| `slug` | `los-hijos-del-rey` | Unique URL-safe slug. |
| `type` | `group` | Admitted selector value for an orchestra/band. |
| `status` | `draft` | **Mandatory exception rule:** New artist records must be created with `status = 'draft'`. |
| `primary_role` | `orchestra` | Admitted selector value for big bands/orchestras. |
| `occupations` | `[]` | Hygiene rule: `occupations` must never contain or repeat `primary_role`. |
| `primary_genre`| `merengue` | Primary genre across all recorded repertoire. |
| `genres` | `[]` | Hygiene rule: `genres` must never contain or repeat `primary_genre`. |
| `artist_tags` | `["secular", "legend"]` | Secular recorded repertoire; legendary status justified by historical stature. |
| `formation_year`| `1976` | Formed mid-1976; debuted August 1976 at Estadio Olímpico. |
| `ended` | `true` | Historic ensemble; core activity closed. |
| `birth_place` | `Santo Domingo` | City of origin rule: "Origin is a city", saved in `birth_place`. |
| `province` | `Distrito Nacional` | Documented province of origin. |
| `spotify` | `2tjPWNqjIhDad2esOUUD7b` | Verified Spotify artist ID. |
| `mbid` | `e826fa8b-8ff0-443f-bb41-6e6eb36370fe` | Verified MusicBrainz group UUID. |
| `aliases` | `[]` | No distinct official aliases required; canonical name used uniformly. |
| `instruments` | `[]` | Not applicable to group entity. |
| `gender` | `null` | Not applicable to group entity. |
| `views` | `0` | Initialized counter. |
| `has_image` | `false` | Image pending editorial provision. |

---

## 4. Applied Database Records and Verification

1. **Artist Record:**
   - **UUID:** `3c82ee60-d565-405d-8423-7895d3706122`
   - **Name:** Los Hijos del Rey
   - **Status:** `draft` (Verified)
   - **Slug:** `los-hijos-del-rey`
   - **Legacy Mirrors:** `bio_es` and `bio_en` populated with clean markdown mirrors.

2. **Editorial Document Records (Source of Truth):**
   - **Spanish Document (`es`):**
     - **ID:** `645f5199-63b6-4711-863f-4481635fcdc8`
     - **Status:** `published` (Revision 1)
     - **Structure:** 19 blocks (1 untitled lead paragraph, 6 bold section titles, prose paragraphs, and bullet lists).
     - **Entity References:** 32 `artistReference` nodes across 13 target catalog artists.
   - **English Document (`en`):**
     - **ID:** `fc4d41a8-6316-47e7-8fde-b27788afee4a`
     - **Status:** `published` (Revision 1)
     - **Structure:** 19 blocks (1 untitled lead paragraph, 6 bold section titles, prose paragraphs, and bullet lists).
     - **Entity References:** 32 `artistReference` nodes across 13 target catalog artists.

3. **Editorial Entity References:**
   - Total rows in `editorial_entity_references`: **64 rows** (32 for `es`, 32 for `en`).
   - Every reference has a unique `occurrenceId` and matches the target artist's canonical name character-for-character.

4. **Integrity Report:**
   - **Blocking Findings:** 0
   - **Warning Findings:** 0
   - **Informational Findings:** 2 (`legacy_compatibility_mismatch`, standard notice for structured TipTap documents alongside plain markdown mirrors).
   - **Hygiene Checks Passed:**
     - `artist.genres` does not contain `primary_genre` (`merengue`).
     - `artist.occupations` does not contain `primary_role` (`orchestra`).

---

## 5. Backward-Reference Audit

In accordance with `docs/ARTIST_PROFILE_WORKFLOW.md` and `docs/EDITORIAL_BIOGRAPHY_FORMAT.md`, an exhaustive scoped search of all existing published structured biographies across Mangulina was conducted.

- **Findings:** Found **32 existing published documents** across **15 catalog artists** that mention "Los Hijos del Rey" (or "Hijos del Rey"):
  - Altamira Banda Show (`e735658a-0cc6-4238-9cf9-e5bebad6724b`): `en`, `es`
  - Bonny Cepeda (`bc4db4c6-c96f-4eb7-af95-ac637785c5bf`): `en`, `es`
  - Dioni Fernández y El Equipo (`fb2c703f-5362-47dd-ada0-7c6d5e106f3b`): `en`, `es`
  - Domingo Peguero (`385cbcf3-c353-48ee-aee3-5d5dff042129`): `en`, `es`
  - Fernando Villalona (`bc310977-31a9-41bb-9af2-7d3a0d7fabdd`): `en`, `es`
  - Johnny Pacheco (`e005898c-4fcc-45da-b857-c6775e92fa52`): `en`, `es`
  - July Mateo "Rasputín" (`052b710d-e91f-41c6-94ac-480100f95f5b`): `en`, `es`
  - Kaki Vargas (`0a36ec1b-2de1-4890-95f2-57d6b19a1d69`): `en`, `es`
  - Los Beduinos (`c2e192d4-f144-4f9a-8db4-b71f0cff391e`): `en`, `es`
  - Los Kenton (`dc89c826-c298-48c8-aa05-50e77d85264a`): `en`, `es`
  - Luis "Terror" Días (`3f71c4c9-b7b5-4b36-a36c-df4baabdc4f9`): `en`, `es`
  - Pablo Martínez (`868b96d3-8a3d-4b7d-a6e4-0b2faa3c4c4a`): `en`, `es`
  - Raulín Rosendo (`faf3e4cb-808e-419c-87ff-5126eed85e73`): `en`, `es`
  - Rubby Pérez (`cff70c92-8632-4c66-b5a0-81622c8128b0`): `en`, `es`
  - Sandy Reyes (`49f8aae7-e066-4b01-a836-126082163c52`): `en`, `es`
  - Sergio Vargas (`059a9e99-5d11-433e-97b9-9c35e57908f1`): `en`, `es`
- **Action:** Documented in detail in `docs/reports/editorial/los-hijos-del-rey-pending-backlinks.json`.
- **Policy Compliance:** In compliance with the draft-artist exception and shared-record gates, these external biographies remain unmodified at this time. Linking external public biographies to a draft artist would expose draft targets through public links (resulting in 404 errors) and requires explicit expanded authorization. These backlinks will be converted during the authorized artist publication workflow.

---

## 6. Exclusions & Unresolved Items

1. **Artist Profile Publication:** The artist record remains in `status = 'draft'`. It will be published only after editor review and explicit instruction.
2. **Portrait Image:** No image was uploaded or generated; left with `has_image = false` for the editor to upload the official historical band photo.
3. **Discography & Credits Ingestion:** Per `AGENTS.md` and `docs/discography.md`, discography import was strictly excluded from this task and will be performed under a dedicated discography mandate.
4. **No Public Cache Traps:** The public URL was never requested in accordance with the 404 cache prevention rule.
5. **Supabase Security Policy:** No RLS, policies, permissions, roles, or grants were modified.
