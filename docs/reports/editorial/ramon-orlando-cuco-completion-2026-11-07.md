# Ramón Orlando and Cuco Valoy — approved biography update completed

Completed 2026-11-07 under the editor's explicit approval for Ramón's public biographies, origin and second surname, and Cuco's one bilingual paragraph. No birth-year change, discography import, shared relation change or other artist edit was authorized or made.

## Records changed

| Record | Before | After |
| --- | --- | --- |
| Ramón Orlando artist `02f23257-1cf6-4a4c-8df1-1f9aa630a2c3` | `birth_place=Manoguayabo`, `province=Santo Domingo`, `second_last_name=null`, `published` | `birth_place=Santo Domingo`, `province=Distrito Nacional`, `second_last_name=García`, `published` |
| Ramón ES biography `560a9787-972f-476f-9543-785c6c5f4d06` | published revision 5 | published revision 6, revised 13-block biography, 17 artist references |
| Ramón EN biography `ae4945d7-8056-4879-8eb1-4cfd84f2717e` | published revision 6 | published revision 7, revised 13-block biography, 17 artist references |
| Cuco ES biography `3f978fc5-e7ec-4ecd-9e99-d168b7edec17` | published revision 5 | published revision 6, one paragraph replaced, 15 blocks and 10 artist references preserved |
| Cuco EN biography `a741e62b-e30d-4e43-8110-04690e816bd1` | published revision 6 | published revision 7, one paragraph replaced, 15 blocks and 10 artist references preserved |
| Ramón `bio_es`, `bio_en` and Cuco `bio_es`, `bio_en` | previous compatibility text | mirrored approved text |

Ramón's structured `date_of_birth=1960-07-29` and `birth_year=1960` were **not changed**. The biography omits the disputed year while retaining 29 July; the 1959/1960 conflict is documented in [the research report](ramon-orlando-interviews-review-2026-11-06.md) for editorial resolution.

## Evidence and editorial decisions

The 38 supplied interview transcripts were indexed, and relevant sections were checked in context. Ramón directly rejects Manoguayabo as his birthplace in the Albert Mena interview, placing his birth in the capital and childhood in Villa Francisca. His 2020 Altanto interview and 2025 conversation with Roberto Ángel Salcedo establish his initial musical-director role in the Orquesta Internacional and its subsequent association with his name. His 2020 Silvio Mora interview and contemporary reporting distinguish his late-1980s conversion from the church he began in 2007. A specialist *Revista Global* account supports his work with Cuco and La Tribu. Primary release metadata supports the García surname and 1993 «Te compro tu novia».

Peter Cruz's already attributed account of the Orquesta Internacional's formation remains unchanged; the two first-person recollections differ. Cuco's new paragraph credits him with initiating and directing Los Virtuosos while explicitly recognizing Ramón's part in preparing the ensemble and its arrangements.

## Verification and production use

- The initial generated SQL failed its transaction check twice and rolled back; readback confirmed that no partial write persisted. A rollback diagnostic showed all intended post-write conditions true, and the check was corrected to avoid an eager constant division-by-zero evaluation.
- The successful transaction saved all four structured biographies through the existing `upsert_editorial_document` function, which validated their format and synchronized `editorial_entity_references`. Post-write readback verified artist fields, published document statuses, revision increments and exact equality between stored reference rows and embedded references (17/17 for Ramón and 10/10 for Cuco).
- One authorized targeted `POST /api/revalidate` returned HTTP 200 with `artists=2`, `songs=0`, `releases=0`, `allArtists=false`.
- Three bounded public spot checks returned HTTP 200 and `x-vercel-cache: REVALIDATED`: Ramón ES and EN showed the García surname and Distrito Nacional, and Cuco ES showed the revised Los Virtuosos paragraph.
- No deployment, broad catalog crawl, schema/security change, media edit, or song/release credit write was performed.

## Task files

- [Research and change manifest](ramon-orlando-interviews-review-2026-11-06.md)
- [Approved biography prose](ramon-orlando-biographies-proposed-2026-11-06.md)
- [Save generator](ramon-orlando-build-approved-save-2026-11-06.mjs)
- [Executed SQL manifest](ramon-orlando-cuco-approved-save-2026-11-06.sql)
- [Document summary](ramon-orlando-approved-document-summary-2026-11-06.json)
- [Interview index helper](ramon-orlando-interview-index-2026-11-06.py)
- [Transcript extract helper](ramon-orlando-transcript-extract-2026-11-06.py)
- [Bounded live check](ramon-orlando-cuco-live-check-2026-11-07.mjs)
