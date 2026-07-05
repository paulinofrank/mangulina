# Creative Works Editorial Workflow

This document describes the official Mangulina process for documenting creative contributions (production, composition, arrangement, engineering credits, etc.) across artists' works.

## Overview

The workflow follows a standardized three-stage process:

```
Research Spreadsheet (detailed, one row per role)
    ↓
Consolidation Utility (merge roles per work)
    ↓
Editorial Spreadsheet (one row per work)
    ↓
Import Script (populate database)
    ↓
Normalized Database (credited_works + credited_work_credits)
```

This architecture separates editorial simplicity from database normalization:
- **Editors** work with a simple consolidated format (one row = one work, comma-separated roles)
- **Database** remains normalized (one work + multiple credit records)
- **UI** displays chronologically by year → works, with roles shown together

## Stage 1: Research Spreadsheet

The detailed source spreadsheet where each row represents **one role for one work**.

**Example structure:**

| Year | Album_Title | Track_Title | Performer | Role |
|------|------------|-------------|-----------|------|
| 2005 | Gasolina Album | Gasolina | Daddy Yankee | Producer |
| 2005 | Gasolina Album | Gasolina | Daddy Yankee | Composer |
| 2005 | Gasolina Album | Gasolina | Daddy Yankee | Mix Engineer |

**Required columns:**
- Year
- Album_Title
- Album_Type (Studio Album, Compilation, Single, etc.)
- Label
- Track_Number
- Track_Title
- Performer
- Role
- Credit_Details (optional)
- Co_Credits (optional)
- Source_Confidence (High, Medium, Low)

## Stage 2: Consolidation Utility

The `consolidateCreativeWorks.ts` script merges multiple rows per work into a single consolidated row.

**Usage:**
```bash
npx tsx scripts/consolidateCreativeWorks.ts \
  --input data/LunyTunes_Detailed.xlsx \
  --output data/LunyTunes_Consolidated.xlsx
```

**What it does:**
1. Groups rows by (Year, Album_Title, Track_Title, Performer)
2. Merges all roles for each work into a comma-separated list
3. Deduplicates roles (no role appears twice)
4. Preserves role order by first appearance
5. Intelligently merges Credit_Details, Co_Credits, and Source_Confidence

**Output statistics:**
- Rows read
- Unique works
- Duplicate work groups
- Total roles merged
- Output rows
- Execution time

**Idempotency:** Running the script multiple times on the same input always produces identical output.

## Stage 3: Editorial Spreadsheet (Consolidated)

The simplified workbook editors maintain and use as the source for imports.

**Structure (one row per work):**

| Year | Album_Title | Track_Title | Performer | Roles |
|------|-------------|-------------|-----------|-------|
| 2005 | Gasolina Album | Gasolina | Daddy Yankee | Producer, Composer, Mix Engineer |

**Key format rules:**
- **Year:** Release year (integer)
- **Album_Title:** Release or album name
- **Track_Title:** Song or work title
- **Performer:** Credited performer(s) as they appear in the release
- **Roles:** Comma-separated list of creative roles, no duplicates, ordered by first appearance

**Editorial simplicity:**
- Only these five columns are curated
- No other fields are maintained in the editorial workflow
- The database schema mirrors this simplicity

This is the **official editorial source** for all subsequent imports.

## Stage 4: Import Script

The `importCreativeWorksFromConsolidated.ts` script reads the simplified consolidated spreadsheet and populates the database.

**Required spreadsheet columns:**
- Year
- Album_Title
- Track_Title
- Performer
- Roles

**Workflow:**
1. For each spreadsheet row:
   - Create or reuse one row in `credited_works`
   - Split Roles column by comma
   - Trim whitespace
   - Normalize each role
   - Create one row in `credited_work_credits` per role

**Usage (by artist slug — preferred):**
```bash
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx
```

**Dry-run (validation only):**
```bash
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-slug luny-tunes \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx \
  --dry-run
```

**Fallback usage (by artist name):**
```bash
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-name "Luny Tunes" \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx
```

**Advanced usage (by artist ID):**
```bash
npx tsx scripts/importCreativeWorksFromConsolidated.ts \
  --artist-id <uuid> \
  --file ./data/LunyTunes_WorksList_Consolidated.xlsx
```

**Artist lookup priority:**
1. `--artist-slug` (preferred): Exact slug match
2. `--artist-name` (fallback): Exact name match (aborts if multiple matches)
3. `--artist-id` (advanced): Manual UUID specification

**Safety features:**
- Zero artists found: Aborts with clear error
- Multiple artists found: Lists matches and aborts
- Missing required columns: Validates and reports which columns are missing
- Extra columns ignored: Only requires the 5 essential columns
- Always uses upsert: Subsequent runs skip existing works (dedup key: title, performer_text, release_title, release_year)

**What it does:**
1. Reads consolidated spreadsheet
2. For each work:
   - Creates one row in `credited_works` table
   - Splits Roles column by comma
   - Normalizes each role
   - Creates one row in `credited_work_credits` for each role
3. Uses upsert (idempotent): subsequent runs skip existing works
4. Validates artist exists before importing
5. Reports statistics

**Normalization mapping:**
- "Composition" → "Composer"
- "Songwriter" → "Songwriter"
- "Mixing" → "Mix Engineer"
- "Mastered by [Name]" → "Mastering Engineer"
- etc.

See `ROLE_DICTIONARY.md` for complete list.

## Stage 5: Normalized Database

### Schema Design
The database schema is perfectly aligned with the consolidated editorial workflow.

**See:** [SCHEMA_ALIGNMENT_REVIEW.md](SCHEMA_ALIGNMENT_REVIEW.md) for complete analysis

### credited_works Table (Simplified)
One row per unique creative work. Deduplication key: (title, performer_text, release_title, release_year)

**Columns:**
- id (UUID primary key)
- title (TEXT, NOT NULL) — from Track_Title
- performer_text (TEXT, nullable) — from Performer
- release_title (TEXT, nullable) — from Album_Title
- release_year (INTEGER, nullable) — from Year
- created_at, updated_at (timestamps)

**Why this structure:**
- Mirrors the consolidated editorial spreadsheet
- No release_type, label, track_number, or source_confidence (not in editorial workflow)
- Deduplication key changed from 5 columns to 4 (no track_number needed)

**Indexes:**
- UNIQUE(title, performer_text, release_title, release_year) — deduplication
- idx_credited_works_dedup — fast import lookups
- idx_credited_works_release — release-based queries

### credited_work_credits Table (Simplified)
One row per artist + work + role combination. Supports one artist having multiple roles on same work.

**Columns:**
- id (UUID primary key)
- credited_work_id (UUID, foreign key → credited_works.id)
- artist_id (UUID, foreign key → artists.id)
- role (TEXT, NOT NULL, normalized) — from Roles (split by comma)
- created_at, updated_at (timestamps)

**Why this structure:**
- Mirrors the consolidated editorial spreadsheet
- No credit_detail, co_credits, or source_confidence (not in editorial workflow)
- Unique constraint simplified: one role per artist per work (credit_detail removed)

**Constraints:**
- UNIQUE(credited_work_id, artist_id, role) — prevents duplicate roles
- Foreign keys maintain referential integrity

**Indexes:**
- idx_credited_work_credits_work — work → credits lookup
- idx_credited_work_credits_artist — artist portfolio queries
- idx_credited_work_credits_role — role aggregation
- idx_credited_work_credits_artist_role — role summary statistics

**Example:** Luny Tunes on "Gasolina" as Producer, Composer, Arranger → one row in credited_works + three rows in credited_work_credits

## Example: Luny Tunes Import

### Step 1: Research Phase
Compile detailed research spreadsheet with all Luny Tunes credits (one row per role).
- Example: Gasolina appears 3 times (Producer, Composer, Mix Engineer)

### Step 2: Consolidate
```bash
npx tsx scripts/consolidateCreativeWorks.ts \
  --input data/LunyTunes_Detailed.xlsx \
  --output data/LunyTunes_Consolidated.xlsx
```

Result:
- 342 detailed rows → 210 unique works
- Roles merged: ~400+ individual roles consolidated
- Output: Clean editorial spreadsheet

### Step 3: Import
```bash
npx tsx scripts/importCreativeworksFromConsolidated.ts \
  --artist-id ef56311a-ac4b-451e-a7a7-97e5f240cd47 \
  --file ./data/LunyTunes_Consolidated.xlsx
```

Result:
- 210 rows in credited_works
- 342 rows in credited_work_credits
- Works organized by year in UI
- Roles displayed together: "Producer • Composer • Mix Engineer"

## Future Artists

This workflow is now the **standard process** for all future artists:

1. **Juan Luis Guerra** → follows same workflow
2. **Ramón Orlando** → follows same workflow
3. **Manuel Tejada** → follows same workflow
4. **Rafael Solano** → follows same workflow
5. **Luis Días** → follows same workflow
6. Any future artist → follows same workflow

## Database Design Principles

The database is intentionally **NOT simplified**. While editors work with consolidated spreadsheets, the database maintains proper normalization:

- One work = one row in credited_works
- Multiple roles = multiple rows in credited_work_credits
- No redundancy, full referential integrity
- Query-efficient indexes on artist_id, role, work_id

This allows:
- Accurate role tracking (artist X had role Y on work Z)
- Role aggregation (count works per role)
- Year-based filtering (works by year)
- Cross-artist analysis (all works with role Producer)

## Quality Assurance

### Before Consolidating
- [ ] All required columns present
- [ ] No blank Track_Title or Performer cells
- [ ] Years are valid (1850-2100)
- [ ] Roles exist in ROLE_DICTIONARY.md

### Before Importing
- [ ] Consolidated spreadsheet is clean
- [ ] Roles are normalized
- [ ] Artist UUID is correct
- [ ] Dry-run shows expected counts
- [ ] No duplicate works in output

## Maintenance

- **Consolidation script:** Reusable for all artists, no artist-specific logic
- **Import script:** Reusable for all artists, parameterized by artist ID
- **Role normalization:** Centralized in ROLE_DICTIONARY.md
- **Spreadsheet format:** Standardized across all artists

---

**Last Updated:** 2026-07-04  
**Status:** Final / Official Process
