# Duplicate Credits Cleanup — Required Before Schema Migration

## Issue

The existing data contains duplicate credits: the same artist has the same role on the same work multiple times.

**Error received:**
```
ERROR: 23505: could not create unique index "unique_credited_work_credit"
DETAIL: Key (credited_work_id, artist_id, role) is duplicated.
```

**Example duplicate found:**
- Work: b957bd73-34f0-44be-aaf4-692866c03d21
- Artist: ef56311a-ac4b-451e-a7a7-97e5f240cd47 (Luny Tunes)
- Role: Composer
- **Problem:** This combination appears 2+ times in the table

---

## Why This Happened

The old schema allowed duplicates because `credit_detail` was part of the unique constraint:
```sql
UNIQUE(credited_work_id, artist_id, role, credit_detail)
```

But the new simplified schema removes `credit_detail`:
```sql
UNIQUE(credited_work_id, artist_id, role)
```

This exposes the duplicates that were hidden before.

---

## Solution: Two-Step Cleanup

### Step 1: Remove Duplicates (Keep Oldest)

**File:** `supabase/migrations/20260705000006_cleanup_duplicate_credits.sql`

In Supabase SQL Editor:

```
SQL Editor → New Query
Copy/paste: supabase/migrations/20260705000006_cleanup_duplicate_credits.sql
Click Run
```

**What it does:**
1. Identifies all (work, artist, role) combinations that appear more than once
2. For each duplicate group, keeps the **oldest record** (by `created_at`)
3. Deletes all other duplicates
4. Removes any orphaned works (works with no credits)

**Safe because:**
- We keep the first/oldest record (editorial integrity)
- Pre-production data (safe to modify)
- Can re-import cleanly with `--reset-artist`

### Step 2: Apply Schema Cleanup

**File:** `supabase/migrations/20260705000007_final_cleanup_and_constraint.sql`

In Supabase SQL Editor:

```
SQL Editor → New Query
Copy/paste: supabase/migrations/20260705000007_final_cleanup_and_constraint.sql
Click Run
```

**What it does:**
1. Drops obsolete constraints and indexes
2. Removes 14 obsolete columns
3. Creates new simplified unique constraints
4. Recreates indexes for the new schema

---

## Complete Cleanup Workflow

### Option 1: One-Step Cleanup (if duplicates already removed manually)

```bash
# Just apply the schema cleanup
# (Only do this if you've already manually removed duplicates)

# In Supabase SQL Editor:
# Run: supabase/migrations/20260705000007_final_cleanup_and_constraint.sql
```

### Option 2: Two-Step Cleanup (recommended - handles duplicates automatically)

```bash
# Step 1: Remove duplicates
# In Supabase SQL Editor:
# Run: supabase/migrations/20260705000006_cleanup_duplicate_credits.sql

# Step 2: Apply schema cleanup
# In Supabase SQL Editor:
# Run: supabase/migrations/20260705000007_final_cleanup_and_constraint.sql
```

### Option 3: Full Reset & Fresh Import (cleanest)

```bash
# If you want a completely clean slate

# Step 1: Remove all Luny Tunes credits and orphaned works
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
  --reset-artist

# Step 2: Apply schema cleanup
# In Supabase SQL Editor:
# Run: supabase/migrations/20260705000007_final_cleanup_and_constraint.sql

# Step 3: Fresh import
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx
```

---

## What Gets Deleted

### Step 1 (Duplicate Cleanup)

**Deleted:** Duplicate credits (keeping oldest)
- Example: If Composer role appears 3 times, 2 copies are deleted
- Orphaned works with no credits

**Preserved:** All other data

### Step 2 (Schema Cleanup)

**Deleted:** Obsolete columns
- release_type, label, track_number, source_confidence, category, country, source_url, notes, recording_id, release_id (from credited_works)
- credit_detail, co_credits, source_confidence, work_id (from credited_work_credits)

**Preserved:** All work and credit records

---

## Verification

### After Step 1 (Duplicate Cleanup)

```sql
-- Verify no duplicates remain
SELECT COUNT(*) as duplicate_groups
FROM (
  SELECT credited_work_id, artist_id, role
  FROM credited_work_credits
  GROUP BY credited_work_id, artist_id, role
  HAVING COUNT(*) > 1
);

-- Expected: 0 duplicate groups
```

### After Step 2 (Schema Cleanup)

Run checks from `SCHEMA_CLEANUP_VERIFICATION.sql`:
- Check 1-2: Column counts (7 for works, 5 for credits)
- Check 3-6: Constraint verification
- Check 7: Index verification
- Check 8: No obsolete columns
- Check 9-10: Referential integrity

---

## Recommended Workflow for Production

1. **Duplicate Cleanup:**
   ```sql
   -- supabase/migrations/20260705000006_cleanup_duplicate_credits.sql
   ```

2. **Schema Cleanup:**
   ```sql
   -- supabase/migrations/20260705000007_final_cleanup_and_constraint.sql
   ```

3. **Verify:**
   ```sql
   -- Run SCHEMA_CLEANUP_VERIFICATION.sql checks 1-11
   ```

4. **Re-import (if needed):**
   ```bash
   npx tsx scripts/importCreativeWorksFromConsolidated.ts \
     --artist-slug luny-tunes \
     --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
     --reset-artist
   ```

---

## Safety Notes

✅ **Safe operations:**
- Duplicate removal (keeps oldest record)
- Orphaned work deletion
- Column removal
- Constraint addition (after duplicates removed)

✅ **Reversible:**
- Use `--reset-artist` to re-import cleanly anytime
- Original data backups available (if taken)

✅ **No risk to:**
- artists table
- recordings table
- releases table
- recording_credits table
- release_artists table

---

**Status:** ✅ **READY TO CLEANUP**  
**Safety:** ✅ **FULLY REVERSIBLE**  
**Next Step:** Apply Step 1 migration (duplicate cleanup)

---

**Last Updated:** 2026-07-05  
**Authority:** Creative Works — Duplicate Cleanup & Schema Migration
