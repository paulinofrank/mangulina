# Phase 3A Validation Plan

**Status:** Ready for validation  
**Date:** 2026-07-04  
**Scope:** Release Artists table - complete Phase A validation

---

## Pre-Validation Checklist

Before running validation, ensure:

- [ ] Migrations have been applied to Supabase database
- [ ] You have database access (admin or appropriate role)
- [ ] Supabase CLI or database client (psql/pgAdmin) is available
- [ ] All three Phase A migration files are applied in order:
  1. 20260704000000_create_release_artists_table.sql
  2. 20260704000001_release_artists_verification.sql (read-only)
  3. 20260704000002_release_artists_helper_functions.sql

---

## Validation Steps

### 1. Confirm release_artists Table Exists

**Run this query:**

```sql
SELECT 
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'release_artists';
```

**Expected Result:**
- Single row with table_name='release_artists' and table_type='BASE TABLE'

**Status:** ☐ PASS / ☐ FAIL

---

### 2. Confirm Columns Include credited_as

**Run this query:**

```sql
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'release_artists'
ORDER BY ordinal_position;
```

**Expected Columns:**
- `id` (UUID, NOT NULL)
- `release_id` (UUID, NOT NULL)
- `artist_id` (UUID, NOT NULL)
- `role` (TEXT, NOT NULL)
- `credited_as` (TEXT, YES nullable) ← **CRITICAL**
- `display_order` (INTEGER, YES nullable)
- `created_at` (TIMESTAMP WITH TIME ZONE, NOT NULL)
- `updated_at` (TIMESTAMP WITH TIME ZONE, NOT NULL)

**Status:** ☐ PASS / ☐ FAIL

---

### 3. Confirm Indexes Exist

**Run this query:**

```sql
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public' AND tablename = 'release_artists'
ORDER BY indexname;
```

**Expected Indexes:**
- `release_artists_pkey` (primary key on id)
- `idx_release_artists_release_id`
- `idx_release_artists_artist_id`
- `idx_release_artists_role`
- `release_artists_release_id_artist_id_role_key` (unique constraint)

**Status:** ☐ PASS / ☐ FAIL

---

### 4. Confirm Constraints Exist

**Run this query:**

```sql
SELECT
    constraint_name,
    constraint_type,
    column_name
FROM information_schema.table_constraints
JOIN information_schema.key_column_usage 
    ON table_constraints.constraint_name = key_column_usage.constraint_name
WHERE table_schema = 'public' AND table_name = 'release_artists'
ORDER BY constraint_type, constraint_name;
```

**Expected Constraints:**
- PRIMARY KEY on `id`
- UNIQUE on `(release_id, artist_id, role)`
- FOREIGN KEY `release_id` → `releases(id)` with CASCADE DELETE
- FOREIGN KEY `artist_id` → `artists(id)` with RESTRICT Delete
- CHECK constraint on `role` (values: primary, featured, compilation, various_artists, presenter)

**Status:** ☐ PASS / ☐ FAIL

---

### 5. Confirm RLS Policies Exist

**Run this query:**

```sql
SELECT
    tablename,
    policyname,
    permissive,
    roles,
    qual,
    with_check
FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'release_artists'
ORDER BY policyname;
```

**Expected Policies:**
- `release_artists_select_published` (SELECT for published releases)
- `release_artists_select_authenticated` (SELECT for authenticated users)
- `release_artists_manage_admin` (ALL for admin users)

**Status:** ☐ PASS / ☐ FAIL

---

### 6. Confirm RLS is Enabled

**Run this query:**

```sql
SELECT
    tablename,
    rowsecurity
FROM pg_tables
WHERE schemaname = 'public' AND tablename = 'release_artists';
```

**Expected Result:**
- `rowsecurity` = true

**Status:** ☐ PASS / ☐ FAIL

---

### 7. Confirm Helper Function get_release_artists Exists

**Run this query:**

```sql
SELECT
    routine_name,
    routine_type,
    data_type
FROM information_schema.routines
WHERE routine_schema = 'public' AND routine_name = 'get_release_artists'
ORDER BY routine_name;
```

**Expected Result:**
- Function `get_release_artists` exists with routine_type='FUNCTION'

**Test it:**

```sql
-- Test with any release_id from your database
SELECT * FROM public.get_release_artists(
    (SELECT id FROM public.releases LIMIT 1)
);
```

**Expected Result:**
- Returns columns: artist_id, artist_name, artist_slug, role, credited_as, display_order
- Ordered by display_order and role
- No errors

**Status:** ☐ PASS / ☐ FAIL

---

### 8. Confirm Other Helper Functions Exist

**Run this query:**

```sql
SELECT routine_name
FROM information_schema.routines
WHERE routine_schema = 'public' 
  AND routine_name LIKE 'get_%release%'
ORDER BY routine_name;
```

**Expected Functions:**
- `get_release_artists`
- `get_release_artist_credit`
- `get_artist_releases`
- `get_primary_release_artist`
- `get_release_credit_count`

**Status:** ☐ PASS / ☐ FAIL

---

### 9. Confirm Backfill Worked - Row Count

**Run this query:**

```sql
-- Count rows in release_artists
SELECT COUNT(*) as total_release_artists
FROM public.release_artists;

-- Count source rows for backfill
SELECT COUNT(*) as releases_with_release_artist_id
FROM public.releases
WHERE release_artist_id IS NOT NULL;
```

**Expected Result:**
- `total_release_artists` should be >= `releases_with_release_artist_id`
- Non-zero count indicates successful backfill

**Status:** ☐ PASS / ☐ FAIL

---

### 10. Confirm Backfill Data Integrity

**Run this query:**

```sql
-- Detailed backfill validation
WITH backfilled AS (
    SELECT COUNT(*) as count
    FROM public.release_artists
    WHERE role = 'primary'
),
source AS (
    SELECT COUNT(*) as count
    FROM public.releases
    WHERE release_artist_id IS NOT NULL
)
SELECT
    source.count as "Releases with release_artist_id",
    backfilled.count as "Backfilled to release_artists",
    CASE
        WHEN source.count = backfilled.count THEN '✓ MATCH'
        WHEN backfilled.count >= source.count THEN '⚠ MORE (duplicates?)'
        ELSE '✗ FEWER (missing data)'
    END as "Backfill Status"
FROM source, backfilled;
```

**Expected Result:**
- Status shows "✓ MATCH" or "⚠ MORE" (more is acceptable if there are additional credits)
- Never "✗ FEWER"

**Status:** ☐ PASS / ☐ FAIL

---

### 11. Confirm Backward Compatibility - Legacy Field

**Run this query:**

```sql
-- Verify releases.release_artist_id still exists
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' 
  AND table_name = 'releases'
  AND column_name = 'release_artist_id';

-- Show sample data still there
SELECT
    id,
    title,
    release_artist_id
FROM public.releases
WHERE release_artist_id IS NOT NULL
LIMIT 5;
```

**Expected Result:**
- Column `release_artist_id` still exists (NOT DROPPED)
- Legacy data still in `releases` table
- No breaking changes

**Status:** ☐ PASS / ☐ FAIL

---

### 12. Confirm No App Code is Broken

**Run:**

```bash
npm run build
```

**Expected Result:**
- Build completes successfully with no errors
- No TypeScript type errors
- No missing dependencies

**Status:** ☐ PASS / ☐ FAIL

**If build fails:**
- Report error output
- Check if migration breaking any type definitions

---

### 13. Data Integrity Checks

**Run all verification queries from migration 20260704000001:**

Key checks to verify:
- No orphaned foreign key references
- No duplicates in (release_id, artist_id, role)
- No inconsistencies between legacy field and new table

**Status:** ☐ PASS / ☐ FAIL

---

## Validation Summary

### All Checks Passed?

After running all validations above:

- [ ] Step 1: Table exists
- [ ] Step 2: Columns correct (including credited_as)
- [ ] Step 3: Indexes exist
- [ ] Step 4: Constraints exist
- [ ] Step 5: RLS policies exist
- [ ] Step 6: RLS enabled
- [ ] Step 7: get_release_artists function works
- [ ] Step 8: All helper functions exist
- [ ] Step 9: Backfill row count non-zero
- [ ] Step 10: Backfill data integrity confirmed
- [ ] Step 11: Legacy field still intact (backward compatible)
- [ ] Step 12: App build succeeds
- [ ] Step 13: No data integrity issues

---

## Warnings to Check

**None Expected** if migrations applied correctly.

**Possible Warnings:**

1. **Different row count in backfill** 
   - OK if more (additional credits exist)
   - PROBLEM if fewer (data missing)

2. **RLS policies not found**
   - CRITICAL - queries may fail
   - Check migration applied fully

3. **Helper functions missing**
   - WARNING - app queries may need to use raw SQL temporarily
   - Migration 20260704000002 may not have applied

4. **Build fails**
   - CRITICAL - check which files have type errors
   - May indicate migration broke schema assumptions

---

## Next Steps

**If All Checks Pass:**
- Phase A is **SAFE TO ACCEPT**
- Ready to proceed to Phase B (app queries + admin UI)

**If Any Check Fails:**
- Do NOT proceed to Phase B
- Investigate specific failure
- May need to rollback and fix migration

---

## How to Report Results

Please provide:

1. **Validation Matrix** (copy the checkboxes above with marks)
2. **Sample query results** for key validations
3. **Build output** (success or error)
4. **Any warnings** encountered
5. **Final decision:** Phase A APPROVED or NEEDS INVESTIGATION

---

**Phase A Status:** Ready for Validation  
**Created:** 2026-07-04  
**Authority:** Phase 3 Implementation Plan
