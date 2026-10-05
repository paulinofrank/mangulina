Latest update (2026-10-03): [editor clarifications](EDITOR-CLARIFICATIONS.md) closes the Maffio attribution case with four editor-confirmed vocal credits and corrects both Alex Bueno titles to Sin ti no soy nada. Two new Dominican draft profiles still await editorial publication. Earlier counts below are historical.

# Follow-up on the fourteen pending attribution cases

Updated October 3, 2026. No information or permission from the user was required to resume this work.

## Applied and verified

**Ten recording performer corrections:** the ten remaining Sergio Vargas entries now belong to Alex Bueno, with `lead_performer` credits. Alex is also credited as a primary artist on both shared releases. All ten recordings appear in Alex's public discography and none remains in Sergio's. Their recording IDs, work links, release contexts and imported titles were preserved; no recordings were merged and no composer or lyricist roles were inferred.

Karen's [individually billed Spotify edition](https://open.spotify.com/album/5gOCPQHFTL18kXB0pGHblY) assigns tracks 6–10 to Alex. The [1988 Qobuz edition](https://www.qobuz.com/gb-en/album/sergio-vargas-y-alex-bueno-sergio-vargas-alex-bueno/c0stvf47mdmta) carries blanket shared package credits; that does not establish a duet on every song. The [solo Alex catalog](https://www.qobuz.com/au-en/album/regresar-al-amor-alex-bueno/s4tvf4x9cay6b) independently corroborates the repertoire. Original import artist identities also identify Alex. Sources and hashes: [fourteen-sources.json](corrections/fourteen-sources.json). Guarded changes: [fourteen-owner-plan.json](corrections/fourteen-owner-plan.json).

**Sandy MC:** Proyecto Uno's `featured_performer` credit was restored on *Te estoy queriendo (remix)*. The original 2006 Platano Records / Origin Entertainment back cover explicitly prints “Sandy feat Proyecto Uno” on track 21, duration 4:43, catalog 01-0065, barcode 7707025000659. The catalog's imported release barcode, 21-track sequence and remix duration match. The other printed durations differ slightly from digital track lengths; those recordings were not merged or retimed. [Original back cover scan](https://coverartarchive.org/release/2efe8dd1-609c-414d-b4f6-37dba3ed40b6/17307499740.jpg), [plan and source hash](corrections/sandy-credit-plan.json). Public credit readback passed.

## Credits saved with new draft identities

**Guarionex Castro:** restored as `featured_performer` on *Esto no lo venden*, distinct from either Guarionex Aquino identity. The [artist's label-distributed recording](https://audiomack.com/la-banda-gorda/song/esto-no-lo-venden) explicitly names him. A [direct artist interview](https://diariolalibertad.com/2022/02/24/si-no-viene-de-dios-digale-que-no-la-nueva-apuesta-musical-de-guarionex-castro/) confirms his Dominican identity and K-Libre/Rikarena career. New artist ID: `88abc9a2-b55a-4e1f-9694-65e772259f0a`.

**Indhira Martínez:** restored as `featured_performer`, preserving the literal label credit **Indhira**, on *Llévate la cama pa' la calle*. [Apple's specific recording credits](https://music.apple.com/us/song/157780362) confirm her vocals; [the label album on Spotify](https://open.spotify.com/album/2TEPW1Qerg6ZvRSSRbeukx) bills Don Miguelo, Frank Reyes and Indhira. The identity bridge uses her release *El Cañonazo*, her [direct testimony about Frank Reyes and Don Miguelo](https://www.diariolibre.com/amp/revista/musica/indhira-martinez-lanza-tema-navideno-el-canonazo-KH23424691), exact-song promotional history, and the [event announcement identifying her as Dominican](https://www.elcaribe.com.do/cultura-espectaculos/indhira-martinez-rendira-homenaje-a-edith-piaf-en-art-gabangi-2026/). The imported Rubiera attribution was not promoted to a canonical credit. New artist ID: `37e14ad6-20b0-464f-8db5-22137376e533`. Her Spotify profile also includes unrelated foreign repertoire; that mixed profile must not be imported wholesale. [Identity sources and capture types](corrections/indhira-credit-sources.json).

Both new identities remain **draft**, as required by GEMINI.md and CLAUDE.md. Their credits are stored with verified evidence; public visibility remains subject to the existing publication rules. An editor must review their profiles, add photos and publish them. They are not reported as fully completed public credits.

## Remaining research and limitations

**Danza kuduro (merengue electrónico remix), 4:12, recording `5b3c5a81-0456-43af-839c-122660ad5748`:** attribution remains unchanged. DJ databases list a Maffio remix, while fan uploads include a Worldwide remix around 4:08 and another merengue version with different performer billing. None securely identifies the exact 4:12 recording on the imported *El rey del merengue electrónico* package. An original package, artist/label release or master identifier is still needed before assigning Don Omar/Lucenzo/Pitbull/El Cata and Maffio's precise role. No credits were copied from the original song.

**Alex edition/title questions:** individual performer attribution was corrected, but original package/master reconciliation remains open. The ten-track edition's final song is called *Voy a llenarte toda* by Qobuz and *Pero lo dudo* by Spotify, both around 5:18; the solo catalog has a different *Pero lo dudo* around 3:09. The eleven-track imported edition lacks durations/ISRCs. The imported *Si ti no soy nada* and *Sin ti no hay nada* are not silently renamed from another edition. These limitations are preserved in the correction metadata and plan. No claim is made that all title, composer, lyricist or master metadata is now verified.

## URLs, application fix and verification

The ten erroneous Sergio song slugs were replaced with unique Alex slugs. No redirect entries were created. All ten new pages return 200 with Alex in the visible heading; all ten old pages return **404** at the same URL.

Retiring cached pages exposed a preexisting static-to-dynamic failure in the localized not-found component: server-side locale lookup read request headers only when a previously cached recording disappeared, causing 500. The component now reads the existing locale/message provider on the client boundary, retaining the localized 404 search form. TypeScript and targeted ESLint passed. Production deployment `dpl_DfTCvoog94QYYmDNzpP5kB4Bz21W` is READY and aliased to Mangulina. Chrome verified the Spanish 404 and its search box.

[Anonymous catalog verification](corrections/fourteen-owner-verification.json), [production URL and credit verification](corrections/fourteen-production-verification.json). Each data mutation passed a rollback rehearsal, replay guard and expected-state checks. Supabase security was not changed.

Disposition of this fourteen-case follow-up: **11 public attribution corrections completed; 2 credits stored awaiting draft-profile publication; 1 remix attribution unresolved**, with the Alex title/master caveats above kept open separately.
