# Missing Artists Backlog — Named in Bios, Absent from `artists`

## Issue

`EDITORIAL_BIOGRAPHY_FORMAT.md` requires that every Dominican artist named in a
biography be an `artistReference` node paired with an `editorial_entity_references`
row. That rule can only be satisfied if the artist exists in `artists`.

When a named artist is **not** in the catalogue, the writer has two options, both
lossy:

1. Leave the name as plain text (the mention is unlinked and invisible to the
   graph), or
2. Wrap it in « » as a non-catalogued entity per rule 4b.

Neither creates a navigable edge. This file tracks the names that are currently
losing edges, with the evidence that justifies each one.

**How this list was produced:** regex extraction of capitalised name candidates
from every `text` node across all 1,244 rows of `editorial_documents`,
anti-joined against `artists.name`, `artists.stage_name` and
`artists.aliases`, then hand-verified by reading the surrounding sentence in the
Spanish document of each mentioning bio. `docs` = number of `editorial_documents`
rows whose prose contains the string.

Generated 2026-09-09.

---

## P1 — Blocks a structural relationship today

### «Aventura» — the band

| field | value |
|---|---|
| suggested `type` | `group` |
| suggested `aliases` | `{"Los Tinellers"}` |
| docs mentioning | 21 |
| status | **no row exists** |

This is the highest-value gap in the catalogue. Two consequences:

**1. Two relationship rows cannot be written.** `artist_relationships` exists for
exactly this and holds 32 rows (26 `member_of`, 6 `founder_of`). Once the band row
exists:

```sql
-- Romeo Santos, founder and lead voice
insert into artist_relationships
  (source_artist_id, target_artist_id, relationship_type, start_year, end_year)
values
  ('8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3', '<aventura_id>', 'founder_of', 1994, 2011);

-- Henry Santos, singer and songwriter
insert into artist_relationships
  (source_artist_id, target_artist_id, relationship_type, start_year, end_year)
values
  ('8dcfc4e1-9af4-4378-9e19-52573af429a7', '<aventura_id>', 'member_of', 1994, 2011);
```

**2. Two `aliases` arrays are carrying the band as a workaround.** Both
`Henry Santos` and `Romeo Santos` have `aliases = {'Aventura'}`. That is a
reasonable stopgap and is why the name never surfaced as "missing" in an
automated scan — the alias made it look catalogued. Once the band row exists,
consider whether those alias entries should be dropped in favour of the
`artist_relationships` edges.

Founding date: sources conflict between 1993 and 1994. Split 2011; farewell tour
«Cerrando Ciclos» closed 5 January 2025 at Estadio Olímpico Félix Sánchez.

---

## P2 — The Aventura circle, named in Romeo Santos's bio

These are the people the Aventura story cannot be told without. All four are
currently plain text or « » in `romeo-santos`.

| name | docs | role | note |
|---|---|---|---|
| **Lenny Santos** | 8 | requinto, arranger, producer | The single strongest case in P2. He is not only Aventura's guitarist — he is credited in the `elvis-martinez` bio as the man who **taught Elvis Martínez to play guitar** in New York in the early nineties. Two independent bios already need him. Sibling of Max Santos (`artist_family_relationships`, type `sibling`). |
| **Max Santos** | 2 | bass | Slap and rock-riff bass; the other half of the "bachata urbana" sound. Sibling of Lenny. Note both are unrelated to Romeo and Henry despite the shared surname. |
| **Judy Santos** | 2 | vocals | The female voice on «Obsesión», the record that put bachata at number one in seven European countries. |
| **Toby Love** | 0 | vocals | Aventura member before his solo career. **Scope check needed:** he is of Puerto Rican descent, born in the Bronx — confirm he qualifies under the catalogue's Dominican-artist criterion before adding. |

Also named in the Aventura narrative but probably **not** `artists` rows:

- **Elvin Polanco** — spotted the group at the Bronx Dominican Parade in July 1995. A talent scout, not a performer.
- **Julio César García** — the manager who renamed them «Aventura».
- **Franklin Romero** — signed them to «Premium Latin Music» in 1998.
- **«Los Tinellers»** — the group's first name. Belongs in `aliases` on the Aventura row, not as a separate row.

If the schema has a contributors or non-performer table, these four belong there.
Otherwise they stay as « » non-catalogued entities per rule 4b.

---

## P3 — Dominican figures cited across multiple existing bios

These were surfaced by the corpus scan, not by the Romeo work. Each already
carries editorial weight in bios you have published, so each is losing edges now.

| name | docs | evidence from the corpus |
|---|---|---|
| **Guy Frómeta** | 10 | Drummer and producer. The `kilvin-pena` bio describes the Guy Frómeta Band's Monday-night sessions at the Teatro Nacional as where a generation was blooded; the `ronald-romero` bio names him as one of the most accomplished musicians in the country. |
| **Bobby Rafael** | 10 | Arranger and bandleader. Named in `kinito-mendez` as one of the arrangers who came out of that door, and in `rokabanda` as the orchestra's **co-founder in 1992** — and Rokabanda *is* catalogued, so this is a missing edge between two entities that both matter. |
| **La Perversa** | 10 | Dembow. Appears in five bios including `yailin-la-mas-viral` and `la-baby`, consistently framed as one of the women who made Dominican dembow a place a woman could stand. |
| **Antonio Morel** | 8 | Classic merengue bandleader. His Orquesta Antillana is a career waypoint in both `francis-santana` (joined 1947) and `julito-deschamps` (first recording, 1960). Historic figure — `artist_tags = {legend}`. |
| **Bartolo Alvarado** | 8 | The accordionist known as El Ciego de Nagua. Named in `rafaelito-roman` as one of the two principal sources of the genre, and in `fefita-la-grande` as **the man who gave Fefita her stage name**. |
| **Cales Louima** | 8 | Christian-music producer and performer. Appears on recordings in `arianny-aquino` and `matty-martinez`. |
| **El Fother** | 8 | Dembow. Collaboration credits in `el-fecho-rd`; catalogue managed by the subject of `luigui-bleand`. |
| **Yailin** | 6 | Appears as a bare first name in six bios. `Yailin La Más Viral` **is** catalogued — this is likely a `displayText` normalisation issue rather than a missing artist. Verify before adding. |
| **Braulio Fogón** | 2 | Dembow. Low priority. |
| **Chris Lebron** | 2 | Featured on Romeo Santos's «SIRI». Confirm nationality before adding. |

---

## Explicitly out of scope

Named in bios but not Dominican, so no row is expected and « » is correct:
Don Omar, Usher, Drake, Justin Timberlake, Rosalía, Thalía, Daddy Yankee,
Bad Bunny, Celia Cruz, Marc Anthony, Tito Puente, Olga Tañón,
Gilberto Santa Rosa, Silvio Rodríguez, Pablo Milanés, Ivy Queen, Nicky Jam,
Ñengo Flow, Zion & Lennox, Farruko, Manny Montes, Alex Zurdo, Miel San Marcos.

---

## Suggested order of work

1. **«Aventura»** — unblocks two `artist_relationships` rows and resolves the
   alias workaround on two published artists.
2. **Lenny Santos** — two bios need him, and he anchors the sibling edge to Max.
3. **Verify Yailin** — may be a `displayText` fix, not an insert. Cheapest item here.
4. **Bobby Rafael** — connects to the already-catalogued Rokabanda.
5. **Antonio Morel** and **Bartolo Alvarado** — historic figures, each already
   load-bearing in two published bios.
6. Everything else as the genre coverage demands.

After any insert, re-link the mentioning documents: convert the plain-text or
« » mention to an `artistReference` node and write the paired
`editorial_entity_references` row **in the same transaction**. An unpaired node
is a BLOCKING state.
