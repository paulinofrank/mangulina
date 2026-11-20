# Frantoni Santana — approved correction and verification, 2026-11-02

## Scope and current state

- Artist: Frantoni Santana, `efe31bc6-9074-49b2-ae8e-2844242dd8e1`, slug `frantoni-santana`, **published**.
- Existing ES and EN biography documents: published, revision 1. Their opening and early-life sections incorrectly say he was born and raised in Santiago de los Caballeros.
- The editor approved the field and both published-biography changes. The execution results appear below. No music, relationship, security, or publication-status record was changed.

## Evidence and limits

1. The editor supplied a partial text attributed to Frantoni Santana's Facebook account. It says he was born in El Estrecho de Omar Bross, Luperón; spent his adolescence in Vuelta Larga, Imbert; worked in dairy production in Puerto Plata; moved to Santo Domingo in 1981; and served nine years as SGACEDOM president. The pasted text ends mid-sentence. The original Facebook post was not located through profile search, so those early-life statements remain **editor-supplied firsthand-attributed evidence**, not independently reproduced online. The children/partner information is omitted from public copy.
2. His [public Facebook profile](https://www.facebook.com/frantoni.santana/) identifies him as from Puerto Plata. The [Luperón municipality](https://ayuntamientoluperon.gob.do/historia/) confirms El Estrecho Omar Bross is a district of Luperón, Puerto Plata. These corroborate the geography, not the individual's birth there.
3. [SGACEDOM's official history](https://sgacedom.org/nosotros/) records his full personal name, Francisco Ramón Santana Cruz, and his 1998 position as treasurer. [WIPO's conference biography](https://www.wipo.int/edocs/mdocs/copyright/es/ompi_da_sdo_14/ompi_da_sdo_14_ref_u_4.pdf) calls him Frantoni Santana, says he was president for nine years **between 1999 and 2010**, Anti-Piracy Commissioner of ONDA in 2005–06, and author/composer of more than 250 recorded works. A [2009 election report](https://www.diariolibre.com/revista/santana-sigue-en-sgacedom-DBDL185886) independently documents another presidential term. The present biography's “nine years from 1999 until 2010” should not imply 11 continuous years.
4. Facebook posts on [10 October 2012](https://www.facebook.com/frantoni.santana/posts/10151168811923503) and [10 October 2013](https://www.facebook.com/frantoni.santana/posts/10151869143073503) wish him a happy birthday. He thanked the 2012 well-wisher that day. **10 October** is well supported as the birthday, but no birth year was established. The structured `date_of_birth` must remain null; generated `birth_day` and `birth_month` cannot be populated separately.

## Proposed change manifest

| Record/field | Before | Proposed | Basis |
| --- | --- | --- | --- |
| `artists.birth_place` | `Puerto Plata` | `El Estrecho Omar Bross, Luperón` | Editor-supplied autobiographical excerpt; district and province corroborated by the municipality. |
| `artists.province` | `Puerto Plata` | No change | Current value is consistent with the birthplace. |
| `artists.date_of_birth` | null | No change | Birthday known, year unknown. |
| ES and EN biography lead and early-life section | Says born/raised in Santiago | Replace with text below | Correct the contradiction and include relevant early-life account. |
| ES and EN SGACEDOM paragraph | Nine years “from 1999 until 2010” | Nine years **between** 1999 and 2010 | WIPO and 2009 election report. |
| All other artist fields, songs, relationships, status | Existing | No change | Out of scope. |

### Proposed Spanish lead

Frantoni Santana, nombre artístico de Francisco Ramón Santana Cruz, es un compositor y defensor de los derechos de autor dominicano. Nació en El Estrecho Omar Bross, municipio de Luperón, provincia Puerto Plata, y pasó parte de su adolescencia en Vuelta Larga, Imbert. Sus canciones han formado parte del repertorio de distintas orquestas de merengue; la Organización Mundial de la Propiedad Intelectual le atribuye más de 250 obras grabadas. También presidió la Sociedad General de Autores, Compositores y Editores Dominicanos de Música (SGACEDOM) durante nueve años entre 1999 y 2010.

### Proposed Spanish early-life paragraph

Antes de trasladarse a Santo Domingo en 1981, Santana trabajó en la producción de derivados lácteos en Sabaneta de Yásica y Luperón. No concluyó el bachillerato y amplió su formación mediante la lectura de literatura clásica y contemporánea. Su primer gran impacto como compositor de repertorio bailable llegó en 1984, cuando el cantante Koki Acosta debutó al frente de su propia orquesta con el merengue «Y te vi». El enlace existente a Koki Acosta se conservó en el documento estructurado.

### Proposed English lead

Frantoni Santana, the professional name of Francisco Ramón Santana Cruz, is a Dominican composer and copyright advocate. He was born in El Estrecho Omar Bross, in the municipality of Luperón, Puerto Plata province, and spent part of his adolescence in Vuelta Larga, Imbert. His songs have been recorded by merengue orchestras; the World Intellectual Property Organization credits him with more than 250 recorded works. He also served as president of the Dominican authors' society SGACEDOM for nine years between 1999 and 2010.

### Proposed English early-life paragraph

Before moving to Santo Domingo in 1981, Santana worked in dairy production in Sabaneta de Yásica and Luperón. He did not finish secondary school and continued his education by reading classical and contemporary literature. His first major breakthrough in the dance repertoire came in 1984, when bandleader Koki Acosta debuted his orchestra with «Y te vi». The existing Koki Acosta link was retained in the structured document.

## Execution and checks

- The editor authorized the published-profile correction. The English document `07b6f169-b3ee-49ee-a71c-b59da7fdc0e8` and Spanish document `7d923868-d973-4219-b982-1825db128b8f` were saved separately through `upsert_editorial_document`. Each went from revision 1 to revision 2; a final wording cleanup removed editorial-process language, producing revision 3 in each locale. Both remain `published`. The routine validated the JSON and reconstructed the 13 artist references in each locale. The original Koki Acosta reference remains in the early-career paragraph.
- `artists.birth_place` changed from `Puerto Plata` to `El Estrecho Omar Bross, Luperón`; `province` remains `Puerto Plata`, `date_of_birth` remains null, and artist status remains `published`.
- Both legacy Markdown compatibility mirrors were synchronized to the new published wording. Neither structured document nor mirror still mentions Santiago de los Caballeros.
- The [targeted revalidation command](../../../scripts/revalidate.ts) returned `artists: 1, songs: 0, releases: 0, allArtists: false` for `frantoni-santana` after the final wording save. The public [English](https://mangulina.do/artists/frantoni-santana) and [Spanish](https://mangulina.do/es/artists/frantoni-santana) pages were reloaded and visibly show the corrected birthplace, revised leads and first-career paragraphs, and working Koki Acosta links. Neither public biography contains the editorial-process phrase. Screenshots: [EN](frantoni-santana-public-en-2026-11-02.png), [ES](frantoni-santana-public-es-2026-11-02.png).
- The first admin tab contains an unsaved intermediate formatting error from the editing attempt. Automated reload and undo were rejected by the computer-use review because they would discard unsaved content. The published database records and public pages have the correct text; the stale tab must not be published over them. A fresh admin tab was used only for read-back; no unsaved data was copied from the first tab.
