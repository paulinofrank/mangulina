# Database Schema Reference

**Mangulina Database — Current Schema Documentation**

This is the authoritative technical reference for the Mangulina database schema. It documents every table, column, relationship, and constraint as of the current version.

**Related Documents:**
- [DATA_GOVERNANCE.md](DATA_GOVERNANCE.md) — Conceptual data model and editorial rules
- [ARCHITECTURAL_DECISIONS.md](ARCHITECTURAL_DECISIONS.md) — Why the schema is structured this way
- [docs/reports/database/](docs/reports/database/) — Historical schema audits and analysis

---

## Table of Contents

- [Core Entities](#core-entities)
- [Credit Models](#credit-models)
- [Media and Content](#media-and-content)
- [Metadata](#metadata)
- [Utility Tables](#utility-tables)
- [Views and Functions](#views-and-functions)
- [Index Summary](#index-summary)

---

## Core Entities

### artists

**Purpose:** Core artist/person entity for Dominican music database

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| name | text | NO | Canonical artist name |
| slug | text | NO | URL-safe identifier |
| bio | text | YES | Artist biography |
| bio_es | text | YES | Spanish biography |
| birth_date | date | YES | Birth date |
| status | text | NO | published, draft, inactive |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Relationships:**
- `recording_credits.artist_id` → one-to-many
- `credited_work_credits.artist_id` → one-to-many
- `release_artists.artist_id` → one-to-many

**Indexes:**
- Primary key on `id`
- Unique on `slug`
- Index on `status`

**Notes:**
- `slug` must be unique and URL-safe
- `bio` and `bio_es` support full biography content
- Status controls publication/visibility

---

### works

**Purpose:** Musical compositions (not specific recordings or releases)

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| title | text | NO | Composition title |
| title_es | text | YES | Spanish title |
| slug | text | NO | URL-safe identifier |
| description | text | YES | Context about the work |
| status | text | NO | published, draft, inactive |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Relationships:**
- `recordings.work_id` → one-to-many (one work can be recorded multiple times)
- `credited_work_credits.work_id` → one-to-many

**Indexes:**
- Primary key on `id`
- Unique on `slug`
- Index on `status`

**Notes:**
- Represents the underlying composition (distinct from recordings)
- Same work can be recorded by different artists
- Composers and lyricists are credited at this level via `credited_work_credits`

---

### recordings

**Purpose:** Individual audio recordings (performances of a work)

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| work_id | uuid | NO | FK to works |
| title | text | NO | Recording title |
| title_es | text | YES | Spanish title |
| artist_id | uuid | YES | Legacy: primary artist (DEPRECATED—use recording_credits instead) |
| duration_ms | integer | YES | Duration in milliseconds |
| isrc | text | YES | International Standard Recording Code |
| recorded_date | date | YES | Recording date |
| release_year | integer | YES | Year released |
| status | text | NO | published, draft, inactive |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Relationships:**
- `works.id` (FK) → one work can have many recordings
- `recording_credits.recording_id` ← one-to-many (performers)
- `releases.id` ← one-to-many (can appear on multiple releases)

**Indexes:**
- Primary key on `id`
- Index on `work_id`
- Index on `artist_id` (legacy)
- Index on `isrc`
- Index on `status`

**Notes:**
- **`artist_id` is DEPRECATED** — Use `recording_credits` with vocalist/performer role instead
- Kept for backward compatibility (see ADR-006)
- Each recording has one underlying work but can be on many releases
- `isrc` enables linking to external databases

---

### recording_credits

**Purpose:** Credits performers on a recording (vocalists, musicians, engineers, producers)

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| recording_id | uuid | NO | FK to recordings |
| artist_id | uuid | NO | FK to artists |
| role | text | NO | vocal, guitar, producer, etc. |
| display_order | integer | YES | Order for display |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Relationships:**
- `recordings.id` (FK) → which recording
- `artists.id` (FK) → which artist

**Indexes:**
- Primary key on `id`
- Index on `recording_id`
- Index on `artist_id`
- Unique constraint on (recording_id, artist_id, role) to prevent duplicates

**RLS Policies:**
- Enable read access for published recordings
- Restrict write to authenticated admin

**Notes:**
- Credits the actual performers on this specific recording
- Role must be from [ROLE_DICTIONARY.md](ROLE_DICTIONARY.md)
- `display_order` controls presentation order
- Replace use of `recordings.artist_id` with this table

---

### credited_work_credits

**Purpose:** Credits creators of a composition (composers, lyricists, arrangers)

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| work_id | uuid | NO | FK to credited_works |
| artist_id | uuid | NO | FK to artists |
| role | text | NO | composer, lyricist, arranger, etc. |
| display_order | integer | YES | Order for display |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Relationships:**
- `credited_works.id` (FK) → which work
- `artists.id` (FK) → which artist

**Indexes:**
- Primary key on `id`
- Index on `work_id`
- Index on `artist_id`
- Unique constraint on (work_id, artist_id, role)

**Notes:**
- Credits the creators of the composition (not performers)
- Role must be from [ROLE_DICTIONARY.md](ROLE_DICTIONARY.md)
- `display_order` controls presentation order
- Example: Juan Luis Guerra as composer of "Bachata Rosa"

---

### releases

**Purpose:** Albums, singles, EPs released as products

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| title | text | NO | Release title |
| title_es | text | YES | Spanish title |
| slug | text | NO | URL-safe identifier |
| description | text | YES | Release context |
| release_date | date | YES | Official release date |
| release_artist_id | uuid | YES | Legacy: primary artist (DEPRECATED—use release_artists instead) |
| genre | text | YES | Primary genre |
| secondary_genre | text | YES | Secondary genre |
| cover_image_url | text | YES | Album art URL |
| status | text | NO | published, draft, inactive |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Relationships:**
- `release_tracks.release_id` ← one-to-many (tracks on this release)
- `release_artists.release_id` ← one-to-many (credited artists)

**Indexes:**
- Primary key on `id`
- Unique on `slug`
- Index on `status`
- Index on `genre`

**Notes:**
- **`release_artist_id` is DEPRECATED** — Use `release_artists` instead
- Kept for backward compatibility (see ADR-006)
- Genre must be from frozen taxonomy (ADR-003)
- Represents the release as a product (album, single, EP)

---

### release_artists

**Purpose:** Credits artists for a release (primary artist, featured artists, compilation credits)

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| release_id | uuid | NO | FK to releases |
| artist_id | uuid | NO | FK to artists |
| role | text | NO | primary, featured, compilation, various_artists, presenter |
| credited_as | text | YES | Exact release credit text (e.g., "Juan Luis Guerra y 4.40") |
| display_order | integer | YES | Order for display |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Relationships:**
- `releases.id` (FK) → which release
- `artists.id` (FK) → which artist

**Indexes:**
- Primary key on `id`
- Index on `release_id`
- Index on `artist_id`
- Unique constraint on (release_id, artist_id, role)

**RLS Policies:**
- Enable read access for published releases
- Restrict write to authenticated admin

**Notes:**
- Credits artists **for the release** (not composition or performance)
- `role` must be from [ROLE_DICTIONARY.md](ROLE_DICTIONARY.md)
- `credited_as` preserves exact historical credit text (e.g., "Juan Luis Guerra y 4.40")
- `display_order` controls presentation (important for album art order)
- Replace use of `releases.release_artist_id` with this table (ADR-004)

---

### release_tracks

**Purpose:** Tracks on a release in order

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| release_id | uuid | NO | FK to releases |
| recording_id | uuid | NO | FK to recordings |
| track_number | integer | NO | Track position on release |
| title_override | text | YES | Title if different from recording |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Relationships:**
- `releases.id` (FK) → which release
- `recordings.id` (FK) → which recording

**Indexes:**
- Primary key on `id`
- Index on `release_id`
- Index on `recording_id`
- Unique constraint on (release_id, track_number)

**Notes:**
- Maps recordings to releases with track positions
- `track_number` determines order
- `title_override` allows different titles on different releases of same work

---

## Credit Models

The credit model uses three levels (see ADR-004):

```
Work Level (Composition)
  └─ credited_work_credits
      (composer, lyricist, arranger of the WORK)

Recording Level (Performance)
  └─ recording_credits
      (vocalist, guitarist, producer, engineer who PERFORMED)

Release Level (Product)
  └─ release_artists
      (primary artist, featured, compilation credit for the RELEASE)
```

---

## Media and Content

### images

**Purpose:** Store image metadata and URLs

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| entity_type | text | NO | artist, release, work |
| entity_id | uuid | NO | ID of entity |
| url | text | NO | Image URL |
| alt_text | text | YES | Accessibility text |
| display_order | integer | YES | Order for display |
| created_at | timestamp | NO | Record creation |

**Notes:**
- Generic image storage for multiple entity types
- `entity_type` and `entity_id` identify what this image belongs to
- Primarily used for artist photos and album art

---

## Metadata

### genres

**Purpose:** Master list of valid genres (frozen taxonomy)

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| name | text | NO | Genre name |
| name_es | text | YES | Spanish name |
| slug | text | NO | URL-safe identifier |
| description | text | YES | Genre description |
| status | text | NO | approved, deprecated |
| created_at | timestamp | NO | Record creation |
| updated_at | timestamp | NO | Last update |

**Status:** Frozen (ADR-003)
- No new genres without editorial consensus
- All music uses approved genres only
- Deprecated genres kept for historical records

---

### roles

**Purpose:** Master list of valid role names

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| id | uuid | NO | Primary key |
| name | text | NO | Role name (e.g., vocal, composer) |
| role_level | text | NO | recording, work, release |
| description | text | YES | Role description |
| created_at | timestamp | NO | Record creation |

**Notes:**
- Role names tied to specific levels (recording, work, or release)
- See [ROLE_DICTIONARY.md](ROLE_DICTIONARY.md) for full list
- Constraints in application should validate against this

---

## Utility Tables

### analytics_events

**Purpose:** Track user interactions for insights

**Status:** See [docs/reports/analytics/ANALYTICS.md](docs/reports/analytics/ANALYTICS.md)

---

### analytics_rollups

**Purpose:** Aggregated analytics for performance

**Status:** Implemented; see migrations for details

---

## Views and Functions

### Helper Functions (RPCs)

**Documentation:** See specific migration files for implementation details.

Common RPC patterns:
- `get_recording_credits(recording_id uuid)` — All performers on a recording
- `get_work_credits(work_id uuid)` — All creators of a work
- `get_release_credits(release_id uuid)` — All artists credited for a release
- `get_artist_works(artist_id uuid)` — All works where artist is a creator
- `get_artist_recordings(artist_id uuid)` — All recordings where artist performed

---

### Materialized Views

**None currently implemented.** Can be added for performance optimization without changing base schema.

---

### Normal Views

**Primarily used for:**
- Analytics aggregations
- Denormalized views for frontend queries
- RLS policy enforcement

---

## Index Summary

**Indexes exist on:**

| Table | Indexed Columns | Purpose |
|-------|-----------------|---------|
| artists | slug, status | Fast lookup by URL; filter by publication status |
| recordings | work_id, artist_id, isrc, status | Relationship traversal; external linking |
| recording_credits | recording_id, artist_id | Retrieve credits; prevent duplicates |
| works | slug, status | URL lookup; publication filtering |
| releases | slug, status, genre | URL lookup; genre filtering |
| release_artists | release_id, artist_id | Retrieve release credits |
| release_tracks | release_id, track_number | Sequential track retrieval |

**Index Strategy:**
- Foreign keys indexed for relationship traversal
- Unique constraints on natural key combinations
- Status indexed for publication filtering
- Slugs indexed for URL routing

---

## Constraints and Validation

### Foreign Key Constraints

All foreign keys use:
- Cascade delete where appropriate (relationships follow data model)
- Restrict delete where data integrity requires

### Unique Constraints

- `artists.slug` — One URL per artist
- `works.slug` — One URL per work
- `releases.slug` — One URL per release
- `(recording_id, artist_id, role)` on recording_credits — Prevent duplicate credits
- `(work_id, artist_id, role)` on credited_work_credits — Prevent duplicate composition credits
- `(release_id, artist_id, role)` on release_artists — Prevent duplicate release credits

### Check Constraints

- Status fields validate to: published, draft, inactive
- Role fields must exist in `roles` table
- Genre fields must exist in `genres` table (frozen taxonomy)
- Track numbers must be positive integers

---

## Row Level Security (RLS)

**Principle:** All tables with sensitive data use RLS policies.

**Published content** (status='published'):
- Readable by all authenticated users
- Anonymous users can read but cannot write

**Draft/inactive content:**
- Only admin users can read/modify
- Never exposed to public API

**Admin operations:**
- Only superuser or admin role can modify
- All writes logged for audit

---

## Database Statistics

**Current Scale (as of 2026-07-03):**

| Table | Row Count | Notes |
|-------|-----------|-------|
| artists | ~1,000+ | Dominican artists and international collaborators |
| works | ~500+ | Unique compositions |
| recordings | ~2,000+ | Individual performances |
| recording_credits | ~5,000+ | Performers across all recordings |
| releases | ~800+ | Albums, singles, EPs |
| release_artists | ~1,500+ | Credits per release |
| release_tracks | ~10,000+ | Tracks on releases |

**Storage:** See [docs/reports/database/DATABASE_AUDIT.md](docs/reports/database/DATABASE_AUDIT.md) for historical size analysis.

---

## Migration and Evolution

**Schema changes** follow [ADR-006](ARCHITECTURAL_DECISIONS.md#adr-006-preserve-backward-compatibility-during-schema-evolution) and [ADR-007](ARCHITECTURAL_DECISIONS.md#adr-007-additive-migrations-first-deprecate-before-removal).

**Deprecation timeline:**
- **Phase A:** Add new tables/columns alongside old ones
- **Phase B:** Application migrates to new schema
- **Phase C:** After 6 months, mark legacy as deprecated
- **Phase D:** After 12 months, remove legacy (if no longer used)

**Legacy fields currently active:**
- `recordings.artist_id` — Keep until recording_credits widely adopted
- `releases.release_artist_id` — Keep until release_artists widely adopted

See [ARCHITECTURAL_DECISIONS.md](ARCHITECTURAL_DECISIONS.md) for rationale.

---

## Related Documentation

- **Conceptual Model:** [DATA_GOVERNANCE.md](DATA_GOVERNANCE.md)
- **Editorial Rules:** [EDITORIAL_GUIDELINES.md](EDITORIAL_GUIDELINES.md)
- **Role Definitions:** [ROLE_DICTIONARY.md](ROLE_DICTIONARY.md)
- **Architectural Decisions:** [ARCHITECTURAL_DECISIONS.md](ARCHITECTURAL_DECISIONS.md)
- **Historical Audits:** [docs/reports/database/](docs/reports/database/)

---

**Status:** Current  
**Last Updated:** 2026-07-03  
**Authority:** Database Architecture Team  
**Next Review:** As needed or after major migrations
