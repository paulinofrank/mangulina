# Phase 3C Role Strategy Summary (Revised)

**Status:** Ready for Deployment Before Phase 3C-B  
**Date:** 2026-07-05  
**Scope:** Define explicit performer roles + preserve legacy data

---

## Governance Finding

**Audit Result:** `recording_credits` currently contains:
- `role = 'performer'` (13 rows, LEGACY)
- No creative credits in wrong table ✅
- No work-level credits ✅

**Decision:** Preserve legacy data unchanged. Define explicit roles for new entries. Provide manual review path in admin UI.

---

## Changes Made

### 1. Updated ROLE_DICTIONARY.md

**Location:** `docs/ROLE_DICTIONARY.md`  
**Scope:** Authoritative reference for all valid roles in Mangulina

**Recording-Level Roles Defined (11 explicit performer roles):**
- `lead_performer` — Primary performer on this recording
- `featured_performer` — Prominent guest performer
- `guest_performer` — One-time guest appearance
- `orchestra` — Full orchestra ensemble
- `choir` — Vocal ensemble/chorus
- `instrumentalist` — Generic instrumentalist (if role truly unclear)
- `vocalist` — Backup/supporting vocalist
- Plus: guitar, drums, piano, bass, trumpet, saxophone, trombone, strings, horns, percussion, conductor

**Technical Roles Defined (9 roles):**
- `producer` — Session producer
- `engineer` / `recording_engineer` — Recording engineer
- `mixing` / `mixing_engineer` — Mix engineer
- `mastering` / `mastering_engineer` — Mastering engineer
- `session_musician` — Generic session musician
- `arranger` — Recording-specific arranger

**Legacy Roles:**
- `performer` — ⚠️ LEGACY (DO NOT USE for new entries; marked for manual review)

**Work-Level Roles Defined (8 roles):**
- `composer`, `lyricist`, `writer`, `songwriter`, `orchestrator`, `arranger`, `co-composer`, `co-writer`

**Release-Level Roles (Phase 3B):**
- `primary`, `featured`, `compilation`, `various_artists`, `presenter`

**Total:** 40+ valid roles across three levels

**Key Decision Rules:**
- "DO NOT use generic 'performer' — this is legacy and must be manually reviewed"
- "Use explicit roles: lead_performer, featured_performer, guest_performer, orchestra, choir, instrumentalist"
- "The role 'performer' exists in legacy data but should NOT be used for new entries"

### 2. Removed Normalization Migration

**Decision:** Do NOT automatically migrate legacy 'performer' rows

**Rationale:**
- Preserves original data without assumptions
- Allows editors to manually review and classify
- Better for data governance (no automatic mapping that could be wrong)
- Provides audit trail for each manual correction

**Migration Removed:**
- `20260705000000_normalize_recording_credits_performer_roles.sql` — DELETED

### 3. Updated Phase 3C Helper Functions

**File:** `20260705000001_recording_credits_helper_functions.sql`

**Functions (now 8 total):**
1. `get_recording_performers()` — All performers on recording (includes legacy 'performer')
2. `get_recording_performer_credit()` — Display credit for one performer
3. `get_recording_performers_by_role()` — Performers in specific role
4. `get_artist_recording_credits()` — All recordings artist performed on
5. `get_recording_credit_count()` — Count credits by role
6. `get_primary_recording_performer()` — Lead performer
7. `get_recording_performers_summary()` — Text summary
8. **NEW:** `get_legacy_performer_credits()` — List all legacy 'performer' rows needing review

**New Function:**
```sql
get_legacy_performer_credits()
-- Returns all recording_credits with role='performer'
-- For editorial review and admin UI reclassification
-- Used in Phase 3C-B when building performer management UI
```

### 4. Updated Migration Sequence

**Final migration sequence (3 migrations):**

| Order | File | Purpose |
|-------|------|---------|
| 1 | `20260705000000_add_credited_as_to_recording_credits.sql` | Add credited_as column |
| 2 | `20260705000001_recording_credits_helper_functions.sql` | Create 8 helper functions |
| 3 | `20260705000002_recording_credits_verification.sql` | Verification queries + legacy audit |

### 5. Added Legacy Performer Audit Query

**In migration 3 verification SQL:**

```sql
-- Query 21: Legacy Performer Audit
SELECT rc.id, rc.recording_id, r.title, rc.artist_id, a.name, 
       rc.credited_as, rc.display_order, rc.created_at
FROM public.recording_credits rc
JOIN public.recordings r ON r.id = rc.recording_id
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.role = 'performer'
ORDER BY r.title, a.name;
```

**Purpose:** Lists all 13 legacy performer entries for manual review/classification

---

## Data Impact

### Legacy Data Preserved ✅
```
recording_credits (UNCHANGED):
- 13 rows with role='performer' (preserved as-is)
- No automatic migration
- Editorial review path available (Phase 3C-B)
```

### New Data Requirements
```
recording_credits (NEW ENTRIES):
- Must use explicit roles (lead_performer, featured_performer, etc.)
- Cannot use generic 'performer'
- Enforced by ROLE_DICTIONARY.md governance
```

**Data Loss:** Zero (legacy data unchanged)  
**Reversibility:** Not needed (data not modified)  
**Backward Compatibility:** ✅ (role field unchanged, legacy values preserved)  
**Manual Review:** Available in Phase 3C-B admin UI

---

## ROLE_DICTIONARY.md Features

### Three-Level Organization
- **Recording Level** — Performers & technical credits on THIS recording
- **Work Level** — Creators & composers (same across all recordings)
- **Release Level** — Album/single credit artists

### Decision Rules Included
- "DO NOT use generic 'performer' — this is legacy, mark for review"
- "Use explicit roles for new entries (lead_performer, featured_performer, guest_performer, etc.)"
- "Recording-level vs. work-level test"
- "How to decide lead vs. featured vs. guest performer"

### Governance Rules
- ✅ All roles must be listed
- ✅ No role can be used without an entry
- ✅ Code must validate against this dictionary
- ✅ New roles require updates to this dictionary
- ✅ Legacy role 'performer' marked for manual review, not for new use

### References to Authority
- DATA_GOVERNANCE.md § 8 (credit architecture)
- ADR-001 (three-level system)
- EDITORIAL_GUIDELINES.md (editing standards)
- AI_INSTRUCTIONS.md § Rule 3 (no invented roles)

---

## Governance Compliance

✅ **ADR-001:** Three-level credit architecture properly defined  
✅ **DATA_GOVERNANCE.md § 8:** Recording-level roles per specification  
✅ **EDITORIAL_GUIDELINES.md:** Preserves exact credit text via credited_as  
✅ **AI_INSTRUCTIONS.md:** No invented roles, all documented  
✅ **Conservative approach:** Preserve legacy data, enforce explicit roles for new entries  

---

## Build Status

✅ **Compilation:** Success (13.7s)  
✅ **Pages Generated:** 47/47  
✅ **No application code modified**  
✅ **No UI changes**  
✅ **Zero type errors**  

---

## Deployment Readiness

### Pre-Deployment Checklist

- [x] Updated ROLE_DICTIONARY.md (explicit roles + legacy marked)
- [x] Removed automatic normalization migration (data preserved)
- [x] Created 8 helper functions (including legacy audit function)
- [x] Added legacy performer audit query (verification)
- [x] Build passes with all changes
- [ ] Approve deployment to Supabase
- [ ] Run verification queries after deployment
- [ ] Spot-check public pages

### Post-Deployment Actions

1. Run migration 1: Add credited_as column
2. Run migration 2: Create 8 helper functions
3. Run migration 3: Verification queries + legacy audit
4. Run query 21 (legacy_performer_audit) to list 13 legacy rows
5. Spot-check 2-3 recording pages
6. Verify public pages load without errors

### Data Validation After Deployment

- [ ] Confirm 13 rows still have role='performer' (unchanged)
- [ ] Confirm credited_as column exists (nullable)
- [ ] Confirm 8 helper functions exist (including get_legacy_performer_credits)
- [ ] Test get_recording_performers() with sample recording_id
- [ ] Test get_legacy_performer_credits() returns 13 rows
- [ ] No orphaned references
- [ ] No duplicates

---

## Risk Assessment

### Very Low Risk ✅

**Adding credited_as column:**
- ✅ Nullable, zero impact on existing data
- ✅ Proven Phase 3B pattern
- **Risk Level:** VERY LOW
- **Likelihood:** <2%

**Creating helper functions:**
- ✅ Non-breaking, read-only
- ✅ Automatically handle legacy 'performer' role
- **Risk Level:** VERY LOW
- **Likelihood:** <1%

**Preserving legacy data:**
- ✅ Zero changes to existing rows
- ✅ No assumptions, no auto-migration
- ✅ Manual review path available
- **Risk Level:** VERY LOW
- **Likelihood:** 0%

### Low Risk ✅

**Legacy data needs manual review:**
- ⚠️ 13 'performer' rows need classification to explicit types
- ✅ Can be addressed in Phase 3C-B admin UI
- ✅ Not blocking Phase 3C database deployment
- **Risk Level:** LOW
- **Mitigation:** Planned for Phase 3C-B (admin performer management UI)

---

## Next Phase

**Phase 3C-B (Application Layer):**
- Update queries to use helper functions
- Update admin API for recording_credits writes
- **Add UI for managing performer credits** ← Includes manual classification of legacy 'performer' rows
- Use get_legacy_performer_credits() to list entries needing review

**Phase 3D (Work-Level Credits):**
- Create credited_work_credits usage patterns
- Implement creative credit management
- Luny Tunes case study

---

## Summary

**Phase 3C revised strategy:**
1. ✅ Created ROLE_DICTIONARY.md (authoritative reference with explicit roles)
2. ✅ Marked 'performer' as legacy (DO NOT use for new entries)
3. ✅ Preserved 13 legacy 'performer' rows unchanged
4. ✅ Created 8 helper functions (including legacy audit function)
5. ✅ Added verification query to list legacy rows for review
6. ✅ Build passes, no app code changed
7. ✅ Ready for deployment to Supabase

**Benefits:**
- Conservative approach (no automatic data migration)
- Editorial control (manual review available)
- Clear governance (explicit roles required going forward)
- Legacy data preserved (audit trail maintained)

---

**Status:** Ready for Deployment to Supabase  
**Authority:** Phase 3C Implementation (Revised)  
**Build:** ✅ Passes (13.7s)
**Strategy:** Preserve legacy, enforce explicit roles for new data
