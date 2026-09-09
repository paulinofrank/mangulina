# Role Dictionary

**Mangulina Valid Roles by Credit Level**

This document is the authoritative reference for all valid role names in the Mangulina database. 

**Rule:** Do not invent new role names. Always check this dictionary first.

**Status:** Active  
**Last Updated:** 2026-08-22  
**Authority:** Editorial & Technical Governance

---

## Overview

Roles are organized by credit level (per ADR-001: Three-Level Credit Architecture):

1. **Recording-Level Roles** — Who performed on or technically engineered a specific recording
2. **Work-Level Roles** — Who created or composed the underlying musical work
3. **Release-Level Roles** — Who is credited for an album/single product
4. **Artist-Level Occupations** — What an artist *is*, independent of any single credit

---

## Level 1: Recording-Level Roles

**Table:** `recording_credits`  
**Purpose:** Credits performers and technical professionals on a specific recording

### Performance Roles

| Role | Definition | Example | Notes |
|------|-----------|---------|-------|
| `lead_performer` | Primary vocalist or lead musician on this recording | Juan Luis Díaz (vocals on "Obsesión") | Main performer of the recording |
| `featured_performer` | Prominent guest artist featured on this recording | Usher (featured on "Obsesión Remix") | Secondary main performer |
| `guest_performer` | Guest artist with smaller role on this recording | Guest vocalist on one verse | One-time appearance, not primary |
| `instrumentalist` | General instrumental performer (when role unclear) | Unnamed session guitarist | Generic instrumentalist |
| `vocalist` | Backup or supporting vocalist on this recording | Backing vocals | Not lead, supporting vocal |
| `choir` | Vocal ensemble/chorus on this recording | Gospel choir ensemble | Full vocal group |
| `orchestra` | Full orchestra ensemble on this recording | Philharmonic orchestra | Full orchestral ensemble |

### Legacy/Deprecated Roles

| Role | Definition | Status | Action |
|------|-----------|--------|--------|
| `performer` | Generic performer (no specific type) | ⚠️ LEGACY | DO NOT USE for new entries. Mark for manual review. See legacy_performer_audit query. |

### Instrumental Roles

| Role | Definition | Example | Notes |
|------|-----------|---------|-------|
| `guitar` | Guitarist on this recording | Pedro García (guitar) | Specific instrument |
| `drums` | Drummer/percussionist on this recording | Drummer on track | Specific instrument |
| `piano` | Pianist on this recording | Piano player | Specific instrument |
| `bass` | Bass guitarist/bass player on this recording | Bass player | Specific instrument |
| `trumpet` | Trumpet player on this recording | Trumpet section | Specific instrument |
| `saxophone` | Saxophone player on this recording | Sax solo | Specific instrument |
| `trombone` | Trombone player on this recording | Trombone player | Specific instrument |
| `strings` | String section/ensemble on this recording | String orchestra | Multiple strings |
| `horns` | Horn section on this recording | Brass horns | Multiple horns/brass |
| `percussion` | Percussionist on this recording | Timbales, congas, etc. | General percussion |
| `conductor` | Conductor/director of this recording session | Orchestra conductor | Conducting role |

#### Dominican Traditional Instruments

The three instruments of the merengue típico trio. Added because the general
roles above cannot express them: `percussion` erases the distinction between
güira and tambora, which are different instruments played by different people,
and the accordion had no role at all despite being the lead instrument of the
genre. Use these rather than approximating with `percussion`.

| Role | Definition | Example | Notes |
|------|-----------|---------|-------|
| `accordion` | Accordion player on this recording | Merengue típico accordionist | Lead instrument of merengue típico |
| `guira` | Güira player on this recording | Güirero | Metal scraper; distinct from `percussion` |
| `tambora` | Tambora player on this recording | Tamborero | Two-headed drum; distinct from `percussion` |

### Technical Roles

| Role | Definition | Example | Notes |
|------|-----------|---------|-------|
| `producer` | Producer of this recording/session | Luny Tunes (producer) | Session-level producer |
| `engineer` | Recording engineer for this session | Studio engineer | General recording engineer |
| `recording_engineer` | Recording engineer for this session | Recording engineer | Alternative name for engineer |
| `mixing_engineer` | Engineer who mixed this recording | Mixing engineer | Mix engineer |
| `mixing` | Mixing engineer for this recording | Mix engineer | Alternative name for mixing_engineer |
| `mastering_engineer` | Engineer who mastered this recording | Mastering engineer | Mastering engineer |
| `mastering` | Mastering engineer for this recording | Mastering engineer | Alternative name for mastering_engineer |
| `session_musician` | Session musician on this recording (generic) | Unnamed session player | When specific instrument unclear |
| `arranger` | Arranger of THIS recording (recording-specific arrangement) | Arranged for this version | Recording-specific, not work-level |

---

## Level 2: Work-Level Roles

**Table:** `credited_work_credits`  
**Purpose:** Credits creators and composers of the underlying musical work (same across all recordings)

| Role | Definition | Example | Notes |
|------|-----------|---------|-------|
| `composer` | Composer of the musical work | Juan Luis Guerra (composer of "Bachata Rosa") | Who wrote the music/composition |
| `lyricist` | Lyricist/poet who wrote the lyrics | Songwriter who wrote lyrics | Who wrote the words/lyrics |
| `writer` | Writer of the composition (general) | Song writer | General composer/writer |
| `songwriter` | Songwriter (composer + lyricist) | Song creator | Combined composer-lyricist |
| `orchestrator` | Orchestrator of the work | Work arranger | Who orchestrated the composition |
| `arranger` | Arranger of the work (not recording-specific) | Work arrangement | Work-level arrangement |
| `co-composer` | Co-composer of the work | Multiple composers | Shared composition |
| `co-writer` | Co-writer of the work | Multiple writers | Shared writing |

---

## Level 3: Release-Level Roles

**Table:** `release_artists`  
**Purpose:** Credits artists for an album/single product release

| Role | Definition | Example | Notes |
|------|-----------|---------|-------|
| `primary` | Primary artist for this release | "Juan Luis Guerra" (album artist) | Main release artist |
| `featured` | Featured artist on this release | "Aventura featuring Usher" | Co-primary artist |
| `compilation` | Compilation artist (Various Artists) | "Various Artists" | Compilation designation |
| `various_artists` | Various Artists designation | "Various Artists" | Compilation designation |
| `presenter` | Presenter/curator of this release | Album curator/editor | Who presented/curated |

---

## Level 4: Artist-Level Occupations

**Table:** `artists`  
**Column:** `occupations` (jsonb array of strings)  
**Purpose:** Describes what an artist *is*, independent of any single recording, work, or release

Unlike Levels 1–3, these are not credits on a specific item. They answer "what does this
person do?" rather than "what did they do on this track?"

**Field hygiene:** `occupations` must not repeat `artists.primary_role`. If `primary_role`
is `singer`, do not also list `singer` or `vocalist` in `occupations`.

**Rendering:** Values are translated by `translateRoleLikeValue()` in
`src/components/organisms/ArtistFactsCard.tsx`, which lowercases the value and replaces
spaces and hyphens with underscores to build the key `artistFields.roles.<value>`. Every
value below therefore requires matching entries in `messages/en.json` and `messages/es.json`.
Unknown values fall back to the raw string, so a missing key degrades to untranslated text
rather than an error — but shipping without the key violates the i18n rule in CLAUDE.md.

`occupations` also drives a directory facet filter (`src/lib/artistDirectoryData.ts`), so the
stored string must match exactly across artists.

| Occupation | Definition | Example | Notes |
|------------|-----------|---------|-------|
| `songwriter` | Writes songs (lyrics and/or music) | Averly Morillo | Distinct from work-level `composer` credit |
| `composer` | Composes musical works | Juan Luis Guerra | |
| `lyricist` | Writes lyrics | | |
| `arranger` | Writes arrangements | | |
| `producer` | Produces recordings | | |
| `bandleader` | Leads an ensemble | Johnny Ventura | |
| `conductor` | Conducts an ensemble | | |
| `musician` | General instrumental practice | Michel Camilo | Prefer a specific instrument when known |
| ~~`instrumentalist`~~ | **Retired 2026-09-09.** Not popular usage: to a reader, someone who plays an instrument is a musician. Use `musician`, and the specific instrument in `instruments`. | | The 38 rows that carried it as `primary_role` were swept in migration `20260909012600`. The identically named **recording credit role** in the Decision Rules below is a different vocabulary and stays. |
| `accordionist` · `bassist` · `drummer` · `guitarist` · `percussionist` · `pianist` · `saxophonist` · `violinist` | Instrument-specific practice | | |
| `dj` | DJ | | |
| `singer-songwriter` | Performs own material | | Renders via key `singer_songwriter` |
| `vocal coach` | Trains other singers' technique professionally | Lorens Salcedo | Teaching practice, not a performance credit |
| `music educator` | Teaches music formally — academy, conservatory, or school | Lorens Salcedo | Use for institutional or sustained teaching work |
| `actress` · `writer` | Non-musical professional practice | Adalgisa Pantaleón | Only when notable and documented |

**On `vocal coach` vs. `music educator`:** `vocal coach` is specific to voice — technique,
placement, repertoire coaching for singers. `music educator` is broader institutional teaching.
An artist who founded and runs a singing academy warrants both; a session musician who takes
private students warrants neither unless the teaching is a documented part of their public work.

---
## Decision Rules

### When in Doubt: Use Explicit Roles

**DON'T:** Use generic `performer` — this is a legacy role that must be manually reviewed  
**DON'T:** Use generic `instrumentalist` unless truly no other information available  
**DO:** Use specific roles: `lead_performer`, `featured_performer`, `guest_performer`, `vocalist`, `guitar`, `drums`, `orchestra`, `choir`, etc.

**IMPORTANT:** The role `performer` exists in legacy data (13 rows as of 2026-07-05) but should NOT be used for new entries. New entries MUST use explicit performer types.

### Performer Type Decisions

**Q: Is this the main performer on this recording?**
- Yes → `lead_performer`
- No (but prominent) → `featured_performer`
- No (guest appearance) → `guest_performer`

**Q: Is this a specific instrument?**
- Yes → Use specific role (`guitar`, `drums`, `piano`, etc.)
- No → Use `instrumentalist`

**Q: Is this a vocal ensemble?**
- Yes → Use `choir` (not `vocalist`)

**Q: Is this a full orchestra?**
- Yes → Use `orchestra` (not `instrumentalist`)

### Recording-Level vs. Work-Level: The Test

**Recording-Level Questions:**
- "Did this person perform on or engineer THIS SPECIFIC recording?"
- "Would I need to list different people for each recording of this work?"
- If YES → Recording-level role (use Level 1 roles)

**Work-Level Questions:**
- "Did this person create/compose the underlying work?"
- "Would this credit be the same across ALL recordings of this work?"
- If YES → Work-level role (use Level 2 roles)

### Examples

| Scenario | Role | Level | Reason |
|----------|------|-------|--------|
| Juan Luis Díaz sang lead on "Obsesión" studio recording | `lead_performer` | Recording | This specific performance |
| Juan Luis Díaz sang lead on "Obsesión" live version | `lead_performer` | Recording | Different performance, same work |
| Luny Tunes COMPOSED "Obsesión" | `composer` | Work | Same across all recordings |
| Luny Tunes PRODUCED Aventura's recording of "Obsesión" | `producer` | Recording | This session only |
| Aventura's version of "Obsesión" credits both Luny Tunes and Juan Luis Díaz | Both levels | Mixed | Composer (work) + producer (recording) |

---

## Migration Rules

### Adding New Roles

To add a new role to this dictionary:

1. **Determine the level** (Recording, Work, or Release)
2. **Check for duplicates** — Search this document first
3. **Define it clearly** — Include definition and example
4. **Update migration** — Create SQL migration to add role validation
5. **Update documentation** — Add to this dictionary with authority
6. **Update code comments** — Reference this dictionary where roles are used

### Renaming Roles

To rename a role:

1. **Create new migration** — Add new role name
2. **Backfill data** — UPDATE existing rows to new name
3. **Deprecate old role** — Add comment that old name is deprecated
4. **Wait 1 release** — Allow time for downstream to update
5. **Remove old role** — Drop old role from validation

### Removing Roles

To remove a role:

1. **Check for usage** — Query database for records using this role
2. **Migrate data** — Move records to appropriate roles
3. **Update consumers** — Ensure queries don't expect removed role
4. **Remove from validation** — Update CHECK constraints
5. **Update this dictionary** — Mark as removed with date

---

## Current Usage

### Recording-Level Roles Currently Used

From initial data audit (2026-07-05):
- `performer` — 13 rows (LEGACY, marked for manual review, NOT migrated)
- New entries must use explicit roles: `lead_performer`, `featured_performer`, `guest_performer`, etc.

### Work-Level Roles Currently Used

None (table `credited_work_credits` created in Phase 3C but not yet populated)

### Release-Level Roles Currently Used

From Phase 3B:
- `primary` — Actively used
- `featured` — Ready for use
- `compilation` — Ready for use
- `various_artists` — Ready for use
- `presenter` — Ready for use

### Legacy Data Notes

**Role `performer` (13 rows in recording_credits):**
- Preserved as-is (not migrated)
- Status: Requires manual review
- Action: Editors should review and update each row to specific performer type (lead_performer, featured_performer, guest_performer, etc.)
- Timeline: Can be addressed in Phase 3C-B when building admin UI
- Query: Use `legacy_performer_audit()` to list all legacy performer rows for review

---

## Version History

| Date | Version | Change | Authority |
|------|---------|--------|-----------|
| 2026-07-05 | 1.0 | Initial dictionary created | Phase 3C Governance |
| 2026-08-22 | 1.1 | Level 4 (artist-level `occupations`) documented; added `vocal coach` and `music educator` with en/es translation keys | Editorial request |
| | | 13 `performer` rows migrated to `lead_performer` | Phase 3C Implementation |
| | | Recording-level roles defined | DATA_GOVERNANCE.md § 8 |
| | | Work-level roles defined | DATA_GOVERNANCE.md § 8 |
| | | Release-level roles defined | Phase 3B Release Artists |

---

## References

See also:
- **DATA_GOVERNANCE.md § 8** — Credit architecture explanation
- **ARCHITECTURAL_DECISIONS.md ADR-001** — Three-level credit system rationale
- **EDITORIAL_GUIDELINES.md** — When to create vs. merge artist entries
- **AI_INSTRUCTIONS.md § Rule 3** — "Do not invent new role names"

---

## Governance

**This dictionary is authoritative.**

- ✅ All roles must be listed here
- ✅ No role can be used without an entry in this dictionary
- ✅ Code changes that introduce new roles require updates to this dictionary
- ✅ Migration files must validate roles against this dictionary
- ✅ Disputes about roles are resolved by updating this dictionary

**Authority:** Phase 3C Implementation & Editorial Governance  
**Last Reviewed:** 2026-07-05  
**Next Review:** After each phase adds new roles
