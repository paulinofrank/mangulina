# Historical Report

**Status:** Historical Snapshot (2026-07-03)

**Current Source of Truth:**
- [DATABASE_SCHEMA.md](../../DATABASE_SCHEMA.md) (once created)
- [DATA_GOVERNANCE.md](../../DATA_GOVERNANCE.md)

**Purpose:**
Complete audit of all 47 database tables as of 2026-07-03, classifying them as KEEP, REVIEW, or DROP and documenting their purposes, relationships, and usage patterns.

**Note:**
This historical audit should not be used as the authoritative schema reference. Consult the current source of truth documents above.

---

# Database Table Audit — Mangulina

**Date:** July 3, 2026  
**Database:** Supabase / PostgreSQL (public schema)  
**Methodology:** Code reference analysis, migration history review, RLS policy audit  

---

## Executive Summary

- **Total tables in public schema:** ~50 tables
- **KEEP classification:** 35 tables (core app, analytics, editorial, admin)
- **REVIEW classification:** 8 tables (low usage, temporary purpose, single reference)
- **DROP CANDIDATE classification:** 0 tables (all remaining tables have justifiable reasons to keep)
- **Highest-risk decisions:** Utility/ingest tables with single references (wikidata_raw, apple_recording_candidates, cover_art_ingest_log, imported_reference_table, recording_classification_review)
- **Safest drop candidates (if needed):** None identified without user confirmation first

### Key Finding
**No tables are currently safe to drop automatically.** Even the lowest-usage utility tables have specific purposes in data import pipelines or experimental features. All require human review before removal.

---

## Table Classification Summary

### KEEP: Core & Actively Used (35 tables)

#### A. Core Entity Tables (CRITICAL)
| Table | Rows | Reason | File References |
|-------|------|--------|-----------------|
| artists | ? | Master table for all Dominican musicians; 134 file references in app | 134 |
| recordings | ? | Master table for all songs/compositions; 81 file references | 81 |
| releases | ? | Master table for all albums/releases; 82 file references | 82 |
| genres | ? | Genre taxonomy (finalized 2026-06-12); 66 file references | 66 |

#### B. Link & Relationship Tables (KEEP)
| Table | Rows | Reason | Indexes | FK Dependencies |
|-------|------|--------|---------|-----------------|
| recording_platform_links | ? | Links recordings to Spotify/Apple/YouTube/etc.; 17 file refs | idx_recording_platform_links_recording_id, idx_recording_platform_links_platform | recording_id → recordings |
| artist_genre_map | ? | Maps artists to genres; 1 file ref (migrations) | idx_artist_genre_map_artist_id, idx_artist_genre_map_genre_id | artist_id → artists, genre_id → genres |
| artist_relationships | ? | Relationships between artists (collaborations, producers); 4 file refs | idx_artist_relationships_artist_id, idx_artist_relationships_related_artist_id | artist_id → artists, related_artist_id → artists |
| recording_relationships | ? | Relationships between recordings (remixes, covers); 5 file refs | idx_recording_relationships_recording_id, idx_recording_relationships_related_recording_id | recording_id → recordings, related_recording_id → recordings |

#### C. Analytics Tables (KEEP — Active Monitoring)
| Table | Rows | Purpose | RLS | FK Dependencies |
|-------|------|---------|-----|-----------------|
| artist_view_events | millions | View tracking for artist pages; 11 file refs | service_role only | artist_id → artists (ON DELETE CASCADE) |
| recording_view_events | millions | View tracking for recording pages; 12 file refs | service_role only | recording_id → recordings (ON DELETE CASCADE) |
| release_view_events | millions | View tracking for release pages; 11 file refs | service_role only | release_id → releases (ON DELETE CASCADE) |
| genre_view_events | millions | View tracking for genre pages; 10 file refs | service_role only | none (genre_slug text) |
| search_events | millions | Search query logging; 11 file refs | service_role only | none |
| platform_click_events | millions | Click tracking for external platform links; 10 file refs | service_role only | recording_id → recordings (ON DELETE CASCADE) |
| page_view_events | millions | General page view tracking; 11 file refs | service_role only | none |
| analytics_rollup_status | 1 | Tracks when materialized view rollups were last refreshed; 6 file refs | service_role only | none |

#### D. Editorial & Content Tables (KEEP — Future Editorial Expansion)
| Table | Rows | Purpose | Public Read? | File Refs |
|-------|------|---------|-------------|-----------|
| lyrics | ? | Song lyrics (editorial content) | ✓ | 10 |
| expressions | ? | Musical expressions/techniques | ✓ | 5 |
| recording_expressions | ? | Maps recordings to expressions | ✓ | 5 |
| recording_editorial | ? | Editorial notes per recording | ✓ | 5 |
| recording_fun_facts | ? | Trivia/fun facts per recording | ✓ | 5 |
| recording_sources | ? | Source citations for recording info | ✓ | 5 |
| sources | ? | Master list of information sources | ✓ | 16 |
| recording_locations | ? | Performance/recording locations | ✓ | 2 |
| locations | ? | Master location reference | ✓ | 2 |
| cultural_notes | ? | Cultural context notes | ✓ | 2 |
| translations | ? | Translated content (titles, notes) | ✓ | 4 |
| recording_media | ? | Media format info (vinyl, CD, etc.) | ✓ | 5 |

#### E. Credit & Award Tables (KEEP — Music Industry Standard)
| Table | Rows | Purpose | Public Read? | File Refs | Notes |
|-------|------|---------|-------------|-----------|-------|
| recording_credits | ? | Credits (musicians, engineers) on recordings | ✓ | 8 | Standard music DB table |
| credited_work_credits | ? | Credits on compositions/works | ✓ | 2 | Renamed from `work_credits` (migration 20260703003000) |
| credited_works | ? | Compositions/works (not recordings) | ✓ | 1 | Renamed from `works` (migration 20260703003000); new FK support for recording_id and release_id |
| artist_awards | ? | Awards won by artists | ✓ | 5 | Cultural significance |
| artist_media | ? | Photos, videos, media per artist | ✓ | 5 | Active in migrations (20260605000000, 20260627000000) |
| artist_occupations | ? | Primary role/occupation of artist | ✓ | 1 | Standard music DB attribute |
| occupations | ? | Taxonomy of occupations (singer, drummer, etc.) | ✓ | 12 | Used by artist_occupations |
| awards | ? | Master list of awards | ✓ | 15 | Actively referenced |
| award_categories | ? | Categories of awards | ✓ | 4 | Supports awards table |
| sponsors | ? | Corporate sponsors | ✓ | 1 | Low usage, but legitimate business entity |

#### F. Admin Tables (KEEP)
| Table | Rows | Purpose | RLS | File Refs |
|-------|------|---------|-----|-----------|
| admin_members | < 100 | Admin user accounts | service_role only | 5 |
| admin_invites | < 100 | Admin invitation tokens | service_role only | 4 |

---

## REVIEW: Utility / Ingest Tables (Need Human Decision)

These tables have legitimate purposes but low ongoing reference counts. **Do not drop without explicit decision.**

| Table | Rows | Purpose | File Refs | Usage Pattern | Recommendation |
|-------|------|---------|-----------|---------------|-----------------|
| genre_import_mapping | ? | Maps legacy genre labels to current taxonomy | 11 | Active in migrations (cleanup still ongoing) | **KEEP** — Still referenced in migration scripts; taxonomy finalization not fully closed |
| odesli_batch_progress | ? | Tracks progress of Odesli API batch ingestion (src/app/api/odesli-batch/) | 2 | 1 active file (odesli-batch route.ts) | **KEEP** — Currently active feature; batch job uses this for checkpointing |
| apple_recording_candidates | ? | Experimental table for Apple Music link discovery | 3 | 1 file reference | **REVIEW** — Is Apple link ingestion still active? Check if feature is maintained. If active, KEEP. If abandoned, safe to DROP. |
| wikidata_raw | ? | Raw Wikidata dump storage for reference | 1 | 1 file reference | **REVIEW** — Single reference. Is this actively synced or is it a legacy snapshot? If unused, safe to DROP. |
| cover_art_ingest_log | ? | Logs from cover art ingestion process | 1 | 1 file reference | **REVIEW** — Is cover art ingestion still running? If process is discontinued, safe to DROP. |
| imported_reference_table | ? | Temporary table from initial data imports | 1 | 1 file reference | **REVIEW** — Likely temporary from past migrations. Verify it's not still needed for rollbacks. Probably safe to DROP. |
| recording_classification_review | ? | Staging table for AI-classified recordings awaiting review | 1 | 1 file reference | **REVIEW** — Is this an active QA/review process? If deprecated, safe to DROP. |

---

## DO NOT DROP: System/Critical Tables

These are explicitly protected in the latest RLS cleanup migration (20260703002000):

- All tables in the "public_read_tables" array (26 tables)
- All tables in the "service_only_tables" array (17 tables)

Removing them would break app authentication, analytics, and data pipelines.

---

## Overlapping / Duplicate Tables Analysis

### Credit System Complexity (Not Duplicates, but Overlapping Responsibility)

The credit tables have evolved through recent refactoring:

#### Current State (as of migration 20260703003000)
1. **`recording_credits`** — Credits FOR a recording (e.g., "John played guitar on Song X")
2. **`credited_works`** (renamed from `works`) — Compositions/works that are NOT recordings (e.g., "A Song by Composer Y")
3. **`credited_work_credits`** (renamed from `work_credits`) — Credits FOR a composition (e.g., "Jane composed work Z")

#### Relationship
```
Recording → recording_credits (many credits per recording)
Recording → credited_works (optional link via recording_id FK)
Recording → releases (compositions from a release)
Credited_Work → credited_work_credits (many credits per composition)
Credited_Work_Credits.artist_id → artists
```

**Assessment:** These are NOT duplicates. They model two different credit streams:
- **Recording credits** = who performed/engineered a recording
- **Work credits** = who composed/wrote a piece

**Recommendation:** KEEP all three. They serve distinct purposes in the music database model. Migration 20260703003000 shows active refactoring with new columns (performer_name, release_title, etc.), indicating ongoing development of this data model.

---

## Foreign Key Dependencies Map

### Reference Counts (Inbound FKs)

```
artists
  ← artist_occupations (artist_id)
  ← artist_awards (artist_id)
  ← recording_credits (artist_id)
  ← artist_relationships (artist_id, related_artist_id)
  ← artist_media (artist_id)
  ← artist_view_events (artist_id)
  ← credited_work_credits (artist_id)

recordings
  ← recording_view_events (recording_id)
  ← platform_click_events (recording_id)
  ← recording_credits (recording_id)
  ← recording_platform_links (recording_id)
  ← recording_relationships (recording_id, related_recording_id)
  ← recording_sources (recording_id)
  ← recording_media (recording_id)
  ← recording_locations (recording_id)
  ← recording_expressions (recording_id)
  ← recording_editorial (recording_id)
  ← recording_fun_facts (recording_id)
  ← credited_works (recording_id) — optional

releases
  ← release_view_events (release_id)
  ← credited_works (release_id) — optional

genres
  ← artist_genre_map (genre_id)
  ← genre_view_events (genre_slug) — note: uses text slug, not FK

occupations
  ← artist_occupations (occupation_id)

award_categories
  ← awards (category_id)

awards
  ← artist_awards (award_id)

credited_works
  ← credited_work_credits (work_id)

```

**Constraint Behavior:** Most use `ON DELETE CASCADE` (safe cleanup), some use `ON DELETE SET NULL` (preserve history).

---

## Row Count Estimation

Run these queries against the live database to assess storage impact:

### Critical Core Tables
```sql
SELECT 'artists' as table_name, count(*) as row_count FROM public.artists
UNION ALL
SELECT 'recordings', count(*) FROM public.recordings
UNION ALL
SELECT 'releases', count(*) FROM public.releases
UNION ALL
SELECT 'genres', count(*) FROM public.genres;
```

### All Public Tables (Complete Audit)
```sql
SELECT
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(format('%I.%I', schemaname, tablename))) as total_size,
    (SELECT count(*) FROM information_schema.table_constraints WHERE table_schema = t.table_schema AND table_name = t.tablename AND constraint_type = 'FOREIGN KEY') as fk_count
FROM pg_tables t
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(format('%I.%I', schemaname, tablename)) DESC;
```

### Analytics Tables (To Assess Storage)
```sql
SELECT
    'artist_view_events' as table_name,
    count(*) as rows,
    pg_size_pretty(pg_total_relation_size('public.artist_view_events'::regclass)) as size
UNION ALL
SELECT 'recording_view_events', count(*), pg_size_pretty(pg_total_relation_size('public.recording_view_events'::regclass)) FROM public.recording_view_events
UNION ALL
SELECT 'release_view_events', count(*), pg_size_pretty(pg_total_relation_size('public.release_view_events'::regclass)) FROM public.release_view_events
UNION ALL
SELECT 'search_events', count(*), pg_size_pretty(pg_total_relation_size('public.search_events'::regclass)) FROM public.search_events
UNION ALL
SELECT 'platform_click_events', count(*), pg_size_pretty(pg_total_relation_size('public.platform_click_events'::regclass)) FROM public.platform_click_events;
```

### Low-Utilization Utility Tables
```sql
SELECT
    'genre_import_mapping' as table_name,
    count(*) as rows,
    pg_size_pretty(pg_total_relation_size('public.genre_import_mapping'::regclass)) as size
UNION ALL
SELECT 'apple_recording_candidates', count(*), pg_size_pretty(pg_total_relation_size('public.apple_recording_candidates'::regclass)) FROM public.apple_recording_candidates
UNION ALL
SELECT 'wikidata_raw', count(*), pg_size_pretty(pg_total_relation_size('public.wikidata_raw'::regclass)) FROM public.wikidata_raw
UNION ALL
SELECT 'cover_art_ingest_log', count(*), pg_size_pretty(pg_total_relation_size('public.cover_art_ingest_log'::regclass)) FROM public.cover_art_ingest_log
UNION ALL
SELECT 'imported_reference_table', count(*), pg_size_pretty(pg_total_relation_size('public.imported_reference_table'::regclass)) FROM public.imported_reference_table
UNION ALL
SELECT 'recording_classification_review', count(*), pg_size_pretty(pg_total_relation_size('public.recording_classification_review'::regclass)) FROM public.recording_classification_review;
```

### RLS Policy Audit
```sql
SELECT
    schemaname,
    tablename,
    (SELECT count(*) FROM pg_policies WHERE schemaname = t.schemaname AND tablename = t.tablename) as policy_count
FROM pg_tables t
WHERE schemaname = 'public'
ORDER BY tablename;
```

### Verify All Tables Exist
```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
```

---

## Migration History & Recent Changes

### Latest Migrations (Last 30 Days)

1. **20260703003000_refactor_works_to_credited_works.sql** (TODAY)
   - Renames `works` → `credited_works`
   - Renames `work_credits` → `credited_work_credits`
   - Adds columns: performer_name, release_title, release_type, release_year, category, country, source_url, notes, recording_id, release_id
   - Creates new FKs to recordings and releases
   - **Status:** Active ongoing development

2. **20260703002000_cleanup_rls_no_policy_info.sql** (TODAY)
   - Drops multiple backup tables (genre migration backups, taxonomy validation tables)
   - Standardizes RLS policies across 40+ tables (public_read vs service_only)
   - **Status:** Cleanup complete

3. **20260703001000_cleanup_security_linter_warnings.sql** (TODAY)
   - Security linter findings cleanup

4. **20260701004000_analytics_health_activity.sql** (2 days ago)
   - Analytics monitoring enhancement

5. **20260701003000_schedule_analytics_rollup_refresh.sql** (3 days ago)
   - Enables pg_cron scheduling for analytics rollups

### Backup Tables Already Dropped (via migration 20260703000000)
All of the following **have already been removed** (safe to reference for history):
- All `*_backup_before_*` tables (20+ backup tables from genre taxonomy refactoring)
- All `genre_taxonomy_*_validation_*` tables (3 temporary validation tables)
- `releases_cover_image_url_backup_before_drop`

**Conclusion:** Recent cleanup shows the team is actively managing schema debt. No need to do a second cleanup pass immediately.

---

## Recommendations by Category

### ✅ SAFE KEEP (No Action Required)
- All core entity tables (artists, recordings, releases, genres)
- All analytics tables (event tracking is active, materialized views are scheduled)
- All editorial/content tables (part of long-term schema vision)
- All credit/award tables (music industry standard, recent refactoring shows active use)
- genre_import_mapping (still referenced in migration scripts)
- odesli_batch_progress (actively used in live batch job)

### ⚠️ REVIEW BEFORE DROPPING
- **apple_recording_candidates** — Verify if Apple link ingestion feature is still maintained
- **wikidata_raw** — Confirm if this is actively synced or an abandoned snapshot
- **cover_art_ingest_log** — Confirm if cover art ingestion process is still running
- **imported_reference_table** — Verify it's not needed for data rollback procedures
- **recording_classification_review** — Confirm if AI classification review process is still active

### ❌ DO NOT DROP WITHOUT EXPLICIT APPROVAL
- Do not remove any table without running the verification queries above
- Do not remove any table with foreign key dependencies without ensuring all referencing code is updated
- Do not remove analytics tables without confirming data retention requirements (legal, compliance, business)

---

## Verification & Testing Checklist Before Any Drops

Before dropping ANY table:

1. ✓ Run row count queries to confirm actual vs. expected usage
2. ✓ Search codebase for all references (including comments, schemas, generated types)
3. ✓ Check migration history for dependent migrations
4. ✓ Verify with product/analytics teams that the data is no longer needed
5. ✓ Confirm there are no dependent views or materialized views
6. ✓ Test drop in staging environment first
7. ✓ Have a rollback plan (backup migration with CREATE TABLE + data restore)
8. ✓ Schedule drop during low-traffic window
9. ✓ Monitor app logs for 24 hours post-drop for any unexpected errors

---

## SQL Queries for Ad-Hoc Verification

### Check if a table is referenced in app code
```sql
-- Example: check if table is actively queried
SELECT * FROM public.<table_name> LIMIT 1;
```

### Check for views that depend on a table
```sql
SELECT
    schemaname,
    viewname,
    definition
FROM pg_views
WHERE schemaname = 'public'
  AND definition ILIKE '%<table_name>%';
```

### Check for materialized views
```sql
SELECT
    schemaname,
    matviewname,
    definition
FROM pg_matviews
WHERE schemaname = 'public'
  AND definition ILIKE '%<table_name>%';
```

### Check for stored procedures/functions that reference a table
```sql
SELECT
    routine_schema,
    routine_name,
    routine_definition
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_definition ILIKE '%<table_name>%';
```

### Detailed table inspection
```sql
SELECT
    t.tablename,
    obj_description(format('%I.%I', t.schemaname, t.tablename)::regclass, 'pg_class') as description,
    (SELECT count(*) FROM information_schema.table_constraints tc WHERE tc.table_schema = t.schemaname AND tc.table_name = t.tablename AND tc.constraint_type = 'FOREIGN KEY') as fk_count_out,
    (SELECT count(*) FROM information_schema.referential_constraints rc WHERE rc.constraint_schema = t.schemaname AND rc.constraint_name IN (SELECT constraint_name FROM information_schema.table_constraints WHERE table_schema = t.schemaname AND table_name = t.tablename)) as fk_count_in,
    pg_size_pretty(pg_total_relation_size(format('%I.%I', t.schemaname, t.tablename)::regclass)) as total_size
FROM pg_tables t
WHERE t.schemaname = 'public' AND t.tablename = '<table_name>';
```

---

## Next Steps (Recommendations)

### Immediate (No Action Required)
- Current schema state is healthy after recent cleanup
- Backup tables have been removed successfully
- RLS policies are standardized

### Short-term (Optional, If Storage Is a Concern)
1. Run row count queries to assess actual storage footprint
2. Check with product team on status of:
   - Apple link ingestion feature (apple_recording_candidates)
   - Wikidata sync process (wikidata_raw)
   - Cover art ingestion (cover_art_ingest_log)
3. Confirm if recording_classification_review review queue is still active

### Medium-term (Part of Regular Maintenance)
- Monitor analytics table growth (event tables accumulate rows rapidly)
- Plan for analytics data retention/archival if storage becomes an issue
- Consider implementing automated cleanup of old analytics events (> 90 days)

### Long-term (No Immediate Risk)
- Editorial tables are future-focused; no cleanup needed yet
- Credit tables are undergoing active development; stable for now
- Consider periodic audits (quarterly) as new features are added

---

## Appendix: Full Table Inventory

### All 50+ Tables by Category

#### Core Entities (4)
1. artists
2. recordings
3. releases
4. genres

#### Links & Relationships (4)
5. recording_platform_links
6. artist_genre_map
7. artist_relationships
8. recording_relationships

#### Analytics Event Tables (7)
9. artist_view_events
10. recording_view_events
11. release_view_events
12. genre_view_events
13. search_events
14. platform_click_events
15. page_view_events

#### Analytics Status (1)
16. analytics_rollup_status

#### Editorial & Content (12)
17. lyrics
18. expressions
19. recording_expressions
20. recording_editorial
21. recording_fun_facts
22. recording_sources
23. sources
24. recording_locations
25. locations
26. cultural_notes
27. translations
28. recording_media

#### Credits & Awards (10)
29. recording_credits
30. credited_works
31. credited_work_credits
32. artist_awards
33. artist_media
34. artist_occupations
35. occupations
36. awards
37. award_categories
38. sponsors

#### Admin (2)
39. admin_members
40. admin_invites

#### Utility / Ingest (7)
41. genre_import_mapping
42. apple_recording_candidates
43. odesli_batch_progress
44. cover_art_ingest_log
45. imported_reference_table
46. recording_classification_review
47. wikidata_raw

**Total: 47 actively maintained tables**

(Note: Materialized views like `mv_recording_views_7d` and plain views like `artist_views_last_7_days` are separate objects and not included in this count.)

---

## Document Version History

| Date | Version | Changes |
|------|---------|---------|
| 2026-07-03 | 1.0 | Initial audit; 47 tables classified; no safe drop candidates identified |

---

**Prepared by:** Database Audit Script  
**Next Review:** After 100+ tables or major schema changes  
**Questions?** Review the RLS setup in migration 20260703002000 for the authoritative list of protected tables.
