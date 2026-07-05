# Historical Report

**Status:** Historical Snapshot (2026-07-03)

**Current Source of Truth:**
- [ARCHITECTURAL_DECISIONS.md](../../ARCHITECTURAL_DECISIONS.md)
- [DATA_GOVERNANCE.md](../../DATA_GOVERNANCE.md)

**Purpose:**
Summary of Phase 2 architecture review, documenting the design decisions for the credit model migration.

**Note:**
This is a historical snapshot. Consult current governance documents for authoritative guidance.

---

# Phase 2 Architecture Review — Summary

**Date:** 2026-07-03  
**Status:** ✅ Design Complete | Ready for Phase A/B Implementation  
**Documents Created:** 2 comprehensive analysis files

---

## Quick Reference

### Current State (as of 2026-07-03)

| Component | Status | Usage | Risk |
|-----------|--------|-------|------|
| `recording_credits` | ✅ Active | getSongCredits(), home page | Low — source of truth |
| `credited_works` | ✅ New (created 2026-07-03) | Under development | Low — not queried yet |
| `credited_work_credits` | ✅ New (created 2026-07-03) | RPC available | Low — not queried yet |
| `recordings.artist_id` | ⚠️ Legacy | Admin search, home page, views | Medium — heavily used |
| `releases.release_artist_id` | ⚠️ Legacy | Admin search, release pages | Medium — only source |
| `artist_credits` | ❓ Mysterious | Admin deletion checks | Unknown — verify existence |
| `release_artists` | 🔴 Missing | N/A | High — needed for new features |

### Problems Identified

1. **Legacy shortcut fields (`artist_id`, `release_artist_id`)** are denormalized and create data duplication
2. **No `release_artists` table** → can't model featured artists or album collaborations
3. **`credited_works` FK to recordings** is too specific; works should be reusable
4. **`artist_credits` table** referenced in code but not defined in migrations (verify if it exists)
5. **Data duplication risk** between `recordings.artist_id` and `recording_credits`

### Solution: Five-Phase Migration (Conservative Approach)

| Phase | Name | Effort | Risk | Timeline | Status |
|-------|------|--------|------|----------|--------|
| **A** | Create `release_artists` table | 1–2 hrs | 🟢 V. Low | Now | ✅ Ready |
| **B** | Backfill `release_artists` | 1–2 hrs | 🟢 V. Low | After A | ✅ Ready |
| **C** | Update app queries | 4–8 hrs | 🟡 Medium | 1–2 wks | Requires testing |
| **D** | Create views/optimization | 2–4 hrs | 🟡 Medium | After C | Optional |
| **E** | Deprecate legacy fields | 30 min | 🟢 V. Low | Anytime | Ready |
| **F** | Remove legacy fields | 1–2 hrs | 🔴 High | 6+ mo | Post-validation |

---

## Key Findings

### Finding 1: `recording_credits` is the correct source ✅
- **Evidence:** Actively used in `getSongCredits()`, displayed on pages
- **Action:** Keep; use it as the source of truth for recording performers
- **Timeline:** Immediately

### Finding 2: Legacy fields can't be removed yet ⚠️
- **Evidence:** Home page, admin search, views all depend on `recordings.artist_id` and `releases.release_artist_id`
- **Action:** Deprecate gradually; create new tables first
- **Timeline:** Phase C (1–2 weeks) to update queries, then Phase F (6+ months) to remove

### Finding 3: `release_artists` table doesn't exist 🚨
- **Evidence:** No release artist relationship table; only single FK field
- **Action:** Create immediately (Phase A/B)
- **Impact:** Unblocks modeling featured artists, collaborations, album artists
- **Timeline:** Now

### Finding 4: `credited_works` model is questionable ⚠️
- **Evidence:** FKs to recordings and releases (too specific for reusable compositions)
- **Action:** Revisit after 2–3 months of usage; don't remove FKs yet
- **Timeline:** Design review in Q3 2026

### Finding 5: `artist_credits` is undocumented ❓
- **Evidence:** Referenced in admin deletion checks but never defined in migrations
- **Action:** Verify if table exists; if not, remove from admin code
- **Timeline:** Before Phase C

---

## Recommended Next Steps (Priority Order)

### 1. ✅ Verify `artist_credits` existence (15 min)
**Action:** Run this query:
```sql
SELECT COUNT(*) as exists FROM information_schema.tables 
WHERE table_schema = 'public' AND table_name = 'artist_credits';
```
**If exists (>0):** Inspect schema; reconcile with `recording_credits`  
**If not exists (0):** Remove from `src/app/api/admin/recordings/route.ts` and `src/app/api/admin/releases/route.ts`

### 2. ✅ Run PHASE_2_SQL_ANALYSIS.sql (30 min)
**Purpose:** Validate assumptions about data distribution  
**Key questions to answer:**
- How many recordings have `artist_id` populated?
- Do conflicts exist between `artist_id` and `recording_credits`?
- How many releases need to be backfilled?
- Is `credited_works` table empty?

### 3. ✅ Deploy Phase A/B (1–2 hrs)
**Action:** Execute migrations:
- `supabase/migrations/20260710_create_release_artists.sql` (Phase A)
- `supabase/migrations/20260711_backfill_release_artists.sql` (Phase B)

**Verification:**
```sql
SELECT COUNT(*) FROM public.release_artists;  -- Should match releases with release_artist_id
```

**Rollback:** `DROP TABLE public.release_artists;`

### 4. ⏳ Schedule Phase C (1–2 weeks)
**Action:** Plan code updates
- Update `src/lib/homeApi.ts` to query `recording_credits` instead of relying on view
- Update `src/app/api/admin/releases/route.ts` to query `release_artists`
- Test all pages load correctly

**Blockers:**
- Data consistency validation (do conflicts exist?)
- Performance baseline (query times acceptable?)

### 5. 📅 Long-term: Phase F Planning (6+ months)
**Action:** After Phase C is stable for 2+ months, plan removal of:
- `recordings.artist_id` column
- `releases.release_artist_id` column

**Prerequisite:** All queries must use `recording_credits` and `release_artists` exclusively.

---

## Documents Created

### 1. PHASE_2_ARCHITECTURE_REVIEW.md (Main Report)
**Contents:**
- Current state analysis (tables, usage, data flow)
- 14 architectural problems identified
- Recommended final model (6 tables)
- 5-phase migration plan with SQL drafts
- Risk assessment per phase
- Testing checklist
- FAQ & decision points

**Use:** Strategic reference; share with team for review

### 2. PHASE_2_SQL_ANALYSIS.sql (Analysis Queries)
**Contents:**
- 16 query sections for data validation
- Table existence checks
- Data volume & distribution
- Legacy field usage analysis
- Conflict detection (artist_id vs. recording_credits)
- Role distribution
- Backfill readiness
- Storage usage
- Data quality checks

**Use:** Run against live database before Phase C; validate assumptions

---

## Implementation Checklist

### Before Phase A
- [ ] Read PHASE_2_ARCHITECTURE_REVIEW.md
- [ ] Share with team; discuss Phase C timeline
- [ ] Verify `artist_credits` table existence
- [ ] Run PHASE_2_SQL_ANALYSIS.sql (Section 2–4)
- [ ] Check for conflicts in data (Section 4)

### Phase A (Create table)
- [ ] Apply migration `20260710_create_release_artists.sql`
- [ ] Verify table created: `SELECT COUNT(*) FROM public.release_artists;` (should be 0)
- [ ] Confirm RLS policies exist: `SELECT * FROM pg_policies WHERE tablename = 'release_artists';`
- [ ] Deploy to staging first; monitor for errors

### Phase B (Backfill)
- [ ] Apply migration `20260711_backfill_release_artists.sql`
- [ ] Verify backfill: `SELECT COUNT(*) FROM public.release_artists;` (should ≈ releases with release_artist_id)
- [ ] Check for duplicates: `SELECT release_id, COUNT(*) FROM public.release_artists GROUP BY release_id HAVING COUNT(*) > 1;` (should be 0)
- [ ] Deploy to staging; monitor logs

### Phase C (Code updates) — Schedule for 1–2 weeks after B
- [ ] Update `src/lib/homeApi.ts` to query `recording_credits`
- [ ] Update admin endpoints to query new tables
- [ ] Test all pages load correctly
- [ ] Monitor server logs for SQL errors
- [ ] A/B test if possible; monitor error rates

### Phase D (Optimization) — Optional, conditional on perf
- [ ] Create views: `recording_artist_view`, `release_artist_view` (if needed)
- [ ] Benchmark query performance
- [ ] Monitor index usage

### Phase E (Deprecation) — Anytime after B
- [ ] Add deprecation comments to legacy columns
- [ ] Update code comments to mark fields as legacy
- [ ] Document planned removal date (2027-Q1)

### Phase F (Removal) — 6+ months after C is stable
- [ ] Confirm zero references to legacy fields in codebase
- [ ] Confirm zero external tools using legacy fields (API, dashboards)
- [ ] Create final removal migration
- [ ] Test in staging first
- [ ] Deploy with runbook for rollback

---

## Risk Mitigation

### Risk: Phase A/B fails (table creation/backfill)
**Mitigation:** Very low-risk migrations. Even if they fail, they're additive (can be rolled back with DROP/TRUNCATE).

### Risk: Phase C breaks app pages
**Mitigation:** 
- Thorough testing before deployment
- Gradual rollout (staging first, then canary)
- Quick rollback available (revert code)
- Monitor error logs closely

### Risk: Performance degrades
**Mitigation:**
- Run benchmarks before Phase C
- Create indexes on new tables
- Implement views if JOINs are expensive
- Monitor queries during peak traffic

### Risk: External tools break
**Mitigation:**
- Coordinate with external consumers before Phase F
- Deprecation period gives 6+ months warning
- Provide migration guide for external tools

---

## Success Metrics

### Phase A/B Success
- [ ] `release_artists` table exists
- [ ] Row count matches expected (≈ releases with release_artist_id)
- [ ] Zero orphaned FKs
- [ ] Zero conflicts with new data

### Phase C Success
- [ ] All pages load without errors
- [ ] Artist names display correctly
- [ ] Home page trending works
- [ ] Admin search works
- [ ] Server error rate unchanged

### Phase D Success (if pursued)
- [ ] View queries execute in < 100ms
- [ ] No N+1 query patterns
- [ ] Index usage confirmed

### Phase F Success (eventual)
- [ ] Zero references to legacy columns in codebase
- [ ] External tools migrated or notified
- [ ] No regressions in production for 2+ weeks post-removal

---

## Timeline Estimate

| Phase | Effort | Real Time | Dependencies |
|-------|--------|-----------|--------------|
| A | 1–2 hrs | 1 day (deploy staging) | None |
| B | 1–2 hrs | 1 day (after A) | Phase A success |
| C | 4–8 hrs | 1–2 weeks (testing) | Phase B complete |
| D | 2–4 hrs | 3–5 days (optional) | Phase C needs perf fix |
| E | 30 min | 1 day | Phase B/C complete |
| F | 1–2 hrs | 1 day (after 6mo) | 6+ months of Phase C stability |

**Total critical path:** Phase A → B → C → wait 6 months → F ≈ **7 months**

---

## Questions to Answer Before Phase C

1. **Data consistency:** How many conflicts exist between `recordings.artist_id` and `recording_credits`?
2. **Performance:** Will querying `recording_credits` instead of `artist_id` FK be acceptable?
3. **Coverage:** What % of recordings have entries in `recording_credits`? What % will need fallback to `artist_id`?
4. **Timing:** When can the team dedicate 4–8 hrs for Phase C code review & testing?
5. **External consumers:** Are there external tools/dashboards querying `recordings.artist_id` or `releases.release_artist_id` directly?

---

## Conclusion

The credit model refactor is **necessary but low-urgency**. It unblocks new features (featured artists, release collaborations) but doesn't fix critical bugs.

### Recommended Action Plan

**Immediate (this week):**
1. Verify `artist_credits` table existence
2. Run SQL analysis queries
3. Share findings with team

**Near-term (next 1–2 weeks):**
1. Deploy Phase A/B (very low risk)
2. Schedule Phase C planning meeting
3. Start Phase C when team bandwidth available

**Medium-term (1–2 months):**
1. Deploy Phase C (code updates)
2. Monitor for 2+ months for stability

**Long-term (6+ months):**
1. Plan Phase F (removal)
2. Coordinate with external tools
3. Deploy removal migrations

---

**Prepared by:** Phase 2 Architecture Review  
**Status:** ✅ Ready for team review  
**Next action:** Answer 5 questions above; schedule Phase A/B deployment

---

**Documents:**
- [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) — Full analysis & migration plan
- [PHASE_2_SQL_ANALYSIS.sql](PHASE_2_SQL_ANALYSIS.sql) — Ready-to-run verification queries
