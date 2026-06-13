# Mangulina Genre Taxonomy Migration Plan

Status: **Planning only. No production changes applied.**

Generated from the live Supabase taxonomy and the current migration/application files on June 12, 2026.

## Executive Summary

The current database already uses one self-referencing `genres` table and contains no Christian-named rows. Christian meaning is stored in `recordings.recording_context` as intended.

The proposed migration will:

- Add `Pop` as a new top-level genre.
- Promote existing rows for `Jazz`, `Rock / Alternative`, `Electronic`, and `Reggae` to top-level genres.
- Rename promoted `Rock / Alternative` to `Rock`.
- Consolidate the two current Jazz children into one top-level `Jazz` row.
- Move `Latin Pop` from Ballads to Pop.
- Move `Bolero` from Folklore to Ballads.
- Preserve Worship as a top-level genre and Gospel as its child.
- Preserve all `recording_context` values, including `christian`.
- Update 385 recording taxonomy assignments and 14 import mappings.

## Current State: Before

### Main Genres

| ID | Main genre | Recording count | Current children |
|---:|---|---:|---|
| 13 | Worship | 113 | Gospel |
| 1 | Merengue | 3,899 | Perico Ripiao, Orquesta, Calle, Urbano, House, Pambiche, Mambo |
| 2 | Bachata | 3,782 | Tradicional, Moderna, Urbana, Romántica |
| 10 | Urban | 1,626 | Reggaeton, Dembow, Rap / Hip Hop, Trap, Drill, Fusion |
| 5 | Salsa | 565 | Romántica, Dura, Dominicana |
| 7 | Ballads | 491 | Romantic, Latin Pop, Singer-Songwriter |
| 9 | Instrumental | 82 | Jazz, Classical, Orchestral, Piano, Popular |
| 11 | Folklore | 383 | Dominicano, Palos / Atabales, Raíz, Son Dominicano, Bolero |
| 12 | Fusion | 302 | Tropical, Jazz, Afro-Caribbean, Rock / Alternative, Electronic, Reggae |

### Current Rows Requiring Structural Change

| ID | Current row | Current parent | Current recording count | Proposed result |
|---:|---|---|---:|---|
| 29 | Latin Pop | Ballads | 1 | Child of new Pop |
| 36 | Jazz | Instrumental | 82 | Promote to main Jazz |
| 53 | Jazz | Fusion | 1 | Merge into main Jazz ID 36, then delete |
| 55 | Rock / Alternative | Fusion | 301 | Promote and rename to Rock |
| 56 | Electronic | Fusion | 0 | Promote to main Electronic |
| 57 | Reggae | Fusion | 0 | Promote to main Reggae |
| 51 | Bolero | Folklore | 0 | Move under Ballads |

### Christian Status

- Christian rows in `genres`: **0**
- Recordings with `recording_context = 'christian'`: **119**
- Christian recordings currently mapped to Worship: **113**
- Christian recordings mapped to Merengue / Orquesta: **5**
- Christian recordings mapped to Folklore / Son Dominicano: **1**

No Christian cleanup is required in this proposed migration, but validation must confirm these conditions remain true.

## Proposed Final Genres Table: After

Existing IDs should be retained wherever possible. `Pop` requires one new generated ID. Jazz ID 53 is the only proposed deletion.

### Top-Level Rows

| Proposed order | ID | Name | Slug | Change |
|---:|---:|---|---|---|
| 1 | 13 | Worship | `worship` | Unchanged |
| 2 | 1 | Merengue | `merengue` | Unchanged |
| 3 | 2 | Bachata | `bachata` | Unchanged |
| 4 | 10 | Urban | `urban` | Unchanged |
| 5 | 5 | Salsa | `salsa` | Unchanged |
| 6 | 7 | Ballads | `ballads` | Gains Bolero; loses Latin Pop |
| 7 | New ID | Pop | `pop` | New top-level genre |
| 8 | 55 | Rock | `rock` | Promoted from Fusion; renamed |
| 9 | 57 | Reggae | `reggae` | Promoted from Fusion |
| 10 | 36 | Jazz | `jazz` | Promoted from Instrumental; canonical Jazz row |
| 11 | 56 | Electronic | `electronic` | Promoted from Fusion |
| 12 | 9 | Instrumental | `instrumental` | Loses Jazz |
| 13 | 11 | Folklore | `folklore` | Loses Bolero |
| 14 | 12 | Fusion | `fusion` | Loses Jazz, Rock, Electronic, and Reggae |

All top-level rows will have `parent_id = NULL`, `level = 0`, and unique `sort_order` values shown above.

### Proposed Parent-Child Hierarchy

| Parent | Children after migration |
|---|---|
| Worship | Gospel |
| Merengue | Perico Ripiao, Orquesta, Calle, Urbano, House, Pambiche, Mambo |
| Bachata | Tradicional, Moderna, Urbana, Romántica |
| Urban | Reggaeton, Dembow, Rap / Hip Hop, Trap, Drill, Fusion |
| Salsa | Romántica, Dura, Dominicana |
| Ballads | Romantic, Singer-Songwriter, Bolero |
| Pop | Latin Pop |
| Rock | None initially |
| Reggae | None initially |
| Jazz | None initially |
| Electronic | None initially |
| Instrumental | Classical, Orchestral, Piano, Popular |
| Folklore | Dominicano, Palos / Atabales, Raíz, Son Dominicano |
| Fusion | Tropical, Afro-Caribbean |

This produces **14 top-level genres and 35 child genres**, with 49 total taxonomy rows after adding Pop and deleting duplicate Jazz ID 53.

## Recording Impact

### Required Mapping Changes

| Change | Current assignment | Proposed assignment | Recordings affected |
|---|---|---|---:|
| Promote Pop family | Ballads / Latin Pop | Pop / Latin Pop | 1 |
| Promote canonical Jazz | Instrumental / Jazz ID 36 | Jazz / null | 82 |
| Merge duplicate Jazz | Fusion / Jazz ID 53 | Jazz ID 36 / null | 1 |
| Promote Rock | Fusion / Rock / Alternative | Rock / null | 301 |
| Promote Electronic | Fusion / Electronic | Electronic / null | 0 |
| Promote Reggae | Fusion / Reggae | Reggae / null | 0 |
| Move Bolero | Folklore / Bolero | Ballads / Bolero | 0 |
| **Total recording rows updated** |  |  | **385** |

`recording_context` must not be changed by any of these updates.

### ID Preservation Strategy

- Keep Latin Pop ID 29 and change only its `parent_id` and slug.
- Keep Jazz ID 36 as the canonical Jazz ID.
- Remap the one recording using Jazz ID 53 to genre ID 36, then delete ID 53.
- Keep IDs 55, 56, and 57 while promoting them to level 0.
- Keep Bolero ID 51 while changing its parent to Ballads ID 7.
- Create only one new taxonomy row: Pop.

## genre_import_mapping Changes

Exactly 14 current mapping rows need taxonomy target changes.

| Source label | Current target | Proposed target | Context |
|---|---|---|---|
| `acoustic / christian` | Ballads / Latin Pop | Pop / Latin Pop | christian |
| `balada / pop` | Ballads / Latin Pop | Pop / Latin Pop | secular |
| `christian pop` | Ballads / Latin Pop | Pop / Latin Pop | christian |
| `latin pop` | Ballads / Latin Pop | Pop / Latin Pop | secular |
| `latin pop / ballad` | Ballads / Latin Pop | Pop / Latin Pop | secular |
| `blues / tropical jazz` | Fusion / Jazz ID 53 | Jazz / null | secular |
| `jazz / pop ballad` | Instrumental / Jazz ID 36 | Jazz / null | secular |
| `latin jazz` | Instrumental / Jazz ID 36 | Jazz / null | secular |
| `latin jazz / mambo` | Instrumental / Jazz ID 36 | Jazz / null | secular |
| `bolero` | Folklore / Bolero | Ballads / Bolero | secular |
| `bolero / jazz` | Folklore / Bolero | Ballads / Bolero | secular |
| `latin rock / pop` | Fusion / Rock / Alternative | Rock / null | secular |
| `reggae` | Fusion / Reggae | Reggae / null | secular |
| `tropical reggae` | Fusion / Reggae | Reggae / null | secular |

No current import mapping targets Electronic, so Electronic promotion changes no mapping rows today.

Mappings such as `bachata / pop`, `classical / pop`, `latin pop / merengue`, `merengue / pop`, and `salsa / jazz` should remain unchanged because their current target expresses the dominant musical genre rather than merely matching a word in the source label.

## Proposed Transaction Sequence

1. Begin one database transaction and take an advisory migration lock.
2. Create immutable backups of:
   - `genres`
   - recording taxonomy columns
   - `genre_import_mapping`
3. Assert that Christian is absent from `genres` before proceeding.
4. Insert the new Pop top-level row and capture its generated ID.
5. Reparent Latin Pop ID 29 to Pop and change its slug to `pop-latin-pop`.
6. Reparent Bolero ID 51 to Ballads and change its slug to `ballads-bolero`.
7. Promote Jazz ID 36 by setting `parent_id = NULL`, `level = 0`, name `Jazz`, and slug `jazz`.
8. Update the 82 Instrumental/Jazz recordings to `genre_id = 36`, `subgenre_id = NULL`.
9. Update the one Fusion/Jazz recording to `genre_id = 36`, `subgenre_id = NULL`.
10. Remap mappings that target Jazz ID 36 or ID 53 to main Jazz ID 36 with no subgenre.
11. Delete duplicate Jazz ID 53 after confirming it has no recording or mapping references.
12. Promote ID 55 to main `Rock`, slug `rock`, and update its 301 recordings to `genre_id = 55`, `subgenre_id = NULL`.
13. Promote ID 56 to main `Electronic`, slug `electronic`.
14. Promote ID 57 to main `Reggae`, slug `reggae`.
15. Update the one Latin Pop recording to the new Pop genre while retaining subgenre ID 29.
16. Update the 14 listed `genre_import_mapping` rows using IDs, names, and null subgenres where appropriate.
17. Reassign top-level `sort_order` and `display_order` values.
18. Normalize child `sort_order` values within each parent.
19. Run all validation assertions.
20. Commit only if every assertion passes; otherwise roll back.

Because the recording taxonomy trigger requires the genre/subgenre hierarchy to be valid, each promoted row should be changed to level 0 before updating its recording references. All work remains invisible to other sessions until commit.

## Application Changes Required With the Migration

The database migration should be deployed together with application taxonomy updates:

- Add static genre definitions and public genre pages for Pop, Rock, Reggae, Jazz, and Electronic in `src/lib/genres.ts`.
- Remove Jazz, Rock, Electronic, and Reggae from Fusion aliases where they imply child membership.
- Remove Jazz from Instrumental aliases where it implies child membership.
- Add Bolero to Ballads aliases and remove it from Folklore aliases.
- Update the recording classifier so Pop, Rock, Reggae, Jazz, and Electronic resolve as top-level genres.
- Update classifier validation so it no longer expects Jazz under Instrumental or Rock/Electronic/Reggae under Fusion.
- Update homepage genre ordering or feature flags only if the five promoted genres should appear there.
- Verify `/genres/[slug]`, artist filters, admin genre management, song queries, and archive/search results with the new hierarchy.

## Validation Report Required Before Commit

1. Christian rows in genres: expected zero.
2. Main genres: expected 14 active level-0 rows.
3. Child genres: expected 35 active level-1 rows.
4. Duplicate active names under the same parent: expected zero.
5. Active top-level Jazz rows: expected exactly one.
6. Recordings with invalid genre/subgenre relationships: expected zero.
7. Recordings pointing to deleted Jazz ID 53: expected zero.
8. Mapping rows pointing to deleted Jazz ID 53: expected zero.
9. Christian-context recording count before and after: must remain 119.
10. Total recording count before and after: must remain 17,398.
11. Recording mapping updates: expected 385.
12. Import mapping updates: expected 14.

## Rollback Plan

If validation fails before commit, roll back the transaction.

For a post-deployment rollback:

1. Restore `genres` from the migration-specific backup table.
2. Restore `recordings.genre_id`, `recordings.subgenre_id`, and `recording_context` by recording ID.
3. Restore `genre_import_mapping` from its backup.
4. Restore previous application taxonomy definitions and classifier rules.
5. Re-run relationship and foreign-key validation before reopening writes.

No production data was modified while generating this plan.
