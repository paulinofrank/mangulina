# Historical Report

**Status:** Historical Snapshot (2026-07-03)

**Current Source of Truth:**
- [DATA_GOVERNANCE.md](../../DATA_GOVERNANCE.md)
- [DATABASE_SCHEMA.md](../../DATABASE_SCHEMA.md) (once created)

**Purpose:**
Decision matrix for 7 utility/ingest tables that were classified as REVIEW in the Phase 1 database audit. Provides analysis to help determine which tables can be safely deprecated or dropped.

**Note:**
Use this report to understand the historical decision process, but consult current governance documents for the actual status of these tables.

---

# Decision Matrix: Utility/Ingest Tables Requiring Human Review

**Purpose:** Help determine which REVIEW-classified tables can be safely dropped.  
**Date:** 2026-07-03  
**Status:** 7 tables under review; **no drops recommended until decisions are made**

---

## Quick Reference Table

| Table | Row Estimate | File Refs | Last Used | Status | Recommendation |
|-------|--------------|-----------|-----------|--------|-----------------|
| genre_import_mapping | ? | 11 files | In active migrations | 🟡 REVIEW | **KEEP** — still part of taxonomy cleanup |
| odesli_batch_progress | ? | 1-2 files | Daily (batch job) | 🟡 REVIEW | **KEEP** — active feature |
| apple_recording_candidates | ? | 3 files | Unknown | 🔴 REVIEW | **Needs clarification** — Apple link feature status |
| wikidata_raw | ? | 1 file | Unknown | 🔴 REVIEW | **Needs clarification** — Is sync active? |
| cover_art_ingest_log | ? | 1 file | Unknown | 🔴 REVIEW | **Needs clarification** — Cover art process status |
| imported_reference_table | ? | 1 file | Unknown | 🔴 REVIEW | **Probably safe to DROP** — legacy import table |
| recording_classification_review | ? | 1 file | Unknown | 🔴 REVIEW | **Needs clarification** — AI review queue status |

---

## Detailed Analysis Per Table

### 1. genre_import_mapping

**Current Classification:** 🟡 KEEP (with caveats)

**File References:**
- supabase/migrations (11+ references across multiple migrations)
- Active in recent cleanups (20260612*, 20260703000000)

**What It Is:**
- Maps legacy/intermediate genre labels to the current taxonomy
- Created before genre taxonomy was consolidated into a single table
- Maintains historical mappings for data consistency during genre refactoring

**Status Indicators:**
- ✓ Still referenced in migration scripts
- ✓ Part of ongoing cleanup (see migration 20260703000000)
- ✓ No recent code changes, but not stale

**Decision Threshold:**
- **KEEP if:** Genre taxonomy refactoring is not 100% complete
- **DROP if:** All recording → genre mappings have been validated and final taxonomy is locked

**Action:**
1. Check commit messages for final genre taxonomy completion date
2. Verify with team: Is genre_import_mapping still needed for any ongoing migrations?
3. **Recommendation:** KEEP for now. The table is part of an incomplete cleanup cycle.

---

### 2. odesli_batch_progress

**Current Classification:** 🟢 KEEP (Confirmed active)

**File References:**
- `src/app/api/odesli-batch/route.ts` (1 file, active)

**What It Is:**
- Checkpoint table for the Odesli batch ingestion job
- Tracks offset/progress for paginated API requests
- Prevents re-processing and allows resumable jobs

**Status Indicators:**
- ✓ Referenced in an active API route handler
- ✓ Critical for stateful batch operations
- ✓ No alternative implementation visible

**Decision:**
- **CONFIRMED KEEP** — This is an active feature.

**Action:**
- No action needed. This is correctly classified as KEEP.

---

### 3. apple_recording_candidates

**Current Classification:** 🔴 REVIEW (Unclear status)

**File References:**
- supabase/migrations/20260703002000_cleanup_rls_no_policy_info.sql (1 reference in RLS setup)
- Unknown if referenced in current app code

**What It Is:**
- Experimental table for discovering Apple Music links for recordings
- Likely created for a feature to enrich recording metadata with Apple Music URLs

**Status Indicators:**
- ? No recent migration activity
- ? No clear code references in app/
- ? Table existence confirmed via RLS policy setup

**Unknowns:**
1. Is the Apple Music link enrichment feature actively maintained?
2. Are there scheduled jobs that populate this table?
3. Has the feature been abandoned in favor of Odesli links?

**Decision Thresholds:**
- **KEEP if:** Apple link ingestion is an active or near-term feature
- **DROP if:** Feature was experimental and no longer in scope

**Action:**
1. **Check:** Is there an active scheduled job or endpoint that populates apple_recording_candidates?
2. **Check:** Are Apple Music links served on the artist/recording pages?
3. **Ask:** Product/Engineering — "Is Apple Music link enrichment still an active feature?"
4. If feature is active → **KEEP**
5. If feature is abandoned → **SAFE TO DROP** (no FK dependencies expected)

---

### 4. wikidata_raw

**Current Classification:** 🔴 REVIEW (Unclear status)

**File References:**
- supabase/migrations/20260703002000_cleanup_rls_no_policy_info.sql (RLS setup only)
- Unknown app code references

**What It Is:**
- Raw data dump from Wikidata (Wikipedia's structured data source)
- Likely used for initial artist/composition metadata enrichment
- Could be a snapshot for reference or an actively synced dataset

**Status Indicators:**
- ? No clear update frequency
- ? Table mentioned only in RLS setup
- ? No app code directly references it

**Unknowns:**
1. Is Wikidata being actively synced, or is this a one-time import?
2. Are any artist/recording attributes sourced from this table?
3. Is it a backup snapshot or a working reference?

**Decision Thresholds:**
- **KEEP if:** Table is actively synced or serves as a reference for data validation
- **DROP if:** It was a one-time import for historical context and is no longer used

**Action:**
1. **Check:** Query to see if this table's data is younger than 90 days old (indicates active sync)
   ```sql
   SELECT max(updated_at) FROM public.wikidata_raw;
   ```
2. **Check:** Search for any Wikidata QID references in the codebase
   ```bash
   grep -r "wikidata\|wikidata_raw" src/
   ```
3. **Ask:** Data team — "Is Wikidata being actively synced into this table?"
4. If actively synced → **KEEP**
5. If one-time import (no updates in 60+ days) → **SAFE TO DROP** (after confirming no code dependency)

---

### 5. cover_art_ingest_log

**Current Classification:** 🔴 REVIEW (Unclear status)

**File References:**
- supabase/migrations/20260703002000_cleanup_rls_no_policy_info.sql (RLS setup only)

**What It Is:**
- Audit log for cover art ingestion process
- Likely tracks which cover images were downloaded, from which sources, success/failure
- Could be for debugging or compliance

**Status Indicators:**
- ? No recent migration activity
- ? No app code references detected
- ? Mentioned in RLS setup suggests it exists

**Unknowns:**
1. Is the cover art ingestion process still running?
2. Is this log actively written to?
3. Is the log needed for compliance or debugging?

**Decision Thresholds:**
- **KEEP if:** Cover art ingestion is active or the log is required for audit/compliance
- **DROP if:** Cover art is no longer ingested and the log serves no purpose

**Action:**
1. **Check:** See if this table has recent entries
   ```sql
   SELECT max(created_at) FROM public.cover_art_ingest_log;
   ```
2. **Check:** Is there a scheduled job for cover art ingestion?
   ```sql
   SELECT * FROM pg_cron.job WHERE database = 'mangulina';
   ```
3. **Ask:** DevOps/Infrastructure — "Is the cover art ingestion job still running?"
4. If job is active → **KEEP**
5. If job is disabled/removed → **SAFE TO DROP** (after confirming table has no downstream dependencies)

---

### 6. imported_reference_table

**Current Classification:** 🔴 REVIEW (Likely safe to drop)

**File References:**
- supabase/migrations/20260703002000_cleanup_rls_no_policy_info.sql (RLS setup only)

**What It Is:**
- Generic name suggests this is a temporary table from a past data import
- Likely used to load a reference dataset during initial schema setup or a one-time bulk migration
- Now possibly obsolete

**Status Indicators:**
- ❌ No code references outside of RLS setup
- ❌ Generic table name (not descriptive)
- ❌ No migration activity suggests it's not part of ongoing processes

**Unknowns:**
1. What data does this table contain? (name doesn't clarify)
2. Was it used for a one-time import or is it still needed?
3. Are any views/functions dependent on it?

**Decision Thresholds:**
- **KEEP if:** It's referenced by views, materialized views, or functions not yet detected
- **DROP if:** It was a temporary staging table for a completed import

**Action:**
1. **Check:** Look for any views or functions that might reference it
   ```sql
   SELECT definition FROM pg_views WHERE definition ILIKE '%imported_reference_table%';
   SELECT routine_definition FROM information_schema.routines WHERE routine_definition ILIKE '%imported_reference_table%';
   ```
2. **Check:** Look for any foreign key references to it
   ```sql
   SELECT * FROM information_schema.constraint_column_usage WHERE table_name = 'imported_reference_table';
   ```
3. **Check:** When was it last modified?
   ```sql
   SELECT * FROM public.imported_reference_table LIMIT 1; -- to see structure
   ```
4. **Recommendation:** This table name is suspiciously generic and lacks any code references.
   - If the above checks show no dependencies → **SAFE TO DROP**
   - If any dependencies found → **KEEP and rename to something descriptive**

---

### 7. recording_classification_review

**Current Classification:** 🔴 REVIEW (Unclear status)

**File References:**
- supabase/migrations/20260703002000_cleanup_rls_no_policy_info.sql (RLS setup only)

**What It Is:**
- Staging/queue table for recordings that have been AI-classified and are awaiting human review
- Part of a QA workflow for AI classification accuracy
- Could be active or abandoned depending on whether the QA workflow is in use

**Status Indicators:**
- ? No recent migration activity
- ? No clear app code references (might be admin-only)
- ? Mentioned in RLS setup

**Unknowns:**
1. Is there an active AI classification feature?
2. Do humans regularly review classifications in this queue?
3. Is the table actively populated?

**Decision Thresholds:**
- **KEEP if:** AI classification QA workflow is active
- **DROP if:** AI classification has been fully automated or feature was experimental

**Action:**
1. **Check:** Does this table have data?
   ```sql
   SELECT count(*), max(created_at) FROM public.recording_classification_review;
   ```
2. **Check:** Is there a Postgres function or scheduled job that populates it?
   ```sql
   SELECT routine_definition FROM information_schema.routines WHERE routine_definition ILIKE '%recording_classification_review%';
   ```
3. **Check:** Is there an admin page for reviewing classifications?
   ```bash
   grep -r "recording_classification_review" src/app/admin/
   ```
4. **Ask:** Data team — "Is the AI classification QA review process still active?"
5. If active → **KEEP**
6. If abandoned → **SAFE TO DROP** (after confirming no external dependencies)

---

## Decision Framework

### Before Dropping Any Table

**Mandatory Checks (in order):**

1. ✓ **Row count & recency**
   ```sql
   SELECT count(*), max(created_at) FROM public.<table_name>;
   ```

2. ✓ **Foreign key references** (other tables pointing to it)
   ```sql
   SELECT * FROM information_schema.constraint_column_usage WHERE table_name = '<table_name>';
   ```

3. ✓ **View/function dependencies**
   ```sql
   SELECT definition FROM pg_views WHERE definition ILIKE '%<table_name>%';
   SELECT routine_definition FROM information_schema.routines WHERE routine_definition ILIKE '%<table_name>%';
   ```

4. ✓ **Code references** (app code, migrations, scripts)
   ```bash
   grep -r "<table_name>" src/ supabase/
   ```

5. ✓ **RLS policies** (remove before drop)
   ```sql
   SELECT * FROM pg_policies WHERE tablename = '<table_name>';
   DROP POLICY ... ON public.<table_name>;
   ```

6. ✓ **Stakeholder confirmation**
   - Product: "Is this feature still in scope?"
   - Data: "Is this table still being populated?"
   - Ops: "Are there scheduled jobs using this?"

---

## Risk Assessment Matrix

|  | **No Dependencies** | **1-2 Dependencies** | **3+ Dependencies** |
|---|---|---|---|
| **No code refs** | ✅ Safe to drop | ⚠️ Review first | ❌ Keep |
| **1 code ref** | ⚠️ Review context | ⚠️ Review context | ❌ Keep |
| **2+ code refs** | ⚠️ Review first | ⚠️ Review first | ❌ Keep |
| **Recently updated** | ⚠️ Likely still used | ✅ Probably need it | ❌ Keep |
| **Not updated 60+ days** | ✅ Likely obsolete | ⚠️ Review | ⚠️ Review |

---

## Recommended Action Plan

### Phase 1: Information Gathering (Week 1)

**Tasks:**
1. Run SQL verification queries (Section 13-14 of SQL_VERIFICATION_QUERIES.sql)
2. Check timestamps and row counts
3. Search codebase for hidden references
4. Identify scheduled jobs that might populate tables

**Estimated effort:** 2-3 hours

---

### Phase 2: Stakeholder Interviews (Week 1)

**Questions for Product:**
- Is the Apple Music link feature still planned?
- Is the AI classification review workflow active?
- What's the status of experimental features?

**Questions for Data/Analytics:**
- Is Wikidata being synced actively?
- Is cover art still being ingested?
- What's the purpose of imported_reference_table?

**Questions for DevOps/Infrastructure:**
- Which scheduled jobs are running?
- Which ingest processes are active?

**Estimated effort:** 1-2 hours (if decisions are available)

---

### Phase 3: Final Classification (Week 2)

**Decision grid:**
- [ ] apple_recording_candidates → KEEP or DROP?
- [ ] wikidata_raw → KEEP or DROP?
- [ ] cover_art_ingest_log → KEEP or DROP?
- [ ] imported_reference_table → KEEP or DROP?
- [ ] recording_classification_review → KEEP or DROP?

**For each table marked as DROP:**
1. Write a migration with CREATE TABLE (backup) before DROP
2. Test in staging environment
3. Verify app logs for errors
4. Deploy with runbook for rollback

---

### Phase 4: Cleanup Migration (Week 2-3)

**Only after Phase 2 decisions are made:**

1. Create migration file: `20260710_drop_unused_utility_tables.sql`
2. Include:
   - Backup CREATE TABLE statements (for rollback)
   - RLS policy cleanup
   - DROP TABLE statements
   - NOTIFY pgrst reload
3. Test in staging
4. Deploy during low-traffic window
5. Monitor for 24 hours

---

## Example Cleanup Migration (Template)

```sql
-- supabase/migrations/20260710_drop_unused_utility_tables.sql
BEGIN;

-- Backup before drop (run these as SELECT INTO if needed)
-- CREATE TABLE IF NOT EXISTS public.<table_name>_backup_before_drop AS
-- SELECT * FROM public.<table_name>;

-- Drop RLS policies
DROP POLICY IF EXISTS "Allow service role manage <table_name>" ON public.<table_name>;

-- Drop the table
DROP TABLE IF EXISTS public.<table_name>;

NOTIFY pgrst, 'reload schema';

COMMIT;
```

---

## Summary: Next Steps

1. **Do NOT drop any of these tables yet** — This audit is informational.
2. **Run verification queries** to confirm assumptions about row counts and usage
3. **Interview stakeholders** to understand whether features are active
4. **Re-evaluate** based on actual findings, not speculation
5. **Create a cleanup migration** only after decisions are confirmed

---

**Last Updated:** 2026-07-03  
**Review Frequency:** As needed, or before any schema cleanup initiative  
**Owner:** Database Audit (Team review recommended)
