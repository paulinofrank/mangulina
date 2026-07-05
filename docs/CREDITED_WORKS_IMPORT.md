# Credited Works Import Guide

## Overview

The **Credited Works** system documents creative contributions of Dominican artists across the music landscape—production, composition, arrangement, engineering, remixing, and more.

**Scope**: This is an independent editorial portfolio, separate from recordings and releases.

**Key Distinction**:
- **Recording Credits** (`recording_credits`): Songs where the artist performed
- **Production Credits** (`credited_works`): Songs where the artist produced, composed, arranged, engineered, etc.

## Schema

### `credited_works`
Stores one row per unique creative work. Deduplication key:
```
(title, performer_text, release_title, release_year, track_number)
```

**Fields**:
- `id`: UUID primary key
- `title`: Song/work title
- `performer_text`: Performer(s) as credited
- `release_title`: Album or compilation name
- `release_type`: "Studio Album", "Compilation", "Soundtrack", "Single", etc.
- `release_year`: Year of release (nullable)
- `label`: Record label
- `track_number`: Track position (may be "01", "ALL", "Single")
- `source_confidence`: "High", "Medium", "Low" with source
- `created_at`, `updated_at`: Timestamps

### `credited_work_credits`
Stores one row per artist contribution. One work can have multiple credits.

**Fields**:
- `id`: UUID primary key
- `credited_work_id`: Foreign key to work
- `artist_id`: Foreign key to artist
- `role`: Normalized role (Producer, Composer, Arranger, etc.)
- `credit_detail`: Detailed credit text from source
- `co_credits`: Other people involved in this role
- `source_confidence`: Source reliability
- `created_at`, `updated_at`: Timestamps

**Unique constraint**:
```
(credited_work_id, artist_id, role, credit_detail)
```

## Normalized Roles

When importing, roles are normalized to standard values:

| CSV Role | Normalized To |
|----------|---------------|
| Producer | Producer |
| Co-Producer | Co-Producer |
| Executive Producer | Executive Producer |
| Composer / Composition | Composer |
| Songwriter | Songwriter |
| Lyricist | Lyricist |
| Arranger / Music Arrangement | Arranger |
| Beat Arrangement | Arranger |
| Musical Director | Musical Director |
| Conductor | Conductor |
| Mix Engineer / Mixing | Mix Engineer |
| Mastering Engineer | Mastering Engineer |
| Beat Programmer / Dembow pattern | Beat Programmer |
| Remixer | Remixer |

Unknown roles are preserved as-is with a warning.

## Import Process

### 1. Run Migration

Apply the schema migration:

```bash
npx supabase migration up
```

Or manually:

```bash
psql -h [host] -U [user] -d [db] < supabase/migrations/20260705000003_create_credited_works_tables.sql
```

### 2. Prepare CSV

CSV must have these columns:
- Year
- Album_Title
- Album_Type
- Label
- Track_Number
- Track_Title
- Performer
- LT_Role
- LT_Credit_Detail
- Co_Credits
- Source_Confidence

**These fields are ignored:**
- Performer_Nationality
- Performer_Category

### 3. Dry Run (Recommended)

Analyze the import without writing data:

```bash
npx ts-node scripts/importLunyTunesCreditedWorks.ts --dry-run
```

Output shows:
- Total CSV rows read
- Unique works detected
- Credits per role
- Works per year
- Role normalization warnings

### 4. Real Import

Execute the import:

```bash
npx ts-node scripts/importLunyTunesCreditedWorks.ts \
  --file ./data/Luny_Tunes_Complete_MultiRole_Catalog.csv
```

**Environment variables required**:
- `NEXT_PUBLIC_SUPABASE_URL`: Supabase project URL
- `SUPABASE_SERVICE_ROLE_KEY`: Service role key (for server-side operations)

### 5. Verify

Query the results:

```sql
-- View all Luny Tunes production works
SELECT cw.*, ARRAY_AGG(cwc.role) as roles
FROM credited_works cw
LEFT JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
WHERE cwc.artist_id = '[luny-tunes-id]'
GROUP BY cw.id
ORDER BY cw.release_year DESC;

-- View role summary
SELECT role, COUNT(*) as count
FROM credited_work_credits
WHERE artist_id = '[luny-tunes-id]'
GROUP BY role
ORDER BY count DESC;
```

## Idempotency

The import is fully idempotent. Running it multiple times:
- ✓ Detects existing works by deduplication key
- ✓ Skips duplicate credits
- ✓ Updates timestamps only
- ✓ Never deletes data
- ✓ Never modifies other artists

You can safely re-run the import:

```bash
# First import
npx ts-node scripts/importLunyTunesCreditedWorks.ts --file ./data/Luny_Tunes.csv

# Re-run (adds any missing rows, skips duplicates)
npx ts-node scripts/importLunyTunesCreditedWorks.ts --file ./data/Luny_Tunes.csv
```

## Data Layer

**Note**: Phase 4 uses a separate data layer from Phase 3 Recording Credits.
- Phase 3: `getArtistCreditedWorks()` → Songs the artist performed on
- Phase 4: `getArtistWorksPortfolio()` → Songs the artist produced/composed/arranged

Retrieve production works for display:

```typescript
import { getArtistWorksPortfolio } from "@/lib/getArtistWorksPortfolio";

const works = await getArtistWorksPortfolio(artistId);

// works: ProductionWork[]
// Each has: id, title, performer_text, release_title, release_year, roles, etc.
```

Retrieve role summary (e.g., "Producer: 150"):

```typescript
import { getArtistProductionRoleSummary } from "@/lib/getArtistWorksPortfolio";

const summary = await getArtistProductionRoleSummary(artistId);

// summary: RoleSummary[]
// Each has: role, count
```

## Presentation

The React component is responsible for:
- Grouping works by year
- Sorting by year descending
- Merging multiple roles for same work
- Displaying role badges
- Formatting the portfolio

Example structure:

```
2005
  Rakata (Wisin & Yandel) - Mas Flow 2
    Roles: Producer • Arranger • Beat Programmer
  
  Llamé Pa' Verte (Wisin & Yandel) - Pa'l Mundo
    Roles: Producer

2004
  Gasolina (Daddy Yankee) - Barrio Fino
    Roles: Producer • Composer • Mix Engineer
```

The data layer returns a flat list; React does all grouping and merging.

## Troubleshooting

### "Luny Tunes artist not found"

Ensure the artist exists:

```sql
SELECT id, slug, name FROM artists WHERE slug = 'luny-tunes' OR name = 'Luny Tunes';
```

If not found, create the artist first.

### Missing required columns

Check CSV headers match exactly:

```bash
head -1 your_file.csv
```

### Role normalization warnings

Unknown roles are preserved as-is. Review the output and add mappings to `ROLE_NORMALIZATION` if needed.

### Duplicate key violations (rare)

If encountered despite idempotency logic, the issue is likely:
1. CSV has conflicting data (different credits for same row)
2. Manual edits to database

Solution: Review and fix the CSV, then re-run the import.

## Future Imports

To import for other Dominican artists (Juan Luis Guerra, Ramón Orlando, etc.):

1. **Prepare the CSV** with the same structure
2. **Create a new script** by copying `importLunyTunesCreditedWorks.ts`
3. **Replace**:
   - `luny-tunes` with artist slug
   - File path references
   - Artist name fallback
4. **Run the import** following the same process

The schema is artist-agnostic and supports all artists.

## SQL Helpers

Three helper functions are available for direct queries:

### `get_artist_credited_works_with_roles(artist_id)`
Returns all works with roles aggregated:

```sql
SELECT * FROM get_artist_credited_works_with_roles('artist-uuid');
```

### `get_artist_role_summary(artist_id)`
Returns role counts:

```sql
SELECT * FROM get_artist_role_summary('artist-uuid');
```

### RLS Policies

- **SELECT**: Public (anyone can read editorial portfolios)
- **INSERT/UPDATE/DELETE**: Service role only (imports use service role key)
- Editorial portfolios are public data
- Queries don't require authentication
- Writes are restricted to authenticated service role

## References

- Schema: `supabase/migrations/20260705000003_create_credited_works_tables.sql`
- Import: `scripts/importLunyTunesCreditedWorks.ts`
- Data Layer: `src/lib/getArtistProductionPortfolio.ts`
- Documentation: `docs/DATA_GOVERNANCE.md` (Section 8: Credits Architecture)
