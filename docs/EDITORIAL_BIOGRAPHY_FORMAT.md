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

### Draft artist, published biographies — editor clarification, 2026-10-16

For an authorized artist-profile creation or completion, keep the artist record in `draft`, but publish both completed, validated biography documents (`en` and `es`). Use `draft` documents while writing or resolving validation issues; it is not the final state for a finished biography attached to a draft artist. This is covered by the profile-workflow exception in discography.md, Gate B, without another approval step. It does not authorize publishing the artist profile or changing biographies of an already public artist without authorization.

The public artist route first requires a published artist through `getArtistProfile` in `src/lib/artistApi.ts`. It then loads only published biography documents through `src/lib/editorial/publicData.ts`. A published biography therefore does not release a draft artist profile, and leaving a completed biography in draft would prevent it appearing when the artist is later published. Verify the artist remains draft and both biography documents are published after saving. This describes profile-page visibility, not a security guarantee for every data-access channel.

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

### Rule 4c: Collective names are not type labels

Do not add a generic word such as «Orquesta», «Grupo», «Banda» or «Conjunto»
to a collective artist's name merely to describe its type. Use the documented
canonical name exactly as stored. Retain the word only when reliable evidence
shows that it is part of the proper name—for example, «Orquesta Internacional»
associated with Ramón Orlando. The artist type belongs in the profile fields;
the biography and every `artistReference` must use the canonical proper name.

### Rule 5: Both locales

Write `en` and `es`. The Spanish version is an independent piece of writing, not
a machine translation of the English.

### Rule 6: No figures that change from day to day

A biography is read for years; a count that was true on the day it was written
is wrong within weeks. Do not publish:

- views, plays, streams or listens (including "passed a million views"),
- subscribers, followers or likes on any platform, and monthly listeners,
- any "has more than N ..." or "over N ..." phrasing built on those figures.

Say what the song or channel *is* and when it appeared; if the reception matters,
name the event, not the counter (a viral moment, a remix by another artist, a
chart position on a dated chart).

Keep figures that are fixed to a moment or belong to a closed event: "eight
million views in two weeks" after release, sales and certifications, tour
grosses, an award or chart position with its date, the audience of one
broadcast. If a source gives only a live counter, leave the number out.

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

### Required backward-reference audit — editor clarification, 2026-10-24

Creating or completing an artist is not finished after checking only that
artist's own biography. Search existing English and Spanish structured
biographies for the artist's canonical name and documented name variants,
including mentions surrounded by guillemets and plain-text mentions. Search
legacy biography mirrors only to identify missing structured-document coverage;
do not edit the mirrors directly. Do not rely on conversation memory or an
integrity report: a plain-text mention may pass structural validation while
still missing its artist reference.

For each candidate, inspect the surrounding text and confirm identity; name
matching alone never authorizes linking. Record the owner artist UUID, document
UUID, locale, revision, target artist UUID, exact mention and proposed change.
Where the existing task authorizes those document edits, replace only the
verified mention with an artistReference, use the canonical display name and a
fresh occurrenceId, and save through the editorial lifecycle so its relation row
and compatibility mirror remain synchronized. Remove surrounding guillemets
from the artist mention; preserve the surrounding prose and existing references.
Do not invent a reciprocal sentence or a collaboration merely to create links.

This audit is required at both draft completion and authorized artist
publication. Draft status does not authorize publishing another artist's
biography or exposing a draft target through a public link. Preserve existing
publication and shared-record gates: if a verified repair lies outside the
authorized scope, list the exact pending documents and required authorization
in the completion report. Never silently omit the finding or describe the
catalog's reciprocal links as complete. Once authorized, verify both locales,
reference relations, revision increments and the affected published pages;
perform only the existing targeted cache refresh for the actual changed owners.

Example: after adding Martox, inspect Solo Fernández's existing biographies.
Their literal «Martox» mentions must be evaluated for conversion to the Martox
identity; a correct Solo Fernández reference in Martox's biography does not
complete this backward check.

### Efficient link-only updates — 2026-11-14

For several approved mentions in one biography, load its latest structured
document and revision once, apply all verified replacements in memory, and save
the document **once per artist and locale**. Preserve every existing block,
mark, reference target and occurrence ID; give each new `artistReference` a
fresh occurrence ID. Compare the proposed document with the saved version and
skip an identical write. A name match is only a candidate: the identity and
context checks above still apply to each occurrence.

Use the authenticated editorial save lifecycle (`POST
/api/admin/editorial-documents`, or the admin editor that calls it) with
`expectedRevision` and the approved status. That route validates the JSON,
uses the atomic `upsert_editorial_document` operation for document and derived
reference rows, and revalidates the affected owner's profile. Do not write
`editorial_documents` or `editorial_entity_references` with raw SQL merely to
avoid editor clicks; those writes bypass the save lifecycle and cache refresh.
If a programmatic authenticated caller is unavailable, paste the prepared
structured content and save once per locale in the admin editor rather than
editing and saving each mention separately. Never extract browser credentials
to make a batch script work.

Keep one writer, a finite approved document list and request cap. Stop on a
revision conflict, reload that document and reconcile before retrying. After
the final save, verify revision increments, reference-node/relation parity and
only the affected public pages. This method changes execution cost, not the
publication, shared-record or evidence gates.

---

## The Legacy Markdown Mirror

`artists.bio_en` / `bio_es` hold the **markdown source** of the same content:

- section title → `**Title**` on its own line
- paragraphs separated by a blank line
- bullets → `- item`, items separated by two spaces + newline
- `artistReference` → its `displayText`, unadorned

This is not the flattened plain text of the document. Writing the flattened form
instead produces a wrong-looking legacy column.

When adding only `artistReference` links, first check whether the visible text
changes. If it does not, preserve the full Markdown mirror; do not rebuild it
with a paragraph-only serializer that drops `bulletList`, numbered lists or
other nested blocks. If the visible text changes, generate the mirror with a
serializer that preserves every block type and inspect the ends of lists before
publication. Save the document and its mirror together when a mirror update is
needed.

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

**Editor clarification, 2026-10-19 — Origin is a city.** Never put
«República Dominicana», «Dominican Republic», or another country in Origin.
Mangulina documents Dominican artists; this field is not a nationality field.
Leave it empty when the city is unverified. For Dominican artists born abroad,
record the verified birth city and select **Born Abroad** for Province (the
current form's equivalent option is **Nacido en el Exterior**). Foreign residence
alone does not establish foreign birth. For individuals, keep birthplace and
hometown distinct; for collectives, the current Origin control stores the
documented origin city in `birth_place`. Follow
[ARTIST_PROFILE_WORKFLOW.md](ARTIST_PROFILE_WORKFLOW.md) for evidence and current
form-compatible values. This instruction does not authorize edits to existing
artist records as a side effect of documentation work.

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
