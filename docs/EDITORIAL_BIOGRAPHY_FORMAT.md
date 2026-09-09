# Editorial Biography Format

**Mangulina Dominican Music Database — How artist biographies are structured and stored**

This document is the authority on how an artist biography is written and persisted. Read it before creating or editing any biography, by hand or by script.

**Related Documents:**
- [EDITORIAL_GUIDELINES.md](EDITORIAL_GUIDELINES.md) — Editorial philosophy and decision-making
- [DATA_GOVERNANCE.md](DATA_GOVERNANCE.md) — Entity definitions and relationships
- [AI_INSTRUCTIONS.md](AI_INSTRUCTIONS.md) — Project rules for AI assistants

---

## Where a Biography Lives

A biography is **not** a column on `artists`. It is a structured document.

| Location | Role |
|----------|------|
| `editorial_documents` | **Source of truth.** One row per artist per locale. |
| `editorial_entity_references` | One row per artist mention inside a document. |
| `artists.bio_en` / `artists.bio_es` | **Legacy compatibility mirror.** Markdown source of the same content. |

The public profile at `src/app/[locale]/artists/[slug]/page.tsx` renders the
**document**, falling back to the legacy column only when no published document
exists.

### The admin API rejects direct biography writes

`POST /api/admin/artists` refuses any payload containing `bio`, `bio_en`, or
`bio_es` (see `hasForbiddenArtistBiographyFields` in
`src/lib/editorial/migration.ts`). Biographies go through the editorial document
endpoints, not the artist record.

### `editorial_documents` row shape

| Column | Value |
|--------|-------|
| `document_type` | `artist_biography` (the only permitted value) |
| `locale` | `en` or `es` |
| `schema_version` | `1` |
| `status` | `draft` or `published` |
| `owner_artist_id` | FK to `artists.id`, required |
| `revision` | Increment on every edit; never reuse |

A unique index enforces one document per `(document_type, owner_artist_id, locale)`.

---

## Formatting Rules

### Rule 1: Bold is for section titles only

**Never use inline bold.** Do not bold the artist's name in the opening
sentence, song titles, album titles, orchestra names, or TV show names. Those
are plain text.

A section title is a paragraph whose entire content is a single bold text node —
nothing before it, nothing after it.

```
WRONG (inline bold):
  "**Mario Díaz** (born May 31, 1959) is a Dominican composer…"
  "…debuted on **El Show del Mediodía**, performing…"
  "- **El Sinsonte** — the album, issued on Franfer…"

RIGHT:
  "Mario Díaz (born May 31, 1959) is a Dominican composer…"
  "…debuted on El Show del Mediodía, performing…"
  "- El Sinsonte — the album, issued on Franfer…"
```

Some older catalog entries still contain inline bold. They are legacy, not a
precedent to copy.

### Rule 2: There are no `heading` nodes

The schema permits `heading`, but the catalog does not use it — section titles
are bold-only paragraphs. Stay consistent with the catalog.

### Rule 3: Structure

Every biography opens with an **unlabelled lead paragraph** — no title above it —
that states who the artist is, when they were born, and why they matter. Titled
sections follow. The last section is **Legacy** (`Legado` in Spanish).

Section titles are written in the document's own language. A typical shape:

| English | Spanish |
|---------|---------|
| *(lead paragraph, untitled)* | *(párrafo de entrada, sin título)* |
| Early years and formation | Primeros años y formación |
| *(career sections, named for the actual career)* | *(secciones de carrera)* |
| Style and working method | Estilo y método de trabajo |
| Recognition | Reconocimientos |
| **Legacy** | **Legado** |

Name the middle sections after what actually happened to that artist. Do not
force every biography into identical headings.

### Rule 4: Bullet lists

Use `bulletList` blocks for enumerations — notable recordings, awards,
performers who carried an artist's material. Prose paragraphs for everything
else. Do not build a whole biography out of lists.

### Rule 4b: Titles go in guillemets, in both locales

Names of **works** — albums, songs, films, documentaries — and of **entities
that have no row in the catalogue** — bands, labels, festivals, television
programmes — are written between `«` and `»`. This applies to the English
entry as well as the Spanish one: one marker for the whole catalogue.

```
RIGHT:
  "Su primer álbum, «Sigo siendo yo», trajo «Lo que tiene ella» y «Me voy»."
  "He recorded «La Cosquillita» for «Fogaraté», issued by «Karen Records»."

WRONG:
  "Su primer álbum, Sigo siendo yo, trajo Lo que tiene ella y Me voy."
  'He recorded "La Cosquillita" for Fogaraté.'
  "Su primer álbum, _Sigo siendo yo_, trajo..."
```

Three things stay outside the rule:

- **People.** Names of persons are plain text, always.
- **Artists that do have a row.** They are `artistReference` nodes, and the
  link is what marks them. Do not wrap a reference in guillemets — and note
  that `displayText` must still equal `artists.name` character for character,
  so any guillemet would have to sit in the neighbouring text node anyway.
- **Single common words.** A genre, an instrument, a city.

Entries written before this rule was adopted use plain text or straight
quotes and are being retrofitted; they are legacy, not a precedent.

### Rule 5: Both locales

Write `en` and `es`. The Spanish version is an independent piece of writing, not
a machine translation of the English.

---

## Linking Other Artists

Any artist mentioned who already exists in the catalog **must** be an
`artistReference` node, not plain text. Artists not in the catalog stay as plain
text.

Each reference node requires a matching row in `editorial_entity_references`, or
the integrity report raises a **blocking** finding.

```jsonc
// inside a paragraph's content array
{
  "type": "artistReference",
  "attrs": {
    "occurrenceId": "<fresh uuid, unique within the document>",
    "artistId": "<artists.id>",
    "displayText": "<must equal artists.name exactly>"
  }
}
```

```sql
insert into editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
values ($1, $2, 'artist', $3);
```

**`displayText` must match `artists.name` character for character.** If the
catalog stores `Charlie Rodriguez` without the accent, the biography says
`Charlie Rodriguez`. A mismatch raises `display_wording_differs_from_canonical_name`.
Fix the artist record first if the stored name is wrong; do not paper over it in
the prose.

**Link reciprocally.** When creating an artist who is mentioned in an existing
biography, update that biography to link the new artist.

---

## The Legacy Markdown Mirror

`artists.bio_en` / `bio_es` hold the **markdown source** of the same content:

- section title → `**Title**` on its own line
- paragraphs separated by a blank line
- bullets → `- item`, items separated by two spaces + newline
- `artistReference` → its `displayText`, unadorned

This is not the flattened plain text of the document. Writing the flattened form
instead produces a wrong-looking legacy column.

Keeping the mirror in sync is what prevents the `missing_document` blocking
finding (legacy populated, no document). A wording drift between the two only
raises an *informational* `legacy_compatibility_mismatch`.

---

## Integrity Checks

`src/lib/editorial/integrity.ts` builds the report. Before considering a
biography done, confirm:

| Check | Severity if violated |
|-------|---------------------|
| Every reference node has a relation row | blocking |
| Every relation row has a reference node | blocking |
| `target_artist_id` matches the node's `artistId` | blocking |
| Document validates against schema v1 | blocking |
| `occurrenceId` unique within the document | blocking |
| One document per artist per locale | blocking |
| Published document is non-empty | blocking |
| Referenced artists are `published` | warning |
| Draft document while legacy column populated | warning |
| `displayText` equals `artists.name` | informational |

---

## Field Hygiene on the Artist Record

Do not repeat a value across a scalar column and its list column:

| Scalar | List | Rule |
|--------|------|------|
| `primary_role` | `occupations` | `occupations` must not repeat `primary_role` |
| `primary_genre` | `genres` | `genres` must not repeat `primary_genre` |

If `primary_role` is `composer`, then `occupations` holds only the *other*
roles (`lyricist`, `bandleader`, …). If `primary_genre` is `salsa`, then
`genres` holds only the other genres. Genre values come from the approved
taxonomy in the `genres` table — see [EDITORIAL_GUIDELINES.md](EDITORIAL_GUIDELINES.md).

Also note: `birth_day` and `birth_month` are **generated columns** derived from
`date_of_birth`. Do not insert them.

---

## Cache Invalidation

The admin API calls `revalidateArtistProfilePaths`, `revalidateHomepageData` and
`revalidateEditorialDocumentsReferencingArtist` after a write. **Direct database
writes bypass all three** — the artist directory and sitemap segments may serve
stale data until they revalidate on their own. Say so when reporting work done
outside the admin UI.

---

## Reference Implementations

Two entries written to this specification:

- `mario-diaz` — composer, 13 artist references per locale
- `ray-polanco` — singer, 3 artist references per locale

---

**Last Updated:** 2026-08-21
**Status:** Active
**Authority:** Project governance
