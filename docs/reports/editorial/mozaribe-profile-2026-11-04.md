# Mozaribe — artist profile evidence and change manifest

Date: 2026-11-04. Scope: create one **draft** group profile and two **published** biography documents. No discography import, shared relationship row, existing biography edit, image upload, or artist publication is authorized by this request.

## Identity and evidence

| Finding | Evidence | Decision |
| --- | --- | --- |
| Dominican merengue group led by Frantoni Santana during the 1990s | [J&N Publishing announcement](https://minayapr.com/j-n-publishing-compra-catalogo-de-mas-de-140-obras-del-iconico-compositor-dominicano-frantoni-santana/), 2022; Frantoni interview, `E:\Entrevistas - Mangulina\Frantoni\20260628 - @10PREGUNTAS - FRANTONI SANTANA∩╝Ü ∩╝éHubo un plan para frenar a Mozaribe∩╝é.txt`, about 42–45 min | Confirmed. Group identity distinct from Santana's solo artist record `efe31bc6-9074-49b2-ae8e-2844242dd8e1`. |
| Merengue with live violins; Carlos Jáquez was music director and producer | [Space Coast Symphony Orchestra's Carlos Jáquez bio](https://spacecoastsymphony.org/our-family/our-violins/); Frantoni interview, about 43–45 min | Confirmed. Jáquez has no existing Mangulina artist record, so remains plain text. |
| «Apurando el Paso», eight tracks | [Spotify artist](https://open.spotify.com/artist/7cWjlCmnYKmPItUjgsVtNr) and [album](https://open.spotify.com/album/6pgsU3yDkBMnD2NVqSJtog), opened directly in Spotify; [Amazon Music album](https://music.amazon.in/albums/B0CQ3TT4TZ) | Confirmed identity and digital catalog. Spotify ID `7cWjlCmnYKmPItUjgsVtNr`. Songs include «El Indio de la Charca», «Piedrecitas de Oro», «Un Trago», «Mi Vasito de Cristal», «Apurando el Paso», «Rocío de Tus Labios», «Buscando Estrellas» and «Aiobe». |
| Album date | Spotify and Amazon show 1996. A [secondary transcription of US copyright records](https://www.copyrightencyclopedia.com/amor-contra-distancia-demente-donde-andara-%5Bet-al%5D-noche-de/) lists a Mozaribe sound recording with a 1992 creation date and a possibly misread title. | Use 1996 only as the digital catalog's date in the biography. Do not set formation year or original release year from these conflicting metadata. |
| Performances | Santana's first-person interview recalls «El Show del Mediodía», «Punto Final» on August 9 and Plaza España on August 25; year absent in interview excerpt. | Mention the two venues without a precise date. Do not claim to be the first group at Plaza España without corroboration. |
| Majority of compositions by Santana | 2022 J&N Publishing announcement; [Billboard report](https://radiox.cms.socastsrm.com/2022/02/07/jn-publishing-acquires-frantoni-santana-song-catalog/) | Confirmed for the group repertoire in aggregate, not assigned track by track. |

## Proposed new artist row

| Field | Before | After | Reason |
| --- | --- | --- | --- |
| `name`, `sort_name`, `slug` | no row | `Mozaribe`, `Mozaribe`, `mozaribe` | Catalog identity confirmed; exact duplicate lookup returned zero. |
| `type`, `primary_role` | no row | `group`, `orchestra` | Current admin selector values; historical ensemble. |
| `primary_genre`, `genres` | no row | `merengue`, empty array | J&N and recordings; no additional genre independently established. |
| `artist_tags` | no row | `secular` | Romantic and dance repertoire; the tag describes music, not Santana's religion. |
| `instruments` | no row | `violin` | Documented defining sound of the ensemble. |
| `spotify` | no row | `7cWjlCmnYKmPItUjgsVtNr` | Direct Spotify artist page and matching album/songs. |
| `disambiguation` | no row | `Dominican merengue ensemble with violins led by Frantoni Santana` | Distinguishes the historical group from similarly spelled performers. |
| `status` | no row | `draft` | Profile creation exception; artist remains unpublished. |
| `formation_year`, `birth_place`, `province`, `gender`, social handles, `ended` | no row | null | No reliable precise source; group has no personal gender. Origin is a city, not a country. |

## Proposed Spanish biography

Mozaribe fue una agrupación dominicana de merengue impulsada por el compositor Frantoni Santana durante la década de 1990. Su propuesta incorporó violines en vivo al formato bailable; el violinista Carlos Jáquez fue su director musical y productor.

**Merengue con cuerdas**

Santana concibió la agrupación como un encuentro entre el merengue popular y las cuerdas. En una entrevista de 2026 recordó que el formato en vivo incluía dos violines y se ampliaba con músicos invitados en algunas presentaciones. Según «J&N Publishing», el compositor escribió la mayor parte del repertorio de Mozaribe.

**Escenarios y grabaciones**

Santana recordó actuaciones de Mozaribe en «El Show del Mediodía» y en la Plaza España de Santo Domingo. El álbum «Apurando el Paso», fechado en 1996 en las plataformas musicales, reúne ocho temas, entre ellos «El Indio de la Charca», «Piedrecitas de Oro», «Un Trago» y «Rocío de Tus Labios». El título del disco también da nombre a una de sus canciones.

**Legado**

«Apurando el Paso» documenta la colaboración entre las composiciones de Santana y la dirección musical de Jáquez, y conserva la propuesta de un merengue de orquesta con violines que distinguió a Mozaribe.

## Proposed English biography

Mozaribe was a Dominican merengue ensemble developed by composer Frantoni Santana during the 1990s. The group brought live violins into dance music, with violinist Carlos Jáquez serving as its music director and producer.

**Merengue with strings**

Santana conceived the ensemble as a meeting of popular merengue and strings. In a 2026 interview, he recalled that the live lineup included two violins and expanded with guest musicians at some performances. According to «J&N Publishing», Santana wrote most of Mozaribe's repertoire.

**Performances and recordings**

Santana recalled appearances by Mozaribe on «El Show del Mediodía» and at Plaza España in Santo Domingo. The album «Apurando el Paso», dated 1996 in digital music catalogs, contains eight songs, including «El Indio de la Charca», «Piedrecitas de Oro», «Un Trago» and «Rocío de Tus Labios». Its title is also the name of one of the songs.

**Legacy**

«Apurando el Paso» preserves the collaboration between Santana's compositions and Jáquez's musical direction, and documents the orchestral merengue with violins that distinguished Mozaribe.

## Dependencies and unresolved work

- Frantoni Santana's published EN/ES biographies, IDs `07b6f169-b3ee-49ee-a71c-b59da7fdc0e8` and `7d923868-d973-4219-b982-1825db128b8f`, revision 4, contain literal «Mozaribe» mentions. Backward-reference audit identified these two documents. Editing them or adding a shared founder relationship requires scope expansion under AGENTS.md, so they remain unchanged.
- Carlos Jáquez has no artist row yet. No identity is invented for him.
- The Orquesta Sinfónica Nacional row is `needs_review`, so the published biography does not link to its unavailable public page. Santana's account is summarized as guest musicians instead.
- The original album issue date, original label, founding year and city, full membership, precise disbanding date, official social handles and usable licensed image remain unverified.
- No release or recordings currently exist in Mangulina under the album or key track titles. Discography creation requires the separate gate in `docs/discography.md`.
- Allegations in Santana's interviews about why the group stopped are one-sided and excluded.

## Post-write verification

- Created `artists.id = e3727fa9-0203-4011-b5f9-bf3476f67ad5`. The row is `draft` with the exact type, role, genre, tag, Spotify ID, violin and disambiguation listed above. `genres = []`; `occupations` is null. Formation year, origin, province, socials and image are empty.
- Spanish `editorial_documents.id = bad9cc87-6f9f-4ba1-842e-ca1aeb2529ed`; English `3f41f485-37ea-47c7-8985-09469734ae9b`. Both are `published`, schema v1, revision 2. Revision 2 removed a reference to the `needs_review` Orquesta Sinfónica Nacional record so the biography will not lead to its unavailable public page. The first draft was never on a public artist page.
- Both structured documents pass `validate_editorial_document_v1`. Their stored content matches the proposed biography paragraphs and both legacy Markdown mirrors match exactly. The references audit found two nodes and two matching relation rows, no missing/mismatched occurrences, no noncanonical display names, and no references to unpublished artists. The two valid references point to Frantoni Santana, one in each locale.
- The admin editor reloaded Mozaribe as a group with role `Orchestra`, primary genre `Merengue`, tag `Secular`, the confirmed Spotify ID, and status `Draft`. The English and Spanish editors each showed the published biography; both were visually reviewed. The group instrument selector is not shown in that editor tab, so `violin` was verified from the stored row rather than a visible checkbox.
- An admin facts save refreshed the artist cache once. After the final direct biography edit, a targeted `POST /api/revalidate` returned `ok: true`, `artists: 1`, `songs: 0`, `releases: 0`, `allArtists: false`. No public draft URL was opened.
- Frantoni's two published biographies remain at revision 4 with their plain «Mozaribe» mentions. No existing artist profile or shared relation was changed.
