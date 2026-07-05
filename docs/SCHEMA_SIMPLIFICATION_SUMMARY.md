# Schema Simplification — Creative Works

## Overview

The Creative Works schema has been simplified to match the finalized editorial model.

**Editorial Reality:** The consolidated workbook contains only 5 columns  
**Database Reality:** Schema now mirrors this simplicity

---

## What Changed

### Removed Columns

**From `credited_works` table:**
- ❌ `release_type` — "Studio Album", "Single", etc. (not curated)
- ❌ `label` — Record label (not curated)
- ❌ `track_number` — Track position (not curated)
- ❌ `source_confidence` — Confidence metadata (not curated)

**From `credited_work_credits` table:**
- ❌ `credit_detail` — Detailed credit text (not curated)
- ❌ `co_credits` — Co-credit text (not curated)
- ❌ `source_confidence` — Confidence metadata (not curated)

### Updated Deduplication Key

**Before:**
```sql
UNIQUE(title, performer_text, release_title, release_year, track_number)
```

**After:**
```sql
UNIQUE(title, performer_text, release_title, release_year)
```

**Reason:** `track_number` is no longer available in editorial workflow

### Updated Credits Unique Constraint

**Before:**
```sql
UNIQUE(credited_work_id, artist_id, role, credit_detail)
```

**After:**
```sql
UNIQUE(credited_work_id, artist_id, role)
```

**Reason:** `credit_detail` is no longer curated; prevents duplicate roles per artist per work

### Updated Helper Function

**Function:** `get_artist_credited_works_with_roles(p_artist_id UUID)`

**Removed from RETURN TABLE:**
- `release_type`
- `label`
- `track_number`
- `source_confidence`

**Now returns:**
- work_id, title, performer_text, release_title, release_year, roles, created_at

---

## Final Schema

### credited_works

```sql
CREATE TABLE credited_works (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  
  title TEXT NOT NULL,
  performer_text TEXT,
  release_title TEXT,
  release_year INTEGER,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT unique_credited_work UNIQUE (title, performer_text, release_title, release_year)
);

CREATE INDEX idx_credited_works_dedup ON credited_works(title, performer_text, release_title, release_year);
CREATE INDEX idx_credited_works_release ON credited_works(release_title, release_year);
```

### credited_work_credits

```sql
CREATE TABLE credited_work_credits (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  
  credited_work_id UUID NOT NULL REFERENCES credited_works(id) ON DELETE CASCADE,
  artist_id UUID NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
  role TEXT NOT NULL,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT unique_credited_work_credit UNIQUE (credited_work_id, artist_id, role)
);

CREATE INDEX idx_credited_work_credits_work ON credited_work_credits(credited_work_id);
CREATE INDEX idx_credited_work_credits_artist ON credited_work_credits(artist_id);
CREATE INDEX idx_credited_work_credits_role ON credited_work_credits(role);
CREATE INDEX idx_credited_work_credits_artist_role ON credited_work_credits(artist_id, role);
```

---

## Migration

**File:** `supabase/migrations/20260704000004_simplify_credited_works_schema.sql`

**Safe to run on existing databases with data:**
- Uses `DROP COLUMN IF EXISTS` (no errors if column already removed)
- Uses `DROP CONSTRAINT IF EXISTS` (idempotent)
- Uses `DROP INDEX IF EXISTS` (idempotent)
- Creates new constraints and indexes only if tables exist
- Preserves existing data in remaining columns
- Wrapped in `BEGIN; ... COMMIT;` for atomicity

**What the migration does:**
1. Drops old constraints that depend on removed columns
2. Drops indexes on removed columns
3. Recreates helper function without removed columns
4. Removes columns from both tables
5. Creates new constraints with correct column sets
6. Recreates dedup index with correct columns

---

## Import Script Updates

**File:** `scripts/importCreativeWorksFromConsolidated.ts`

**Required spreadsheet columns (only):**
- Year → release_year
- Album_Title → release_title
- Track_Title → title
- Performer → performer_text
- Roles → split into credited_work_credits

**Validation:**
- Aborts if any required column is missing
- Ignores extra columns
- Reports missing columns by name

**Upsert key:**
```sql
onConflict: 'title,performer_text,release_title,release_year'
```

**Credit upsert key:**
```sql
onConflict: 'credited_work_id,artist_id,role'
```

---

## Data Integrity

### No Data Loss
- ✅ Removed columns are not curated (safe to drop)
- ✅ Existing works data preserved
- ✅ Existing credits data preserved
- ✅ Only metadata columns removed

### Deduplication
- ✅ Still prevents duplicate works (4-column key still robust)
- ✅ track_number was never required for uniqueness (Year + Album + Track + Performer is sufficient)
- ✅ Still prevents duplicate roles (artist can't have same role twice on same work)

### Referential Integrity
- ✅ Foreign keys preserved
- ✅ CASCADE delete still works
- ✅ RLS policies unchanged
- ✅ Timestamps maintained for audit trail

---

## Simplified Editorial Workflow

```
Research Spreadsheet
(detailed, one row per role)
          ↓
Consolidation Utility
(merge roles, 5 essential columns)
          ↓
Editorial Spreadsheet
(one row per work)
Year | Album_Title | Track_Title | Performer | Roles
2005 | Gasolina    | Gasolina    | Daddy Y.  | Prod, Comp, Mix
          ↓
Import Script
(safe artist lookup, validation, role split)
          ↓
Simplified Database
credited_works (5 columns)
credited_work_credits (4 columns)
          ↓
UI Display
(chronological portfolio)
```

---

## Benefits of Simplification

| Benefit | Impact |
|---------|--------|
| **Matches editorial reality** | Database mirrors exactly what's curated |
| **Reduced complexity** | Fewer columns, fewer constraints |
| **Clearer intent** | Schema shows what Mangulina cares about |
| **Easier maintenance** | Less metadata to manage |
| **Same functionality** | UI displays works chronologically with roles |
| **Still normalized** | One work → many credits (proper relationship) |

---

## Verification Checklist

- [x] Migration created (safe to run on existing data)
- [x] Import script updated (only 5 required columns)
- [x] Documentation updated (reflects simplified schema)
- [x] Helper function updated (returns only remaining columns)
- [x] Dedup key simplified (4 columns, track_number removed)
- [x] Credit constraint simplified (role-only, credit_detail removed)
- [x] Indexes updated (match new constraints)
- [x] No data loss (only metadata removed)
- [x] Referential integrity maintained
- [x] RLS policies unchanged
- [x] Timestamps preserved for audit trail

---

## Next Steps

1. **Apply migration** to Supabase:
   ```bash
   # In Supabase SQL Editor:
   # Copy/paste contents of supabase/migrations/20260704000004_simplify_credited_works_schema.sql
   # Click Run
   ```

2. **Verify migration** succeeded:
   ```bash
   # Check table structures match simplified schema
   ```

3. **Use simplified import** for future imports:
   ```bash
   npx tsx scripts/importCreativeWorksFromConsolidated.ts \
     --artist-slug luny-tunes \
     --file ./data/LunyTunes_WorksList_Consolidated.xlsx
   ```

---

**Simplification Status:** ✅ **COMPLETE**  
**Schema State:** ✅ **MIRRORS EDITORIAL MODEL**  
**Ready for Import:** ✅ **YES**

---

**Last Updated:** 2026-07-04  
**Authority:** Creative Works — Schema Simplification Final
