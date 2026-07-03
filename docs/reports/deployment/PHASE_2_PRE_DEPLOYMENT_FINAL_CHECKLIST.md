# Historical Report

**Status:** Historical Snapshot (2026-07-03)

**Current Source of Truth:**
- [BUILD_NOTES.md](../../BUILD_NOTES.md)
- [ARCHITECTURAL_DECISIONS.md](../../ARCHITECTURAL_DECISIONS.md)

**Purpose:**
Final pre-deployment checklist for Phase 2, incorporating all design updates including naming corrections and the `credited_as` column addition.

**Note:**
This is a historical checklist from Phase 2. Consult BUILD_NOTES.md for current deployment procedures.

---

# Phase 2: Final Pre-Deployment Checklist

**Status:** ✅ All Design Updates Complete | ⏳ Ready for Deployment  
**Date:** 2026-07-03  
**Critical Updates:** Naming correction + `credited_as` column addition

---

## ⚠️ DEPLOYMENT HOLD NOTICE

**DO NOT DEPLOY PHASE A/B UNTIL ALL ITEMS CHECKED BELOW**

Recent updates made to Phase A/B design:
1. ✅ Table renamed: `release_credits` → `release_artists`
2. ✅ Roles updated: `['artist']` → `['primary', 'featured', 'compilation', 'various_artists', 'presenter']`
3. ✅ Column added: `credited_as text null`
4. ✅ Documentation updated: all references corrected
5. ✅ SQL migrations updated
6. ✅ Validation queries added

This checklist ensures deployment includes all changes.

---

## Design Verification Checklist

### Phase A: Table Creation

#### Table Name & Purpose
- [ ] Table is named `release_artists` (NOT `release_credits`)
- [ ] Purpose: Artists credited at release/album level only
- [ ] NOT for creative credits (those go to `credited_work_credits`)

#### Column Definition ✅
- [ ] Column `id uuid PRIMARY KEY DEFAULT gen_random_uuid()`
- [ ] Column `release_id uuid NOT NULL FK → releases(id) ON DELETE CASCADE`
- [ ] Column `artist_id uuid NOT NULL FK → artists(id) ON DELETE CASCADE`
- [ ] Column `role text NOT NULL` (NOT nullable)
- [ ] **NEW:** Column `credited_as text` (nullable)
- [ ] Column `display_order integer DEFAULT 0`
- [ ] Column `created_at timestamptz NOT NULL DEFAULT now()`
- [ ] Column `updated_at timestamptz NOT NULL DEFAULT now()`

#### Constraints
- [ ] PRIMARY KEY on `id`
- [ ] FOREIGN KEY on `release_id` (cascade delete)
- [ ] FOREIGN KEY on `artist_id` (cascade delete)
- [ ] UNIQUE constraint on `(release_id, artist_id, role)`

#### Indexes
- [ ] Index on `release_id`
- [ ] Index on `artist_id`
- [ ] Index on `role`
- [ ] Unique index for constraint

#### RLS Policies
- [ ] Policy: "Allow public read release_artists" (SELECT for anon, authenticated)
- [ ] Policy: "Allow service role manage release_artists" (ALL for service_role)

#### RLS Enforcement
- [ ] RLS enabled on table
- [ ] Permissions granted (SELECT, ALL to appropriate roles)

#### Helper Function
- [ ] Function: `get_release_artists(release_id uuid)` created
- [ ] Returns: artist_id, artist_name, **credited_as**, role, display_order
- [ ] Granted to: anon, authenticated, service_role

### Phase B: Backfill

#### Backfill Source
- [ ] Source table: `public.releases`
- [ ] Source column: `releases.release_artist_id`
- [ ] Filter: WHERE `release_artist_id IS NOT NULL`

#### Backfill Values
- [ ] `role` = `'primary'` (NOT `'artist'`)
- [ ] **NEW:** `credited_as` = `artists.name` (via JOIN)
- [ ] `display_order` = `0`
- [ ] `created_at` = `now()`

#### Backfill Query Pattern
```sql
INSERT INTO public.release_artists (..., credited_as, ...)
SELECT ..., a.name as credited_as, ...
FROM public.releases r
JOIN public.artists a ON a.id = r.release_artist_id
WHERE r.release_artist_id IS NOT NULL
```

#### Data Integrity
- [ ] No duplicates in backfill (UNIQUE constraint prevents)
- [ ] No NULL credited_as (all backfilled rows have artist.name)
- [ ] All rows have role='primary'
- [ ] All rows have valid release_id (FK)
- [ ] All rows have valid artist_id (FK)

---

## Documentation Verification Checklist

### Primary Documents
- [ ] PHASE_2_ARCHITECTURE_REVIEW.md — Read completely
  - [ ] Section 2 (release_artists table) includes `credited_as`
  - [ ] Phase A migration has correct column definition
  - [ ] Phase B migration has correct backfill logic
  - [ ] Helper function includes credited_as in return table
  - [ ] Phase D view includes COALESCE(credited_as, artist_name)

- [ ] PHASE_2_SQL_ANALYSIS.sql — Review validation section
  - [ ] New Section 16 (credited_as validation) added
  - [ ] Queries check credited_as population
  - [ ] Queries show custom credits (credited_as ≠ artist_name)

- [ ] PHASE_2_DEPLOYMENT_CHECKLIST.md — Follow these steps
  - [ ] Phase A verification includes `credited_as` column check
  - [ ] Phase B verification includes credited_as population check

### Supporting Documents
- [ ] PHASE_2_NAMING_CORRECTION.md — Explains naming change
- [ ] PHASE_2_CREDITED_AS_ADDITION.md — Explains credited_as column (new)
- [ ] ARCHITECTURE_AUDIT_INDEX.md — Updated references

---

## Code Integration Checklist (Phase C Preparation)

### TypeScript Types
- [ ] Type: `ReleaseArtist` includes all columns
- [ ] Type: `credited_as: string | null;`
- [ ] Type includes role union: `'primary' | 'featured' | 'compilation' | 'various_artists' | 'presenter'`

### Display Logic
- [ ] Code: `COALESCE(credited_as, artist.name)` for display
- [ ] Fallback: artist.name if credited_as is NULL

### Query Updates
- [ ] Home page trending: can query release_artists if needed
- [ ] Admin releases: can query credited_as for display
- [ ] All queries account for nullable credited_as

---

## Data Validation Checklist

### Pre-Backfill
- [ ] Count releases with release_artist_id
  ```sql
  SELECT COUNT(*) FROM public.releases WHERE release_artist_id IS NOT NULL;
  ```
  Note this number → use for post-backfill validation

### Post-Backfill
- [ ] Backfill count matches
  ```sql
  SELECT COUNT(*) FROM public.release_artists WHERE role = 'primary';
  ```
  Should match pre-backfill count

- [ ] All credited_as populated
  ```sql
  SELECT COUNT(*) FROM public.release_artists WHERE credited_as IS NULL;
  ```
  Expected: 0

- [ ] No orphaned FKs
  ```sql
  SELECT COUNT(*) FROM public.release_artists ra
  WHERE NOT EXISTS (SELECT 1 FROM public.releases r WHERE r.id = ra.release_id);
  ```
  Expected: 0

- [ ] Sample data integrity
  ```sql
  SELECT ra.id, ra.role, ra.credited_as, a.name, r.title
  FROM public.release_artists ra
  JOIN public.artists a ON a.id = ra.artist_id
  JOIN public.releases r ON r.id = ra.release_id
  LIMIT 20;
  ```
  Visual inspection: credited_as should match artist name (for backfill)

---

## Deployment Authorization

### Required Approvals
- [ ] **Tech Lead** — Architecture review approved
  - [ ] Reviewed table schema
  - [ ] Approved naming (release_artists, not release_credits)
  - [ ] Approved role values (primary, not artist)
  - [ ] Approved credited_as column addition
  - [ ] Approved backfill strategy (artist.name)
  - Approved by: _________________ Date: _________

- [ ] **Product Manager** — Requirements confirmed
  - [ ] Confirmed release-level artists (not creative credits)
  - [ ] Confirmed credited_as purpose (exact credit text)
  - [ ] Confirmed role values are sufficient
  - [ ] Confirmed backfill from artist.name is acceptable
  - Approved by: _________________ Date: _________

- [ ] **Data/Analytics Team** — Data strategy aligned
  - [ ] Confirmed backfill approach
  - [ ] Confirmed no data loss
  - [ ] Confirmed credited_as semantics
  - Approved by: _________________ Date: _________

- [ ] **QA Lead** — Testing plan reviewed
  - [ ] Pre-deployment verification queries understood
  - [ ] Post-deployment validation understood
  - [ ] Knows what to monitor
  - Approved by: _________________ Date: _________

### Deployment Authorization Sign-Off
**I confirm that:**
- [ ] All updates have been reviewed
- [ ] All approvals above are in place
- [ ] I understand the table schema
- [ ] I understand the backfill strategy
- [ ] I understand the deployment procedure
- [ ] I have a rollback plan (if needed)

**Authorized by:** _________________  
**Title:** _________________  
**Date:** _________________  
**Time (UTC):** _________________  

---

## Phase A Deployment Steps

1. **Stage 1: Pre-flight checks** (15 minutes)
   - [ ] Review migration file: 20260710_create_release_artists.sql
   - [ ] Verify table definition matches checklist above
   - [ ] Verify column named `credited_as text` included
   - [ ] Verify RLS policies defined
   - [ ] Verify helper function created

2. **Stage 2: Deploy to staging** (1 hour)
   ```bash
   supabase migration up --experimental
   # OR manually apply migration
   ```
   - [ ] Monitor logs for errors (expected: none)
   - [ ] Confirm PostgREST schema reload

3. **Stage 3: Staging verification** (30 minutes)
   - [ ] Table exists
   - [ ] RLS policies applied
   - [ ] Indexes created
   - [ ] Helper function available
   - [ ] `credited_as` column exists and is nullable

4. **Stage 4: Deploy to production** (1 hour)
   ```bash
   supabase db push
   ```
   - [ ] Monitor logs for errors
   - [ ] Verify schema updated
   - [ ] No app errors in logs

5. **Stage 5: Post-deployment** (30 minutes)
   - [ ] Verify table in production
   - [ ] Verify RLS policies applied
   - [ ] Verify indexes created
   - [ ] Verify helper function works
   - [ ] Document completion time

**Total Phase A time:** ~3 hours (including monitoring)

---

## Phase B Deployment Steps

**Prerequisite:** Phase A deployed and verified ✅

1. **Stage 1: Pre-flight checks** (15 minutes)
   - [ ] Review migration file: 20260711_backfill_release_artists.sql
   - [ ] Verify backfill uses role='primary' (NOT 'artist')
   - [ ] Verify credited_as = a.name
   - [ ] Verify WHERE clause filters correctly
   - [ ] Verify conflict handling

2. **Stage 2: Dry run on staging** (30 minutes)
   ```sql
   BEGIN;
   -- Run backfill query
   INSERT INTO ... SELECT ...
   -- Check results
   SELECT COUNT(*) FROM public.release_artists;
   SELECT COUNT(*) FROM public.release_artists WHERE credited_as IS NULL;
   -- ROLLBACK to undo
   ```
   - [ ] Row count meets expectation
   - [ ] All credited_as populated
   - [ ] No errors

3. **Stage 3: Deploy to production** (1 hour)
   ```bash
   supabase migration up --experimental
   ```
   - [ ] Monitor logs for errors
   - [ ] Verify data loaded

4. **Stage 4: Post-deployment validation** (1 hour)
   - [ ] Backfill row count matches
   - [ ] No NULL credited_as
   - [ ] No duplicates
   - [ ] No orphaned FKs
   - [ ] Sample data inspection
   - [ ] Document completion

**Total Phase B time:** ~3 hours (including verification)

---

## Rollback Plan

### Phase A Rollback
If Phase A fails:
```sql
DROP TABLE IF EXISTS public.release_artists;
```

Impact: Zero data loss (table is empty anyway)

### Phase B Rollback
If Phase B fails after partial backfill:
```sql
TRUNCATE TABLE public.release_artists;
```

Impact: Reverts backfill; table becomes empty again; can retry

---

## Success Metrics

### Phase A Success
- [x] Table `release_artists` created
- [x] `credited_as` column exists and is nullable
- [x] RLS policies applied
- [x] Indexes created
- [x] Helper function available
- [x] No schema errors

### Phase B Success
- [x] Backfilled rows count correct
- [x] No NULL credited_as values
- [x] All rows role='primary'
- [x] No duplicate rows
- [x] No orphaned FKs
- [x] Sample data looks correct
- [x] No errors in logs

---

## Next Steps (After Deployment)

1. ✅ Phase A/B deployed
2. ⏳ **Wait 24 hours** for stability verification
3. ⏳ Phase C: Code updates (1-2 weeks)
   - Update home page
   - Update admin endpoints
   - Test all pages
4. ⏳ Phase D: Optional (views)
5. ⏳ Phase E: Deprecation (6+ months out)
6. ⏳ Phase F: Removal (6+ months after Phase C)

---

**Final Status:** ✅ Ready to deploy after all boxes are checked

**DO NOT PROCEED unless all items above are verified and authorized.**

---

**Document created:** 2026-07-03  
**Last updated:** 2026-07-03  
**Version:** 1.0
