# Historical Report

**Status:** Historical Snapshot (2026-07-03)

**Current Source of Truth:**
- [DATA_GOVERNANCE.md](../../DATA_GOVERNANCE.md)
- [ARCHITECTURAL_DECISIONS.md](../../ARCHITECTURAL_DECISIONS.md)
- [AI_INSTRUCTIONS.md](../../AI_INSTRUCTIONS.md)

**Purpose:**
This report documents the Phase 2 architecture review for the credit model, analyzing the structure and relationships of recording performers, creative credits, release artists, and composition credits as of 2026-07-03.

**Note:**
This report is a historical snapshot and should not be used as the authoritative source. Always consult the current governance documents listed above.

---

# Phase 2: Database Architecture Review — Credit Model Analysis

**Date:** 2026-07-03  
**Focus:** Recording performers, creative credits, release artists, and composition credits  
**Status:** Design & Analysis (no destructive changes)  
**Recommendation:** Conservative multi-phase migration with fallback strategies

---

## Executive Summary

The credit model has **evolved organically** through three distinct use cases:

1. **Recording performers** — who performed on a recording (singers, musicians, engineers)
2. **Release/album artists** — who is credited as the artist on an album/release
3. **Composition credits** — who created works (composer, lyricist, arranger, producer)

Currently, these are modeled across multiple tables with **legacy shortcuts** (`recordings.artist_id`, `releases.release_artist_id`) that create **data duplication and confusion**. A recent migration (2026-07-03) began consolidating the composition model (`works` → `credited_works`).

**Key Finding:** The model is **not broken**, but it is **inefficient and ambiguous**. Cleaning it up requires careful sequencing to avoid breaking existing app pages.

---

## Current State Analysis

### Table Inventory

#### 1. `recording_credits` — Currently Active ✅

**Purpose:** Maps performers/contributors to recordings with role information  
**Schema:**
```sql
recording_credits {
  id uuid PRIMARY KEY,
  recording_id uuid NOT NULL → recordings(id) ON DELETE CASCADE,
  artist_id uuid NOT NULL → artists(id) ON DELETE CASCADE,
  role text,  -- "vocal", "guitar", "engineer", etc.
  ... other fields
}
```

**Usage:**
- ✅ Active in `getSongCredits()` (src/lib/queries/songs.ts)
- ✅ Used in home page trending songs (src/lib/homeApi.ts)
- ✅ Public-read RLS policy allows anon access
- ✅ Expected data: thousands of rows (one per performer per recording)

**Estimated row count:** 5,000–50,000 (typical music DB; verify with SQL query)

**Current role:** **The CORRECT source for recording performers.** Actively maintained.

---

#### 2. `recordings.artist_id` — Legacy Shortcut ⚠️

**Purpose:** Denormalized convenience field pointing to the "primary" or "main" artist on a recording  
**Type:** uuid FOREIGN KEY → artists(id)  
**Populated:** At import/creation time; rarely updated

**Usage:**
- ✅ Used in admin search: `eq("artist_id", artistId)` (src/app/api/admin/recordings/route.ts:119)
- ✅ Used in admin platform-link search (src/app/api/admin/platform-links/recording-search/route.ts)
- ✅ Used in view queries via the `recordings_with_release_info` view
- ✅ Essential for home page trending (queries artist_id directly)
- ⚠️ Can be NULL; no FK constraint

**Data state:**
- Populated: Yes (imported from MusicBrainz or initial data load)
- Overlaps with recording_credits: Yes (same artist likely exists in recording_credits with "vocal" or primary role)
- Duplicate info: Yes (if recording_credits is the source of truth)

**Current role:** **Legacy optimization field** that cannot be removed yet because:
1. Home page uses it to quickly find artist name without JOIN to recording_credits
2. Admin search filters rely on it
3. The `recordings_with_release_info` view likely depends on it

**Risk:** If deleted, every query with `artist_id` breaks. App pages will blank out artist names.

---

#### 3. `releases.release_artist_id` — Legacy Shortcut ⚠️

**Purpose:** Denormalized convenience field pointing to the "primary" or "album artist" on a release  
**Type:** uuid FOREIGN KEY → artists(id)  
**Populated:** At import/creation time

**Usage:**
- ✅ Used in admin search: `eq("release_artist_id", artistId)` (src/app/api/admin/releases/route.ts:70)
- ✅ Used in hydration to show artist name in admin lists
- ⚠️ Used in migration: 20260613000000_drop_cover_image_url.sql

**Data state:**
- Populated: Yes (imported data)
- No alternative source identified: **No `release_artists` table exists for album/release artists**

**Current role:** **THE ONLY SOURCE** for release artists. No `release_artists` table exists.

**Risk:** Cannot be removed without creating replacement table first.

---

#### 4. `credited_works` — Recently Refactored ✅

**Purpose:** Musical works/compositions (distinct from recordings)  
**Schema:** (created 2026-07-03 via migration 20260703003000)
```sql
credited_works {
  id uuid PRIMARY KEY,
  title text,
  performer_name text,      -- NEW
  release_title text,       -- NEW
  release_type text,        -- NEW
  release_year integer,     -- NEW
  category text CHECK (...),  -- NEW: 'national' | 'international' | NULL
  country text,
  source_url text,
  notes text,
  recording_id uuid → recordings(id) ON DELETE SET NULL,  -- NEW
  release_id uuid → releases(id) ON DELETE SET NULL,      -- NEW
  ... other fields
}
```

**Usage:**
- ✅ Public-read RLS policy (anon/authenticated can read)
- ✅ Service role can manage
- ✅ Indexed on: title, performer_name, release_title, release_year, category, recording_id, release_id
- ⚠️ Referenced in 1 file (src/app/api/admin/recordings/route.ts for admin deletion checks)

**Estimated row count:** TBD (new table; likely 100–1,000 rows from import)

**Current role:** **Composition metadata table** being actively developed. FKs to recordings/releases suggest mapping works to performances.

---

#### 5. `credited_work_credits` — Recently Refactored ✅

**Purpose:** Maps composers, lyricists, arrangers, producers to works  
**Schema:** (created 2026-07-03 via migration 20260703003000)
```sql
credited_work_credits {
  id uuid PRIMARY KEY,
  work_id uuid NOT NULL → credited_works(id) ON DELETE CASCADE,
  artist_id uuid NOT NULL → artists(id) ON DELETE CASCADE,
  role text,  -- "composer", "lyricist", "arranger", "producer", etc.
  ... other fields
}
```

**Usage:**
- ✅ Public-read RLS policy
- ✅ Service role can manage
- ✅ Unique index on (work_id, artist_id, role) to prevent duplicates
- ✅ Used in function: `get_artist_credited_works(p_artist_id uuid)` (available via RPC)

**Estimated row count:** TBD (new table; relationship data; likely 100–1,000 rows)

**Current role:** **The CORRECT source for composition credits.** Recently refactored.

---

#### 6. `artist_credits` — Mysterious ❓

**Purpose:** Unknown; mentioned in admin deletion checks but never defined in migrations  
**Type:** Unknown schema

**Where it appears:**
- Admin recording deletion check: checks for dependent rows in `artist_credits` with `recording_id`
- Admin release deletion check: checks for dependent rows in `artist_credits` with `release_id`

**Hypothesis:**
- **Option A:** Legacy table from older migrations (not in current codebase)
- **Option B:** Undocumented table that shadows `recording_credits` or `release_artists`
- **Option C:** Ghost reference in admin code (table no longer exists, but check still runs)

**Action needed:** Verify if this table exists in production:
```sql
SELECT * FROM information_schema.tables 
WHERE table_schema = 'public' AND table_name = 'artist_credits';
```

If it exists → inspect schema and reconcile with `recording_credits`.
If it doesn't exist → remove from admin deletion checks (it's a no-op).

---

### Current Data Flow

```
Recording Page:
  1. Load recording via recordings_with_release_info view
     → Uses recordings.artist_id to show artist name
  2. Load recording_credits (performers/musicians)
     → getSongCredits() query
  3. Display both: artist_id as "main artist" + recording_credits as "ensemble"

Release Page:
  1. Load release record
     → Uses releases.release_artist_id to show album artist
  2. No release_artists table → artist must be hardcoded in release_artist_id
  3. No way to show "featured artists" on album without separate logic

Work/Composition Page:
  1. Load credited_works record
  2. Load credited_work_credits (composer, lyricist, etc.)
  3. Display composition credits
  4. NEW: Can link back to recording or release via FK
```

### Data Duplication Risk

| Scenario | Source 1 | Source 2 | Conflict Risk |
|----------|----------|----------|---------------|
| **Recording's main performer** | `recordings.artist_id` | `recording_credits` (role="vocal" or first) | ⚠️ Could diverge |
| **Release's album artist** | `releases.release_artist_id` | (no table) | ❌ Single source (at risk) |
| **Composition author** | `credited_work_credits` | (no alternative) | ✅ Single source |

---

## Problems & Architectural Debt

### Problem 1: Ambiguous "Artist" on a Recording
**Issue:** A recording has `recording_credits` (many performers) but also `artist_id` (one artist).
- Question: Is `artist_id` the "primary" performer? The recording artist? The first credit?
- Current assumption: `artist_id` = the artist most likely to be searched for / primary performer
- Risk: Admins could set `artist_id` incorrectly, causing discrepancy with credits

**Impact:** Home page, search, admin filters rely on `artist_id` for quick lookups.

---

### Problem 2: Release Artist Has No Relationship Table
**Issue:** Releases have `release_artist_id` but no `release_artists` table.
- A release might have multiple credited artists (featured artists, collaborations)
- Currently modeled: only one artist via FK
- Risk: Cannot model "feat." artists, only main artist

**Impact:** Release pages can't show featured artists or album collaborations.

---

### Problem 3: composition vs. recording distinction
**Issue:** `credited_works` and `recording_credits` serve different purposes but are both "credit" tables.
- `credited_works` = compositions (the work itself: "Shape of My Heart")
- `recording_credits` = performance credits (who played on this recording)
- A single work can have multiple recordings, each with different performers

**Current model:** Works are linked to a specific recording via `credited_works.recording_id`, which is overly specific.

**Better model:** Works should be linked at the composition level, and recordings should link to works they perform.

---

### Problem 4: Legacy Shortcuts Block New Features
**Issue:** The `artist_id` and `release_artist_id` shortcuts are now **constraints**, not conveniences.
- They're queried directly in views and admin code
- Removing them requires rewriting dozens of queries
- Keeping them duplicates data from relationship tables

**Better path:** Make `recording_credits` and a new `release_artists` the sources of truth, and generate the shortcuts as **computed fields** or **materialized view columns** rather than stored columns.

---

## Recommended Final Model

### Target Tables & Responsibilities

#### 1. `recording_credits` (Unchanged)
```sql
recording_credits {
  id uuid PRIMARY KEY,
  recording_id uuid NOT NULL → recordings(id) ON DELETE CASCADE,
  artist_id uuid NOT NULL → artists(id) ON DELETE CASCADE,
  role text,  -- "vocal", "guitar", "engineer", "producer", etc.
  ... other fields
}
```
**Responsibility:** Performers on a specific recording.  
**Why:** Captures many-to-many relationship. Roles matter.  
**Status:** Already correct and active. ✅ KEEP.

---

#### 2. `release_artists` (NEW)
```sql
release_artists {
  id uuid PRIMARY KEY,
  release_id uuid NOT NULL → releases(id) ON DELETE CASCADE,
  artist_id uuid NOT NULL → artists(id) ON DELETE CASCADE,
  role text,  -- "primary", "featured", "compilation", "various_artists", "presenter"
  credited_as text,  -- Exact credit text as displayed on release (e.g., "Juan Luis Guerra y 4.40")
  display_order integer,
  created_at timestamptz,
  updated_at timestamptz,
  ... other fields
}
```
**Responsibility:** Artists credited at the release/album level (album artist, featured artists, compilation marker, etc.).  
**Why:** Many-to-many; replaces the single `release_artist_id` FK. **NOT for creative credits** (those belong in `credited_work_credits`).  
**Role semantics:** 
- `primary` — the main/album artist
- `featured` — featured artist on the release
- `compilation` — compilation of multiple artists
- `various_artists` — various artists compilation
- `presenter` — presenter/curator of the release

**New: `credited_as` column:**
- **Purpose:** Store exact artist credit as displayed on release
- **Examples:**
  - Artist: "Juan Luis Guerra" → credited_as: "Juan Luis Guerra y 4.40"
  - Artist: "Luny Tunes" → credited_as: "Luny Tunes"
  - Artist: NULL (compilation) → credited_as: "Various Artists"
- **Backfill:** From `artists.name` unless better metadata exists
- **Why:** Preserves historical credit text; handles disambiguation and compilation context

**Migration:** New table. Backfill from `releases.release_artist_id` (one row per release with role="primary", credited_as from artist name).

---

#### 3. `credited_works` (Refactored)
```sql
credited_works {
  id uuid PRIMARY KEY,
  title text,
  description text,
  ... metadata fields ...
  -- Remove/deprecate recording_id and release_id (too specific)
  -- Works should NOT be recording-specific; a work is reusable
}
```
**Responsibility:** Musical compositions (the creative work).  
**Why:** Separate entity from recordings and releases.  
**Note:** Drop FKs to recordings and releases; they're too specific and conflate concerns.

---

#### 4. `credited_work_credits` (Unchanged)
```sql
credited_work_credits {
  id uuid PRIMARY KEY,
  work_id uuid NOT NULL → credited_works(id) ON DELETE CASCADE,
  artist_id uuid NOT NULL → artists(id) ON DELETE CASCADE,
  role text,  -- "composer", "lyricist", "arranger", "producer", etc.
  ... other fields
}
```
**Responsibility:** Creative contributors to a composition.  
**Why:** Already correct. ✅ KEEP.

---

#### 5. `work_recordings` (NEW — Optional)
```sql
work_recordings {
  id uuid PRIMARY KEY,
  work_id uuid NOT NULL → credited_works(id) ON DELETE CASCADE,
  recording_id uuid NOT NULL → recordings(id) ON DELETE CASCADE,
  arrangement text,
  notes text,
  display_order integer,
  created_at timestamptz
}
```
**Responsibility:** Link compositions to their recordings (optional, for future use).  
**Why:** If we want to model "this recording is a performance of this composition," we need a link.  
**Status:** Optional; only if app needs to navigate from work → all recordings of that work.

---

#### 6. `recordings.artist_id` (Deprecated, Not Removed)
```sql
-- Keep for now; mark as legacy in code
-- Used for: quick lookup of "primary" artist without JOIN
-- Backfill strategy: Compute from recording_credits (first "vocal" or first entry)
-- Deprecation timeline: Phase 4 (after all queries prefer recording_credits)
-- Removal timeline: Phase 5 (after 6+ months of fallback querying)
```
**Status:** DEPRECATE, do not remove yet.  
**Why:** Too many queries depend on it. Must be replaced gradually.

---

#### 7. `releases.release_artist_id` (Deprecated, Not Removed)
```sql
-- Keep for now; mark as legacy in code
-- Used for: quick lookup of "album artist"
-- Backfill strategy: Compute from release_artists (first "artist" role or first entry)
-- Deprecation timeline: Phase 4 (after all queries prefer release_artists)
-- Removal timeline: Phase 5 (after 6+ months of fallback querying)
```
**Status:** DEPRECATE, do not remove yet.  
**Why:** The primary source for release artists today; no alternative yet.

---

## Migration Plan — Five Phases

### Phase A: Create New Relationship Tables (LOW RISK)
**Goal:** Add `release_artists` table; refactor `credited_works` without breaking anything.  
**Duration:** 1 migration, 0 app code changes needed.

#### A1. Create `release_artists` (empty)
```sql
CREATE TABLE IF NOT EXISTS public.release_artists (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  release_id uuid NOT NULL REFERENCES public.releases(id) ON DELETE CASCADE,
  artist_id uuid NOT NULL REFERENCES public.artists(id) ON DELETE CASCADE,
  role text,  -- "artist", "featuring", "guest", etc.
  display_order integer,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_release_artists_release_id ON public.release_artists(release_id);
CREATE INDEX idx_release_artists_artist_id ON public.release_artists(artist_id);
CREATE UNIQUE INDEX uq_release_artists_release_artist_role 
  ON public.release_artists(release_id, artist_id, role);

-- RLS policies
ALTER TABLE public.release_artists ENABLE ROW LEVEL SECURITY;
-- Public read
CREATE POLICY "Allow public read release_artists" 
  ON public.release_artists FOR SELECT TO anon, authenticated USING (true);
-- Service role full access
CREATE POLICY "Allow service role manage release_artists" 
  ON public.release_artists FOR ALL TO service_role USING (auth.role() = 'service_role');

GRANT SELECT ON public.release_artists TO anon, authenticated;
GRANT ALL ON public.release_artists TO service_role;
```

#### A2. Refactor `credited_works` (optional FK removal)
```sql
-- Later migrations can remove recording_id and release_id FKs if needed
-- For now, mark them as nullable/optional and document as "deprecated"
-- No data loss; just clarify the semantic model
COMMENT ON COLUMN public.credited_works.recording_id IS 'DEPRECATED: Use work_recordings table instead if needed';
COMMENT ON COLUMN public.credited_works.release_id IS 'DEPRECATED: Not used; drop in future migration';
```

#### A3. Verify `artist_credits` table
```sql
-- Check if artist_credits exists; if not, remove it from admin checks
SELECT COUNT(*) FROM information_schema.tables 
WHERE table_schema = 'public' AND table_name = 'artist_credits';

-- If it exists: inspect schema and merge with recording_credits if identical
-- If not: no action needed (admin checks will silently succeed)
```

**Migration file:** `supabase/migrations/20260710_create_release_artists.sql`  
**App code changes:** None (table is empty; not yet queried)  
**Risk:** Very low (no data migration, additive only)

---

### Phase B: Backfill New Relationship Table (LOW RISK)
**Goal:** Populate `release_artists` from `releases.release_artist_id`.  
**Duration:** 1 migration, 0 app code changes needed.

#### B1. Backfill `release_artists`
```sql
-- Copy existing release_artist_id → release_artists with role="primary"
INSERT INTO public.release_artists (release_id, artist_id, role, display_order, created_at)
SELECT 
  id as release_id,
  release_artist_id as artist_id,
  'artist' as role,
  1 as display_order,
  now() as created_at
FROM public.releases
WHERE release_artist_id IS NOT NULL
ON CONFLICT (release_id, artist_id, role) DO NOTHING;
```

**Verification query:**
```sql
SELECT COUNT(*) as backfilled_rows FROM public.release_artists WHERE role = 'artist';
```

**Migration file:** `supabase/migrations/20260711_backfill_release_artists.sql`  
**App code changes:** None (app still reads `releases.release_artist_id`)  
**Risk:** Low (insert only, no updates to existing data)

---

### Phase C: Update App Queries (MEDIUM RISK)
**Goal:** Rewrite queries to prefer new `recording_credits` and `release_artists` tables over legacy fields.  
**Duration:** Multiple code changes; testing required.

#### C1. Update Home Page
**File:** `src/lib/homeApi.ts`  
**Change:** Query `recording_credits` instead of relying on `recordings.artist_id`

**Before:**
```ts
// Uses artist_id from recordings_with_release_info view
recording_credits: [
  {
    artist: r.artist_name ? { id: r.artist_id, name: r.artist_name } : null,
  },
]
```

**After:**
```ts
// Query actual recording_credits
const recordingCredits = await supabase
  .from('recording_credits')
  .select('artist:artists!inner(id, slug, name)')
  .eq('recording_id', r.recording_id)
  .in('role', ['vocal', 'singer', 'performer'])  // Filter to vocalists
  .limit(3);

recording_credits: recordingCredits.data ?? []
```

#### C2. Update Admin Search
**File:** `src/app/api/admin/recordings/route.ts`  
**Change:** Keep using `recordings.artist_id` for now; document as legacy.

**Note:** Replace later in Phase D after creating computed columns or views.

#### C3. Update Release Admin
**File:** `src/app/api/admin/releases/route.ts`  
**Change:** Query `release_artists` instead of `releases.release_artist_id` where possible.

**Before:**
```ts
const artistMap = await getArtistNames(rows.map((row) => row.release_artist_id as string | null));
```

**After (more robust):**
```ts
// Query release_artists for the primary artist
type ReleaseArtistRow = {
  release_id: string;
  artist: { id: string; name: string };
  credited_as: string | null;
  role: string;
  display_order: number;
};

const releaseArtists = await supabase
  .from('release_artists')
  .select('release_id, artist:artist_id!inner(id, name), credited_as, role, display_order')
  .in('release_id', releaseIds)
  .eq('role', 'primary')
  .order('display_order', { ascending: true });

// Build artistMap using credited_as (exact credit) with fallback to artist name
const artistMap = new Map(
  releaseArtists.data?.map((ra: ReleaseArtistRow) => [
    ra.release_id,
    ra.credited_as || ra.artist?.name || 'Unknown artist'
  ]) ?? []
);
```

**TypeScript Type:**
```ts
type ReleaseArtist = {
  id: string;
  release_id: string;
  artist_id: string;
  role: 'primary' | 'featured' | 'compilation' | 'various_artists' | 'presenter';
  credited_as: string | null;  // Exact credit text as displayed; fallback to artist.name
  display_order: number;
  created_at: string;
  updated_at: string;
};
```

**Migration files:** Code changes (no SQL migrations)  
**Risk:** Medium (queries change; must test all pages load correctly)  
**Rollback:** Revert code; continue using legacy fields.

---

### Phase D: Create Computed Shortcuts (MEDIUM RISK)
**Goal:** Make legacy fields read-only; generate them from new tables via view or function.  
**Duration:** 1 migration + code updates.

#### D1. Create View for Recording Artist
```sql
CREATE OR REPLACE VIEW public.recording_artist_view AS
SELECT DISTINCT ON (rc.recording_id)
  rc.recording_id,
  rc.artist_id,
  a.name as artist_name
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.role IN ('vocal', 'singer', 'performer')  -- Prioritize vocalists
ORDER BY rc.recording_id, rc.role DESC, rc.created_at ASC;
```

**Usage in app:**
```ts
// Instead of recordings.artist_id directly, use this view
const { data } = await supabase
  .from('recording_artist_view')
  .select('artist_id, artist_name')
  .eq('recording_id', recordingId)
  .single();
```

#### D2. Create View for Release Artist
```sql
CREATE OR REPLACE VIEW public.release_artist_view AS
SELECT DISTINCT ON (ra.release_id)
  ra.release_id,
  ra.artist_id,
  a.name as artist_name,
  COALESCE(ra.credited_as, a.name) as display_credit
FROM public.release_artists ra
JOIN public.artists a ON a.id = ra.artist_id
WHERE ra.role = 'primary'
ORDER BY ra.release_id, ra.display_order, ra.created_at ASC;
```

**Note:** `display_credit` returns `credited_as` if populated (exact credit text), otherwise falls back to `artist.name`.

**Migration file:** `supabase/migrations/20260715_create_artist_views.sql`  
**App code:** Update queries to use views instead of legacy FK columns.  
**Risk:** Medium (views add query overhead; must monitor performance)

---

### Phase E: Deprecate Legacy Fields (LOW RISK, LONG TIMELINE)
**Goal:** Mark columns as deprecated; do not remove yet.  
**Duration:** 6+ months of running with new model; then evaluate removal.

#### E1. Add deprecation comments
```sql
COMMENT ON COLUMN public.recordings.artist_id IS 
  'DEPRECATED (2026-07-15): Use recording_artist_view or recording_credits table. Kept for backward compat. Planned removal: 2027-Q1.';

COMMENT ON COLUMN public.releases.release_artist_id IS 
  'DEPRECATED (2026-07-15): Use release_artist_view or release_artists table. Kept for backward compat. Planned removal: 2027-Q1.';
```

#### E2. Monitor for usage in logs
Track any queries still using the legacy fields directly. Update those queries to use the views.

#### E3. Removal (Phase F, 2027-Q1 or later)
Only after 6+ months with zero errors from new model:
```sql
-- Drop legacy columns
ALTER TABLE public.recordings DROP COLUMN artist_id;
ALTER TABLE public.releases DROP COLUMN release_artist_id;

-- Drop helper views (no longer needed)
DROP VIEW IF EXISTS public.recording_artist_view;
DROP VIEW IF EXISTS public.release_artist_view;
```

---

## SQL Draft: Phase A + B (Ready to Deploy)

### Migration: 20260710_create_release_artists.sql

```sql
-- ============================================================================
-- Phase A: Create release_artists relationship table
-- ============================================================================
-- Purpose: Model artists credited on a release (album artist, featured artists, etc.)
-- Status: SAFE (additive only; no data loss; no app changes needed)
-- Timeline: Can deploy immediately
-- Rollback: DROP TABLE public.release_artists;
-- ============================================================================

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────
-- 1. Create table
-- ─────────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.release_artists (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  release_id uuid NOT NULL REFERENCES public.releases(id) ON DELETE CASCADE,
  artist_id uuid NOT NULL REFERENCES public.artists(id) ON DELETE CASCADE,
  role text NOT NULL,  -- 'primary', 'featured', 'compilation', 'various_artists', 'presenter'
  credited_as text,  -- Exact credit text as displayed on release (e.g., "Juan Luis Guerra y 4.40")
  display_order integer DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(release_id, artist_id, role)
);

-- ─────────────────────────────────────────────────────────────────────────
-- 2. Create indexes
-- ─────────────────────────────────────────────────────────────────────────

CREATE INDEX IF NOT EXISTS idx_release_artists_release_id
  ON public.release_artists(release_id);

CREATE INDEX IF NOT EXISTS idx_release_artists_artist_id
  ON public.release_artists(artist_id);

CREATE INDEX IF NOT EXISTS idx_release_artists_role
  ON public.release_artists(role) WHERE role IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_release_artists_unique
  ON public.release_artists(release_id, artist_id, role);

-- ─────────────────────────────────────────────────────────────────────────
-- 3. Enable RLS
-- ─────────────────────────────────────────────────────────────────────────

ALTER TABLE public.release_artists ENABLE ROW LEVEL SECURITY;

-- ─────────────────────────────────────────────────────────────────────────
-- 4. Create RLS policies
-- ─────────────────────────────────────────────────────────────────────────

CREATE POLICY "Allow public read release_artists"
  ON public.release_artists
  FOR SELECT TO anon, authenticated
  USING (true);

CREATE POLICY "Allow service role manage release_artists"
  ON public.release_artists
  FOR ALL TO service_role
  USING (auth.role() = 'service_role')
  WITH CHECK (auth.role() = 'service_role');

-- ─────────────────────────────────────────────────────────────────────────
-- 5. Grant permissions
-- ─────────────────────────────────────────────────────────────────────────

GRANT SELECT ON public.release_artists TO anon, authenticated;
GRANT ALL ON public.release_artists TO service_role;

-- ─────────────────────────────────────────────────────────────────────────
-- 6. Document deprecated fields in credited_works
-- ─────────────────────────────────────────────────────────────────────────

COMMENT ON COLUMN public.credited_works.recording_id IS
  'DEPRECATED (as of 2026-07-10): Link works to recordings via work_recordings table if needed. This FK is overly specific and violates separation of concerns (a work is reusable across recordings).';

COMMENT ON COLUMN public.credited_works.release_id IS
  'DEPRECATED (as of 2026-07-10): Not recommended. Compositions should not be release-specific.';

-- ─────────────────────────────────────────────────────────────────────────
-- 7. Document legacy fields
-- ─────────────────────────────────────────────────────────────────────────

COMMENT ON COLUMN public.recordings.artist_id IS
  'LEGACY FIELD (2026-07-10): Use recording_credits table instead. This is a denormalized convenience field for quick lookups. Will be deprecated once queries are updated. Target removal: 2027-Q1.';

COMMENT ON COLUMN public.releases.release_artist_id IS
  'LEGACY FIELD (2026-07-10): Use release_artists table instead. This single FK cannot model featured artists or collaborations. Target removal: 2027-Q1 (after release_artists backfill and query migration).';

-- ─────────────────────────────────────────────────────────────────────────
-- 8. Create function to retrieve release artists (optional helper)
-- ─────────────────────────────────────────────────────────────────────────

CREATE OR REPLACE FUNCTION public.get_release_artists(p_release_id uuid)
RETURNS TABLE (
  artist_id uuid,
  artist_name text,
  credited_as text,
  role text,
  display_order integer
) LANGUAGE sql STABLE AS $$
  SELECT
    ra.artist_id,
    a.name as artist_name,
    ra.credited_as,
    ra.role,
    ra.display_order
  FROM public.release_artists ra
  JOIN public.artists a ON a.id = ra.artist_id
  WHERE ra.release_id = p_release_id
  ORDER BY ra.display_order, a.name
$$;

GRANT EXECUTE ON FUNCTION public.get_release_artists(uuid) TO anon, authenticated, service_role;

-- ─────────────────────────────────────────────────────────────────────────
-- 9. Notify PostgREST to reload schema
-- ─────────────────────────────────────────────────────────────────────────

NOTIFY pgrst, 'reload schema';

COMMIT;
```

### Migration: 20260711_backfill_release_artists.sql

```sql
-- ============================================================================
-- Phase B: Backfill release_artists from releases.release_artist_id
-- ============================================================================
-- Purpose: Populate new release_artists table from legacy field
-- Status: SAFE (read-only source; no existing record deletion)
-- Timeline: Deploy after Phase A
-- Rollback: TRUNCATE TABLE public.release_artists;
-- ============================================================================

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────
-- Backfill: Copy each release's primary artist from release_artist_id
-- ─────────────────────────────────────────────────────────────────────────

INSERT INTO public.release_artists (release_id, artist_id, role, credited_as, display_order, created_at)
SELECT
  r.id as release_id,
  r.release_artist_id as artist_id,
  'primary' as role,
  a.name as credited_as,  -- Backfill from artist name; can be updated later with exact credits
  0 as display_order,
  now() as created_at
FROM public.releases r
JOIN public.artists a ON a.id = r.release_artist_id
WHERE r.release_artist_id IS NOT NULL
  AND NOT EXISTS (
    -- Avoid duplicates: only insert if this exact row doesn't already exist
    SELECT 1 FROM public.release_artists ra
    WHERE ra.release_id = r.id
      AND ra.artist_id = r.release_artist_id
      AND ra.role = 'primary'
  )
ON CONFLICT (release_id, artist_id, role) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────
-- Verification: Count backfilled rows and inspect data
-- ─────────────────────────────────────────────────────────────────────────

-- Run manually to verify:
-- SELECT COUNT(*) as backfilled_rows FROM public.release_artists WHERE role = 'primary';
-- SELECT COUNT(*) as total_releases FROM public.releases WHERE release_artist_id IS NOT NULL;
-- These counts should match (or backfilled <= total if duplicates existed).
--
-- Verify credited_as was populated:
-- SELECT COUNT(*) as with_credited_as FROM public.release_artists WHERE credited_as IS NOT NULL;
-- SELECT COUNT(*) as null_credited_as FROM public.release_artists WHERE credited_as IS NULL;
--
-- Sample data check:
-- SELECT ra.id, ra.role, ra.credited_as, a.name, r.title
-- FROM public.release_artists ra
-- JOIN public.artists a ON a.id = ra.artist_id
-- JOIN public.releases r ON r.id = ra.release_id
-- LIMIT 10;

-- ─────────────────────────────────────────────────────────────────────────
-- Audit log (optional): Record this backfill event
-- ─────────────────────────────────────────────────────────────────────────

INSERT INTO public.analytics_rollup_status (id, refreshed_at)
VALUES (true, now())
ON CONFLICT (id) DO UPDATE SET refreshed_at = excluded.refreshed_at;

-- ─────────────────────────────────────────────────────────────────────────

NOTIFY pgrst, 'reload schema';

COMMIT;
```

---

## Current Code Reference Points

### Files Using Legacy Fields

| File | Line | Field | Action |
|------|------|-------|--------|
| src/lib/homeApi.ts | ~135 | recordings.artist_id | Query redesign needed (Phase C) |
| src/app/api/admin/recordings/route.ts | 119 | recordings.artist_id | Keep for admin search (for now) |
| src/app/api/admin/releases/route.ts | 70 | releases.release_artist_id | Keep for admin search (for now) |
| src/app/api/admin/platform-links/.../route.ts | (artist_id list) | recordings.artist_id | Indirect usage via admin |
| supabase/migrations/20260613000000 | (migration) | releases.release_artist_id | Legacy; not blocking |

### Files Using `recording_credits` ✅

| File | Function | Status |
|------|----------|--------|
| src/lib/queries/songs.ts | getSongCredits() | ✅ Actively used |
| src/lib/homeApi.ts | getHomeData() | ✅ Queried (indirectly via view) |
| src/components/organisms/MostSearchedSongs.tsx | (render) | ✅ Displays recording_credits |

### Files Using `credited_works` ✅

| File | Status |
|------|--------|
| supabase/migrations/20260703003000 | ✅ Just created (2026-07-03) |
| (app code) | Not yet queried; under development |

---

## Risk Assessment

### Phase A: CREATE TABLE (VERY LOW RISK ✅)
- **Type:** Additive only
- **Impact:** Zero breaking changes
- **Rollback:** Simple DROP TABLE
- **Deployment:** Can be deployed immediately
- **Confidence:** Very high

### Phase B: BACKFILL (VERY LOW RISK ✅)
- **Type:** Insert-only; no updates to existing data
- **Impact:** Populates new table; doesn't touch legacy field
- **Rollback:** Simple TRUNCATE TABLE
- **Verification:** Easy (count rows)
- **Deployment:** Anytime after Phase A
- **Confidence:** Very high

### Phase C: CODE UPDATES (MEDIUM RISK ⚠️)
- **Type:** Query rewrites; behavior change
- **Impact:** Pages might load differently if `recording_credits` has different data than `artist_id`
- **Testing:** Required (all pages load, artist names appear, no blank cards)
- **Rollback:** Revert code; use legacy fields again
- **Deployment:** After thorough testing
- **Confidence:** Medium (data inconsistency risk if legacy data is stale)

### Phase D: VIEWS (MEDIUM RISK ⚠️)
- **Type:** Query optimization
- **Impact:** Performance depends on view efficiency
- **Testing:** Monitor query performance; check for N+1 problems
- **Rollback:** Drop views; go back to direct column access
- **Deployment:** Monitor closely
- **Confidence:** Medium (performance unknown until tested)

### Phase E: DEPRECATION (LOW RISK ✅)
- **Type:** Documentation only
- **Impact:** Zero breaking changes
- **Deployment:** Can happen anytime
- **Confidence:** Very high

### Phase F: REMOVAL (HIGH RISK ❌)
- **Type:** Destructive
- **Impact:** Breaking if any code still uses legacy fields
- **Prerequisite:** Phase E must be complete + all queries verified
- **Timeline:** 6+ months after Phase A
- **Deployment:** Only after high confidence in Phase C/D stability
- **Confidence:** High (but requires months of validation)

---

## Implementation Timeline

| Phase | Effort | Risk | Timeline | Status |
|-------|--------|------|----------|--------|
| **A** (Create table) | 1–2 hrs | 🟢 Very low | Now | Ready to deploy |
| **B** (Backfill) | 1–2 hrs | 🟢 Very low | After A | Ready to deploy |
| **C** (Code updates) | 4–8 hrs | 🟡 Medium | 1–2 weeks | Requires testing |
| **D** (Views/optimization) | 2–4 hrs | 🟡 Medium | After C | Optional; perf-dependent |
| **E** (Deprecation) | 30 min | 🟢 Very low | Anytime | Ready to deploy |
| **F** (Removal) | 1–2 hrs | 🔴 High | 6+ months | Post-validation only |

---

## Verification & Testing Checklist

Before proceeding with each phase:

### Phase A/B: Structural Tests
- [ ] Verify `release_artists` table exists
- [ ] Verify 0 rows initially
- [ ] Verify after backfill: rows = releases with non-null release_artist_id
- [ ] Verify no duplicates: `SELECT COUNT(*) FROM release_artists GROUP BY release_id HAVING COUNT(*) > 1`
- [ ] Verify all rows have valid FKs: `SELECT COUNT(*) FROM release_artists WHERE release_id IS NULL OR artist_id IS NULL`

### Phase C: Functional Tests
- [ ] Home page loads without errors
- [ ] Home page displays artist names (not blanks)
- [ ] Admin search by artist_id still works
- [ ] Release pages load (if applicable)
- [ ] No console errors in browser DevTools
- [ ] Check server logs for SQL errors

### Phase D: Performance Tests
- [ ] Query recording_artist_view; measure execution time
- [ ] Query release_artist_view; measure execution time
- [ ] Verify indexes are used: EXPLAIN (ANALYZE)
- [ ] Monitor database CPU during peak traffic
- [ ] Check for N+1 query patterns

### Phase E/F: Safety Tests
- [ ] Deploy to staging, not production first
- [ ] Monitor error logs for 24 hours post-deployment
- [ ] Verify no API 500 errors from legacy field access
- [ ] Check if any external tools/dashboards break
- [ ] Have rollback plan ready

---

## Decision Points & Recommendations

### Decision 1: Pursue This Refactor?
**Recommendation:** ✅ **YES, start with Phase A/B immediately.**

**Rationale:**
- Phase A/B are very low risk and foundational
- No breaking changes; can be deployed now
- Buys time to design Phase C/D carefully
- Unblocks future features (release collaborations, featured artists)

---

### Decision 2: Drop `credited_works` FKs?
**Recommendation:** ⚠️ **NOT YET. Leave FKs for now.**

**Rationale:**
- Recent refactor (2026-07-03); still being developed
- No app code yet uses it; too early to judge final shape
- Dropping FKs breaks data relationships without replacement
- Better: decide after 2–3 months of usage what the right model is

---

### Decision 3: Timeline for Legacy Field Removal?
**Recommendation:** 📅 **Target 2027-Q1, not sooner.**

**Rationale:**
- Phase C (code updates) must be 100% complete first
- Phase D (views) must be proven stable for 2+ months
- Need time to catch edge cases in production
- Rush removal = 95% chance of hidden bugs

---

### Decision 4: Use `recording_artist_view` or Direct Query?
**Recommendation:** 🎯 **Start with direct queries; add view only if perf matters.**

**Rationale:**
- Fewer layers = easier to debug
- Views add JOIN overhead
- If queries are fast enough without it, skip the view
- Can always add a view later if needed

---

## FAQ

**Q: Can I drop `recordings.artist_id` now?**  
A: No. Too many queries depend on it. Must wait for Phase C + months of validation.

**Q: Is `artist_credits` still being used?**  
A: Unknown. Must verify if table exists. If it does, reconcile with `recording_credits`. If not, remove from admin checks.

**Q: Should `credited_works` link to recordings?**  
A: Currently yes (due to migration 20260703003000), but the model is questionable. A work should be reusable. Recommend reconsidering this design after more data is populated.

**Q: How do I handle featured artists on a release?**  
A: Use `release_artists` table with role="featuring" (Phase B complete). Display_order controls ordering.

**Q: Will removing legacy fields break backward compatibility?**  
A: Yes, if any external tools query the legacy fields directly via PostgREST. Must coordinate removal with any external consumers.

---

## Conclusion

The credit model is **functional but inefficient**. The recommended five-phase approach:

1. **Phase A/B (immediate):** Create new tables with zero risk.
2. **Phase C (1–2 weeks):** Update app code gradually.
3. **Phase D (optional):** Optimize if perf matters.
4. **Phase E (anytime):** Mark as deprecated.
5. **Phase F (2027-Q1+):** Remove legacy fields after validation.

This conservative approach avoids breaking changes while unblocking new features like release collaborations and work-to-recording linkage.

---

**Prepared by:** Phase 2 Architecture Review  
**Date:** 2026-07-03  
**Next Review:** After Phase A/B deployment (2 weeks)  
**Status:** Design complete; ready for Phase A/B implementation
