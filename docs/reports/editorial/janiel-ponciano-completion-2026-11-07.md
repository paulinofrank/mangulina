# Janiel Ponciano — profile completion (7 November 2026)

## Scope and records

- Created artist `7f7cefd2-05e8-4581-89d6-04091c2ff114`, slug `janiel-ponciano`, status `draft`.
- Published biography documents only, not the artist: English `f8ca1596-5ae2-4355-b469-099887272d85` and Spanish `d98513e8-5bb5-4eed-8825-befeb5acff3b`, both revision 1 and status `published`.
- No discography import, portrait, artist relationship, family relationship, public profile publication or changes to another artist were made.

## Research findings and field decisions

The two supplied sheets were treated as leads. Independent checks found the full personal name **Janiel Fernando Ponciano Lebrón** in an [ONAPI registry](https://www.onapi.gov.do/transparencia/index.php/institucional/publicaciones/3515-historico-de-publicaciones-de-registro/3517-historico-de-publicaciones-de-registro-2000-2019/407-2015-2019-pu/953-2019-pu?download=6110%3Apublicacion-15-de-marzo-2019) and as the reversed writer name in a [SAYCO work list](https://www.sayco.org/_files/ugd/733ded_d5db21634f7f41cbb913be11dd707a63.pdf). The personal-name fields preserve all four parts; `stage_name` holds the professional form and the full name is a search alias. His father's public Facebook birthday posts on [30 August 2015](https://www.facebook.com/photo/?fbid=740417362726652) and [30 August 2022](https://www.facebook.com/photo/?fbid=618552699679253), plus a 2014 post, establish the day and month and the father-son relationship. None establishes the birth year. `date_of_birth` remains null because the database requires a complete date; birthplace and province remain null because neither was directly established.

The [band-supplied biography](https://www.multitracks.com.br/artists/barak/biography/) and [Diario Libre interview](https://www.diariolibre.com/amp/videos/revista/musica/2025/03/11/barak-los-hijos-de-pastores-que-llenan-estadios-con-mensaje-de-fe/3028498) support bass, vocals and songwriting in Barak. The [2026 Bondadoso Dios report](https://radionotas.com/2026/10/07/barak-habla-en-su-nuevo-album-de-un-bondadoso-dios/) also credits production. Therefore `primary_role=musician`, `occupations=[bassist,singer,songwriter,producer]`, `instruments=[bass,voice]`, `primary_genre=worship`, `genres=[]`, `artist_tags=[christian]`, and `gender=male` (his father explicitly calls him a son and man). Facebook `janiel.poncianolebron` and Instagram `janielponciano` are handles. No personal Spotify ID or reusable portrait was verified.

The [Latin Grammy artist record](https://www.latingrammy.com/en/artists/barak-33057/) and [2023 nominations list](https://www.grammy.com/news/2023-latin-grammys-complete-winners-nominees-nominations-list/) support the two group nominations; [Diario Libre's concert report](https://www.diariolibre.com/revista/musica/2025/04/12/barak-se-presenta-tras-tragedia-en-discoteca-jet-set/3071674) confirms the 2025 Quisqueya performance. The [Grupo Hope video](https://www.youtube.com/watch?v=Lt7fd0yqOG0) gives four writers of «Kadosh». [Shazam's track credits](https://www.shazam.com/song/1853885115/uso-honorable) give seven writers and a 10 April 2026 release for «Uso Honorable», correcting the supplied three-writer/2025 account. [Secuencias](https://www.secuencias.com/songs/KABED/Favor-And-Gracia/Llena-Este-Lugar/overview/) lists Janiel and Ezequiel for «Llena Este Lugar», whereas the official video description supplied in the research sheet lists Janiel alone. The biographies say only that Janiel is among its credited writers. No work or release records were imported.

## Verification

- Ran the version 1 document validator on both generated documents before saving.
- Queried persisted artist fields after saving: status `draft`; personal names, roles, handles and tag present; no duplicate primary role in occupations or primary genre in genres.
- Queried both documents: status `published`, revision 1, nine blocks each.
- Each document has 12 artist-reference nodes and 12 synchronized relationship rows; all targets exist and are published.
- The legacy biography mirrors contain 2,129 English and 2,338 Spanish characters.

## Backward-reference audit and pending scope

Search of all other structured biographies and legacy mirrors found only two existing plain-text mentions of Janiel: **Grupo Hope** English document `13c392e7-97ba-47f1-b170-146af33b0a0c` and Spanish document `2e2cf32e-5329-4421-a6e5-4456ce2dd642`, both revision 3. Each says “Janiel Ponciano” among the writers of «Kadosh». They remain unlinked because Grupo Hope is now a published artist and revising those documents is a shared/public biography change outside this profile-creation scope. A structured `member_of` relationship from Janiel to Barak and any family links are likewise pending expanded authorization. No public URL for the draft artist was opened.
