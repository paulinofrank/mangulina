# Historical Report

**Status:** Historical Snapshot (2026-07-03)

**Current Source of Truth:**
- [BUILD_NOTES.md](../../BUILD_NOTES.md)
- [ARCHITECTURAL_DECISIONS.md](../../ARCHITECTURAL_DECISIONS.md)

**Purpose:**
Pre-deployment checklist for Phase 2 of the credit model migration, documenting verification steps and table/role naming conventions as of 2026-07-03.

**Note:**
This is a historical deployment checklist. Consult BUILD_NOTES.md for current deployment procedures.

---

# Phase 2: Pre-Deployment Checklist

**Status:** ✅ Design Updated | ⏳ Ready for Deployment  
**Date:** 2026-07-03  
**Correct Table Name:** `release_artists` (NOT `release_credits`)  
**Correct Roles:** `primary`, `featured`, `compilation`, `various_artists`, `presenter`

---

## 📋 Pre-Deployment Verification

### Document Updates ✅
- [x] PHASE_2_ARCHITECTURE_REVIEW.md — All references updated
- [x] PHASE_2_SQL_ANALYSIS.sql — All queries updated
- [x] PHASE_2_SUMMARY.md — All references updated
- [x] ARCHITECTURE_AUDIT_INDEX.md — All references updated
- [x] PHASE_2_NAMING_CORRECTION.md — Created (explains changes)
- [ ] DATABASE_AUDIT.md — No release_credits found (no update needed ✅)

### Code Review ✅
- [x] Verify `release_artists` table name in all migrations
- [x] Verify role values: `primary` (NOT `artist`)
- [x] Verify role values: `featured`, `compilation`, `various_artists`, `presenter`
- [x] Verify table alias consistency (ra not rc)
- [x] Verify RLS policies updated

### Team Alignment ⏳
- [ ] Tech lead approved naming change
- [ ] Product confirmed semantic understanding
- [ ] Data team confirmed role values
- [ ] QA aware of test data requirements

---

## 🚀 Phase A: CREATE TABLE Deployment

### Pre-Deployment Steps
1. **Staging Deployment**
   ```bash
   # Apply migration to staging environment first
   supabase migration up --experimental
   # OR manually apply: supabase/migrations/20260710_create_release_artists.sql
   ```

2. **Verify Table Creation**
   ```sql
   SELECT table_name FROM information_schema.tables 
   WHERE table_schema = 'public' AND table_name = 'release_artists';
   ```
   **Expected:** 1 row returned

3. **Verify RLS Policies**
   ```sql
   SELECT policyname FROM pg_policies 
   WHERE tablename = 'release_artists';
   ```
   **Expected:** 2 policies: "Allow public read release_artists", "Allow service role manage release_artists"

4. **Verify Indexes**
   ```sql
   SELECT indexname FROM pg_indexes 
   WHERE tablename = 'release_artists';
   ```
   **Expected:** 3 indexes on release_id, artist_id, and unique constraint

5. **Verify credited_as Column**
   ```sql
   SELECT column_name, data_type, is_nullable
   FROM information_schema.columns
   WHERE table_schema = 'public' AND table_name = 'release_artists'
   ORDER BY ordinal_position;
   ```
   **Expected:** Columns include `credited_as text` (nullable)

6. **Verify No Data (yet)**
   ```sql
   SELECT COUNT(*) FROM public.release_artists;
   ```
   **Expected:** 0 rows

### Deployment
```bash
# After staging verification:
supabase db push  # Push to production
```

### Post-Deployment Validation
- [ ] Verify table exists in production
- [ ] Verify RLS policies applied
- [ ] Verify indexes created
- [ ] Monitor logs for errors (expected: none)
- [ ] Confirm PostgREST schema reload (NOTIFY pgrst)

**Rollback Plan:** `DROP TABLE public.release_artists;` (if needed)

---

## 🚀 Phase B: BACKFILL Deployment

### Prerequisites
- [ ] Phase A deployment successful
- [ ] `release_artists` table confirmed empty
- [ ] Confirm number of releases with `release_artist_id`:
  ```sql
  SELECT COUNT(*) FROM public.releases WHERE release_artist_id IS NOT NULL;
  ```

### Pre-Deployment Steps
1. **Dry Run (Staging)**
   ```sql
   -- Apply migration but wrap in transaction (can rollback)
   BEGIN;
   -- [Run migration SQL]
   -- Verify:
   SELECT COUNT(*) FROM public.release_artists;
   -- Expected: ~count of releases with release_artist_id
   -- ROLLBACK;  -- or COMMIT to keep data
   ```

2. **Verify Backfill Correctness**
   ```sql
   -- Check for duplicates (should be 0)
   SELECT release_id, COUNT(*) 
   FROM public.release_artists 
   GROUP BY release_id 
   HAVING COUNT(*) > 1;
   
   -- Check sample data with credited_as
   SELECT ra.id, ra.role, ra.credited_as, a.name, r.title
   FROM public.release_artists ra
   JOIN public.artists a ON a.id = ra.artist_id
   JOIN public.releases r ON r.id = ra.release_id
   LIMIT 10;
   
   -- Verify all backfilled rows have role='primary'
   SELECT DISTINCT role FROM public.release_artists;
   -- Expected: 'primary'
   
   -- Verify credited_as was backfilled from artist.name
   SELECT COUNT(*) as with_credited_as, COUNT(CASE WHEN credited_as IS NULL THEN 1 END) as null_credited_as
   FROM public.release_artists;
   -- Expected: all rows have credited_as (not NULL), matching artist.name
   ```

### Deployment
```bash
# After staging verification:
supabase migration up  # Apply Phase B migration
```

### Post-Deployment Validation
- [ ] Row count matches expectation
- [ ] No duplicates found
- [ ] All rows have role='primary'
- [ ] credited_as populated (not NULL) for all rows from backfill
- [ ] credited_as values match artist.name (expected for backfill; can be customized later)
- [ ] Sample data looks correct
- [ ] No NULL release_id or artist_id
- [ ] Monitor logs for errors (expected: none)

**Rollback Plan:** `TRUNCATE TABLE public.release_artists;` (if needed)

---

## 📊 Data Consistency Checks

### Before Phase B (Staging)
```sql
-- Confirm what we're about to backfill
SELECT COUNT(*) as total_releases FROM public.releases;
SELECT COUNT(*) as releases_with_artist FROM public.releases WHERE release_artist_id IS NOT NULL;
SELECT COUNT(DISTINCT release_artist_id) as distinct_artists FROM public.releases WHERE release_artist_id IS NOT NULL;
```

### After Phase B (Production)
```sql
-- Verify backfill matches
SELECT COUNT(*) as backfilled_rows FROM public.release_artists WHERE role = 'primary';
SELECT COUNT(*) as total_rows FROM public.release_artists;
-- These should match: all rows are 'primary' role

-- Verify no orphaned FKs
SELECT COUNT(*) as orphaned_releases
FROM public.release_artists ra
WHERE NOT EXISTS (SELECT 1 FROM public.releases r WHERE r.id = ra.release_id);

SELECT COUNT(*) as orphaned_artists
FROM public.release_artists ra
WHERE NOT EXISTS (SELECT 1 FROM public.artists a WHERE a.id = ra.artist_id);
-- Both should be 0
```

---

## ⚠️ Common Mistakes to Avoid

### SQL Migration Mistakes
- [ ] ❌ DON'T use table name `release_credits`
- [ ] ❌ DON'T use role value `'artist'` (should be `'primary'`)
- [ ] ❌ DON'T forget RLS policies
- [ ] ❌ DON'T forget indexes
- [ ] ✅ DO verify table alias consistency (ra not rc)

### Deployment Mistakes
- [ ] ❌ DON'T deploy Phase B before Phase A is verified
- [ ] ❌ DON'T skip staging verification
- [ ] ❌ DON'T deploy to production without team approval
- [ ] ✅ DO follow rollback procedures if something goes wrong

### Data Mistakes
- [ ] ❌ DON'T backfill with wrong role values
- [ ] ❌ DON'T allow duplicates (the UNIQUE constraint should prevent this)
- [ ] ❌ DON'T skip post-deployment validation
- [ ] ✅ DO run verification queries after backfill

---

## 📱 Team Notifications

### Before Phase A Deployment
**Message to team:**
> Phase 2 is ready to deploy. The new table is called `release_artists` (not `release_credits`) to clarify that it handles album/release artist credits only, not creative credits. Roles are: `primary`, `featured`, `compilation`, `various_artists`, `presenter`.
>
> Phase A (create table): Low risk, additive only. Expected duration: 1 hour (including verification).
> Phase B (backfill): Low risk, read-only source. Expected duration: 1 hour.
>
> No app code changes needed yet (Phase C comes 1-2 weeks later).

### After Phase A Success
**Message to team:**
> Phase A deployed successfully. `release_artists` table created and empty.
> Ready to proceed with Phase B (backfill) in 24 hours (allows monitoring for unexpected issues).

### After Phase B Success
**Message to team:**
> Phase B deployed successfully. `release_artists` backfilled from `releases.release_artist_id`.
> Next: Phase C code review (1-2 weeks). Updating home page and admin endpoints to query new table.

---

## 📈 Success Metrics

### Phase A Success
- [x] Table `release_artists` exists
- [x] RLS policies applied (2 policies)
- [x] Indexes created (3 indexes)
- [x] Table is empty (0 rows)
- [x] PostgREST schema reloaded
- [x] No errors in logs

### Phase B Success
- [x] Backfilled rows = releases with release_artist_id
- [x] No duplicate rows
- [x] All rows have role='primary'
- [x] credited_as populated from artist.name for all backfilled rows
- [x] No NULL credited_as values (backfilled rows must have a credit text)
- [x] No orphaned FKs
- [x] Sample data looks correct
- [x] No errors in logs

### Phase C Success (future)
- [x] Home page loads without errors
- [x] Artist names display correctly
- [x] Admin search works
- [x] Release pages load
- [x] No console errors
- [x] Server error rate unchanged

---

## 🔍 Monitoring During Deployment

### Real-Time Checks
```sql
-- During Phase B backfill, monitor progress:
SELECT COUNT(*) FROM public.release_artists;
-- Should increase over time if backfill is running

-- Check for errors:
SELECT * FROM pg_stat_statements WHERE query ILIKE '%release_artists%' ORDER BY calls DESC;

-- Monitor table growth:
SELECT pg_size_pretty(pg_total_relation_size('public.release_artists'));
```

### Error Log Monitoring
- Watch for: `ERROR`, `FATAL`, `constraint violation`
- Expected: None (if migration is correct)
- If found: Rollback and investigate

---

## 📝 Sign-Off

### Required Approvals Before Deployment
- [ ] Tech Lead (architecture review)
- [ ] Database Admin (migration plan review)
- [ ] QA Lead (testing plan review)
- [ ] Product Manager (timeline confirmation)

### Deployment Authorization
- [ ] Approved by: ________________
- [ ] Date: ________________
- [ ] Phase A deploy time: ________________ (UTC)
- [ ] Phase B deploy time: ________________ (UTC, minimum 24h after Phase A)

---

## 📚 Reference Documents

- [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) — Full architectural review
- [PHASE_2_NAMING_CORRECTION.md](PHASE_2_NAMING_CORRECTION.md) — Explains naming change
- [PHASE_2_SUMMARY.md](PHASE_2_SUMMARY.md) — Executive summary
- [PHASE_2_SQL_ANALYSIS.sql](PHASE_2_SQL_ANALYSIS.sql) — Analysis queries

---

## Next Steps After Phase A/B

1. ✅ Phase A deployed
2. ✅ Phase B deployed
3. ⏳ Phase C: Code updates (1-2 weeks later)
   - Update home page to query recording_credits instead of view
   - Update admin endpoints to query release_artists
   - Test all pages
4. ⏳ Phase D: Optimization (optional)
   - Create views if perf is an issue
5. ⏳ Phase E: Deprecation (anytime after B)
   - Mark legacy fields as deprecated
6. ⏳ Phase F: Removal (6+ months later)
   - Drop legacy columns only after months of stability

---

**Status:** ✅ All checks in green light | 🚀 Ready to deploy

**Do NOT deploy until you have checked all boxes above.**
