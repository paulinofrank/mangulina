# Historical Report

**Status:** Historical Snapshot (2026-07-03) — Design Addition

**Current Source of Truth:**
- [DATA_GOVERNANCE.md](../../DATA_GOVERNANCE.md)
- [ARCHITECTURAL_DECISIONS.md](../../ARCHITECTURAL_DECISIONS.md)

**Purpose:**
Documents the addition of the `credited_as` nullable text column to the `release_artists` table for preserving exact historical credit text (e.g., "Juan Luis Guerra y 4.40") separately from canonical artist names.

**Note:**
This design enhancement was incorporated into the current governance. This report preserves the development process.

---

# Phase 2: Addition of `credited_as` Column

**Date:** 2026-07-03  
**Status:** ✅ **COLUMN ADDED TO DESIGN — DO NOT DEPLOY UNTIL VERIFIED**  
**Impact:** Phase A table schema, Phase B backfill logic, Phase C TypeScript types

---

## Change Summary

### New Column: `credited_as`
```sql
credited_as text null
```

**Purpose:** Store the exact artist credit as displayed or printed on the release.

### Examples
```
Artist entity: Juan Luis Guerra
credited_as: "Juan Luis Guerra y 4.40"
Reason: Release lists "Juan Luis Guerra y 4.40" as the artist credit

Artist entity: Luny Tunes
credited_as: "Luny Tunes"
Reason: Matches artist.name exactly

No individual artist / Compilation context:
credited_as: "Various Artists"
Reason: Compilation credit; no specific artist entity
```

### Backfill Strategy
```sql
credited_as = artists.name  -- unless better metadata exists
```

If a release has custom metadata with exact credit text, use that instead. For Phase B MVP, backfill from `artists.name`.

---

## What Was Updated

### 1. ✅ PHASE_2_ARCHITECTURE_REVIEW.md

#### Table Definition (Section 2: release_artists)
```sql
CREATE TABLE IF NOT EXISTS public.release_artists (
  ...
  credited_as text,  -- Exact credit text as displayed on release
  ...
)
```

#### Phase A Migration: 20260710_create_release_artists.sql
- Added column definition with comment
- Documented purpose and examples

#### Phase B Migration: 20260711_backfill_release_artists.sql
```sql
INSERT INTO public.release_artists (..., credited_as, ...)
SELECT
  ...,
  a.name as credited_as,  -- Backfill from artist name
  ...
FROM public.releases r
JOIN public.artists a ON a.id = r.release_artist_id
```

#### Phase B Verification Queries
Added queries to verify:
- `credited_as` was populated (not NULL)
- Sample data inspection
- Matching artist.name validation

#### Phase D View
```sql
CREATE OR REPLACE VIEW public.release_artist_view AS
SELECT ...,
  COALESCE(ra.credited_as, a.name) as display_credit
```

#### Helper Function: get_release_artists()
Updated return table to include `credited_as`:
```sql
RETURNS TABLE (
  ...
  credited_as text,
  ...
)
```

### 2. ✅ PHASE_2_SQL_ANALYSIS.sql

#### New Section 16: CREDITED_AS VALIDATION
Added queries to:
- Check population rate of `credited_as`
- Identify custom credits (credited_as ≠ artist.name)
- Inspect null vs. populated values
- Sample custom credit examples
- Find ambiguous compilation contexts

### 3. ✅ PHASE_2_DEPLOYMENT_CHECKLIST.md

#### Phase A Pre-Deployment
Added verification step:
```sql
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'release_artists'
```
**Expected:** `credited_as text null` column exists

#### Phase B Validation
Updated queries to verify:
- credited_as population
- credited_as matches artist.name (for backfill)
- Sample data inspection includes credited_as

#### Success Metrics
Added Phase B checks:
- [x] credited_as populated from artist.name
- [x] No NULL credited_as values

### 4. ✅ Phase C: TypeScript Types
New type definition:
```ts
type ReleaseArtist = {
  ...
  credited_as: string | null;  // Exact credit text; fallback to artist.name
  ...
};
```

Usage example in admin code:
```ts
COALESCE(ra.credited_as, ra.artist?.name)  // Use exact credit if available, fallback to name
```

---

## Semantic Clarity: Why `credited_as`

### The Problem
A release lists an artist as "Juan Luis Guerra y 4.40" but the database artist entity is just "Juan Luis Guerra". Which do we display?

### The Solution
- **Keep artist entity** (`artist_id` → `artists.name`): "Juan Luis Guerra"
- **Store exact credit** (`credited_as`): "Juan Luis Guerra y 4.40"
- **Display logic** uses `credited_as` if available, fallback to `artist.name`

### Use Cases
1. **Album artwork credit:** "Juan Luis Guerra y 4.40" (full ensemble name)
2. **Various artists compilation:** credited_as = "Various Artists"
3. **Simplified entity name:** credited_as preserves original credit text
4. **Feature/collaboration:** credited_as can encode "Luny Tunes featuring Romeo"
5. **International credits:** credited_as preserves localized spelling/formatting

---

## Data Integrity Guarantees

### Backfill Phase (Phase B)
```
credited_as IS NOT NULL  -- Required: every backfilled row must have a credit text
```

The backfill uses `artists.name`, which is always populated.

### Manual Entry Phase (Phase C+)
```
credited_as can be NULL  -- Optional: updated later with exact release credits
```

Admins can populate exact credit text from liner notes, metadata, etc.

### Display Logic (Phase C+)
```
display_credit = COALESCE(credited_as, artist.name)
```

Always shows something; never blank.

---

## Schema Evolution Path

### Phase A (Current: Create table)
```sql
credited_as text null
```
Column exists; empty (until Phase B backfill).

### Phase B (Current: Backfill)
```sql
credited_as = artists.name  -- For all backfilled rows
```
All rows populated from artist name.

### Phase C (Future: Code updates)
```
credited_as displayed if available; fallback to artist.name
```
App queries prefer `credited_as` for display.

### Phase D+ (Future: Data enrichment)
```
Admin users can update credited_as with exact release credits
E.g., from liner notes: "Juan Luis Guerra y 4.40"
```
Store exact credit text as discovered/verified.

---

## Migration Safeguards

### No Data Loss
- Column is nullable
- Backfill uses artist.name (safe, always populated)
- Existing display logic still works (uses fallback)

### Reversibility
- If Phase B fails: `ALTER TABLE release_artists DROP COLUMN credited_as;`
- If Phase C has issues: queries can ignore credited_as and use artist.name

### Validation
Post-backfill queries confirm:
```sql
-- All backfilled rows have a credit text
SELECT COUNT(*) FROM release_artists 
WHERE credited_as IS NULL AND role = 'primary';
-- Expected: 0 rows
```

---

## FAQ

**Q: Why not use a separate `credit_text` field?**  
A: `credited_as` is clearer about purpose: it's the artist-as-credited, not arbitrary text.

**Q: What if credited_as is identical to artist.name?**  
A: That's fine! It's still the exact credit. The column documents what was credited.

**Q: Can credited_as contain special characters?**  
A: Yes. Examples: "4.40", "Various Artists", "feat.", "y", "&", etc.

**Q: Is credited_as always 1:1 with artist_id?**  
A: Not necessarily. Example:
  - Artist: Juan Luis Guerra
  - credited_as: "Juan Luis Guerra y 4.40"
  - One artist; multiple credited-as variants possible (but rare).

**Q: Should credited_as be unique?**  
A: No. Multiple artists could have the same credited_as in compilation context ("Various Artists").

**Q: When do we populate credited_as from release metadata?**  
A: Phase D+ (future). Phase B MVP uses artist.name only.

---

## Deployment Impact

| Phase | Change | Effort |
|-------|--------|--------|
| **A** | Add column definition | Already done |
| **B** | Backfill from artist.name | Already done |
| **C** | Update TypeScript types, app queries | +15 min (types) |
| **D+** | Data enrichment (manual) | Future phase |

**Net impact:** Zero added complexity. Column is backward-compatible.

---

## Deployment Verification

### Phase A Check (Table Creation)
```sql
SELECT COUNT(*) FROM information_schema.columns
WHERE table_name = 'release_artists' AND column_name = 'credited_as';
-- Expected: 1 (column exists)
```

### Phase B Check (Backfill)
```sql
SELECT COUNT(*) FROM release_artists WHERE credited_as IS NULL;
-- Expected: 0 (all rows have credited_as = artist.name)
```

### Phase C Check (App Integration)
```sql
-- Test that display_credit works correctly
SELECT COALESCE(credited_as, artist_name) as display_credit
FROM release_artist_view
LIMIT 10;
-- Expected: all rows have a display_credit value
```

---

## References

- [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) — Full SQL migrations
- [PHASE_2_SQL_ANALYSIS.sql](PHASE_2_SQL_ANALYSIS.sql) — Validation queries
- [PHASE_2_DEPLOYMENT_CHECKLIST.md](PHASE_2_DEPLOYMENT_CHECKLIST.md) — Deployment steps

---

**Status:** ✅ Column design complete | ✅ SQL migrations updated | ⏳ Awaiting deployment approval

**DO NOT DEPLOY PHASE A/B until:**
- [ ] Team confirms `credited_as` is needed
- [ ] Backfill strategy (artist.name) is acceptable for MVP
- [ ] Phase C code can handle nullable `credited_as` (with fallback)
- [ ] All verification queries are understood
