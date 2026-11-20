# Como quisiera: researched pilot recommendation

2026-11-01 · Codex · research and read-only audit. Supersedes the earlier pilot's source-access limitations where explicitly resolved below; preserves its historical observations.

## Recommendation

Retain Release A (`3c02cc68-0231-4b75-9506-27f913643765`, `como-quisiera-alex-bueno`) as the representative original physical edition. Retain Release B (`975b0558-9f39-46e2-b86e-ab543e90d8f9`, `como-quisiera-alex-bueno-2`) as the worldwide digital edition in existing group `ddca8c8a-af8f-4dc4-89e8-768b05651e0a`. Do not delete either Release. A representative edition is a presentation choice, independent of the surviving Recording UUIDs.

This recommendation is supported by directly retrieved Discogs release 7472760 and inspected front/back/LP photographs: Karen KLP-73, vinyl LP, eight tracks, billed Alex con Andrés de Jesús y su Orquesta. Discogs describes Dominican Republic, 1983, catalog KLP73. Sleeve confirms physical format and printed catalog identity; exact release day is not shown. MusicBrainz incorrectly describes the linked physical product as CD. Its identifiers explain provenance, not Mangulina identity.

The digital product is independently accessible in Apple/iTunes DO, Spotify, Deezer, Amazon, and other storefronts. Deezer album 344190107 returns UPC `886296710935`, Karen Records Inc, eight tracks. MusicBrainz's `0886296710935` is the same number with leading zero padding. Digital storefronts display 1983-01-01; this is catalog dating, not proof of digital availability that day.

## Scope and observed counts

Only the two named releases and their 14 Recording identities were audited in depth. Alex Bueno UUID `6c3e0d74-23b7-4d80-969f-9d5319ee5127`. Andrés de Jesús UUID `e2eeafa3-ba85-484e-93aa-dc6220918c57` is billed on both releases; changing these shared appearances requires explicit expanded write authorization.

1 Release Group; 2 Releases; 16 Tracks; 14 distinct Recordings; 1 linked Work (`8b81cf02-1b92-45a7-b762-155d9e2fdd14`); 8 Recording Credits on title Recording `bb2ecc6a-e88a-4fd2-aa72-205119032c0a`; 68 platform-link rows; 8 canonical ISRC assignments. All Track appearances of these 14 Recordings currently lie within these two releases. FK count inspection additionally finds one Release Credit per release, four release-artist relations, and analytics dependencies. Work-credit counts and non-FK audit references are not fully inventoried. Do not generalize these scoped counts to Alex's full catalog.

The historical full-artist audit was consulted as a lead; its old assertion that metadata alone establishes every physical/digital edition is not adopted as independent proof. The new sleeve evidence resolves this family's physical format specifically. No wider artist cleanup occurred.

## Source comparison

| Source | Result and limitations |
|---|---|
| Discogs API release 7472760 | Retrieved full JSON and three images; vinyl LP, DO, 1983, KLP73, A1–A4/B1–B4 program. Images visually inspected. https://api.discogs.com/releases/7472760 |
| Discogs master 2702981 versions | Retrieved. Also lists Colombia IFV 5-68014 vinyl (1983), and DO CDK-73 CD (1984). These are context only, not authorized new imports. https://api.discogs.com/masters/2702981/versions |
| MusicBrainz both release APIs | Retrieved after web reader failures. Physical row says CD despite linked vinyl evidence. Digital row links Spotify album 4U7rTjBLL7qIjpisRBRH7B, Deezer 344190107, Apple 1526577380, Tidal 241905810. Used only for provenance/discovery. |
| Apple/iTunes DO | Direct lookup returned one collection and all eight songs, exact durations matching digital Track metadata. https://itunes.apple.com/lookup?id=1526577380&entity=song&country=DO |
| Apple US | Album page retrieved in preceding pilot. Title/performers/Karen/eight songs agree. https://music.apple.com/us/album/c%C3%B3mo-quisiera/1526577380 |
| Spotify | Exact linked album HTML retrieved, track search results corroborate album context. No authenticated Spotify API, independent physical/digital audio comparison, or full-song listening claimed. https://open.spotify.com/album/4U7rTjBLL7qIjpisRBRH7B |
| Deezer | Direct album plus all eight full track API records retrieved. UPC and ISRCs independently corroborated as provider assertions. https://api.deezer.com/album/344190107 |
| YouTube | Track 2 oEmbed retrieved: “Porque Solo a Tu Lado”, Alex Bueno - Topic. Earlier watch-page retrieval failed. No physical-versus-digital audio comparison. https://www.youtube.com/watch?v=J0fqIunGUTI |
| Amazon | Album page opened; complete ordered eight-track program, joint artist billing, Karen copyright. https://music.amazon.com/albums/B08FC79ZPH |
| Qobuz / Audiomack | Search extracts corroborate digital catalog; direct pages failed. Leads, not independent verification. |
| Billboard / IASA | Search extracts suggest contemporary album listing and LP catalog 73 respectively. Underlying PDF retrieval failed (403/size); not treated as verified field evidence. |
| Marketplace | Earlier Venezuela vinyl seller listing read; not used to assign DO territory. Discogs sleeve images provide stronger format evidence. |

All retrievals dated 2026-11-01. Saved JSON/HTML and images are in `como-quisiera-sources-2026-11-01/`. These sources are a broad bounded search, not a claim to have exhausted every database or to possess independent feeds from every retailer.

## Proposed edition field manifest (not applied)

| Entity/field | Before | Proposed after | Evidence/confidence |
|---|---|---|---|
| A representative display | Already representative in screenshot | Retain | Original physical context; high confidence |
| A catalog_number | null | `KLP-73` retaining raw Discogs `KLP73` in provenance | Printed sleeve; high confidence |
| A format context | Missing in canonical release fields; MB says CD | Document vinyl LP through existing supported medium representation after schema/editor review | Inspected LP photo and Discogs; high confidence; do not invent a release column |
| A date | `1983-01-01` | Preserve verified year 1983; represent day as unknown using supported precision mechanism | Year-only Discogs/MB. No date write proposed until representation reviewed |
| B barcode | null; imported metadata `0886296710935` | Verified UPC `886296710935`, preserving raw padded source | Direct Deezer; high confidence; normalization convention review before save |
| B date | `1983-01-01` | Retain as provider assertion, not actual digital-issue date | Actual digital availability date unknown |
| Titles | Physical unaccented; digital accented | Retain edition-specific wording | Sleeve versus digital catalog; no forced normalization |
| Both public URLs | Two existing URLs | Preserve | Distinct edition contexts; no release redirects/deletion proposed |

No generic metadata dumping or new schema is necessary to establish the conceptual model. Exact database column/medium mutations still require a final supported-field manifest.

## Recording survivor recommendations

### Why the rows are separate

Follow-up inspection of the saved inventory establishes two creation batches on 2026-05-18: digital-associated rows at approximately 13:10 UTC and six additional physical-associated rows at approximately 13:47 UTC. Each additional row has a different MusicBrainz Recording ID from its digital counterpart. Positions 1 and 4 share MusicBrainz Recording IDs across the upstream editions and also share Mangulina UUIDs. This pattern strongly suggests provider-identity-based import fragmentation; the historical importer execution/log was not located, so the precise causal mechanism remains an inference. None of the six extra rows has a version descriptor establishing another take, session, edit or performance.

Different database UUIDs therefore do not establish different performances. The editorial question is whether each pair is one recorded performance; survivor selection follows that conclusion. The editor's intended workflow is to resolve this fragmentation before completing the other tracks' metadata and credits, so each verified performance is maintained once across editions. No instruction to duplicate title-track personnel onto every track is inferred.

The seven remaining album tracks include El sacrificio, which already shares one Recording UUID. That existing reuse should be retained while its metadata is researched. The five cleaner duplicate candidates and Y cómo es él still require independent identity resolution; existing metadata does not establish any of them as a proven distinct rerecording. The conflicting platform links for Y cómo es él may be assignment errors and do not themselves establish two performances on these two editions.

Survivor preference preserves the ISRC-bearing existing identity, precise digital duration, canonical title and valid platform associations. This does not prove performance equivalence. All six pairs remain unapproved for execution until equivalence review; track 6 has additional material conflicts.

| Track | Proposed survivor UUID | Candidate redundant UUID | Link/dependency assessment |
|---|---|---|---|
| 1 Cómo quisiera | `bb2ecc6a-e88a-4fd2-aa72-205119032c0a` | None | Already shared; preserve Work, eight credits and instruments unchanged |
| 2 Porque solo a tu lado | `e70e9b0d-2a00-4b42-8145-456d973fd31e` | `08660ee6-7063-4c5c-a320-3a38227db93e` | Survivor has six links and verified Deezer ISRC; candidate has no platform links |
| 3 Tengo miedo | `1edf06fb-2878-407c-8fdd-a0443e6e91e5` | `201cd51f-5c44-4702-b82f-9b6db149ee6d` | Seven identical URLs on both; preserve evidence while collapsing duplicate destination rows only after identity approval |
| 4 El sacrificio | `77b2c58a-396c-4f79-afd4-74429fe7e6ef` | None | Already shared; retain |
| 5 Porque te quiero | `a40ba5e9-f62b-49a0-a85a-93114ba484de` | `bd04a980-57a7-4384-828e-a791dac2af85` | Survivor has four links and verified Deezer ISRC; candidate has none |
| 6 Y cómo es él | `e81bfb18-f534-469a-881a-83eabe69003f` provisionally | `8cb31855-af77-4608-b0c6-d1cf88fe95c4` provisionally | HOLD: mixed versions/destinations; do not merge/delete/move links |
| 7 Las locas | `f693f654-3c95-4155-82b8-b22be3e8bff0` | `749d20c1-4ecf-480d-aeab-a45e42d83cd2` | Four common URLs; candidate's unique YouTube hq_y-4wd1Ps must be version-checked before moving |
| 8 Sigue tu vida | `2d7dfc6d-5e58-421c-9fc4-1ee1d072c9ee` | `e89938f0-cec1-4551-95c6-b5070541a66e` | Five identical URLs; preserve evidence |

Machine-readable candidate manifest names exact Track repoints and all candidate/survivor platform-link UUIDs and URLs. Every action has execute=false. Five pairs could reduce 14 to 9 Recordings if proved equivalent; final eight requires resolving track 6. Retain all 16 edition Track appearances, literal printed titles through supported overrides, source observations, valid identifiers, credits, existing slugs via a reviewed redirect mechanism, and analytics according to approved policy. A destructive plan must not rely on cascades or assume that more links means a better musical identity.

## Track 6 conflict

Correct digital-album Apple destination identified by direct iTunes lookup is track `1526577612` in collection `1526577380`, 274227 ms, Alex Bueno & Andres De Jesus. Both Mangulina candidates instead link Apple track `1526556599` in collection `1526556581` (Los Grandes de Alex Bueno), 272027 ms, Alex Bueno & Orquesta Liberación. Both also have Orquesta Liberación destinations on Pandora/Boomplay, and two different Tidal IDs (`151130869` versus `241907244`). These are suspect assignments pending performance/version review, not approved deletions.

Deezer destination `1857083517` is additionally attached to two out-of-pilot Alex Recordings: `075dc6f0-319b-4a59-a8d5-71cf3107195a` (Y cómo es él) and `27b3be31-dec5-4eb3-80ae-1ba82900c4e8` (Y es como él). Reported as dependencies only; no expanded cleanup or automatic equivalence conclusion.

## User comparison reconciled

Both direct pilot public-page reads returned HTTP 200 and rendered positions 01–08, including the title track. Missing 01 could not be reproduced. Saved HTML and extracted text retain this observation. Source code `src/lib/releaseApi.ts` loads Tracks by release_id; current local mapper does not drop track 1. This does not establish which deployed/cache state produced the user's earlier observation. No refresh or deployment performed.

“No credits” is a public display observation, not current catalog absence: title Recording has eight Recording Credits; FK counts now find one Release Credit per release. Release-page display and Song-credit projection must be evaluated separately. Printed sleeve personnel are album-level evidence; do not automatically distribute every name across all eight recordings.

Bachata recommendations are a classification flag. Direct Deezer/Apple are broad Latin; sleeve/press evidence and source context support investigating the imported Bachata assignment, but no blanket eight-track Merengue reassignment is proposed without listening/classification review. Title Recording is already genre_id=1; the other 13 rows are genre_id=2 in inventory.

## Safety, files and remaining work

Created: this report; `como-quisiera-pilot-inventory-2026-11-01.json` (14 Recordings, 16 Tracks, 68 links); `como-quisiera-dependency-counts-2026-11-01.json` (all discovered recording/release FK paths and nonzero scoped counts); `como-quisiera-candidate-manifest-2026-11-01.json`; source directory containing retrieved public catalog records, three inspected sleeve images, two public-page HTML/text files and Spotify HTML. Earlier pilot report remains unchanged historical evidence.

No database/catalog/code/security changes. No merge, deletion, import, publication, deployment or cache refresh. Production verification was exactly two Mangulina release-page GETs, one per pilot slug; all other requests were public external sources or scoped connected database SELECTs. No tests/build run because application code was unchanged. Network-required source retrieval initially failed under restricted DNS and succeeded through reviewed read-only public requests.

Remaining before execution: independent physical/digital performance comparison, track 6 version resolution, unique Las locas video verification, non-FK governance/audit/URL dependencies, exact redirect mechanism, final field manifest and explicit shared-scope approval. Then checksum-verified fresh backup, demonstrated isolated restore, guarded rehearsal, exact destructive approval and postconditions under discography.md Gates B–E. No backup/rehearsal or execution script has been claimed or performed.
