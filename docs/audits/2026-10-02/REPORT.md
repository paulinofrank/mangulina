# Mangulina discography and credits audit — October 2, 2026

**Update:** The user subsequently authorized official-source verification and corrections. Catalog corrections have now been applied, public readbacks checked, and affected pages refreshed. See [CORRECTIONS.md](CORRECTIONS.md) for the current results, evidence, code validation and unresolved cases. The findings and counts below preserve the **initial, pre-correction snapshot**.

## Result and scope

The suspicion is supported. There are demonstrable recording-attribution errors and composition credits created from those errors. A separate presentation problem mixes performance contributions into Works & Credits. These are different problems and require different corrections.

This initial pass was a catalog-wide structural audit with targeted historical verification, not a certification of every credit. Read-only, repeatable-read database snapshot: **October 2, 2026, 6:25:39 p.m. America/New_York** (22:25:39 UTC). Its database operations were SELECTs inside a READ ONLY transaction, followed by ROLLBACK. The subsequent authorized correction pass is documented separately; its catalog changes must not be confused with this initial snapshot. Supabase security remains unchanged.

Coverage: 896 artists, 22,377 recordings, 5,078 releases, 27,755 track placements, 7,342 recording credits, 1,533 canonical Works, 1,617 canonical Work credits, 593 legacy portfolio entries and 362 legacy portfolio credits. Public recording projection contains 22,145 rows. Draft artists were included in internal inspection but are not assumed public.

## What belongs where

- **Work:** the underlying composition. Composer/lyricist authorship does not follow whichever singer records it.
- **Recording:** a particular performance/version. Lead/featured performers, session musicians, production and recording-specific arrangements belong here.
- **Release:** an issued package. A shared album can belong to several release artists without every artist performing every track.
- **Track:** a recording's placement on a release. Reuse on compilations does not change recording ownership or authorship.
- **Artist portfolio:** a presentation of contributions, not another source of musical identity. A collaboration or bandleader/vocalist distinction is not automatically a wrong credit.

The September 17 update at the beginning of DATA_GOVERNANCE.md identifies work_credits as canonical and credited_works as legacy. AI_INSTRUCTIONS.md Rule 9 still says local authorship should live on recordings and restricts portfolio entries to international artists; that conflicts with the current model and DATA_GOVERNANCE.md §5.5. Older worked examples in the guidance also should not be used as historical evidence.

## P1 — Encuentro: wrong recording and authorship credits

Release UUID `9377dfe3-7011-47d7-964d-98b628918559` is stored as a Juan Luis Guerra release. That alone is not wrong: he participates in this shared release. However, **11 tracks performed by the other billed artists have Guerra as recordings.artist_id AND an explicit Guerra lead_performer credit**. Their imported recording artist credits identify other performers.

The [Fundación Nacional para la Cultura Popular's 2002 CD listing](https://tienda.prpop.org/products/encuentro-robi-draco-rosa-juan-luis-guerra-ruben-blades) independently identifies the track performers:

| Tracks | Documented performers | Stored recording artist / lead performer |
|---|---|---|
| Blanca mujer; Vagabundo; Penélope; Mamá; Cruzando puertas | Robi Draco Rosa | Juan Luis Guerra |
| El nacimiento de Ramiro; Amor y control; Sin tu cariño; Pedro Navaja; Padre Antonio y su monaguillo Andrés | Rubén Blades | Juan Luis Guerra |
| Patria | Rubén Blades and Robi Draco Rosa | Juan Luis Guerra |

Every one of those 11 recordings links to a Work giving Guerra **both composer and lyricist credits marked verified**: 22 credit assertions require review. Performer evidence alone cannot establish the replacement authors, but it disproves the assumption used to generate these credits.

Two independently established authorship errors:

- **Pedro Navaja:** Work UUID `43c3b9b9-9522-473b-bce8-c371d76b26ec`. Guerra composer credit `f2d1c8fe-9a4e-4deb-aea9-7b68dc7faf4b` and lyricist credit `f6a13707-e881-4039-a422-7df7e39a1933` are marked verified. [Label-delivered credits](https://www.youtube.com/watch?v=VA5j_zbJHug) identify Rubén Blades as composer, and the [Work record](https://musicbrainz.org/work/98670c17-a436-3656-97df-aceb662476a2) identifies him as composer and lyricist.
- **Amor y control:** Guerra composer credit `1d8d66bc-a3e3-40a7-9911-55668e054548` and lyricist credit `7537d88b-fa9a-4f6c-88ad-4657ac1f2643` are marked verified. [Sony-delivered credits on Blades's official channel](https://www.youtube.com/watch?v=NgP0OYgWHpY) identify Rubén Blades as both composer and lyricist.

Exact recording IDs, lead-credit IDs, full Work rows and Work-credit IDs for all 11 are preserved in **encuentro-credit-errors.json**. Do not delete the release or remove Guerra's legitimate release participation. Correct individual recording credits and canonical authorship through the existing editorial workflow; retain the historical shared-release context. Non-Dominican performers/authors should use external contributors rather than newly created Dominican artist records.

## P1 — Cover/collaboration performances incorrectly treated as authorship

The following Works also assign Guerra composer AND lyricist credits marked verified. His performance participation can be legitimate while those authorship credits are wrong.

| Work | Contrary authorship evidence | Audit disposition |
|---|---|---|
| Gracias a la vida | [Warner-delivered ensemble recording credits](https://www.youtube.com/watch?v=dZH2fnEBldo) name Violeta Parra as composer | Guerra composition attribution contradicted; preserve his performance credit |
| Esto es vida | [Sony-delivered duet credits](https://www.youtube.com/watch?v=asigY6xpPyw) name Draco Rosa as composer and lyricist | Guerra composer/lyricist credits contradicted |
| Si no te hubieras ido | [Licensed recording credits](https://www.qobuz.com/au-en/album/asi-soy-charlie-cruz/0685738267163) identify Marco Antonio Solís as composer and lyricist | Guerra composer/lyricist credits contradicted; validate exact linked performance separately |
| Woman del Callao | [Licensed recording credits](https://www.qobuz.com/us-en/album/calipso-clasicos-y-originales-alfrid-valdez-el-rey-del-steel-band/goptnvv89paam) identify Julio Delgado as composer and lyricist | Guerra composer/lyricist credits contradicted; validate edition and any adaptation before replacement |
| Bendita tu luz | Available sources disagree on precise role division; Guerra's dual authorship cannot be justified by participation | Review original liner notes/publishing registrations; do not guess replacements |
| Esto es vida (bachata remix) | Authorship must remain separate from remix/arrangement contributions | Review alongside the original Work; do not automatically merge versions or transfer roles |

Full Work UUIDs, current assertions and recording UUIDs are in **composition-credit-review.json**. Evidence from another recording is used for underlying composition identity only; it does not establish session or arrangement credits for Mangulina's exact recording.

## P1 — Compilation tracks inherit the wrong artist

**Dos x uno:** release UUID `703e499f-41ec-4042-8340-d974bf96ef1d`, matching MusicBrainz release `1d2ed965-e379-4a71-9035-7aa4eceade32`. **14 recording rows assigned to Los Toros Band have imported recording credits naming Eddy Herrera.** The package itself is a shared release, as [Apple Music](https://music.apple.com/us/album/dos-x-uno/1233741515) confirms. The [matching edition's tracklist](https://musicbrainz.org/release/1d2ed965-e379-4a71-9035-7aa4eceade32) distinguishes Herrera tracks from Toros Band tracks. **Me gusta**, recording `5a06765c-3c7f-4a5a-bd78-00030e922a3a`, is incorrectly stored under Toros Band; [Apple's song listing](https://music.apple.com/us/song/me-gusta/472096763) independently identifies Herrera. Only Toros Band is present in this release's release_artists rows, so release credit coverage is incomplete too.

**El tiburón:** recording `50f358b7-3326-4571-89ac-3b294b234b89` is assigned to Ilegales, with no explicit recording performer credits, on **2 grandes voces de la fiesta latina**. Imported recording metadata names Proyecto Uno; the [label's official lyric video](https://www.youtube.com/watch?v=7ATCpd6My6s) corroborates the artist. Preserve the compilation placement while correcting recording attribution.

Other concentrated source conflicts requiring edition-level review:

| Stored artist | Other artists named by imported recording credits | Candidate rows |
|---|---|---:|
| Raulín Rodríguez | Frank Reyes / Antony Santos | 20 |
| Zacarías Ferreira | Alex Bueno / Frank Reyes / Raulin Rodriguez | 19 |
| Junior & Jorge | Luis Vargas | 11 |
| Sergio Vargas | Alex Bueno | 10 |
| Joe Veras | Alex Bueno / Yoskar Sarante | 10 |
| Teodoro Reyes | Luis Vargas | 9 |
| Frank Reyes | Luis Vargas | 8 |
| Tony Seval | Aramis Camilo | 6 |

These counts describe source conflicts, not independently verified errors. The complete **attribution-review.csv** has 178 recording candidates where a different existing catalog artist is named in the imported artist credit. It includes aliases, ensemble/member distinctions and genuine collaborations; do not apply blanket reassignment. The broader **import-candidates.json** records 1,085 raw owner/name mismatches and 1,210 potentially missing performer relationships. Those queues overlap and contain false positives. They are not error totals.

## P2 — Works & Credits presentation admits performance credits

The loader src/lib/getArtistWorksPortfolio.ts uses ARTIST_WORK_CREDIT_ROLES, whose list includes lead_performer, performer, featured_performer, guest_performer and vocalist. Accordingly, another artist's performance contribution can appear in Works & Credits without a creative credit.

ArtistWorksPortfolio.tsx DOES apply an exclusion filter; the audit does not claim self-performance filtering is absent. Its predicate accepts a group when any recording has another performer and a different release artist. It then retains every recording in that group and removes the current artist from performer labels. This can leave self-performance versions inside a surviving group and can obscure a genuine duet's credited performer list. A band's recording versus its lead vocalist is also inadequately handled by comparing releaseArtistId.

Correction should operate on individual contributions/recordings before grouping, distinguish creative from performance roles and preserve the complete credited performer display. Do not change authoritative credits just to make a tab disappear. No application patch was applied during this audit.

The legacy portfolio RPC also omits recording_id although credited_works now has that column and the loader expects it optionally. Thus canonical/legacy deduplication by recording UUID cannot work for those returned rows. This is a read-projection contract issue, not proof that their historical credits are wrong.

## Root cause and verification weakness

scripts/execute_phase6_credits_and_works.ts selects ALL recordings with Guerra's artist_id and inserts a Guerra lead credit. It groups recordings by stripped title, looks up/creates Works by title or slug, then inserts Guerra composer and lyricist credits with verification_status='verified', without authorship evidence. It also derives composition year from recording/release chronology. These are invalid inference rules: package ownership does not prove performance, performance does not prove authorship, identical titles do not prove Work identity, and release year does not prove composition year.

The snapshot contains **450 Guerra Work credits created at exactly 2026-09-18T03:41:09.399Z**. That shared timestamp and the observed credit pattern are consistent with bulk generation; they do not independently prove which script execution created each row. Review that entire batch rather than trusting its verified flag.

Across all canonical Work credits, **603 are verified and 1,014 unverified**. work_credit_sources contains just **2 source rows**, and Work-credit metadata is empty on every row. Notes exist on 30 rows. Other editorial assertion/evidence tables were not exported in this pass, so this does NOT establish that all other credits lack evidence. It establishes that verified status cannot be treated as independent substantiation here.

## Integrity findings and boundaries

- Zero dangling Track→Recording, Track→Release, Recording→Artist or Recording→Work references in the snapshot.
- Zero duplicate semantic recording/work credits by entity, contributor identity and role.
- Zero populated role_id/code disagreements in the checked canonical/legacy credit tables.
- **24 published Works have no linked recording**; listed in unanchored-works.json. Review release anchors; their existence is not proof of invented compositions.
- **14 composition-role credits remain at Recording scope**. Legacy placement requires review, not automatic transfer.
- **220 generic performer and 4 featured_artist credits** remain. The live role registry regards performer as active, while older documentation calls it deprecated. Do not automatically reinterpret them.
- Local legacy portfolio entry **Creíste**, Ramón Orlando credited for Antony Santos, has two credits and no recording anchor. This needs reconciliation with canonical data, not deletion on the assumption it is foreign-only.
- Same titles, multiple recordings, multiple releases, release-artist/lead-vocalist differences, and composer/performer differences are not themselves errors.

Not completed: every artist's original liner notes, all publishing registrations, audio listening/version matching, every external contributor identity, all assertion/evidence records, anonymous-site visibility checks, or every imported source relationship. This audit finds and prioritizes actual problems without claiming that unchecked credits are correct.

## Deliverables and reproduction

summary.json stores counts and integrity results. schema.json preserves the inspected columns and live read-function definitions. encuentro-credit-errors.json and composition-credit-review.json identify specific assertions. attribution-review.csv is the concise editorial queue; the larger JSON queues preserve supporting source conflicts.

catalog-snapshot.json is a local 49 MB working snapshot, excluded from Git by this directory's .gitignore. Keep it locally to reproduce the analysis; it is not a restoration backup. The extraction reads the existing DATABASE_URL without printing it. Run node docs/audits/2026-10-02/reproduce/audit-discography-catalog.mjs to take a new read-only snapshot, then the analyze-discography-audit, analyze-discography-imports, summarize-discography-audit and verify-discography-audit .mjs scripts in that same reproduce directory (run from the repository root). New snapshots may change counts; the narrative describes this dated snapshot.

Recommended correction order: stop ownership-derived verified-credit generation; review Encuentro recording and Work assertions; correct shared-compilation recording ownership and release credit completeness; fix portfolio contribution filtering and legacy recording-ID projection; then review the remaining source-conflict and evidence queues. Reuse existing governed editorial mechanisms and preserve URLs, release appearances and original credited text.
