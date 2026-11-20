# Como quisiera — primary-source track curation

2026-11-01 · Codex · research only. Scope: original eight tracks on Alex Bueno / Andrés de Jesús's Como quisiera, existing release UUIDs `3c02cc68-0231-4b75-9506-27f913643765` and `975b0558-9f39-46e2-b86e-ab543e90d8f9`. No new artist, recording, Work, credit, edition or publication created. Existing curated Cómo quisiera is preserved.

## Identity standard

MusicBrainz, Discogs and storefronts are fallible source assertions. Their IDs do not establish Mangulina recording identity. Photos of printed release material are primary evidence for what that edition credits; a printed credit may still be mistaken and must remain attributable to its source. A database row without a version descriptor is not evidence of a separate performance. Equally, repeated retailer feeds or identical titles do not prove one performance.

The curation objective is one canonical Recording for each proven recorded performance, shared by legitimate edition Tracks, with metadata and credits maintained once. Distinct proven performances remain distinct. No preference for an identifier-rich row resolves musical equivalence by itself.

## Newly inspected primary material

Retrieved Discogs API records and all available image files for:

- Colombian IFV LP 5-68014: https://api.discogs.com/releases/21172810 . Two images inspected: front/back sleeve. Back shows the original eight-track program, personnel, production and recording credits. Country and edition assertions are not permission to add another release.
- Karen CDK-73 CD: https://api.discogs.com/releases/37006224 . Three images inspected: front, physical disc and back insert. Disc prints per-track composer names and timings; back names arrangements and production. The printed program adds El chofer as track 9. This CD is materially different from the original eight-track LP and is not silently identified with either pilot release. Its Discogs year is a source assertion; no exact CD issue date is independently verified from the images.

Local images: `como-quisiera-sources-2026-11-01/discogs-37006224-1.jpg` is the physical CD face with composer credits; `discogs-37006224-2.jpg` is the CD back; `discogs-21172810-1.jpg` is the Colombian LP back. Original Karen LP photos inspected in the previous turn remain available as `discogs-sleeve-0.jpg` through `discogs-sleeve-2.jpg`.

## Track-by-track evidence matrix

Composer wording below is transcribed from the physical CD face. Modern display accents do not replace the literal source. These are composition-level claims, not session performance roles. The CD is evidence for source attribution, not proof that its audio equals the digital or LP audio.

| Original position | Song | Printed CD composer claim | Printed CD time / verified iTunes digital time | Current identity disposition |
|---|---|---|---|---|
| A1 / 1 | Cómo quisiera | `Comp. Ray Polanco` | 4.09 / 250227 ms | Existing shared Recording `bb2ecc6a-e88a-4fd2-aa72-205119032c0a`, curated Work and credits preserved |
| A2 / 2 | Porque solo a tu lado | `Comp. Pepe Luis Soto` | 4.12 / 253667 ms | Two Mangulina rows, probable duplicate; no independent alternate-performance evidence located |
| A3 / 3 | Tengo miedo | `Comp. Rafael M. Ruiz` | 4.03 / 245200 ms | Two rows, probable duplicate; seven existing platform destinations coincide; no physical/digital audio comparison completed |
| A4 / 4 | El sacrificio | `D.R.` | 4.03 / 247787 ms | Already one shared Recording `77b2c58a-396c-4f79-afd4-74429fe7e6ef`; author remains unidentified on this source |
| B1 / 5 | Porque te quiero | `Comp. Anthony Ríos` (printed without display accent) | 3.47 / 231773 ms | Two rows, probable duplicate; identity equivalence pending |
| B2 / 6 | Y cómo es él | `Comp. Jose Luis Perales` | 4.31 / 274227 ms | Two rows plus mixed platform assignments; candidate equivalence and destination versions require separate decisions |
| B3 / 7 | Las locas | `Comp. Pepe Rosario` | 3.36 / 219133 ms | Two rows, probable duplicate; unique YouTube destination requires verification |
| B4 / 8 | Sigue tu vida | `D.R.` | 4.09 / 251373 ms | Two rows, probable duplicate; five platform destinations coincide; author remains unidentified on this source |

The printed CD timings are consistently shorter than the digital metadata, by approximately 1–5 seconds. Do not treat the printed times as precise measured audio durations, and do not claim a different edit from that discrepancy alone. D.R. is preserved literally; it is neither an identified composer nor a justified public-domain declaration. Unknown author fields remain unresolved.

## Personnel and production evidence

Colombian LP back transcribes album credits: singer Alex; first trumpet Ramón Rodríguez; second trumpet D'Julio; third trumpet Juan Severino; alto sax Andrés de Jesús; tenor sax José Aquino; piano July Pie; bass Johnny Báez; güira/drums Manuel Franco; conga Canón Vilomar; tambora/percussion Carlitos Guareño; chorus Rey Polanco; arrangements/direction Andrés de Jesús; production Bienvenido Rodríguez; sound engineer Salvador Morales; recording Estudios EMCA. Preserve source wording and uncertain spellings pending larger scans/identity research.

CD back independently prints `Arreglos: Andres De Jesus` and `Productor: Bienvenido Rodriguez`. These are supported album-context claims. Track-specific personnel participation is not independently enumerated. Do not automatically clone every album credit to each of the eight Recording identities. In particular, source `Rey Polanco` chorus and `Ray Polanco` composition wording are preserved separately until the contributor identity is documented; do not infer equivalence from spelling.

Existing title-track credits are established editorial history and are not overwritten or removed by this research.

## Contributor resolution and remaining gaps

Scoped database name search finds existing candidates Anthony Ríos `081c1484-bf1c-4b11-ba01-d68446b7b111`, Pepe Rosario `03586dc0-5bbe-4b91-859d-f9c0dd580ea4`, Andrés de Jesús `e2eeafa3-ba85-484e-93aa-dc6220918c57`, and Ray Polanco `69289f21-4168-4fb5-af44-90438e068e3a`. These are identity candidates, not newly approved mappings merely from matching names. The same bounded search found no artist rows matching Pepe Luis Soto or Rafael Ruiz; aliases/external-contributor identities have not been exhaustively searched. No profiles created.

Targeted searches for the composer/song combinations did not yield usable independent corroboration for Pepe Luis Soto/Rafael M. Ruiz. A same-name composer exists in external sources, but that does not resolve the printed person's identity. Anthony Ríos attribution is supported directly by the disc. Same-title Pepe Rosario/Hermanos Rosario references are discovery leads, not proof that the Work is identical without lyric/audio comparison.

The 2013 collector account at https://clasicospagoza.blogspot.com/2013/12/ describes a 45 containing Y cómo es él / Como quisiera and alleges the Y cómo es él version differs from the album. It is an explicit version-research lead, not independently verified listening evidence. Do not erase all same-title Alex recordings across the wider catalog. Those outside this album remain outside write scope.

## What remains before catalog curation can be applied

1. Obtain independent audio for the original LP/authorized issue and compare against the exact digital tracks. Current research has sleeve images and digital catalog metadata, not an independently verified LP audio transfer. No listening, fingerprint or waveform equivalence is claimed.
2. Resolve the six duplicate candidate pairs individually. Incorrect platform matches do not establish different album performances. Keep El sacrificio's existing shared identity.
3. Reconcile composer identities and existing Works before proposing Work links or authorship credits. D.R. tracks remain unknown unless additional evidence identifies authors.
4. Resolve intrinsic genre/version and source-scoped personnel facts; preserve uncertainty instead of filling every track with the same album personnel.
5. Produce a final exact field/dependency manifest. The earlier survivor JSON remains a conditional research artifact with execute=false, not musical proof or merge approval.

No permission question is needed for this research. Applying catalog corrections remains subject to discography.md Gate B: `Editor approval must cover the actual manifest before catalog writes`; merges additionally require Gates C–D, expanded shared Andrés de Jesús scope, verified backup/restore and rehearsal. This report is not an executable manifest and does not request premature deletion approval.

## Changes and checks

Created this report and two public-source JSON files plus five downloaded/visually inspected images in the existing source directory. Read existing pilot inventory, performed bounded external searches and one scoped artist-name SELECT. Existing research files remain unchanged. No database, music data, application code, security, publication, deployment, cache refresh or Mangulina production-page requests in this follow-up. No build/tests needed for research documents. Seven tracks now have explicit source-level authorship dispositions, including two unresolved author claims; performance identity investigation remains incomplete for six pairs.
