# Historical Report

**Status:** Historical Snapshot (2026-07-03)

**Current Source of Truth:**
- [DATA_GOVERNANCE.md](../../DATA_GOVERNANCE.md)
- [ARCHITECTURAL_DECISIONS.md](../../ARCHITECTURAL_DECISIONS.md)

**Purpose:**
Index of all architecture audit documents completed in Phase 1 and Phase 2, covering all 47 database tables and the credit model analysis.

**Note:**
This report is a historical snapshot. Always consult current governance documents for the authoritative source.

---

# Mangulina Database Architecture Audit — Complete Documentation

**Date:** 2026-07-03  
**Status:** ✅ Phase 1 (Complete) & Phase 2 (Design Ready)  
**Scope:** All 47 tables + credit model deep dive

---

## 📋 Document Index

### Phase 1: Full Database Audit (Completed)

#### 1. **[DATABASE_AUDIT.md](DATABASE_AUDIT.md)** — Comprehensive Table Inventory
- **Purpose:** Classify all 47 tables; identify risks
- **Contains:**
  - Executive summary (35 KEEP, 7 REVIEW, 0 DROP)
  - Detailed classification by category (core, analytics, editorial, credits, admin, utility)
  - Foreign key dependency map
  - Overlapping table analysis
  - Recent migration history
  - No tables identified as safe to drop
- **Who should read:** Everyone; use as source of truth for table purposes
- **Key finding:** Schema is healthy; recent cleanup removed 23+ backup tables

#### 2. **[SQL_VERIFICATION_QUERIES.sql](SQL_VERIFICATION_QUERIES.sql)** — Ready-to-Run Analysis
- **Purpose:** Verify audit findings against live database
- **Contains:**
  - 14 query sections covering table inventory, row counts, FKs, RLS, views, functions
  - Analytics table volume analysis
  - Low-utilization utility table inspection
  - Data quality checks
  - Deep-dive queries for specific tables
- **Who should run:** DevOps, data engineers; run against staging/production to validate
- **Timeline:** 30 minutes to run all queries

#### 3. **[DECISION_MATRIX_FOR_UTILITY_TABLES.md](DECISION_MATRIX_FOR_UTILITY_TABLES.md)** — Utility Table Decisions
- **Purpose:** Framework for deciding which low-usage tables to keep/drop
- **Contains:**
  - Risk assessment matrix
  - Detailed analysis per table (7 REVIEW tables)
  - Phase-based action plan
  - Example cleanup migration template
- **Who should read:** Product managers, data team; answers "can we drop X table?"
- **Key finding:** Most utility tables have legitimate purposes; no auto-drop recommended

---

### Phase 2: Credit Model Architecture Review (Completed)

#### 4. **[PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md)** — Deep Credit Model Analysis
- **Purpose:** Design final credit model; plan migration without breaking app
- **Contains:**
  - Current state analysis (6 credit-related tables/fields)
  - 14 architectural problems identified
  - Recommended final model (clear responsibilities per table)
  - 5-phase migration plan (Phase A → F, 7 months total)
  - SQL migration drafts for Phase A/B (ready to deploy)
  - Risk assessment & rollback strategies
  - FAQ & decision points
- **Who should read:** Architects, lead engineers; shapes next 6+ months of work
- **Key finding:** Credit model works but is inefficient; Phase A/B safe to deploy now

#### 5. **[PHASE_2_SQL_ANALYSIS.sql](PHASE_2_SQL_ANALYSIS.sql)** — Data Validation Queries
- **Purpose:** Validate credit model assumptions before implementing Phase C
- **Contains:**
  - 16 query sections for schema inspection, data volume, conflicts, backfill readiness
  - Performance baseline queries
  - Duplicate detection (artist_id vs. recording_credits)
  - RLS policy audit
  - Data quality checks
- **Who should run:** Engineers before Phase C implementation; answers "is our data clean?"
- **Timeline:** 30 minutes to run and interpret

#### 6. **[PHASE_2_SUMMARY.md](PHASE_2_SUMMARY.md)** — Executive Summary & Checklist
- **Purpose:** Quick reference; implementation roadmap
- **Contains:**
  - Current state table (what's active, what's broken)
  - 5 key findings
  - Priority-ordered next steps
  - Implementation checklist (before/during each phase)
  - Risk mitigation strategies
  - Timeline & success metrics
  - Questions to answer before Phase C
- **Who should read:** Team leads, product managers; answers "what do we do next?"
- **Key finding:** Phase A/B can deploy immediately (very low risk)

---

## 🎯 How to Use These Documents

### Scenario 1: "Should we drop table X?"
1. Read: **DATABASE_AUDIT.md** (search for table name)
2. Check: **DECISION_MATRIX_FOR_UTILITY_TABLES.md** (if it's a utility table)
3. Verify: Run relevant queries from **SQL_VERIFICATION_QUERIES.sql** (confirm usage)
4. Decide: Consult with product team; revisit in 6 months if still unused

### Scenario 2: "Why do we have all these credit tables?"
1. Read: **PHASE_2_ARCHITECTURE_REVIEW.md** → Section "Current State Analysis"
2. Understand: Problems section explains overlaps
3. Reference: SQL queries in **PHASE_2_SQL_ANALYSIS.sql** for data state

### Scenario 3: "How do we refactor the credit model?"
1. Start: **PHASE_2_SUMMARY.md** for quick overview
2. Deep dive: **PHASE_2_ARCHITECTURE_REVIEW.md** for full plan
3. Implement: Deploy Phase A/B using SQL drafts in the review
4. Validate: Run **PHASE_2_SQL_ANALYSIS.sql** queries before Phase C
5. Check: Use **PHASE_2_SUMMARY.md** implementation checklist

### Scenario 4: "What tables are safe to query? Any data quality issues?"
1. Check: **DATABASE_AUDIT.md** → "KEEP" tables with RLS status
2. Audit: Run **SQL_VERIFICATION_QUERIES.sql** → Section 13 (data quality checks)
3. Verify: No orphaned FKs, no NULL constraint violations

---

## 📊 Quick Facts

### Database Health
| Metric | Value |
|--------|-------|
| Total tables | 47 active |
| Tables to KEEP | 35 |
| Tables to REVIEW | 7 |
| Tables safe to DROP | 0 (without approval) |
| Backup tables dropped (already cleaned) | 23+ |
| RLS policies | Standardized (2026-07-03 cleanup) |
| Recent migrations | 5 in last week |

### Credit Model Status
| Component | Status | Next Action |
|-----------|--------|------------|
| `recording_credits` | ✅ Active | Keep; source of truth |
| `credited_works` | ✅ New (2026-07-03) | Monitor; refactor later |
| `credited_work_credits` | ✅ New (2026-07-03) | Keep; development stable |
| `recording_credits` | ✅ In use | Keep; foundation |
| `release_artists` | 🔴 Missing | Create (Phase A) |
| `recordings.artist_id` | ⚠️ Legacy | Deprecate (Phase E) |
| `releases.release_artist_id` | ⚠️ Legacy | Deprecate (Phase E) |

---

## 🚀 Next Steps (Priority Order)

### This Week (Immediate)
1. **Read** [PHASE_2_SUMMARY.md](PHASE_2_SUMMARY.md) (5 min)
2. **Run** "verify artist_credits existence" query from PHASE_2_SUMMARY.md (1 min)
3. **Run** [SQL_VERIFICATION_QUERIES.sql](SQL_VERIFICATION_QUERIES.sql) Sections 1–4 (20 min)
4. **Share** findings with team; discuss Phase C timeline

### Next 1–2 Weeks (Phase A/B)
1. Review Phase A/B SQL drafts in [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md)
2. Deploy `20260710_create_release_artists.sql` to staging
3. Deploy `20260711_backfill_release_artists.sql` to staging
4. Verify: row counts, RLS policies, no duplicates
5. Deploy to production

### 1–2 Months (Phase C Planning)
1. Review code changes needed in [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) → Phase C section
2. Run full [PHASE_2_SQL_ANALYSIS.sql](PHASE_2_SQL_ANALYSIS.sql) to identify conflicts/performance issues
3. Plan code refactor: prioritize home page, then admin endpoints
4. Test all pages load correctly
5. Monitor for 2+ months for stability

### 6+ Months (Phase F Planning)
1. Verify zero references to legacy columns in codebase
2. Coordinate with external tools/dashboards
3. Plan removal; deploy with rollback plan

---

## 📚 Related Resources

### Database Schema
- **Source:** supabase/migrations/*.sql
- **Most recent:** 20260703003000_refactor_works_to_credited_works.sql
- **RLS setup:** 20260703002000_cleanup_rls_no_policy_info.sql

### App Code References
- **Home API:** src/lib/homeApi.ts (uses recordings.artist_id)
- **Song queries:** src/lib/queries/songs.ts (uses recording_credits)
- **Admin recordings:** src/app/api/admin/recordings/route.ts (uses artist_id, recording_credits)
- **Admin releases:** src/app/api/admin/releases/route.ts (uses release_artist_id)

### Functions & Procedures
- `get_artist_credited_works(artist_id)` — RPC available
- `get_release_artists(release_id)` — Recommended new function
- Analytics functions: `refresh_analytics_rollups()`, `analytics_health()`, etc.

---

## ⚠️ Known Issues / Action Items

### HIGH PRIORITY
- [ ] Verify if `artist_credits` table exists (referenced in admin code but not defined)
- [ ] Identify conflicts between `recordings.artist_id` and `recording_credits` (data consistency)
- [ ] Confirm `recordings_with_release_info` view dependencies on legacy fields

### MEDIUM PRIORITY
- [ ] Run [PHASE_2_SQL_ANALYSIS.sql](PHASE_2_SQL_ANALYSIS.sql) on production to validate assumptions
- [ ] Identify external tools querying `recordings.artist_id` or `releases.release_artist_id` directly
- [ ] Plan Phase C code changes (1–2 week effort estimate)

### LOW PRIORITY (6+ months out)
- [ ] Revisit `credited_works` FK design (is it too recording-specific?)
- [ ] Plan Phase F removal migration
- [ ] Create comprehensive data migration guide for external consumers

---

## 🔗 Cross-References

| If You're Asking... | See... |
|-------------------|---------|
| "What tables exist?" | [DATABASE_AUDIT.md](DATABASE_AUDIT.md) → Appendix (all 47 tables) |
| "Is this table safe to delete?" | [DECISION_MATRIX_FOR_UTILITY_TABLES.md](DECISION_MATRIX_FOR_UTILITY_TABLES.md) |
| "Why do we have recording_credits AND artist_id?" | [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) → Problems section |
| "How do I query credits?" | [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) → Recommended Final Model |
| "What's the migration plan?" | [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) → Five Phases section |
| "Are there data conflicts?" | [PHASE_2_SQL_ANALYSIS.sql](PHASE_2_SQL_ANALYSIS.sql) → Section 4 |
| "When can we remove legacy fields?" | [PHASE_2_SUMMARY.md](PHASE_2_SUMMARY.md) → Timeline (6+ months) |
| "What's the implementation checklist?" | [PHASE_2_SUMMARY.md](PHASE_2_SUMMARY.md) → Implementation Checklist |

---

## 📋 Approval & Sign-Off

These documents are **design documents** — not approved for implementation yet.

### Required Approvals Before Phase A/B Deployment
- [ ] Tech lead (architecture review)
- [ ] Product manager (timeline, scope)
- [ ] Data team (confirms backfill assumptions)

### Required Approvals Before Phase C Deployment
- [ ] QA lead (testing plan)
- [ ] Operations (deployment runbook, rollback plan)
- [ ] Product (confirms no feature conflicts)

---

## 📞 Questions?

Refer to the **FAQ** sections in:
- [PHASE_2_ARCHITECTURE_REVIEW.md](PHASE_2_ARCHITECTURE_REVIEW.md) → FAQ section
- [PHASE_2_SUMMARY.md](PHASE_2_SUMMARY.md) → Questions to Answer Before Phase C

---

## 📝 Document Version History

| Date | Document | Version | Status |
|------|----------|---------|--------|
| 2026-07-03 | DATABASE_AUDIT.md | 1.0 | ✅ Complete |
| 2026-07-03 | SQL_VERIFICATION_QUERIES.sql | 1.0 | ✅ Complete |
| 2026-07-03 | DECISION_MATRIX_FOR_UTILITY_TABLES.md | 1.0 | ✅ Complete |
| 2026-07-03 | PHASE_2_ARCHITECTURE_REVIEW.md | 1.0 | ✅ Complete |
| 2026-07-03 | PHASE_2_SQL_ANALYSIS.sql | 1.0 | ✅ Complete |
| 2026-07-03 | PHASE_2_SUMMARY.md | 1.0 | ✅ Complete |
| 2026-07-03 | ARCHITECTURE_AUDIT_INDEX.md | 1.0 | ✅ Complete |

---

## 🏁 Summary

**You now have:**
- ✅ Complete inventory of all 47 tables
- ✅ Risk assessment for each table
- ✅ Framework for deciding which tables to keep/drop
- ✅ Comprehensive credit model architecture review
- ✅ Five-phase migration plan (7 months, low-risk)
- ✅ Ready-to-deploy SQL migrations for Phase A/B
- ✅ Complete testing & verification queries

**Next action:** Schedule team review of PHASE_2_SUMMARY.md; answer 5 questions; deploy Phase A/B.

---

**Prepared by:** Architecture Audit Script  
**Status:** Design Complete | Ready for Implementation  
**Last Updated:** 2026-07-03
