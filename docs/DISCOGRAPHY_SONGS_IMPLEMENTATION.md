# Song-centered discography implementation

## Phase 0: backup (2026-09-16)

Local snapshot: `C:\Mangulina\_discography_backup_20260916_214731`.
`file-manifest.json` lists 2,021 files with sizes and SHA-256 hashes, checked
against every copied file. Includes all src, messages, public, tests, docs,
scripts, supabase migrations/validation/plans, manifests, ingest, data, existing
backups, root configuration and local data files. Existing uncommitted changes
are preserved both in the snapshot and in `pre-existing-changes.patch`.

`discography-data.dump` contains the explicitly approved scoped live database
export. `database-scope.json` names every included table. Archive listing and
complete extraction to `discography-restore.sql` succeeded. This verifies archive
readability, not a full database restore rehearsal. Restore selected files from
`files/<relative path>` into the project; restore database data with PostgreSQL
18 pg_restore into a compatible schema, preserving foreign-key dependencies and
governed triggers. Never restore blindly over a live database. This is not a full
Supabase-cluster backup. Authentication, analytics events, storage objects,
credentials, dependencies, build output and temporary browser profiles are excluded.
Remote cover-art binaries were not exported; their local code and DB references
were preserved. No source or data changed before the backup was verified.

## Phase 1: observed architecture

The live database already has `works` -> `recordings.work_id`, `release_groups`
-> `releases.release_group_id`, and `tracks(recording_id, release_id)` for
appearances. `recordings.release_id` is a legacy representative-release pointer,
not the full appearance history. UUIDs are identity; neither title, MBID nor ISRC
is a merge key. `recording_version_profiles` and `recording_relationships` already
support governed version facts and derivations.

Live baseline: 100 Works (99 published, one draft); 17,592 Recordings, only 105
with a Work; 23,338 Tracks; 3,325 Releases; 53 version profiles; 82,512 platform
links. 3,346 recordings appear on multiple releases. The only currently linked
multi-recording Work is draft, so it must not be exposed as a published Work.

Authoritative composition credits use `work_credits` (100 rows), not the older
`credited_work_credits` editorial portfolio. `recording_credits` has 646 rows and
semantic uniqueness constraints. Audit found zero duplicate semantic Work or
Recording credits, and zero dangling Track/Recording/Work references. Three
legacy composer credits remain at Recording scope and require editorial review;
16 generic performer credits and four featured_artist credits also need review.
Do not silently promote or reinterpret them.

Provenance already exists: `work_credit_sources`, `editorial_assertions`, typed
assertion-target tables and `editorial_assertion_evidence` permit several sources
to support one contribution. Preserve it; no parallel provenance system is needed.
Release contributor coverage is currently `release_artists`, not a comprehensive
release production/artwork-credit system. No speculative release-credit migration.

The artist profile groups release editions into Albums, Singles, Compilations,
and Other, and every category uses the same expandable release row. Tracklists
resolve `tracks.recording_id` to the canonical Recording and link to its Song
page. A Recording may therefore appear under several releases without creating
another Recording identity or contributor credit.

`/songs/[slug]` previously addressed an individual Recording, while `/songs`
did not exist. `recordings_with_release_info` gets its artist from the representative
release, which can misattribute compilation recordings. Platform links already
use `recording_platform_links.recording_id`; only approved links are public.
`recording_isrcs` and `recording_isrc_sources` preserve multiple identifiers and
their evidence. `recordings.isrcs` is the legacy mirror.

Release `status` is a release-industry status (Official, Bootleg, etc.), NOT an
editorial published flag. Public visibility is based on the associated artist.
Filtering releases on status='published' would hide real release history.

## Implementation contract

Reuse the existing ontology, credits, provenance, and version workflow. Do not
mass-create Works for unlinked recordings, merge identities, or move uncertain
credits. Performing-artist profiles document release history; contributor
profiles group credits by canonical Work or Recording identity; Song pages group
only explicitly linked recordings. No public draft Work data.

Published Work URLs reserve `work-<work slug or UUID>` within `/songs/`, keeping
existing Recording slugs intact. The live audit found no conflicting recording
slugs with this prefix. Recording links to a known published Work target the
corresponding recording anchor. Legacy recording pages remain addressable.

Database changes are additive read projections only, with a rollback file. No
music rows or authoritative credit relationships are migrated. Release detail URLs
remain contextual historical destinations; release directory URLs redirect to Songs.

## Verification and remaining review

Production build and TypeScript pass. The full test suite passes: 424 tests.
Focused lint reports no errors. SQL integrity checks return zero duplicate
Recording projection rows, duplicate semantic credits, dangling Track references,
unpublished artist exposure, draft Work exposure, or incorrect Recording ownership
for the sampled platform-link payloads. Forward and rollback SQL were exercised
inside rolled-back transactions before applying each migration.

The revised presentation audit covers Brayan Booz with Albums, Singles, a
Compilation and Other releases; every one of the 71 returned release summaries
has a tracklist. “La morena” reuses one Recording across 14 releases, including
11 compilations. “Ojalá que llueva café” has six documented Recordings and one
Juan Luis Guerra composer credit despite appearing across 16 releases. Manuel
Tejada has one arranger credit for “Colegiala” despite five release appearances.
“Latidos de Tambor” retains nine Recording-specific platform links. Detailed
release-appearance rows remain in the read projection but are hidden on the
public Song page, as are ISRC, undocumented-version placeholders, and earliest
documented release-year labels.

Verified all 69 currently public featured/guest-credit relationships against the
new artist query. Directory first page, second page, search and both locales were
tested. A concurrency check caught a directory timeout: the second migration
pages title/identity candidates before loading artwork/year. Four before/after
JSON results matched exactly, the SQL test took about 195 ms, and all three
concurrent directory requests then returned 200 with 48 entries each.

The catalog changed independently during this task: the final read-only sample
had 19,521 Recordings, 25,501 Tracks, 4,308 Releases and 2,962 recording credits.
The baseline above is the initial snapshot, not a claim that other ongoing
catalog work stopped. Our migrations perform no INSERT/UPDATE/DELETE against
music, credits, identifiers or platform-link tables.

Editorial completion of missing Work links, unverified version identity, legacy
misplaced credits, and exact provider matching requires source review. The local
backup's `editorial-review.json` identifies the three Recording-scope composer
credits, all 26 existing Work titles containing version/participation markers,
Averly's unlinked recordings, and the draft multi-recording Colegiala Work. These
markers are review candidates, not proof of an incorrect identity. The draft Work
remains private. Multi-version routing is unit-tested; there is currently no
published, linked multi-recording Work to validate publicly without fabricating
or prematurely publishing data. Approved provider status is existing catalog
evidence, not a claim that every remote audio URL was independently listened to.

## Implementation report

1. **Backup:** 2,021 local files plus 44 scoped music/supporting database tables;
   manifests and SHA-256 verification retained. Four key files were copied back
   into an isolated restoration-check folder and rehashed. Database archive list
   and SQL extraction pass; no full Supabase restoration rehearsal was performed.
2. **Existing architecture:** Reused Work, Recording, Release Group, Release,
   Track, canonical credits, version profiles, identifiers and provenance.
3. **Changes:** Public recording projection, release-oriented artist discography,
   identity-safe contributor portfolios, Songs directory, composition destinations
   and restrained recording context panels.
4. **Schema:** `20260917010000_public_song_catalog.sql` adds one security-invoker
   view and three read functions. `20260917011000_song_directory_pagination.sql`
   optimizes the directory function without changing its access or results.
   Both are applied and recorded in `supabase_migrations.schema_migrations`.
5. **Data migrations:** None. No automatic Work creation, credit reassignment,
   Recording merges, identifier normalization or release deletion.
6. **Credits:** Work and Recording credits display separately. Contributor
   portfolios now include authoritative `work_credits`, once per composition,
   independently of recording/release counts. Existing provenance is unchanged.
7. **Artist UX:** Restores the backed-up Albums, Singles, Compilations and Other
   tabs with expandable release tracklists. Each Track resolves its canonical
   Recording before linking to the Song page.
8. **Song pages:** Searchable/paginated `/songs`; published Work pages under the
   reserved `work-` slug namespace; existing recording pages keep editorial,
   media, lyrics, source and analytics behavior. Release-appearance evidence is
   retained in data but no longer rendered publicly. No inferred Work relationships.
9. **Platforms:** Only approved, exact Recording-ID links appear inside each
   recording section. No platform set is placed on an abstract Work or copied
   per appearance. Legacy link data stays in the database.
10. **Verification:** Build, TypeScript, 424 tests, focused lint, SQL integrity,
    anonymous access, transactional rollback, representative page and link checks.
11. **Unresolved:** The editorial issues listed above; no blanket version/identity
    merges. Remote storage assets were not copied into the backup. Existing
    mastering/arrangement scope ambiguities are preserved for source review.
12. **Files:** See the exact implementation file list below.
13. **Delivery:** No automatic commit, push, or website deployment. Database read
    migrations were applied only after explicit approval. Roll back application
    files before dropping the read endpoints; run the two rollback plans newest
    first and repair their migration-history entries if rolling back permanently.

## Implementation files

- `.gitignore`
- `docs/DATA_GOVERNANCE.md`
- `docs/DISCOGRAPHY_SONGS_IMPLEMENTATION.md`
- `messages/en.json`, `messages/es.json`
- `next.config.ts`
- `src/app/[locale]/artists/[slug]/page.tsx`
- `src/app/[locale]/discover/page.tsx` (only the Songs/releases navigation entries)
- `src/app/[locale]/songs/page.tsx`
- `src/app/[locale]/songs/[slug]/page.tsx`
- `src/app/api/admin/recordings/route.ts`
- `src/components/organisms/ArtistSongDiscography.tsx`
- `src/components/organisms/ArtistDiscographyAccordion.tsx`
- `src/components/organisms/ArtistDiscographyTabs.tsx`
- `src/components/organisms/ArtistDiscographyRelease.tsx`
- `src/components/organisms/ArtistWorksPortfolio.tsx`
- `src/components/organisms/SongCreditsSection.tsx`
- `src/components/organisms/SongVersionsSection.tsx`
- `src/lib/getArtistWorksPortfolio.ts`
- `src/lib/queries/songCatalog.ts`, `src/lib/queries/songs.ts`
- `src/lib/revalidateCatalogProfiles.ts`
- `src/lib/sitemapCatalog.ts`, `src/lib/songIdentity.ts`
- `supabase/migrations/20260917010000_public_song_catalog.sql`
- `supabase/migrations/20260917011000_song_directory_pagination.sql`
- `supabase/plans/20260917010000_public_song_catalog_rollback.sql`
- `supabase/plans/20260917011000_song_directory_pagination_rollback.sql`
- `supabase/validation/20260917010000_public_song_catalog.sql`
- `tests/ontology/songCatalog.test.ts`
- `tests/performance/sitemapArchitecture.test.ts`

Existing edits to About, ArtistFactsCard, translations, Discover, local settings,
and unrelated concurrently added biography migrations were not reverted. The
file snapshot preserves the original translation/Discover state before our edits.
