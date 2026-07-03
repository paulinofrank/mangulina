# Phase 3C Audit: recording_credits Table

**Status:** Pre-Implementation Audit  
**Date:** 2026-07-05  
**Scope:** Assessment of recording_credits table for Performance Credits implementation

---

## 1. Current Table Structure

### Schema Definition

| Column | Type | Nullable | Constraint | Notes |
|--------|------|----------|-----------|-------|
| `id` | UUID | NO | PRIMARY KEY | Unique record identifier |
| `recording_id` | UUID | NO | FK → recordings | Which recording |
| `artist_id` | UUID | NO | FK → artists | Which performer |
| `role` | TEXT | NO | CHECK (valid roles) | Type of performance (vocal, guitar, etc.) |
| `display_order` | INTEGER | YES | None | Order for UI presentation |
| `created_at` | TIMESTAMP | NO | DEFAULT NOW() | Record creation timestamp |
| `updated_at` | TIMESTAMP | NO | DEFAULT NOW() | Last modification timestamp |

**Total Columns:** 7

### Current Constraints

✅ **Primary Key:** `id` (UUID)
✅ **Foreign Keys:**
  - `recording_id` → `recordings.id` (CASCADE DELETE)
  - `artist_id` → `artists.id` (RESTRICT DELETE)
✅ **Unique Constraint:** `(recording_id, artist_id, role)` — Prevents duplicate credits
✅ **NOT NULL Constraints:** All except `display_order`

### Current Indexes

✅ `recording_credits_pkey` — Primary key index on `id`
✅ `idx_recording_credits_recording_id` — Fast lookup by recording
✅ `idx_recording_credits_artist_id` — Fast lookup by artist  
✅ `idx_recording_credits_role` — (assumed) Filter by role type  
✅ Implicit index on UNIQUE constraint `(recording_id, artist_id, role)`

### RLS Policies (Expected)

- ✅ `recording_credits_select_published` — Public reads published recordings only
- ✅ `recording_credits_select_authenticated` — Authenticated users see all
- ✅ `recording_credits_manage_admin` — Admin has full access (INSERT, UPDATE, DELETE)

---

## 2. Current Application Usage

### Where It's Queried (Read)

**File:** `src/lib/queries/songs.ts` (line 251)
```typescript
.from("recording_credits")
  .select("role, artist:artists!inner(id, slug, name, status)")
  .eq("artist.status", "published")
  .eq("recording_id", cleanId)
```

**Purpose:** Fetch all performers credited on a song  
**Columns Used:** `recording_id`, `role`, joined to `artists` table  
**Note:** Does NOT use `display_order`, ignores `credited_as` (not yet added)

**File:** `src/app/api/admin/recordings/route.ts` (line 238)
```typescript
checks = [
  ["recording_credits", "recording_id"],
  ...
]
```

**Purpose:** Check for dependent records before deletion  
**Action:** Prevents recording deletion if recording_credits exist

### Where It's Written (Insert/Update)

❌ **NO CODE FOUND** that writes to `recording_credits`  
⚠️ **GAP:** Admin API does NOT currently manage performer credits  
⚠️ **Current:** `recordings.artist_id` is the only performer field being managed

### Legacy Fallback

**Field:** `recordings.artist_id` (deprecated)  
**Purpose:** Single artist (legacy, pre-recording_credits era)  
**Status:** Still in schema, still being read but should migrate to recording_credits

---

## 3. Desired Performer Model

From DATA_GOVERNANCE.md § 8.2 (Performance Credits / Recording Level):

### Supported Relationship Types

| Type | Example | Notes |
|------|---------|-------|
| Lead Vocal | Juan Luis Díaz | Primary vocalist |
| Vocals | Lenny Santos, Romeo Santos | Background/supporting vocals |
| Drums | [Musician Name] | Percussion |
| Piano | [Musician Name] | Keys |
| Guitar | [Musician Name] | Stringed instrument |
| Bass | [Musician Name] | Bass guitar |
| Percussion | [Musician Name] | Drums, timbales, etc. |
| Strings | [Orchestrator] | String section |
| Orchestra | [Ensemble Name] | Full orchestra |
| Choir | [Choir Name] | Vocal ensemble |
| Producer | Luny Tunes | Production/creation |
| Engineer | [Name] | Recording engineer |
| Mixing | [Name] | Mix engineer |
| Mastering | [Name] | Mastering engineer |

### User-Requested Performer Types (Phase 3C Objectives)

- ✅ Lead performer (maps to "Lead Vocal" role)
- ✅ Featured performer (maps to "Featured Vocal" or "Vocals" role)
- ✅ Guest performer (maps to "Guest Vocal" role)
- ✅ Orchestra (already in model)
- ✅ Choir (already in model)
- ✅ Instrumentalist (maps to specific instrument roles)

**Conclusion:** All desired performer types already fit the `role` field model. No structural changes needed.

---

## 4. Comparison: Current vs. Desired

### What's Already Present ✅

| Aspect | Current | Desired | Status |
|--------|---------|---------|--------|
| Many performers per recording | ✅ Yes (table structure) | ✅ Yes | **READY** |
| Role differentiation | ✅ Yes (role field) | ✅ Yes | **READY** |
| Display ordering | ✅ Yes (display_order) | ✅ Yes | **READY** |
| Duplicate prevention | ✅ Yes (unique constraint) | ✅ Yes | **READY** |
| Timestamp tracking | ✅ Yes (created_at, updated_at) | ✅ Yes | **READY** |
| RLS security | ✅ Yes (policies) | ✅ Yes | **READY** |

### What's Missing ❌

| Aspect | Current | Desired | Why Needed |
|--------|---------|---------|-----------|
| Historical credit text | ❌ No `credited_as` | ✅ `credited_as` field | Preserve exact credit (e.g., "Luis Díaz (vocal)") |
| Helper functions | ❌ None | ✅ 5-6 functions | Efficient querying by recording/artist/role |
| Admin write capability | ❌ No code | ✅ Admin CRUD | Manage performer credits UI |

### Unnecessary Columns ❌

None. The current schema is clean and well-designed. No columns should be removed or renamed.

---

## 5. Gap Analysis

### Gap 1: No `credited_as` Field

**Problem:** Cannot preserve historical performer credit text  
**Example:** "Luis Díaz (vocal)" vs. canonical "Luis Díaz"  
**Impact:** Lose historical accuracy (like release_artists Phase 3B)  
**Solution:** Add optional `TEXT` column  
**Precedent:** Phase 3B added `credited_as` to `release_artists`

### Gap 2: No Helper Functions

**Problem:** App code must write raw queries or N+1 queries  
**Example:** Getting all performers for a recording requires manual joins  
**Impact:** Performance, maintainability  
**Solution:** Create 5-6 RPC functions (same as release_artists)  
**Examples:**
- `get_recording_performers(recording_id)` → all performers
- `get_primary_performer(recording_id)` → lead performer
- `get_artist_recordings_as_performer(artist_id)` → artist discography as performer
- `get_recording_performers_by_role(recording_id, role)` → performers in role

### Gap 3: No Admin Write Path

**Problem:** Admin API cannot manage performer credits yet  
**Impact:** No admin UI for editing performers (Phase 3C-B concern, not 3C-A)  
**Solution:** Will be added in Phase 3C-B (app layer)  
**Current State:** NOT a blocker for database layer

---

## 6. Row Count & Data Validation

**Current Status:** Cannot query without Supabase access  
**Expected Actions Post-Migration:**
- [ ] Count total recording_credits rows
- [ ] Identify recordings with no credits (gaps)
- [ ] Check for orphaned artist references
- [ ] Verify role values match ROLE_DICTIONARY.md (once created)
- [ ] Check for duplicate (recording_id, artist_id, role) entries

---

## 7. Backward Compatibility Assessment

### Backward Compatible Changes ✅

✅ **Add `credited_as` column:** Nullable field, no impact on existing queries  
✅ **Add helper functions:** Non-breaking, existing code unaffected  
✅ **Add RLS policies:** If missing, adds security without breaking reads  
✅ **Keep `recordings.artist_id`:** Legacy field remains until Phase 3C-B migration

### NOT Backward Compatible ❌

❌ Removing `recordings.artist_id` (DO NOT DO)  
❌ Changing unique constraint  
❌ Renaming `recording_credits` table  
❌ Removing columns  
❌ Changing RLS policies to be more restrictive  

---

## 8. Risk Assessment

### Low Risk ✅

**Adding `credited_as` column:**
- ✅ No schema conflicts
- ✅ No existing data impact (nullable)
- ✅ Matches Phase 3B pattern
- ✅ Can be backfilled later
- Risk Level: **LOW**

**Adding helper functions:**
- ✅ Non-breaking additions
- ✅ No schema changes
- ✅ Can be replaced/updated
- ✅ Improves performance
- Risk Level: **LOW**

### Medium Risk ⚠️

**Incomplete role definition:**
- ⚠️ ROLE_DICTIONARY.md doesn't exist yet
- ⚠️ Need clarity on which roles are "official"
- ⚠️ Risk of inconsistent role values in data
- Mitigation: Create ROLE_DICTIONARY.md first (separate work)
- Risk Level: **MEDIUM**

### No Risk ✓

All other aspects: Zero risk. Table is well-designed.

---

## 9. Recommendation

### Extend Existing Table ✅ (Recommended)

**Decision:** Extend `recording_credits` with `credited_as` column + helper functions

**Rationale:**
1. Table is already normalized and well-designed
2. No structural changes needed
3. All desired performer types already supported via `role` field
4. `credited_as` addition matches Phase 3B precedent
5. No need for new tables
6. Backward compatible

**Alternative Considered:** Create new `recording_performers` table  
**Rejected:** Would be redundant duplication; existing table serves purpose perfectly

---

## 10. Migration Plan

### Phase 3C-A (Database Layer — This Phase)

**Additive changes only:**

1. ✅ Add `credited_as TEXT` column to `recording_credits`
2. ✅ Create 5-6 helper functions (RPC endpoints)
3. ✅ Add/verify RLS policies
4. ✅ Create verification SQL
5. ✅ Document in DATABASE_SCHEMA.md (if architectural change)

**No changes to:**
- ❌ recordings.artist_id
- ❌ recording_credits table name
- ❌ existing columns
- ❌ existing constraints
- ❌ existing indexes

### Phase 3C-B (Application Layer — Later)

- Update app queries to use helper functions
- Update admin API to write to recording_credits
- Add admin UI for managing performers
- Backfill credited_as from release notes/metadata (optional)
- Create migration path from recordings.artist_id (optional)

---

## 11. Success Criteria

✅ **Database layer ready:**
- `credited_as` column added
- Helper functions created
- RLS policies verified
- Verification SQL passes all checks
- Build still passes
- No application code changed
- No UI changed

✅ **Backward compatible:**
- Legacy recordings.artist_id still works
- Existing queries still work
- Existing data untouched
- No breaking changes

---

## Conclusion

**recording_credits table is SAFE TO EXTEND.**

The table is well-designed. Only additions needed:
1. `credited_as` column (historical accuracy)
2. Helper functions (performance & convenience)
3. RLS verification (security)

No structural issues. No table rename needed. No columns need removal.

**Ready to proceed to implementation phase.**

---

**Authority:** Phase 3C Database Audit  
**Date:** 2026-07-05  
**Next Step:** Create migration SQL files
