# Discography research and change protocol

Status: active shared protocol, installed with owner authorization on 2026-10-15. Applies to every assistant, including Perplexity. Research and review are separate from permission to write. This protocol preserves the existing music ontology. For discography scope, research, identity, credit placement and review gates, it supersedes conflicting historical guidance. The Supabase security prohibition remains mandatory. Historical reports describe their original task, not permission to repeat it.

## 1. Read the existing model

Read these repository documents before making identity or credit recommendations:

- ../AGENTS.md and AI_INSTRUCTIONS.md: shared scope and project rules.
- DATA_GOVERNANCE.md, especially the dated Public Song projection section, and EDITORIAL_GUIDELINES.md: editorial authority and catalog scope.
- architecture/MUSIC_ONTOLOGY.md and architecture/EDITORIAL_GOVERNANCE.md: identities, assertions, evidence and editorial decisions.
- ROLE_DICTIONARY.md and architecture/CREDIT_ROLE_VOCABULARY.md: permitted roles; report discrepancies rather than inventing values.
- architecture/RECORDING_VERSION_IDENTITY.md and DISCOGRAPHY_SONGS_IMPLEMENTATION.md: versions, canonical credits, release appearances and legacy fields.
- architecture/ARTIST_RECORDING_CATALOG_VERIFICATION_AND_CLEANUP.md: mandatory procedure for any proposed cleanup.

Use existing artist research and audit reports as leads, not proof that their conclusions remain correct. Historical execution reports and artist priority lists do not authorize a new task. If references are unavailable, state the limitation and keep the result a research proposal.

## 2. Freeze scope before research

Record the user's request, named artist(s), verified existing UUIDs when accessible, date range, release categories, requested fields, allowed files and intended deliverables. Distinguish research, read-only audit, proposed corrections and approved execution. Do not invent missing UUIDs or claim to have inspected a database you cannot access.

If scope is ambiguous, continue useful research for the named subject and ask about the ambiguous portion before expanding it. A request for one artist never authorizes cleaning other artists, collaborators' profiles, global duplicates or the whole catalog. Do not change application code, schema, database data, security, biographies, images, platform links or publication state during documentation/research work. Do not execute ingestion or cleanup scripts merely because a guide contains commands.

Read-only inspection of related records may establish context. Changes to a shared Work, Recording, Release, Track or credit can affect other artists; list every known affected artist and dependency, then request explicit scope expansion. Document missing collaborators as unresolved literal credits; do not automatically create profiles. Any separately authorized artist creation must establish eligibility under existing Dominican-artist policy and use draft status.

## 3. Keep entities distinct

| Entity | Meaning | Identity safeguards |
| --- | --- | --- |
| Work | Underlying composition independent of performer or edition | Same title does not establish the same composition. Link only after evidence and editorial review. Do not mass-create Works for unlinked Recordings. |
| Recording | Distinct recorded performance or evidenced audio version | Can appear on many releases. A provider track is not automatically a new Recording. Preserve existing UUIDs. |
| Release | Specific published edition/product | Verify format, territory, date, label, catalog number/barcode, packaging and full program. Missing metadata does not establish a distinct edition. |
| Release Group | Existing grouping of related editions | Grouping is separate from deciding whether editions or Recordings are duplicates. |
| Track | Placement of a Recording on one Release, with disc/position and applicable override | New appearance does not require a new Work or Recording. Two edition tracklists are separate placements even when they use the same Recordings. |

Example: one studio performance on an original album and a compilation generally means one Work if proven, one Recording, two Releases and two Track appearances. A later live performance is a separate Recording and may share the Work after verification.

Do not treat recordings.release_id as the complete appearance history or proof of original release. Inspect Tracks and relevant artist/release relations. Treat dates separately: composition, recording/session, original release, edition/reissue, digital availability and retrieval date. Preserve the precision supported by sources; do not invent January 1 for a year-only date. Earliest found evidence is not proof of the first release.

## 4. Research and verification

Draft-profile precaution (editor clarification, 2026-10-23): construct and verify authorized discography through the admin editor and scoped database reads while the artist remains draft. Do not open its public artist URL as a preview: the intentional 404 may be cached. Saving discography under a draft artist is not itself an error. After separately authorized artist publication, invalidate that artist's concrete localized profile paths and confirm the public response actually shows the artist; a successful refresh acknowledgement alone is insufficient. Follow ARTIST_PROFILE_WORKFLOW.md. Do not recreate identities or reimport music to resolve a stale public 404.

1. Inventory existing scoped catalog/research first. Mark whether inventory is complete, sampled, offline or access-limited.
2. Establish the release sequence, then inspect each edition and ordered tracklist. Keep studio, live, EP, single, compilation, soundtrack and special projects distinct according to evidence.
3. **Mandatory Multi-Database / Multi-Platform Cross-Verification**: Never rely on a single commercial platform or catalog feed (e.g., Spotify alone). Streaming services suffer from catalog fragmentation, distributor-specific ingestion, territory-specific licensing, and missing or delayed album partitions. Research must cross-reference all accessible major music databases and storefronts:
   - **Spotify**: Artist album/single endpoints, UPCs, and available track ISRCs.
   - **Apple Music / iTunes**: Dominican storefront (`country=DO`) and international catalogs for complete track counts, collection types, and releases missing from other providers.
   - **Deezer**: Independent cataloging, alternative distributor feeds, and distinct album/EP/single classifications.
   - **YouTube Music / Official Channels**: Topic audio tracks, official music videos, and visual credits.
   - **MusicBrainz**: Provenance and release groups (note absence or coverage gaps for emerging digital-era artists).
   - **Discogs**: Physical releases, liner notes, catalog numbers, barcodes, and label matrix data.
   - **Dominican Music Archives & Press**: Official artist announcements and reputable reporting (e.g., Diario Libre, El Nuevo Diario, Listín Diario) for biographical context, composers, and songwriting credits.
   Document which databases were inspected and report discrepancies across providers in the change manifest.
4. Prefer identifiable physical labels/sleeves/booklets, official artist/label catalogs, contemporaneous releases and reputable archives. Use commercial catalogs and independent discographic research as corroboration.
5. **Mandatory Genre Classification and Cover Art Completeness**:
   - **Genre and Subgenre Assignment**: Every cataloged recording must have its `genre_id` (and applicable `subgenre_id`) explicitly populated according to the canonical `genres` table taxonomy (e.g. `genre_id = 5` for Salsa, `genre_id = 1` for Merengue, `genre_id = 2` for Bachata). Creating recordings without genre classification leaves tracklists incomplete in the API and UI.
   - **Cover Art Standards**: Every created release must be accompanied by its official cover artwork. Follow the established storage pipeline: upload the high-resolution source to `cover-art-originals/{release_id}.jpg`, process WebP variants (`300px/{release_id}.webp` and `150px/{release_id}.webp`) into the `cover-art` storage bucket via Sharp, and set `releases.has_cover_image = true`. Releases must never be left with missing covers when verifiable artwork exists across Cover Art Archive, Apple Music, Discogs, or streaming feeds.
6. MusicBrainz is provenance/discovery only for cleanup identity decisions under the existing cleanup policy. Search snippets, AI answers, unsourced lists and copied storefront metadata are leads, not verification. Multiple sites repeating one feed are not independent sources.
7. Open the underlying source. Record exact URL or archival/physical reference, issuer/title, accessed date, edition identifiers, relevant page/track or audio timestamp, factual claim and limitations. Cite each proposed correction at field level. Do not fabricate citations or claim listening/physical inspection you did not perform.
8. Preserve conflicting accounts, source dates, original text and reasoned assessment. Use verified, provisional, disputed or unknown as research labels, not invented database status values. One explicit primary source may support an uncontroversial field; contested dates, identity and destructive recommendations need independent corroboration or remain unresolved.
9. Use exact audio/version evidence where necessary: performance, language, event, edit, mix, duration and audible differences. State access limits. No inaccessible-source claim becomes verified through confidence alone.

Track coverage and gaps; never claim a complete discography unless the defined scope was accounted for. Cite newly found evidence separately from existing catalog assertions.

## 5. Versions and duplicates

Create duplicate candidates, never automatic merge decisions. Titles, spelling normalization, duration proximity, ISRCs, MBIDs, UPCs, artwork and provider IDs are comparison signals; none is a sufficient identity key. Search aliases and known existing identities before proposing additions.

Preserve independently evidenced live performances, rerecordings, alternate takes, languages, remixes and edits. A remaster label, encoding, compilation appearance or territory change alone does not establish a new Recording. Remastering alone is not a new Recording; independently proven performance/audio derivation differences require editorial review under the version-identity model. Hold uncertain cases for editorial resolution. A documented edition difference may justify a Release while reusing a Recording. Do not implement the future Arrangement model or force medleys into unsupported Work relationships.

Classify candidates as distinct, supported duplicate, probable duplicate or unresolved, with evidence for both identity and differences. Compare Release identity independently of Recording identity. Freeze any approved survivor/redundant decisions by exact UUID; execution must never choose survivors heuristically.

Before proposing a merge/deletion, inventory Tracks, credits, Work links, identifiers and provenance, assertions, version relations, platform links, artwork/media, legacy pointers, public URLs/redirects, analytics and cross-artist effects. Preserve legitimate appearances and unique valid evidence. Report conflicts rather than discarding them to satisfy constraints.

## 6. Credits and attribution

- Transcribe the literal credited name and role; keep canonical identity mapping separate. Preserve credited_as where supported. An alias or collective membership is not proof of participation in a session.
- Composition authorship belongs to the Work; performance and session production belong to the Recording; release billing belongs to the Release. Check the current ontology and implementation before proposing a target relation. Authoritative composition credits use work_credits; credited_works/credited_work_credits are legacy portfolio data in the dated governance update.
- Arrangement and mastering require evidence of scope. Do not automatically move historical credits or reinterpret generic performer/featured credits. Report dictionary/ontology conflicts for editorial review.
- Do not infer composer, lyricist, arranger, producer, featured performer or ownership from release billing, title text, genre, repeated metadata or a profile's primary occupation. Absence of a credit is not evidence that a person did not participate.
- Reuse canonical semantic credits and attach additional evidence through existing provenance. Repeated release appearances do not multiply composition/session contributions.
- Keep self-performance display policy separate from historical credit truth: a portfolio display rule never authorizes deleting a valid authorship credit. Contributor research must retain performer/release context without expanding edits into that performer's catalog without approval.
- Recording platform destinations must match the exact Recording and version. Do not copy links across versions or attach recording availability to an abstract Work. Existing approved status is not proof of independent listening.

### Contributor Catalog Ingestion Rules — Editor Instruction, 2026-10-24

When processing song catalogs, creative works, and songwriting credits for an author/contributor:

1. **Absolute Prohibition of Karaoke and Imitation Covers**: Under no circumstances will Karaoke, backing tracks, or imitation cover albums (e.g., «Pistas Para Cantar Como...») be cataloged. They introduce redundancy and lack documentary value for original artist work.
2. **Existing Songs in Performer Discography**: If a song/recording already exists in the performer's discography in Mangulina, do not duplicate releases or recordings; only attach or update the contributor authorship credits (`work_credits` / `recording_credits`).
3. **Missing Performers**: If the lead performer does not exist in Mangulina, do not create them automatically during a contributor workflow; exclude the song and report it at the end for future editorial evaluation.
4. **Performers Without Existing Discography**: If the performer already exists in Mangulina but does not yet have their discography built/cataloged, do not create partial floating releases/tracks; report the artist at the end to be worked on as a dedicated discography task later.
5. **International Works Must Be Original (Exclusion of Foreign Re-recordings / Covers)**: Creative contributions for foreign/international performers are ONLY cataloged if the song is an **original international work** (conceived, composed, arranged, or produced specifically for that foreign artist, or premiered originally by them). Re-recordings, covers, or adaptations of pre-existing Dominican songs performed by foreign artists (e.g., foreign orchestras or singers covering already released Dominican hits) are **strictly excluded**. Such covers do not constitute international creative works of the author, but external re-recordings of national repertoire without cataloging value in Mangulina.

## 7. Review gates

Gate A — Scope: establish subject, deliverables and action authority. Proceed autonomously with authorized research. No data-write authority is implied.

Gate B — Evidence review: deliver findings and an exact proposed change manifest. Each action specifies entity UUID or proposed new identity, before/after fields, evidence, confidence, reason, dependencies and affected artists. Unresolved identities remain unchanged. Editor approval must cover the actual manifest before catalog writes, with this exception authorized and clarified by the editor on 2026-10-16: a request to create or complete a named artist profile authorizes saving that artist with artists.status = draft and publishing its completed, validated English and Spanish biography documents with editorial_documents.status = published, without a second approval of the manifest. Keep the evidence manifest, identity checks and post-write verification of both statuses. Biography publication prepares content for the artist's eventual release; it does not publish the draft artist profile. The exception does not cover publishing the artist profile, publishing biographies for an already public artist without authorization, destructive actions, shared-record changes, expanded artist scope, discography imports or security changes; Gate C and the Supabase security prohibition otherwise remain unchanged.

Gate C — Destructive/shared/public actions: obtain explicit approval for merges, deletions, bulk replacements, shared-record modifications, expanded artist scope and publication. Describe exact records, consequences and recovery method first. Prior approval is reusable only for the same manifest and scope; changed assumptions require renewed review. Resolve contradictory rules before the affected action. Do not use bypass mode to skip gates.

Gate D — Cleanup rehearsal: follow the existing cleanup procedure, including checksum-verified backup, demonstrated isolated restore, complete dependencies, frozen machine-readable manifest, exact script and guarded transaction. Present rehearsal results for explicit destructive approval before production. Refresh the backup if state changed. No security changes by assistants; a human applies under SUPABASE_SECURITY_POLICY.md.

Gate E — Verification: compare approved actions with actual results, abort on stale preconditions or unexpected effects, validate identities, references, ordered tracklists, credits, provenance, identifiers, platform destinations and URLs. Verify that unrelated artist records did not change. Use read-only baselines and before/after comparisons where execution is authorized. Database/code/application checks belong only to separately authorized execution tasks.

## 8. Required audit and change report

Every task ends with:

- Scope, date, assistant/tool, access limitations and action authority.
- Exact files created/updated and records read/proposed/changed, with UUIDs where available; distinguish proposals from applied actions.
- Field-level before/after values, reasons and source references; retain literal source credits and conflicting evidence.
- Separate counts for Works, Recordings, Releases, Release Groups, Track appearances and credits; report unknown counts as unknown.
- Duplicate/version decisions, exclusions, unresolved cases and cross-artist effects.
- Approvals received/pending, manifest reference and backup/rehearsal/rollback evidence when applicable.
- Checks actually performed, results, failures and remaining editorial questions. Never present proposed checks as completed checks.

For research-only tasks, explicitly say: no database, application code or music data changed. Store research reports in the agreed location; use existing provenance/audit mechanisms for approved catalog work rather than creating a parallel database system. Do not expose credentials or private configuration in reports.
