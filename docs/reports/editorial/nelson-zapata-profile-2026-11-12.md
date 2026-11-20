# Nelson Zapata — profile and reference manifest (2026-11-12)

Scope authorized by editor: create Nelson Zapata's artist profile, upload the supplied portrait, publish the artist and both biographies, and link every verified Nelson Zapata mention in existing artist biographies. No discography import, relationship record, schema/code/security change, or deployment.

## Identity and field evidence

| Field | Before | Intended value | Evidence / limit |
| --- | --- | --- | --- |
| Name / slug | no matching artist row | Nelson Zapata / `nelson-zapata` | [His first-person VICE account](https://www.vice.com/es/article/la-historia-de-proyecto-uno-contada-por-uno-de-sus-fundadores-nelson-zapata/), verified social accounts. No middle or second surname established. |
| Personal name | absent | first Nelson; last Zapata | Same first-person account. |
| Kind / role | absent | `solo_artist` / `singer` | He describes becoming lead singer; Proyecto Uno is a separate existing artist. |
| Occupations | absent | `composer`, `producer`, `bandleader` | First-person account and his Facebook account identify writing, production and musical leadership. No duplicate of primary role. |
| Main / additional genre | absent | `merengue-house` / none | His account describes the merengue/house/hip-hop fusion and the existing Proyecto Uno classification. |
| Classification / gender / instruments | absent | `secular` / `male` / `voice`, `güira` if form-compatible | Secular group repertoire, Facebook personal information, first-person account of singing and school güira. Personal religious wording does not change repertoire classification. |
| Birth city / province | absent | Santo Domingo / Distrito Nacional | He says explicitly in [VICE](https://www.vice.com/es/article/la-historia-de-proyecto-uno-contada-por-uno-de-sus-fundadores-nelson-zapata/) and [Infobae](https://www.infobae.com/teleshow/infoshow/2020/08/01/de-trabajar-sin-saberlo-para-el-desarrollo-del-viagra-a-crear-el-hit-el-tiburon-la-sorprendente-historia-del-lider-de-proyecto-uno/) that he was born in Santo Domingo. |
| Birth date / year | absent | empty | His father [wrote on 1 May 2015 that it was Nelson's birthday](https://www.facebook.com/rafael.zapata.18/posts/pfbid03kszEav2KmNwWTFaxrxHXCdtjn5vtgVTAMdB1ryV9HqsCeNr9f5eLLG2trDeiNynl). A 30 April 2017 greeting may have been early. The day/month can be stated in the biography, but no sufficiently consistent birth year is established. Infobae's account of moving at age 15 in 1980 conflicts with a later story placing him at five in 1974. |
| Facebook | absent | `NELSONZAPATA` | Exact supplied URL opened to personal account describing Proyecto Uno founder and producer. |
| Instagram | absent | `nelzapata` | Exact supplied URL opened to verified personal account identifying Proyecto Uno founder, composer and producer. |
| Spotify / YouTube / website | absent | empty | No verified personal artist page/handle; group identifiers must not be assigned to Nelson. |
| Portrait | absent | supplied file | `C:\Users\fvpg\OneDrive\Downloads\nelson-zapata-watercolor-600x600.jpg`, inspected; editor expressly supplied it for this profile. |

## Biography basis

The [first-person history in VICE](https://www.vice.com/es/article/la-historia-de-proyecto-uno-contada-por-uno-de-sus-fundadores-nelson-zapata/) gives the 1980 move to New York, Seward Park High School talent show, güira-to-voice transition, three earlier merengue orchestras, founding with Rick Echavarría around 1989, Pavel de Jesús's sequencing work, the adaptation «Todo el mundo (Everybody)», and «Brinca». The [2020 Infobae interview](https://www.infobae.com/teleshow/infoshow/2020/08/01/de-trabajar-sin-saberlo-para-el-desarrollo-del-viagra-a-crear-el-hit-el-tiburon-la-sorprendente-historia-del-lider-de-proyecto-uno/) corroborates his birthplace, formative musical path and the growth of «Está pegao» and «El tiburón». A [UNPHU production thesis](https://repositorio.unphu.edu.do/bitstream/handle/123456789/5885/Equipos%2C%20t%C3%A9cnicas%20y%20procesos%20de%20produccion%20del%20merengue%20de%20los%2090%E2%80%99s.pdf?isAllowed=y&sequence=1) and existing Sandy/Papo biographies document the duo's genesis after a Proyecto Uno audition. A [2026 interview](https://mundour.com/2026/04/24/proyecto-uno-regresa-a-caracas-con-presentacion-especial-en-bajo-el-arbol/) confirms current group activity. Do not assign the group catalog or awards to Nelson as a solo act. The attached draft's 1979 founding caption, fixed «In Da House» year and 2026 chart claim are omitted for lack of clear consistent support.

## Backward references

Search of structured `editorial_documents.document` for the exact string `Nelson Zapata` found eight genuine, currently published documents, one occurrence each. Convert only that span to a canonical `artistReference`, preserving all other wording and nodes, saving each document with expected revision:

| Owner | EN document / before revision | ES document / before revision |
| --- | --- | --- |
| Proyecto Uno `f838ab51-002f-4737-ab38-17f65beec9ab` | `e28a9a97-7343-45e4-a687-8b05f1a925cb` / 2 | `c36856b0-00cc-4a9c-98dd-b2792c8048b9` / 1 |
| Sandy MC `ae72a84f-28eb-44d2-8553-b840a4a1c1fe` | `ffbf35b0-e366-495d-bd07-470c700484aa` / 2 | `a63614f4-40f4-4ad5-9c9d-bae736333417` / 1 |
| Papo MC `d719b174-87c1-4f59-98aa-970dc7203093` | `e71f967a-48a9-4247-bc95-18a906e2babf` / 1 | `9ee32e6a-33b8-4804-ba4b-4a445f565286` / 1 |
| Sandy & Papo MC `b0d54c43-f4f2-446e-98eb-8cd19032abb6` | `39feaa74-0ec1-4f59-b906-d8f1fb69353b` / 3 | `7771c04c-9bc4-45c8-97c1-efcee9a2c298` / 3 |

The editor expressly requested updates to **all mentions in all biographies**, so this is the authorized shared biography scope. No structured membership or founder relationship is included. Search for first-name-only references must discriminate namesakes; do not blindly link every `Nelson`.

## Execution and verification

- Created artist `8320823b-6719-45c3-a414-cf43619c7b21` as `draft`, with the field values above. The editor displayed the saved fields, including the `merengue-house` genre, gender, province, roles, social handles and empty Spotify ID. Its `date_of_birth` and `birth_year` remain null.
- Published validated structured biography documents EN `d5cb5096-8d90-4e34-bb8b-85aa78b73e6e` and ES `c34d2d39-6bcc-4d8b-9e31-1891cef023c1`, both revision 1. Their opening paragraphs and section titles render correctly in the public pages.
- The editor-supplied `.jpg` file actually contains WebP bytes. An identical-byte temporary `.webp` copy was uploaded through the admin editor; the editor confirmed the image under `8320823b-6719-45c3-a414-cf43619c7b21.webp`. The temporary workspace copy was removed after upload.
- Saved the eight incoming biographies listed above with expected revisions, preserving all non-Nelson text and existing references. A subsequent surname audit identified one further unlinked, unambiguous Nelson mention in each Proyecto Uno biography. Those two documents were saved a second time with the canonical display text `Nelson Zapata` and new occurrence IDs. The final Proyecto Uno revisions are EN 4 and ES 3; Sandy MC EN 3 / ES 2, Papo MC EN 2 / ES 2, Sandy & Papo MC EN 4 / ES 4. All remain `published`.
- Admin status update published the artist, confirmed by the “Artist profile updated” UI message and database readback: `artists.status=published`, `has_image=true`; both biography documents `published` with validation result empty; 10 incoming `artistReference` nodes in eight documents match 10 `editorial_entity_references` rows, all with the canonical name. A global surname search ruled out unrelated Zapatas in other biographies.
- Scoped public checks showed `/es/artists/nelson-zapata` and `/artists/nelson-zapata` serving the correct locale, portrait, fields and biographical links. Proyecto Uno's Spanish page showed the first Nelson link after the artist publication. The second surname link, added afterward, was **still stale on the public Proyecto Uno page** at the last check, though the database document and reference rows are correct. The admin profile editor declined an unchanged save (“No changes to save”), so it did not refresh the page. An attempt to use the biography Publish control for the targeted refresh was stopped *before execution* by automatic approval review because the account hit its usage limit, with a suggested retry time of 15 Nov 2026, 07:02. Do not claim this final public refresh complete. It remains the only blocked action.
- No discography, relationship record, schema, security, application code, deployment or broad cache invalidation was changed. Final database review ended 2026-11-12 21:51 UTC. Production phase: one artist insert, two biography inserts, eight incoming document saves plus two surname corrections, one image upload, one status update, one unchanged admin save attempt (no write), one blocked Publish attempt (not executed), three representative public-page navigations plus one targeted check of the stale page; no revision conflicts or retries.
