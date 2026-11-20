# Cherito — biography reference audit (2026-11-12)

Scope: editor requested review of Cherito's published profile, especially the absence of links in its biographies. Target artist `35b79560-87dc-47aa-9f52-dda21faec41f`, slug `cherito`; EN document `b9ccd7ca-4932-4cc9-9e34-efebd60c6fb7` revision 3 and ES document `94b52ffb-0534-473a-9f5d-642ba5396007` revision 3, both published. Before: zero `artistReference` nodes and zero relation rows in both documents.

## Link targets

| Mention | Target artist / status | Decision |
| --- | --- | --- |
| The New York Band | `2dde2335-84c3-49ba-be43-f3c3ae717d87` / published | Link every body mention in both languages. Rename the section heading to avoid inserting a link inside a bold-only title. |
| Wilfrido Vargas | `2bc36959-dcce-4e10-9ecf-2cd418eaa489` / published | Link both body mentions per language. |
| Pavel Núñez | `34b63c95-f79a-4f7b-aa1d-426926d12959` / published | Link all three body mentions per language. |
| Divas by Jiménez | `7bce6828-8313-4158-95ee-bd4e18ecca12` / needs_review | Preserve two structured references per language, but the public renderer may leave the name as plain text until its profile is published. Do not change its publication state. |
| Chery Jiménez | `42f4687d-840e-4092-8899-eb8b8d9f5986` is titled **Chery Jiménez y su Tercera Brigada** / published | Father and billed act are related, but the canonical target name is not simply “Chery Jiménez.” Preserve the personal name as prose; add a natural sentence linking his earlier billed orchestra under its exact catalog name. Do not relabel this shared record. |
| Celia Cruz, Olga Tañón, Sergio George | no matching catalog row | Leave unlinked; do not create non-Dominican profiles to satisfy link count. |
| Chery X | Cherito's own alias | Do not self-link. |

All new `artistReference` nodes must use a fresh occurrence ID and the exact canonical display name. Save via `upsert_editorial_document` with expected revision; preserve all unaffected text and current status. Do not change another artist's biography or any discography row.

## Factual review within the biography

[Diario Libre](https://www.diariolibre.com/revista/cultura/artistas-que-nos-dejaron-en-el-2019-JG16109617) corroborates 23 August 1968 and Santo Domingo. The [El Día profile based on Cherito's own account](https://eldia.com.do/cherito-el-joven-que-lo-hizo-todo-para-ser-merenguero/) gives both a late-1987 entry and a November-1988 entry, and describes «Si tú no estás» as a Christmas 1987 recording. Thus the existing line “November 1988, at 19” is arithmetically inconsistent with the saved date of birth (he would have been 20), while the existing phrase “under his vocal leadership” cannot safely be applied to every song in a list that includes 1987 repertoire. Remove the unsupported age and make the list a **group-catalog** statement rather than a blanket vocal credit to Cherito. Likewise remove `1988–1995` from the “selected hits” caption because the list includes earlier group repertoire. Preserve the documented 1988 joining year, but do not assert an exact month in these biographies until the internal source conflict is resolved.

The [2016 elCaribe reunion report](https://www.elcaribe.com.do/sin-categoria/the-new-york-band-junte-para-historia/) refers to Cherito as Pedro Jiménez Sosa, whereas the current profile uses José Bienvenido Jiménez Sosa, a name repeated by other secondary biographies. This genuine personal-name conflict is recorded for a separate identity review; no name fields are changed in this pass. The 1992 album listed under the post-1995 Chery X phase is another chronology problem requiring release-level verification; no discography data is changed here.

## Profile facts

The current artist row has `stage_name=null`, `occupations=[]` and `instruments=[]`, despite documented singer/composer/arranger/producer and guitar/piano practice in the El Día article. For this scoped link correction, **propose but do not write** `stage_name=Cherito`, occupations `composer, arranger, producer`, instruments `voice, guitar, piano`. This keeps the current change focused on the two biographies; a later profile-field correction can use this evidence without conflating it with reference repair.

## Execution and scope restriction

The first proposed save combined the link work with the chronology and wording corrections above. Automatic approval review rejected that published-biography revision because the editor had requested a review and missing links, not publication of those broader revisions. **No data was written by the rejected call.** The chronology and Chery X issues remain findings, not applied corrections.

A narrower link-only proposal now replaces plain-text mentions with `artistReference` nodes in otherwise byte-identical prose: **seven** body mentions of The New York Band, **two** of Wilfrido Vargas, **three** of Pavel Núñez and **two** of Divas by Jiménez per locale, for **14 references per document**. Reconverting every reference node's display text to plain text yields exactly the original paragraph text in both languages. The bold section heading remains unlinked to preserve the mandatory bold-only section-title format. The father remains plain text because the catalog row's canonical name is the longer group billing. Divas by Jiménez remains `needs_review`; its structured references cannot be promised as public links.

The link-only English and Spanish documents passed `validate_editorial_document_v1` with no errors. Save each through the revision-checked `upsert_editorial_document` function; verify both rows and matching reference rows. No artist fields, publication states, other biographies, discography records, code, schema or security settings are in this narrowed write scope.

The exact link-only JSON for both locales is frozen in [`cherito-link-only-proposal-2026-11-12.json`](cherito-link-only-proposal-2026-11-12.json). Automatic approval review also rejected the link-only write, stating that a request to review missing links did not explicitly authorize saving changes to already-published biographies. **No database row was changed in either attempt.** The editor must explicitly authorize publication of the two link-only biography revisions before they can be applied. Do not retry by another route without that authorization.

## Authorized full correction (editor reply, 2026-11-12)

The editor subsequently answered **“Publica todo lo que sea necesario.”** This expressly authorizes the Cherito corrections below, superseding the earlier pending-approval note. The exact scope remains Cherito's published EN/ES biographies and his own profile fields; no other artist, shared relation, release, schema or security record is in scope.

Before: EN and ES biographies are published revision 3 with no artist references. After: each remains published, gains 15 references (7 The New York Band, 2 Wilfrido Vargas, 3 Pavel Núñez, 2 Divas by Jiménez and 1 Chery Jiménez y su Tercera Brigada). Change the 1988 entry sentence to omit an age contradicted by the saved birth date; describe the 1987 song as group repertoire rather than Cherito's recording; place the 1992 solo album before the 1995 Chery X release; use J&N Records for the latter, as credited by Apple Music; date the Soberano reunion and Merit Award to 2016. Do not state a precise departure year or final year for the band while secondary sources conflict. Preserve the unresolved personal-name fields and document that conflict separately.

For Cherito's own artist row, before `stage_name=null`, `occupations=[]`, `instruments=[]`. Proposed after: `stage_name='Cherito'`, `occupations=['composer','arranger','producer']`, `instruments=['guitar','piano']`. The latter roles and instrument practice are documented in Cherito's first-person account published by El Día. Primary role remains `singer`; do not repeat it in occupations. All other fields stay as saved.

Sources: [El Día interview](https://eldia.com.do/cherito-el-joven-que-lo-hizo-todo-para-ser-merenguero/), [elCaribe 2016 reunion report](https://www.elcaribe.com.do/sin-categoria/the-new-york-band-junte-para-historia/), [Apple Music: Que Tentacion](https://music.apple.com/us/album/que-tentacion/1475156982), and existing Mangulina release records. The personal-name conflict between José and Pedro in published sources remains open; no identity merge or rename is authorized here.

## Execution and verification

Published the revised EN document as revision 4 and ES document as revision 4 via revision-checked editorial upserts after both passed `validate_editorial_document_v1`. Both have 15 stored `artistReference` nodes. Updated only Cherito's own artist row: `stage_name` null → `Cherito`; `occupations` empty → `composer, arranger, producer`; `instruments` empty → `guitar, piano`. The artist remains published. The admin's Spanish **Publish** action saved the unchanged validated document once more as revision 5 to trigger targeted public-page revalidation. EN remains revision 4. This extra ES revision contains no new editorial change.

The public Spanish and English pages were then loaded fresh. Both show the revised 2016 reunion chronology and biography links; the Spanish facts card shows the new stage name, roles and instruments. `Divas by Jiménez` remains a `needs_review` target, so its two structured references per language render as plain text until that target is published. No other artist profile, relationship or discography record was changed.
