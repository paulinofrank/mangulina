Latest update (2026-10-03): [editor clarifications](EDITOR-CLARIFICATIONS.md) closes the Maffio attribution case with four editor-confirmed vocal credits and corrects both Alex Bueno titles to Sin ti no soy nada. Two new Dominican draft profiles still await editorial publication. Earlier counts below are historical.

# Production deployment and 86-case attribution review

Latest: [fourteen-case follow-up](FOURTEEN-FOLLOWUP.md) applied and publicly verified ten Alex Bueno performer corrections and Proyecto Uno’s remix credit. Indhira Martínez and Guarionex Castro credits are stored against new draft identities awaiting editorial publication. One exact Maffio remix attribution remains unresolved. Alex edition/title/master questions remain documented separately. Earlier counts below are historical.

Latest update: [Aramis / Tony compilation correction](ARAMIS-COMPILATION.md) resolves all six disputed Aramis recordings and six additional El Zafiro owner errors. The original 86-case cohort now has **72 settled and 14 unresolved or partly resolved**. Earlier counts below are historical.

Latest attribution update: [Chrome and social-source follow-up](CHROME-FOLLOWUP.md) verified and applied El Prodigio's accordion credit on Amores. The 86-case cohort now has **66 settled and 20 unresolved or partly resolved**. Counts below describe the earlier pass.

Latest authorship follow-up: [the 213-claim review](AUTHORSHIP-213.md) verified 31 additional claims, superseded 13 wrong claims, and added 26 author roles across eight Works. The 12 recording-owner corrections below remain available for the user's later review.

Updated October 2, 2026, approximately 9 p.m. America/New_York.

The pending application fixes are deployed to [Mangulina](https://mangulina.do). Vercel deployment `dpl_4kjePwdcD8KrERQWJpvGEMBYgRwt` completed its production build and TypeScript checks and was aliased to the production domain. English and Spanish home pages, both affected artist pages, and the actual De Moca a París recording URL returned HTTP 200. [Deployment verification](corrections/deployment-verification.json).

An initial upload exceeded Vercel's file-count limit. The archive retry included 1.8 GB of local material and was cancelled. `.vercelignore` now excludes local audit data, credentials, backups and tooling; the successful application upload was approximately 994 KB. No Git push was needed for the direct Vercel deployment. The unrelated local Claude settings file was left untouched.

## Review outcome

All 86 original candidates have an explicit disposition in [86-case-review.json](corrections/86-case-review.json): **65 settled, 21 still unresolved or only partly resolved**. Settled includes 20 valid band/project attributions, 33 restored collaboration-credit cases, and 12 corrected recording owners. This does not certify every historical fact or every vocal role on those records.

The follow-up applied **12 recording-owner corrections, 57 performer-credit additions, five shared primary release credits, and one correction from primary to featured release billing**. Sources are preserved with URLs and retrieval hashes in [remaining-official-sources.json](corrections/remaining-official-sources.json), exact guarded plans, and local before/after transaction receipts.

| Package or recording | Result |
|---|---|
| Dos generaciones | Retain Alina/Alinna Vargas participation; restore Wilfrido Vargas shared package credit and both label-billed performers on all 13 tracks. MainArtist credit is mapped to general performer, without claiming a particular vocal part. |
| Los 30 de Kinito | Retain Kinito ownership; add the explicitly featured Rokabanda on five flagged recordings. |
| De Moca a París; Frío, frío live | Restore Johnny Ventura and Romeo Santos, respectively, as featured performers. Preserve the studio/live distinction. |
| Así bonito | Restore Frank Ceara as co-performer using his official artist-channel release. |
| A escondidas, 4x4 en salsa | Correct Alex Bueno ownership to Sexappeal. Match original position 8, duration 4:34 and the label's full alternative title A Escondidas Te Vere Aka a Escondidas. |
| La quiero a morir, Alex Bueno bachata compilation | Retain Alex Bueno and add the explicit Sergio Vargas featured credit on both catalog recording variants. Do not merge their IDs. |
| Estoy Atrapado (Grunjeo) | Retain the band; restore Korven Brox as co-performer and shared release artist. |
| Como tú no hay nadie | Retain Zawezo and add Shadow Blow; Zawezo's official upload confirms the collaboration. |
| Llévate la cama pa' la calle | Retain Don Miguelo and restore Frank Reyes. Indhira's credit is documented but her canonical identity remains unresolved. |
| El Pichirri | Correct owner to Yomel el Meloso, restore the three featured artists, and change Ito's release billing to featured with literal credited name Ito Gamy. |
| Brindo con agua | Retain its placement in Henry Santos's solo package and restore Aventura's recording participation. |
| Frente a frente, original and 2023 remaster | Reassign positions 1, 3, 5, 7, 9 in each edition to Antony Santos and restore both shared release credits. Literal Platano credits are corroborated by Virgin Music uploads and Apple distribution. Qobuz's incorrect artist display mapping to Romeo Santos is not accepted. No versions were merged. |
| En el salón de la fama | Retain La Banda Gorda project; restore Wason Brazobán and Silvio Mora. Guarionex Castro's distinct identity remains unresolved. |
| Nueva vida | Miriam Cruz's official site explicitly identifies this as her Miriam Cruz y las Chicas project. Preserve valid attribution. Qobuz's 1981 date conflicts with her official 1993 account and is not used as dating evidence. |
| Monchy & Alexandra | Preserve the duo attribution supported by original packaging and official distribution. An individual lead voice within the duo does not establish an unrelated solo release. |
| Me decidí | The eight flagged Joan Soriano collaborations were already supported and corrected in the earlier pass using iASO's original label credits. |

## Remaining 21 cases

The full list, reasons and supporting/conflicting sources are in [unresolved-after-review.json](corrections/unresolved-after-review.json).

- Six Tony Seval/Aramis Camilo compilation tracks: no original packaging or official track-level evidence for this exact 14-track edition. Community listings are research leads only.
- Ten Sergio Vargas/Alex Bueno shared-album recordings: conflicting official editions and versions require reconciliation. Do not transfer ownership based solely on another edition's display name or similar title.
- Amores: Guerra ownership is supported; El Prodigio's exact accordion/guest contribution still needs original track-specific evidence. A featured-singer role is not inferred.
- Maffio's Danza kuduro remix: exact performer/remixer roles need evidence for this remix rather than the original recording.
- Sandy MC's Te estoy queriendo remix: the available official package has 20 tracks; this catalog placement is track 21. Exact edition remains unidentified.
- Indhira and Guarionex Castro: explicit source credits exist, but canonical identity matches are not established. Neither was linked to an unrelated similarly named person.

The raw import-mismatch report still contains 74 rows because it compares imported names without understanding bands or collaborations. **74 raw mismatches is not 74 unresolved errors.** The editorial unresolved queue is 21.

## Verification

All follow-up mutation batches passed rollback rehearsal before application. Guards rejected unsupported role and missing-title inputs before any commit; corrected rehearsals then passed. Expected-before checks, replay refusal, source records, typed credit evidence and executed decisions preserve the audit trail.

[Final database verification](corrections/applied-verification.json) passed **52 checks**: all 115 owner corrections across both passes, all 163 new performer-credit rows, all 57 recent additions visible through anonymous public readers, corrected primary/featured El Pichirri release billing, existing composition-credit checks, and zero structural/semantic integrity failures. The public view security fingerprint remains unchanged. No Supabase security was altered.

Public caches were refreshed successfully for 37 artists, 654 songs and 35 releases. [Cache refresh](corrections/page-refresh.json).

The earlier 213 unverified generated authorship claims remain unverified. The broader catalog audit and those claims are outside the completed 86-case review and still require further evidence.
