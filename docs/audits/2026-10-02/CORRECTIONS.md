# Verified corrections — October 2, 2026

**Latest authorship update:** [The 213-claim follow-up](AUTHORSHIP-213.md) applied 31 additional verifications, superseded 13 incorrect claims, and restored 26 author roles across eight Works. The original generated cohort now contains 230 verified, 51 superseded and 169 unverified claims. Historical counts below describe the earlier passes.

**Later update:** The website fixes are now deployed. The follow-up reviewed all 86 candidates: 65 settled and 21 unresolved or partially resolved, with 12 further owner corrections and 57 performer-credit additions applied. Current totals are 115 corrected recording owners, 163 new performer credits, 16 added shared release credits, and one corrected featured release billing. See [deployment and follow-up review](FOLLOWUP.md). The sections below describe the earlier pass; the linked applied-verification file now includes the follow-up results.

Catalog corrections were applied to the live database after the user requested official-source verification and correction. Final read-only verification: October 2, 2026, approximately 8:07 p.m. America/New_York (October 3 UTC). This is a catalog-wide structural audit plus documented historical corrections. It is **not certification of every fact in the entire catalog**.

## Applied results

| Change | Count |
|---|---:|
| Recording principal-artist corrections | 103 |
| New structured recording performer credits | 106 |
| Existing incorrect performer credits corrected | 11 |
| Missing shared-release primary-artist credits restored | 11 |
| Composition Works corrected or expanded | 27 |
| New explicitly sourced composition credits | 70 |
| Incorrect composition-credit rows superseded | 38 |
| Previously generated authorship roles independently verified with evidence | 199 |
| Recording-title corrections | 2 |

No recordings, Works, release appearances or existing platform links were deleted or merged. Foreign participants were credited through external_contributors, without adding them to the Dominican artist directory. New external identities remain draft; their source-backed names are available through the existing public credit readers.

The original 450-credit ownership-generated cohort is now completely accounted for: **199 independently verified, 38 superseded, 213 still unverified**. The initial unsupported-verification reset affected 428 rows; 199 were subsequently verified with independent evidence and six more superseded. “Unverified” preserves a claim for review; it does not certify it or establish that it is false. Across the whole canonical credit table the current counts are 422 verified, 1,227 unverified and 38 superseded.

## Recording attribution and shared releases

Eighty-four recording corrections were supported by label-delivered Qobuz MainArtist credits, exact release position/title and matching imported recording identities. The corrected performers are Eddy Herrera (14), Luis Vargas (28), Frank Reyes (15), Raulín Rodríguez (5), Yoskar Sarante (5), Alex Bueno (14) and Sexappeal (3). The exact UUID-level changes and official URLs are in [compilation-plan.json](corrections/compilation-plan.json).

These span Dos x uno, Bachata Fest volumes 1 and 2, Dobletazo, 2 grandes de la bachata volume 4, and 4x4 en salsa volume 1. Shared package billing was preserved and ten missing release-artist associations added. The Qobuz release Sergio Vargas y Alex Bueno bills both artists on each track; that evidence was insufficient to transfer recordings to one artist, so those candidates were retained for further review.

**Encuentro:** The original Banco Popular CD back cover explicitly names each performer. Eleven performances of Rubén Blades and/or Robi Draco Rosa had incorrectly been assigned to Juan Luis Guerra, including explicit Guerra lead-performer credits. Their principal artist is now external, the eleven wrong credits were corrected, and Patria's second lead restored. Qué bonita luna retains Guerra and now includes the other two credited leads. The album remains in Guerra's discography because he genuinely participates in the package.

Primary evidence: [original CD back cover](https://coverartarchive.org/release/b2292ff5-f723-4d66-9b9b-a4e959b95aa7/17457932811.jpg), inspected visually, with source URL and SHA-256 preserved in [package-evidence.json](corrections/package-evidence.json). The physical release is the 2002 Banco Popular package, barcode 604731200779. Cover Art Archive is the repository for the original artifact; its community-written metadata was not treated as primary evidence.

**2 grandes voces de la fiesta latina:** The original Mock & Roll / Sony BMG Norte CD back explicitly assigns positions 2, 4, 6, 8, 10, 12, 14 and 16 to Proyecto Uno. Those eight Recording owners were corrected from Ilegales to Proyecto Uno, their lead credits added, and shared album billing restored. Dame un chín now has both Ilegales and Johnny Ventura lead credits, matching the printed duet billing. Other featured identities not independently resolved were not invented.

Primary evidence: [original CD back cover](https://coverartarchive.org/release/a4f66633-e31d-4269-a9bc-c48b2d07143b/37061999424.jpg), visually inspected; barcode 883736022726, 2007 copyright. The [Sony Legacy release page](https://www.legacyrecordings.com/releases/2-grandes-voces-de-la-fiesta-latina/) corroborates the package and track listing. UUID-level plan: [additional-recording-plan.json](corrections/additional-recording-plan.json).

**Me decidí:** [iASO's own Bandcamp release](https://iasorecords.bandcamp.com/album/me-decid) confirms Joan Soriano's band and explicitly identifies Fernando Soriano, Griselda Soriano and Andre Veloz as featured artists on particular tracks. Nine featured-performer credits were added across eight recordings, preserving Joan's valid band attribution. The two issued versions reuse the same Recordings. “Youlanda” was corrected to “Yolanda”; “Váyase” to “Váyase en paz”. Existing slugs were preserved, and matching Track overrides corrected where applicable.

## Composition credits

Composer, lyricist and songwriter roles were assigned only where the source explicitly supports the specific role. A generic Writer credit was not arbitrarily split into composer and lyricist. A producer or performer credit was not converted into authorship.

The first sixteen corrected Works had thirty-two ownership-derived Guerra composer/lyricist rows superseded. Forty-five replacement credits identify the actual writers:

| Work | Source-backed writers / role limits |
|---|---|
| Blanca mujer; Cruzando puertas; Mamá; Esto es vida | Draco Rosa and Luis Gómez Escolar — composer and lyricist |
| Vagabundo; Penélope | Draco Rosa and José Manuel Navarro Sempere — composer and lyricist |
| Amor y control; Pedro Navaja; El nacimiento de Ramiro | Rubén Blades — composer and lyricist |
| Sin tu cariño | Rubén Blades and Louie Ramirez — composer and lyricist |
| Padre Antonio y su monaguillo Andrés; Patria | Rubén Blades — explicit Composer and Writer, mapped to composer and songwriter |
| Gracias a la vida | Violeta Parra — composer; no additional lyricist role inferred from this source |
| Si no te hubieras ido | Marco Antonio Solís — composer and lyricist |
| Woman del Callao | Julio Delgado — composer and lyricist |
| Bendita tu luz | Fher Olvera and Sergio Vallin — songwriter; source says Writer |

The sources are the original artists' label-delivered releases, including Sony's Vagabundo/Frío/Vida, Fania's Siembra/Maestra vida/Buscando América/Bohemio y poeta, Warner's Amar es combatir and the explicitly billed Gracias a la vida single. Exact source tracks, literal author strings, roles and URLs are retained in [work-plan.json](corrections/work-plan.json), [additional-work-plan.json](corrections/additional-work-plan.json) and [official-release-credits.json](corrections/official-release-credits.json). Sony's own [Esto es vida announcement](https://www.sonymusic.es/lanzamientos/draco-lanza-esto-es-vida-duo-con-juan-luis-guerra-como-2o-single-extraido-de-su-nuevo-disco-vid/) corroborates the songwriting and duet distinction. Sin tu cariño's coauthor was taken from the original Fania release; a later edition omitting that coauthor was not used to erase him.

Eleven further Works were corrected or expanded with twenty-five sourced credits. Six additional Guerra roles were superseded: both composer and lyricist on Si tú me quieres and Buscando el mar, lyricist on Siempre queda el amor, and composer on Abriendo caminos.

| Work | Added authors and explicit roles |
|---|---|
| Si tú me quieres | Yoel Henriquez, Juan Fernando Fonseca, Yadam González — composer and lyricist |
| Buscando el mar | Carlos Vives, Andres Leal, Carlos Huertas Jr. — composer and lyricist; Hugo Huertas — composer; Martín Velilla — lyricist |
| Siempre queda el amor | Pedro Manuel Guerra Mansito — lyricist; Guerra's separate composer role retained |
| Abriendo caminos | Diego Torres and Luis Cardoso — composer; no lyricist attribution invented |
| A pedir su mano | Lea Lignazzi — composer and lyricist, as explicitly credited on Privé; literal spelling retained |
| Viviré | Shungu Wembadio Pene Kikumba — composer |
| Mal de amor | Jean Baptiste Joseph Nemours — composer |
| El costo de la vida; Los mangos bajitos | Diblo Dibala — composer; variant source credit DIBALA YANCOMBA retained |
| Canto de hacha; La cosquillita | Francisco Ulloa — composer, using his existing Dominican artist identity |

Exact evidence is in [collaboration-work-plan.json](corrections/collaboration-work-plan.json) and [juan-luis-label-credits.json](corrections/juan-luis-label-credits.json). The latter preserves thirty-one fetched label-credit pages, their retrieval times and HTML hashes. [Privé](https://www.qobuz.com/es-es/album/prive-juan-luis-guerra-440/wo32u7jgdj08a) explicitly names Lea's authorship roles. [Karen's 2025 remastered compilation](https://www.qobuz.com/us-en/album/grandes-exitos-juan-luis-guerra-440/g5q6xpw3gjsia) supplies the omitted composer credits. [Apple Music's label credits for El costo de la vida](https://music.apple.com/us/song/1744021526) corroborate Diblo Dibala's name. No biographical details or nationality claims were fabricated.

Coauthor restoration does **not** certify a remaining unsourced role of another author. For example, the outstanding Guerra role claims on Canto de hacha still require original detailed liner notes or publishing evidence; Francisco Ulloa's explicit composer credit was restored without claiming that this resolves every adaptation/lyricist question.

## Independently verified existing credits

The [199-credit verification plan](corrections/supported-authorship-plan.json) records exact existing Work-credit UUIDs, linked Recording UUIDs, release positions, literal track credits and source URLs. It verifies 148 composer and 51 lyricist roles. It uses original/explicitly identified packages such as Bachata rosa, Areíto, Literal, Para ti, Todo tiene su hora, Privé and Capitán Avispa. Composer-only credits never verify a lyricist role. The generated cohort was selected by its original UUID list, avoiding timestamp conversion ambiguity.

No new Work association or title-based merge was created by this process. A remastered composition credit may substantiate an existing composition's author; it does not establish that two audio performances are the same Recording. The complete-anniversary-compilation ordering did not match a proposed edition bridge, so it was excluded from automated verification. Dame's abbreviated author identities remain unresolved rather than being guessed.

## Presentation and recurrence fixes

The local application changes implement the current governance distinction: Discography presents performances/releases; Works & Credits presents creative contributions for other performers. Self performances are filtered per Recording, including co-performer/featured credits. A Work with both self and external versions can retain its eligible external version; role unions are recomputed afterward.

Performance-only roles were removed from creative portfolio eligibility. Production, engineering and conducting tabs replace the vocal-only portfolio tab. Composer, lyricist, songwriter and generic writer credits have separate tabs; a generic Writer credit no longer appears under Lyricist. External names are resolved through the existing public recording-credit reader. The legacy portfolio reader's omitted recording_id is recovered through a public query so canonical and editorial entries can be deduplicated correctly. The portfolio cache version was advanced.

The ownership-derived generator scripts/execute_phase6_credits_and_works.ts was retired. It now exits with an explanatory message and never loads credentials or connects to the database. It previously manufactured verified composition authorship from recording ownership.

**Deployment status:** Database data and the public recording view's SELECT rule are live. Application source changes are saved and validated locally; they have not been pushed or deployed. The production portfolio filtering fix therefore still requires the normal application deployment.

## Verification and security boundary

Every mutation batch was first executed inside a transaction and rolled back. Final runs include strict expected-before checks, advisory locks, replay refusal, before/after receipts and executed editorial decisions. New/changed authorship credits have work_credit_sources, typed assertions and supporting or disputing evidence. Catalog decisions preserve previous state; no superseded credit was hard-deleted.

[Applied verification](corrections/applied-verification.json) confirms all 103 recording owners, all 106 new performer rows, all 70 new authorship roles, all 38 superseded rows and all 199 independent verifications. Anonymous public readers expose the new composition roles and hide superseded roles. Eleven external Encuentro performances no longer appear in Guerra's recording repertoire; the closing three-artist performance remains intact. Structural checks found zero dangling references, role-code disagreements or duplicate active semantic credits.

The public recording projection's album-owner fallback was corrected so an external lead is not silently reassigned to a Dominican album participant. Only the existing view SELECT rule was replaced. View owner, grants, reloptions including security_invoker, and RLS flags were fingerprinted before/after and remain identical. A first rehearsal detected CREATE OR REPLACE VIEW resetting an option and fully rolled back; the applied rule-only approach preserved every fingerprint field. No RLS policies, grants, roles, auth settings, keys, function security or advisor settings were changed.

Application verification: **437 tests passed**, the ten targeted portfolio tests passed after the final role-tab change, npx tsc --noEmit and targeted ESLint passed, production build passed and generated 327 static pages. All twenty-two audit scripts passed syntax checks. The retired generator exits safely with status 1 as intended. [Cache refresh](corrections/page-refresh.json) succeeded for 21 affected artist profiles, 616 song paths and 14 release paths, using the existing authenticated revalidation endpoint. This cache refresh does not deploy local source changes.

Full before/after receipts and original packaging images are retained locally and excluded from Git. Reviewable plans, source URLs/hashes, decisions summaries and verification results are retained under corrections/. The original catalog snapshot remains unchanged as the audit baseline.

## Still unresolved

There are **86 remaining exact-other-artist candidate rows**, down from 178. Ninety-two initial candidates were corrected; eleven additional external Encuentro owners brought the total Recording owner corrections to 103. Remaining candidates are not automatically errors: they include band identities, aliases, legitimate duets, samples/remixes and genuinely unresolved compilations. Joan Soriano's eight flagged guest tracks have official-source explanations and structured featured credits restored while their valid band attribution remains.

The original [Monchy & Alexandra Hasta el fin CD back](https://coverartarchive.org/release/670e06e5-9531-4f16-8b03-a1bc4229fa51/38898664761.jpg) and booklet confirm the duo's package. A single member's lead-vocal metadata does not justify transferring those Recordings out of the group's discography. Detailed per-track vocal claims were not guessed from the printed album name.

Remaining priorities include Tony Seval/Aramis Camilo's La combinación perfecta; Sergio Vargas/Alex Bueno's shared album; Antony Santos/Raulín Rodríguez's Frente a frente; undocumented remix/sample credits; ambiguous abbreviated authors and publishing/adaptation roles. Conflicting digital editions were not used as grounds for correction. The complete UUID queue is [remaining-attribution-review.json](corrections/remaining-attribution-review.json).

Also outstanding: the 213 unverified claims in the generated cohort; wider verification of the catalog's other historical claims; 24 unanchored Works from the baseline; legacy recording-scoped composition credits; additional original liner notes, rights registrations and audio/version comparisons. The catalog contains 22,377 Recordings and 5,078 Releases, so an exhaustive official-source certification remains unfinished. Unchecked facts must not be represented as verified by this pass.
