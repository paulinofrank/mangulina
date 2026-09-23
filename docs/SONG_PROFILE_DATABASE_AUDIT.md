# Song Profile Database Audit

**Audit date:** 2026-09-19  
**Scope:** Read-only inspection of the live catalog and the repository's public Song queries.  
**Purpose:** Determine whether Mangulina can present composition, performance, production, instrument, label, version, and listening information on a normalized Song profile.

## Executive finding

The database has the correct entity structure for the proposed Song profile:

`Work -> Recording -> Track -> Release`

It also has separate Work credits, Recording credits, canonical role definitions,
external contributors, version profiles, platform links, ISRCs, instruments,
labels, and provenance tables. No new general-purpose Work, Recording, credit,
instrument, label, or platform-link table is needed.

The limiting factor is data coverage, not the core model. Composition credits
are strong for the 615 existing Works. Lead-performer coverage is partial.
Arranger and producer coverage is sparse. Backing-vocal and normalized instrument
credits are effectively absent. Labels exist mainly as unnormalized Release text.
Only 698 public Recordings are currently linked to a published Work, so most catalog entries
cannot yet participate in a true composition-plus-versions page.

## Readiness by requested public field

| Public field | Correct scope | Database support | Current live coverage | Assessment |
|---|---|---|---:|---|
| Composer | Work | `work_credits`, role `composer` | 615 Works | Ready for linked Works |
| Lyricist | Work | `work_credits`, role `lyricist` | 485 Works | Ready where documented |
| Songwriter | Work | Registered role `songwriter` | 0 Works | Schema ready; no live data |
| Arranger | Work or Recording according to evidence | Registered for both scopes; `recording_credits` populated | 146 public Recordings; 0 Works | Displayable, sparse |
| Lead performer | Recording | `recording_credits`, role `lead_performer` | 5,418 Recordings | Displayable, partial |
| Backing vocals | Recording | Role dictionary maps supporting vocals to `vocalist` | 0 Recordings | Not currently displayable from live data |
| Musicians by instrument | Recording | `instruments` + `recording_credit_instruments` | 1 instrument; 0 links | Structure exists; population and public projection are missing |
| Producer | Recording; sometimes Release | `recording_credits`, role registry supports Recording/Release scope | 70 public Recordings | Displayable, very sparse |
| Label | Release | `releases.label`, `releases.label_id`, `labels` | 594 Releases have text; 0 normalized labels | Text can display as release context; canonical label navigation is not ready |
| Platform links | Recording | `recording_platform_links.recording_id` | 15,758 public Recordings | Ready and correctly scoped |
| Version identity | Recording | `recording_version_profiles` | 45 public Recordings | Schema ready; very sparse |

## Catalog coverage

The public Recording population used for percentages below is 20,997 Recordings
whose canonical owner Artist is published.

| Measure | Count | Coverage |
|---|---:|---:|
| Public Recordings linked to a published Work | 698 | 3.32% |
| Public Recordings with any Recording credit | 5,440 | 25.91% |
| Public Recordings with performer credit | 5,435 | 25.88% |
| Public Recordings with arranger credit | 146 | 0.70% |
| Public Recordings with producer credit | 70 | 0.33% |
| Public Recordings with `vocalist` credit | 0 | 0% |
| Public Recordings with normalized instrument credit | 0 | 0% |
| Public Recordings with a version profile | 45 | 0.21% |
| Public Recordings with an approved platform link | 15,758 | 75.05% |
| Public Recordings with a non-superseded ISRC | 4,576 | 21.79% |
| Public Recordings appearing on a Release | 20,982 | 99.93% |
| Public Recordings with label text through a Release | 1,487 | 7.08% |

There are 615 Works, of which 614 are published. All 615 have at least one
non-superseded Work credit. Every Work has a composer credit; 485 have a lyricist
credit. No current Work uses `songwriter`, `writer`, or Work-scoped `arranger`.

## Credit vocabulary and live use

The canonical role registry contains 18 active roles. Its relevant normalized
scope rules are:

- Work: `composer`, `songwriter`, `lyricist`.
- Recording: `lead_performer`, `featured_performer`, `performer`, `instrumentalist`,
  `pianist`, `arranger`, `producer`, `co_producer`, `beat_programmer`, engineers,
  conductor, and musical director.
- Release: `executive_producer`; `producer` and `musical_director` are also allowed.
- `arranger` is allowed at Work and Recording scope because the evidence may
  describe either a reusable arrangement or one particular recorded arrangement.

Live Work-credit roles:

| Role | Credit rows | Distinct Works |
|---|---:|---:|
| Composer | 633 | 615 |
| Lyricist | 493 | 485 |

Live Recording-credit roles:

| Role | Credit rows | Distinct Recordings |
|---|---:|---:|
| Lead performer | 5,452 | 5,418 |
| Arranger | 146 | 146 |
| Featured performer | 137 | 118 |
| Performer | 105 | 105 |
| Producer | 70 | 70 |
| Featured artist (legacy vocabulary) | 4 | 4 |
| Composer (mis-scoped legacy rows) | 3 | 3 |
| Piano (legacy role-as-instrument) | 1 | 1 |

The three Recording-scoped composer rows and the four `featured_artist` rows
remain editorial review items. This audit did not move or reinterpret them.

## Instruments

The normalized structure is correct:

- `instruments` defines bilingual canonical instrument terms.
- `recording_credit_instruments` joins one Recording credit to one or more
  instruments in display order.

It is not operationally populated. The registry contains only `piano`, and the
join table contains zero rows. Thirteen Recording credits contain an `instrument`
key in legacy metadata, and one credit uses `piano` directly as its role. The
current public credit function does not expose either metadata or normalized
instrument joins.

To display “Musician — Guitar” reliably, the project needs instrument vocabulary
population, editorial assignment of instruments to Recording credits, and a
public read projection that returns instruments with each credit. No new table
is required.

## Backing vocals

The role dictionary defines `vocalist` as a supporting or backing vocal credit,
while `lead_performer` identifies the principal performance. The role is not in
the canonical `credit_roles` table and there are no `vocalist` rows in live
`recording_credits`.

Before a public “Backing vocals” group can be dependable, the existing approved
`vocalist` vocabulary needs to be registered in the canonical role table and
then populated through evidence-based data entry. Existing lead-performer rows
must not be automatically reclassified.

## Labels

The schema has both a canonical `labels` table and `releases.label_id`, but the
labels table is empty and every `label_id` is null. Label information currently
lives as free text in `releases.label`:

- 4,804 Releases total.
- 594 Releases contain label text (12.36%).
- 1,487 public Recordings inherit at least one labeled Release appearance.
- 0 Releases point to a canonical Label identity.

The Song page can safely show existing label text only as context for a named
Release. It should not treat that text as a Work or Recording attribute. If one
Recording appears on several Releases, each Release may legitimately have a
different label. Canonical Label pages, deduplication, or ownership claims should
wait for a dedicated label normalization project.

## Public-query readiness

`get_public_song_context` already returns:

- The selected published Work.
- Work credits.
- All explicitly linked public Recordings.
- Version facts.
- Recording credits.
- Recording-specific identifiers and approved platform links.
- Release appearances as underlying archival context.

The public `get_public_recording_credits` function currently returns only role,
identity type, identity ID, display name, Artist slug, and country. It does not
return canonical role metadata, credit detail, display order, instruments, or
credit provenance. The Song profile can group the existing simple roles now,
but instrument-aware presentation requires extending this read projection.

The Work page also does not currently receive a deliberately selected compact
Release/label context. Release appearances are available internally, but the UI
correctly stopped rendering their detailed territory, disc, and track-position
rows. A future query should derive a restrained release summary without moving
the label onto the Work or Recording.

## Provenance

The model supports sources through `sources`, `work_credit_sources`,
`recording_sources`, and the editorial assertion system. Current canonical-source
coverage is extremely limited:

- 1 row in `sources`.
- 0 of 1,126 Work credits linked through `work_credit_sources`.
- 10 Recordings linked through `recording_sources`.

Credits can be displayed because they are canonical catalog rows, but the public
profile cannot yet offer strong per-credit evidence at scale. Future editorial
work should attach evidence rather than duplicate credits.

## Integrity results

The read-only audit found:

- 0 Work credits with an invalid Artist/external-contributor identity shape.
- 0 Recording credits with an invalid Artist/external-contributor identity shape.
- 0 Track references to missing Recordings.
- 0 Track references to missing Releases.

No music, credit, release, label, instrument, or identity record was modified.

## Relevant table inventory

| Table | Rows | Purpose and key fields |
|---|---:|---|
| `works` | 615 | Composition identity: `preferred_title`, `slug`, language, composition/publication years, status |
| `work_credits` | 1,126 | Work contributor identity and role: Work, Artist or external contributor, role/role ID, credited-as text, detail, sequence, verification |
| `credit_roles` | 18 | Bilingual canonical role vocabulary, family, normal scope, order, status |
| `credit_role_scopes` | 21 | Permitted Work, Recording, or Release scopes for canonical roles |
| `recordings` | 21,230 | Recorded-performance identity: Work, owner Artist, title, year, duration, context, identifiers, genre, representative Release |
| `recording_credits` | 5,918 | Recording contributor identity and role, credited-as text, order, metadata |
| `instruments` | 1 | Bilingual canonical instrument vocabulary |
| `recording_credit_instruments` | 0 | Many-to-many Recording-credit instrument assignments |
| `recording_version_profiles` | 45 | Studio/live/etc., derivation/remix kind, language, performance context and date |
| `recording_isrcs` | 4,908 | Recording-specific ISRCs and verification state |
| `recording_isrc_sources` | 4,913 | Evidence and observation records for Recording ISRC assignments |
| `recording_platform_links` | 84,884 | Recording-specific provider URLs, approval state, confidence, source and external ID |
| `tracks` | 26,602 | Release appearance joining one Release to one canonical Recording, with disc/position/title override |
| `releases` | 4,804 | Release edition: group, artist, date/year, type, country, label text/ID, catalog number, barcode |
| `release_groups` | 2,813 | Groups editions/reissues under a release-level product identity |
| `release_artists` | 3,412 | Ordered Release-level artist credits and historical credited-as text |
| `labels` | 0 | Canonical Label identity; structurally present but unused |
| `artists` | 768 | Public canonical Artist identities |
| `external_contributors` | 76 | Canonical non-catalog contributor identities used by Work and Recording credits |
| `sources` | 1 | Canonical evidence sources |
| `work_credit_sources` | 0 | Evidence links for Work credits |
| `recording_sources` | 10 | Evidence links for Recordings |

## Column inventory

### Composition and roles

- `works`: `id`, `preferred_title`, `slug`, `language`, `composition_year`,
  `publication_year`, `status`, `editorial_notes`, `metadata`, timestamps.
- `work_credits`: `id`, `work_id`, `artist_id`, `external_contributor_id`,
  `role`, `role_id`, `credited_as`, `credit_detail`, `sequence`,
  `verification_status`, `notes`, `metadata`, timestamps.
- `credit_roles`: `id`, `code`, bilingual display names, `description`,
  `role_family`, `normal_scope`, `status`, `display_order`, `metadata`, timestamps.

### Recording, performance, and production

- `recordings`: `id`, `title`, `slug`, `work_id`, `artist_id`, `recording_year`,
  `duration`, `recording_context`, `release_id`, `youtube_id`, `isrcs`, `mbid`,
  `disambiguation`, genre/subgenre IDs, classification fields, metadata, views,
  timestamps.
- `recording_credits`: `id`, `recording_id`, `artist_id`,
  `external_contributor_id`, `role`, `role_id`, `credited_as`, `position`,
  `display_order`, `metadata`, timestamp.
- `instruments`: `id`, `code`, bilingual display names, `status`, `metadata`, timestamps.
- `recording_credit_instruments`: `recording_credit_id`, `instrument_id`,
  `sequence`, timestamp.
- `recording_version_profiles`: `recording_id`, `performance_kind`,
  `derivation_kind`, `language_code`, performance date/precision/context, timestamps.

### Listening and identifiers

- `recording_platform_links`: `id`, `recording_id`, `platform`, `url`, `label`,
  `link_type`, official/status/order fields, confidence/source/external ID,
  matched title/artist, checked and row timestamps.
- `recording_isrcs`: `id`, `recording_id`, `isrc`, `verification_status`, first
  observed/last verified dates, notes, metadata, timestamps.

### Release context

- `tracks`: `id`, `release_id`, `recording_id`, disc/track/position fields,
  `title_override`, length, MusicBrainz/medium IDs, metadata, timestamps.
- `releases`: `id`, `title`, `slug`, `type`, date/year fields, `release_group_id`,
  `release_artist_id`, `label`, `label_id`, country, status, packaging, barcode,
  catalog number, MBID, disambiguation, metadata, artwork flag, views, timestamps.
- `release_groups`: `id`, `title`, type fields, MBID, release date/year,
  disambiguation, metadata, timestamps.
- `release_artists`: `id`, `release_id`, `artist_id`, `role`, `credited_as`,
  `display_order`, timestamps.
- `labels`: `id`, `name`, `type`, `area`, MBID, disambiguation, metadata, timestamps.

### Contributor identity and evidence

- `artists`: canonical public identity, slug/status, biographical and profile fields.
- `external_contributors`: canonical preferred/sort name, entity type, country,
  occupations, status, image/editorial metadata and timestamps.
- `sources`: title, type, author, publisher, URL, date and notes.
- `work_credit_sources`: Work credit, source/source ID, assertion and verification
  states, references, observation dates, notes and metadata.
- `recording_sources`: Recording, source, usage and timestamp.

## Recommended implementation boundary

The existing database can support an honest first version of the profile now:

1. Show composer and lyricist at Work scope.
2. Show lead/featured/general performers, arrangers, and producers per Recording
   only when those rows exist.
3. Keep approved platform links per Recording.
4. Show label text only under a specific compact Release context.
5. Omit empty credit groups rather than implying completeness.

Before promising the full requested profile, complete three focused foundations:

1. Approve and populate backing-vocal vocabulary and data.
2. Populate canonical instruments and `recording_credit_instruments`, then expose
   instruments through the public Recording-credit projection.
3. Decide whether label text remains archival Release text or is normalized into
   canonical `labels` identities; do not automatically merge label strings.

Increasing Work links and version profiles is also necessary for the composition
plus documented-versions experience to cover more than a small part of the catalog.
