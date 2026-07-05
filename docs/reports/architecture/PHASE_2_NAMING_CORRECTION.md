# Historical Report

**Status:** Historical Snapshot (2026-07-03) — Implementation Note

**Current Source of Truth:**
- [ARCHITECTURAL_DECISIONS.md](../../ARCHITECTURAL_DECISIONS.md)
- [DATA_GOVERNANCE.md](../../DATA_GOVERNANCE.md)

**Purpose:**
Documents a critical naming correction during Phase 2 development, changing table name from `release_credits` to `release_artists` to align with data model consistency.

**Note:**
The changes documented here were incorporated into the current governance documents. This report preserves the historical correction process.

---

# Phase 2: Naming Correction — CRITICAL UPDATE

**Date:** 2026-07-03  
**Status:** ⚠️ **NAMING CORRECTED — DO NOT DEPLOY UNTIL VERIFIED**  
**Impact:** Phase A/B SQL migrations, documentation, and semantics

---

## Change Summary

### Table Rename
```
BEFORE: release_credits
AFTER:  release_artists
```

### Role Semantics Clarification
The new table is for **artist-to-release relationships only**, NOT creative credits.

```
BEFORE: roles = ["artist", "main artist", "featuring", "guest", "collaboration", etc.]
AFTER:  roles = ["primary", "featured", "compilation", "various_artists", "presenter"]
```

### Reason
- **`release_artists`** clearly indicates: artists associated with a release
- **`release_credits`** is ambiguous: could imply creative credits (composer, arranger, etc.)
- **Release-level roles only:** Album artist, featured artists, compilation marker, presenter
- **Creative credits live elsewhere:** `credited_work_credits` (composer, lyricist, arranger, producer)

---

## What Was Updated

### 1. ✅ PHASE_2_ARCHITECTURE_REVIEW.md
- All references: `release_credits` → `release_artists`
- Role documentation: clarified release-level roles only
- SQL migrations: updated role values and table names
- Function names: `get_release_artists()` (recommended)
- Views: `release_artist_view` (using role='primary')

### 2. ✅ PHASE_2_SQL_ANALYSIS.sql
- All analysis queries: updated table references
- Backfill queries: uses release_artists
- RLS audit: updated table names

### 3. ✅ PHASE_2_SUMMARY.md
- Summary tables: updated references
- Implementation checklist: updated table names
- Timeline: no changes to duration/risk

### 4. ✅ ARCHITECTURE_AUDIT_INDEX.md
- Cross-references: updated table names
- All links still valid

### 5. ✅ DATABASE_AUDIT.md
- ⚠️ **NOT YET UPDATED** (see next section)

---

## What Still Needs Manual Review

### DATABASE_AUDIT.md
**Action:** Update this document to reference the new naming
- Section: Overlapping / Duplicate Tables → remove old release_credits discussion
- Section: Appendix → update table inventory
- File size: ~100 KB; check for any other credit table discussions

**Recommendation:** Search and replace:
```bash
grep -n "release_credits" "DATABASE_AUDIT.md"
```
Then manually review context and update.

---

## Semantic Clarity: Why This Matters

### Before (Ambiguous)

| Table | Purpose | Confusion Risk |
|-------|---------|---|
| `recording_credits` | Performers on a recording | ✅ Clear |
| `release_credits` | ? Artists on release? Or creative credits? | ⚠️ Ambiguous |
| `credited_works` | Compositions | ✅ Clear |
| `credited_work_credits` | Creative contributors to compositions | ✅ Clear |

### After (Explicit)

| Table | Purpose | Clarity |
|-------|---------|---------|
| `recording_artists` (future) | Performers on a recording | ✅ Crystal clear |
| `release_artists` | Album/release artist credits | ✅ Crystal clear |
| `credited_works` | Compositions | ✅ Crystal clear |
| `credited_work_credits` | Creative contributors to compositions | ✅ Crystal clear |

**Principle:** Naming should disambiguate purpose, not duplicate it.

---

## Role Values: Release-Level Only

### Valid Roles for `release_artists`
```
'primary'          — The main/album artist
'featured'         — Featured artist on the release
'compilation'      — Part of a compilation
'various_artists'  — Various artists compilation marker
'presenter'        — Curator/presenter of the release
```

### Invalid Roles (Belong in `credited_work_credits`)
```
'composer'         — ❌ USE credited_work_credits INSTEAD
'lyricist'         — ❌ USE credited_work_credits INSTEAD
'arranger'         — ❌ USE credited_work_credits INSTEAD
'producer'         — ❌ USE credited_work_credits INSTEAD
'engineer'         — ❌ USE credited_work_credits INSTEAD
'vocal'            — ❌ USE recording_artists INSTEAD (when renamed)
'guitar'           — ❌ USE recording_artists INSTEAD (when renamed)
```

**Why:** Separate concerns. A person is "composer of work X", not "composer of release Y".

---

## SQL Migration Verification

### Phase A: Create release_artists

**Before correction:**
```sql
role text,  -- 'artist', 'featuring', 'guest', 'collaboration', etc.
```

**After correction:**
```sql
role text,  -- 'primary', 'featured', 'compilation', 'various_artists', 'presenter'
```

**Status:** ✅ Updated in PHASE_2_ARCHITECTURE_REVIEW.md

### Phase B: Backfill release_artists

**Before correction:**
```sql
'artist' as role
WHERE rc.role = 'artist'
```

**After correction:**
```sql
'primary' as role
WHERE ra.role = 'primary'
```

**Status:** ✅ Updated in PHASE_2_ARCHITECTURE_REVIEW.md

---

## Deployment Checklist: DO NOT DEPLOY UNTIL...

### Pre-Deployment Verification
- [ ] Read this entire document
- [ ] Verify all 4 documents were updated (see "What Was Updated" section)
- [ ] Check DATABASE_AUDIT.md for any remaining `release_credits` references
- [ ] Review SQL migration role values (should be 'primary', not 'artist')
- [ ] Confirm with team: the semantic model matches your requirements

### Code Comment Updates
- [ ] Update any internal docs/ADRs that reference the old name
- [ ] Add comment to Phase A migration: "release-level artists only; creative credits go to credited_work_credits"

### Team Communication
- [ ] Notify data team of correct role values
- [ ] Brief product: release artists model is for album metadata, not creative credits
- [ ] Brief QA: test new role values in backfill query

---

## FAQ

**Q: Why not call it `release_artist_credits`?**  
A: Shorter, clearer. `release_artists` is parallel to `recording_artists` (when recording_credits is eventually renamed). Avoids "credits" confusion.

**Q: What if we need release-level creative credits later?**  
A: Create a different table (e.g., `release_work_credits`). The distinction is: who is credited on the release (release_artists) vs. who created the work (credited_work_credits).

**Q: Can we add 'engineer' as a release_artists role?**  
A: No. Engineers are credited per recording (in recording_artists), not per release. If you need release-level engineering credits, that's a new requirement; design separately.

**Q: Is 'compilation' a role or a flag?**  
A: For now, a role. Could later become a column (is_compilation: boolean). Keep it as a role for MVP.

---

## Timeline Impact

| Phase | Change | Timeline Impact |
|-------|--------|---|
| **A** (Create table) | ✅ Naming corrected | 0 change |
| **B** (Backfill) | ✅ Role value corrected | 0 change |
| **C** (Code updates) | ✅ References updated | 0 change |
| **D** (Views) | ✅ Updated | 0 change |
| **E** (Deprecation) | ✅ Updated | 0 change |
| **F** (Removal) | ✅ Updated | 0 change |

**Net impact:** Zero delay. Naming correction is a pre-deployment fix.

---

## Approval Sign-Off

### Corrections Made By
- System: Architecture Audit Script
- Date: 2026-07-03
- Reason: User feedback on naming clarity

### Ready for Deployment When
- [ ] Tech lead approves naming change
- [ ] Product confirms semantic understanding
- [ ] DATABASE_AUDIT.md is manually updated
- [ ] All documents reviewed for consistency
- [ ] Team acknowledges role values are release-level only

---

## Next Action

1. ✅ **Read this document** (you are here)
2. ✅ **Verify all 4 documents were updated** (see section above)
3. ⏳ **Manually update DATABASE_AUDIT.md** (search for release_credits)
4. ⏳ **Get team approval** (naming, semantics, role values)
5. ⏳ **Deploy Phase A/B** (updated SQL migrations)

---

**Status:** ✅ All automated updates complete | ⏳ Awaiting manual DATABASE_AUDIT update and team approval

**Reference:** See [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) for full context.
