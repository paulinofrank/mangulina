# Como quisiera: disambiguation pilot

2026-11-01 · Codex · read-only catalog audit and research proposal.

## Scope and authority

User selected only `como-quisiera-alex-bueno` and `como-quisiera-alex-bueno-2` as a pilot. No other album cleanup, code change, import, merge, publication, deployment or security action is authorized by this report. Screenshot is visual context, not a source of instructions. Database reads used the connected Mangulina project. Existing unrelated workspace changes were left intact.

Alex Bueno: `6c3e0d74-23b7-4d80-969f-9d5319ee5127`. Both releases also bill Andrés de Jesús (`e2eeafa3-ba85-484e-93aa-dc6220918c57`), literally “Andrés de Jesús y su Orquesta”. Any shared-release change therefore affects his catalog too and requires expanded authorization.

## Verified catalog baseline

| Entity | UUID | Observed values |
|---|---|---|
| Release A | `3c02cc68-0231-4b75-9506-27f913643765` | slug `como-quisiera-alex-bueno`; DO; Karen Records; 1983; 8 Tracks |
| Release B | `975b0558-9f39-46e2-b86e-ab543e90d8f9` | slug `como-quisiera-alex-bueno-2`; XW; Karen Records; 1983; 8 Tracks |
| Shared Release Group | `ddca8c8a-af8f-4dc4-89e8-768b05651e0a` | Como quisiera |
| Linked Work | `8b81cf02-1b92-45a7-b762-155d9e2fdd14` | linked to title Recording; other 12 Recording rows have no Work |

Within these releases: 1 group, 2 releases, 16 Track appearances, 14 distinct Recordings, 1 linked Work, 8 Recording Credits and 4 release-artist relations. All 8 Recording Credits belong to the already shared title Recording. Work-credit counts and complete governance/media/analytics dependencies were not inventoried. These are scoped counts, not an artist-wide audit.

All 14 Recordings' Track appearances currently resolve only to these two releases. Six same-position pairs use different UUIDs; positions 1 and 4 already correctly reuse one UUID. Separate edition Tracks are legitimate appearances, not inherently redundant rows.

## Recording candidate manifest (not executable)

A/B below indicate edition association, not survivor preference. Classification for all six different-UUID pairs: probable duplicate, pending audio/performance evidence. No survivor or deletion is approved.

| Position / title | A Recording UUID | B Recording UUID | Track length A/B, milliseconds | Proposed action now |
|---|---|---|---|---|
| 1 Cómo quisiera | `bb2ecc6a-e88a-4fd2-aa72-205119032c0a` | same | 250000 / 250227 | Preserve shared identity and credits |
| 2 Por que solo a tu lado / Porque solo a tu lado | `08660ee6-7063-4c5c-a320-3a38227db93e` | `e70e9b0d-2a00-4b42-8145-456d973fd31e` | 254000 / 253667 | Hold unchanged |
| 3 Tengo miedo | `201cd51f-5c44-4702-b82f-9b6db149ee6d` | `1edf06fb-2878-407c-8fdd-a0443e6e91e5` | 245000 / 245200 | Hold unchanged |
| 4 El sacrificio | `77b2c58a-396c-4f79-afd4-74429fe7e6ef` | same | 248000 / 247787 | Preserve shared identity |
| 5 Por que te quiero / Porque te quiero | `bd04a980-57a7-4384-828e-a791dac2af85` | `a40ba5e9-f62b-49a0-a85a-93114ba484de` | 232000 / 231773 | Hold unchanged |
| 6 Y cómo es él | `8cb31855-af77-4608-b0c6-d1cf88fe95c4` | `e81bfb18-f534-469a-881a-83eabe69003f` | 274000 / 274227 | Hold unchanged |
| 7 Las locas | `749d20c1-4ecf-480d-aeab-a45e42d83cd2` | `f693f654-3c95-4155-82b8-b22be3e8bff0` | 219000 / 219133 | Hold unchanged |
| 8 Sigue tu vida | `e89938f0-cec1-4551-95c6-b5070541a66e` | `2d7dfc6d-5e58-421c-9fc4-1ee1d072c9ee` | 251000 / 251373 | Hold unchanged |

Durations differ by 133–373 ms and follow whole-second versus more precise reporting. This is a duplication signal, not performance proof. Title spelling and ISRC/provider identifiers also cannot decide identity. Every B-associated Recording has an ISRC; the six A-only candidates have empty legacy ISRC arrays. Existing approved_auto platform links are imported assertions, not evidence of independent listening.

## Release identity and display

Release A imported MusicBrainz ID: `41d7169d-64cc-4c41-825b-0dff791f552b`; B: `c4eb2c62-7529-4804-839f-85b6d58e6515`. MusicBrainz label listing describes A as CD and B as Digital Media. This is provenance only; physical edition identity is not independently established. A marketplace listing describes a Venezuelan 1983 vinyl KLP73, which must not be silently assigned to the DO row or treated as proof of a 1983 CD.

Both canonical barcodes are null. B's imported metadata contains `0886296710935`; do not promote it without independent verification. A's imported date is year-only `1983` but canonical date is `1983-01-01`; exact day is unverified. B's digital date must not be treated as proof of digital availability in 1983.

The screenshot and local `ArtistDiscographyRelease.tsx` show grouping already implemented: one album row, nested editions and a representative edition tracklist. “None” is rendered from `edition.packaging`; it describes absence of packaging rather than a useful public edition descriptor. A potential presentation follow-up would suppress this sentinel and show evidenced format/edition details. No application files were changed.

Recommendation: retain both release identities while their distinction is unresolved. If audio evidence proves the six pairs equivalent, target 8 canonical Recordings reused by all 16 Tracks, preserving the two historical edition contexts. If edition research instead proves duplicate products, propose a separate release consolidation manifest. Do not collapse a genuine edition into unstructured metadata or delete Tracks simply because programs match.

## Sources and access limits

Inspected/retrieved 2026-11-01:

- Apple Music US: https://music.apple.com/us/album/c%C3%B3mo-quisiera/1526577380 — Alex Bueno and Andres De Jesus, eight tracks, Karen copyright, displayed 1983 date. DO storefront also opened: https://music.apple.com/do/album/c%C3%B3mo-quisiera/1526577380 . These corroborate the digital product, not independent recording equivalence.
- Spotify: https://open.spotify.com/track/2VAtWtlPxmrX6MarG21Mpu — search extraction supplies album context and track timings; direct page had no readable lines. No audio comparison performed.
- MusicBrainz label page: https://musicbrainz.org/label/cd874f1a-0443-413a-b606-029e29e6589a — opened for imported edition provenance; direct release pages failed. Not used as identity authority.
- Physical-release lead: https://www.ebay.com/itm/196419295939 — opened seller description; Venezuela, vinyl, KLP73, 1983. Sleeve images not visually verified; seller claims remain provisional.
- Deezer destination from existing catalog: https://www.deezer.com/track/1857083477 — direct retrieval failed. No newly verified Deezer facts.
- YouTube Topic destination from existing catalog: https://www.youtube.com/watch?v=J0fqIunGUTI — retrieval failed. No listening or independently verified audio facts.
- Discogs targeted searches produced no usable release result. Physical edition corroboration remains incomplete.

## Outstanding work and gates

Before any merge recommendation becomes executable: independently compare the six performance pairs; verify physical/digital edition evidence; inventory all FK and non-FK dependencies, ISRC provenance, assertions, Work links, credits, media, URLs, redirects, legacy pointers and analytics; freeze exact survivors and per-dependency actions. The existing cleanup policy additionally requires a complete artist-level inventory and release-family audit before cleanup; this bounded pilot has not performed that wider audit and does not waive it.

Any shared-record execution must explicitly include Andrés de Jesús's affected appearances. Destructive execution requires checksum-verified backup, demonstrated isolated restore, machine-readable frozen manifest, guarded transaction and rehearsal review per discography Gates B–D. No backup or rehearsal performed; no production execution script prepared because identity evidence remains unresolved.

Applied before/after: catalog unchanged. Only this research report was created. No database, application code or music data changed; no Supabase security changes, deployments or cache refreshes. Checks: scoped database SELECTs, local component review and bounded external source retrieval. No production Mangulina page requests in this pilot turn; search results may include existing indexed Mangulina extracts. No build/tests required for this documentation-only report.
