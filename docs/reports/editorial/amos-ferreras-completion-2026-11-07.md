# Amos Ferreras — Profile Completion & Publication Report

**Date:** 2026-11-07  
**Entity:** Amos Ferreras (Amos Ferreras García)  
**Slug:** `amos-ferreras`  
**Artist UUID:** `5392e2ec-6465-443f-bad8-fc7e726aea17`  
**Status:** `published` (Artist) / `published` (Editorial Documents)  

---

## 1. Summary of Actions & Status

1. **Artist Profile Publication & Field Hygiene:**
   - Artist record published: `status = 'published'` per editor authorization.
   - Verified personal name fields: `first_name: 'Amos'`, `middle_name: null`, `last_name: 'Ferreras'`, `second_last_name: 'García'`.
   - Populated `sort_name: 'Ferreras, Amos'`, `stage_name: 'Amos Ferreras'`, `aliases: ['Amos Ferreras García']`.
   - Geographic origin & birthplace hygiene: Barahona is documented as his origin/hometown from his profile, but without primary birth record evidence. Per `docs/ARTIST_PROFILE_WORKFLOW.md` (Rule 37 & 60), `birth_place` is set to `null` while `province` is set to `'Barahona'`.
   - Role & occupations hygiene: `primary_role: 'singer'`. Per Rule 142 & 299, `occupations` must not duplicate `primary_role`, so `'singer'` was removed, leaving `occupations: ['guitarist', 'songwriter', 'producer']`.
   - Genre hygiene: `primary_genre: 'worship'`, `genres: []` (no duplication of primary genre).
   - Instruments & Tags: `instruments: ['voice', 'guitar']`, `artist_tags: ['christian']`.
   - Social accounts normalized: `instagram: 'amosferreras'`, `facebook: 'amos.ferreras'`, `website: 'https://amosferreras.com'`.

2. **Bilingual Editorial Documents (Schema v1):**
   - Published English biography (`id: 72130d6c-0fd6-4b8f-afd3-7bf2208019b2`, `revision: 1`, `status = 'published'`).
   - Published Spanish biography (`id: 928a94b9-c508-4482-8b5c-0c3e47c3f9a8`, `revision: 1`, `status = 'published'`).
   - Validated schema compliance via `validateEditorialDocument` (0 issues).
   - Formatted in accordance with `docs/EDITORIAL_BIOGRAPHY_FORMAT.md`: bold-only section titles, no heading nodes, guillemets for works and non-catalog entities, and legacy markdown mirrors in `artists.bio_en` and `artists.bio_es`.

3. **Entity References (Outbound):**
   - Linked catalog artists within both biographies:
     - **Grupo Grace** (`43a14bc5-52fd-43df-9bd9-15f3b11dcf3b`)
     - **World Worship** (`1da4849c-18c1-4cae-8c5c-f7c708a08110`)
     - **En El Cielo Worship** (`dff9c83a-bfab-4185-9339-864691626871`)
     - **Rut Casfer** (`61976174-16a2-470f-9ba9-89505211baf8`)
   - All 22 relation rows in `editorial_entity_references` are synchronized and resolve to published artists.

4. **Backward-Reference Audit & Reciprocal Linking (Inbound):**
   - Converted plain-text mentions of Amos Ferreras to active `artistReference` nodes in the published biographies of:
     - **En El Cielo Worship** (`dff9c83a-bfab-4185-9339-864691626871`):
       - English (`265e77a2-b2f8-4c24-86da-c4d9c2fb9de5`): Revision incremented to 2.
       - Spanish (`466dc0e6-3b63-460e-8ded-7a2198e40cdd`): Revision incremented to 2.
     - **Kabed** (`e6a27ceb-0e41-434e-b6aa-d1550c6d578b`):
       - English (`5b30b437-1181-4a27-a582-2b376337d76d`): Revision incremented to 4.
       - Spanish (`c5dd6c68-bb67-4e8b-9355-adc3319d1891`): Revision incremented to 4.
   - Inserted 4 new relation rows in `editorial_entity_references` pointing to Amos Ferreras (`5392e2ec-6465-443f-bad8-fc7e726aea17`).
   - Verified schema compliance across all updated documents (0 blocking errors).

5. **Cache Revalidation:**
   - Executed targeted cache revalidation via production API for `amos-ferreras`, `en-el-cielo-worship`, and `kabed`.

---

## 2. Field Manifest

| Field | Value | Evidence / Governance Note |
|---|---|---|
| `id` | `5392e2ec-6465-443f-bad8-fc7e726aea17` | Existing UUID |
| `name` | `Amos Ferreras` | Stage / Public Name |
| `stage_name` | `Amos Ferreras` | Canonical billing |
| `sort_name` | `Ferreras, Amos` | Surnames, Given names |
| `first_name` | `Amos` | Documented given name |
| `middle_name` | `null` | None documented |
| `last_name` | `Ferreras` | Documented first surname |
| `second_last_name` | `García` | Documented second surname (Deezer / MultiTracks) |
| `slug` | `amos-ferreras` | Canonical slug |
| `type` | `solo_artist` | Solo musician |
| `status` | `published` | Authorized by editor |
| `gender` | `male` | Documented |
| `primary_role` | `singer` | Primary artistic practice |
| `occupations` | `['guitarist', 'songwriter', 'producer']` | Hygenic list; excludes `primary_role` |
| `primary_genre` | `worship` | Governed genre |
| `genres` | `[]` | Empty; does not duplicate `primary_genre` |
| `artist_tags` | `['christian']` | Repertoire-based tag |
| `instruments` | `['voice', 'guitar']` | Verified instruments |
| `birth_place` | `null` | Place of birth lacks birth proof |
| `province` | `Barahona` | Origin province documented on profile |
| `date_of_birth` | `null` | Undocumented (not invented) |
| `facebook` | `amos.ferreras` | facebook.com/amos.ferreras |
| `instagram` | `amosferreras` | @amosferreras |
| `website` | `https://amosferreras.com` | Official website |
| `aliases` | `['Amos Ferreras García']` | Full legal/publishing name |
| `bio_en` (doc) | `72130d6c-0fd6-4b8f-afd3-7bf2208019b2` | Schema v1, rev 1, `published` |
| `bio_es` (doc) | `928a94b9-c508-4482-8b5c-0c3e47c3f9a8` | Schema v1, rev 1, `published` |
