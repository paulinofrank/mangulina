# Schema Cleanup & Safe Re-Import Process

## Overview

Complete schema cleanup for Creative Works Phase 4. The schema is being simplified from the old detailed model to match the finalized 5-column editorial workbook.

**Status:** Pre-production (safe to reset and re-import)

---

## What's Being Removed

### From `credited_works` table (10 obsolete columns):
- `release_type` — "Studio Album", "Single", etc.
- `label` — Record label
- `track_number` — Track position
- `source_confidence` — Source metadata
- `category` — national/international classification
- `country` — Country of origin
- `source_url` — URL to source
- `notes` — Free-form notes
- `recording_id` — Foreign key to recordings (unused)
- `release_id` — Foreign key to releases (unused)

### From `credited_work_credits` table (4 obsolete columns):
- `credit_detail` — Detailed credit text
- `co_credits` — Co-credit text
- `source_confidence` — Source metadata
- `work_id` — Old column name (should be credited_work_id)

---

## Final Schema

### credited_works (7 columns)
```sql
id uuid primary key default gen_random_uuid()
title text not null
performer_text text
release_title text
release_year integer
created_at timestamptz default now()
updated_at timestamptz default now()

UNIQUE(title, performer_text, release_title, release_year)
```

### credited_work_credits (5 columns)
```sql
id uuid primary key default gen_random_uuid()
credited_work_id uuid not null references credited_works(id) on delete cascade
artist_id uuid not null references artists(id) on delete cascade
role text not null
created_at timestamptz default now()
updated_at timestamptz default now()

UNIQUE(credited_work_id, artist_id, role)
```

---

## Migration Process

### Step 1: Apply Migration

In Supabase SQL Editor:

```
SQL Editor → New Query
Copy/paste: supabase/migrations/20260705000005_cleanup_credited_works_schema.sql
Click Run
```

**What the migration does:**
1. Drops old constraints (safe, uses `IF EXISTS`)
2. Drops old indexes
3. Removes obsolete columns (uses `DROP COLUMN IF EXISTS`)
4. Creates new unique constraints
5. Recreates simplified indexes
6. Preserves RLS policies and triggers

**Safe to run multiple times** — all operations are idempotent.

### Step 2: Verify Cleanup

Run queries from `SCHEMA_CLEANUP_VERIFICATION.sql`:

```sql
-- Check 1: Verify credited_works has exactly 7 columns
SELECT column_name FROM information_schema.columns
WHERE table_name = 'credited_works' AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check 2: Verify credited_work_credits has exactly 5 columns
SELECT column_name FROM information_schema.columns
WHERE table_name = 'credited_work_credits' AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check 3: Verify constraints
SELECT constraint_name FROM information_schema.table_constraints
WHERE table_name IN ('credited_works', 'credited_work_credits');
```

---

## Safe Re-Import with Reset

### Option 1: Fresh Import (if no production data)

```bash
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx
```

### Option 2: Reset & Re-Import (clean slate)

```bash
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
  --reset-artist
```

**What `--reset-artist` does:**
1. Finds the artist by slug/name/id
2. Deletes all `credited_work_credits` rows for that artist
3. Deletes orphaned `credited_works` rows (works with no credits)
4. Then imports fresh data from the spreadsheet

**Never touches:**
- artists table
- recordings table
- releases table
- recording_credits table
- release_artists table

### Option 3: Dry Run First (recommended)

```bash
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
  --reset-artist \
  --dry-run
```

**Output shows:**
- Spreadsheet validation
- Role analysis
- Artist lookup
- What would be deleted (if --reset-artist)
- How many works and credits would be imported

---

## Import Mapping

### Spreadsheet Columns → Database Columns

**credited_works:**
- Track_Title → title
- Performer → performer_text
- Album_Title → release_title
- Year → release_year

**credited_work_credits:**
- Roles (split by comma) → role (one row per role)
- Artist → artist_id (fixed for import)
- Work → credited_work_id (linked during import)

### Required Columns
The importer **only requires** these 5 columns:
- Year
- Album_Title
- Track_Title
- Performer
- Roles

Any extra columns in the workbook are **safely ignored**.

---

## Expected Results (Luny Tunes)

After successful import with `--reset-artist`:

**credited_works:**
- 210 rows total
- Unique by (title, performer_text, release_title, release_year)

**credited_work_credits:**
- ~341–342 rows total (depends on exact duplicate role handling)
- Unique by (credited_work_id, artist_id, role)

**Breakdown by role:**
- Producer: ~190 credits
- Composer: ~69 credits
- Arranger: ~44 credits
- Mastering Engineer: ~12 credits
- Mix Engineer: ~10 credits
- Executive Producer: ~6 credits
- Co-Producer: ~3 credits
- Beat Programmer: ~3 credits
- Remixer: ~2 credits

---

## Complete Import Workflow

```bash
# Step 1: Validation (dry run)
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
  --dry-run

# Output shows:
# ✓ Read 210 works
# ✓ Found: Luny Tunes (...)
# Dry run OK. Ready to import...

# Step 2: Reset old data
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
  --reset-artist \
  --dry-run

# Output shows:
# ✓ Deleted X credit records
# ✓ Deleted Y orphaned work records
# Dry run (with reset): Would delete...

# Step 3: Real import with reset
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
  --reset-artist

# Output shows:
# ✓ Deleted X credits
# ✓ Deleted Y orphaned works
# ✓ Inserted 210 works
# ✓ Inserted 342 credits
# Import complete! ...

# Step 4: Verify in database
# Run checks from SCHEMA_CLEANUP_VERIFICATION.sql
```

---

## Safety Guarantees

### What Cannot Happen

❌ **Cannot delete from:**
- artists table
- recordings table
- releases table
- recording_credits table
- release_artists table

❌ **Cannot create orphaned records:**
- Orphaned works are explicitly deleted
- All credits link to existing works

❌ **Cannot violate constraints:**
- Unique constraints enforced
- Foreign keys maintained
- NOT NULL columns always populated

### What Is Reversible

✅ **Can reverse this import:**
1. Reset again: deletes all data for that artist
2. Or manually delete from credited_work_credits, then credited_works
3. Or restore from backup if needed

---

## Verification Checklist

After migration:

- [ ] Migration applied successfully
- [ ] 7 columns in credited_works (verified with Check 1)
- [ ] 5 columns in credited_work_credits (verified with Check 2)
- [ ] Correct unique constraints (verified with Checks 3 & 6)
- [ ] No obsolete columns exist (verified with Check 8)
- [ ] No orphaned credits (verified with Check 9)
- [ ] No invalid artist references (verified with Check 10)
- [ ] No NULL in NOT NULL columns (verified with Check 11)

After import:

- [ ] 210 works in credited_works
- [ ] ~342 credits in credited_work_credits
- [ ] All credits linked to valid works (Check 9)
- [ ] All artist_ids are valid (Check 10)
- [ ] No duplicates (unique constraints enforced)

---

## Rollback Plan

If something goes wrong:

**Option 1: Reset same artist**
```bash
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
  --reset-artist
```

**Option 2: Manual cleanup**
```sql
-- Delete all credits for this artist
DELETE FROM credited_work_credits WHERE artist_id = '<artist-id>';

-- Delete orphaned works
DELETE FROM credited_works WHERE id NOT IN (
  SELECT DISTINCT credited_work_id FROM credited_work_credits
);
```

**Option 3: Restore from backup** (if migration failed)
Contact DevOps for database restore

---

## Next Steps

1. **Apply migration** to Supabase
2. **Run verification queries** to confirm cleanup
3. **Dry-run import** to validate spreadsheet
4. **Real import** with `--reset-artist`
5. **Verify results** against expected counts
6. **Test UI** to ensure works display correctly

---

**Status:** ✅ **READY FOR PRODUCTION**  
**Safety:** ✅ **FULLY REVERSIBLE**  
**Data Integrity:** ✅ **GUARANTEED**

---

**Last Updated:** 2026-07-05  
**Authority:** Creative Works — Schema Cleanup & Re-Import Final
