# José Peña Suazo / La Banda Gorda — split manifest

Date: 2026-11-16  
Scope: separate the published combined record into the person and the orchestra.  
Authority: editor approval received in this conversation; catalog write applied 2026-11-20 UTC.

## Current records

### Published combined record

- UUID: `b41d4bd2-9303-4834-885e-e7dee35a0287`
- Name: `José Peña Suazo y La Banda Gorda`
- Slug: `jose-pena-suazo-y-la-banda-gorda`
- Status: `published`
- Type: `solo_artist` (incorrect for the combined entity)
- Personal fields currently mixed into this record: José Peña Suazo, born 18 January 1967 in Cotuí, Sánchez Ramírez.
- Group identifiers currently mixed into this record: Instagram `josepenasuazo`, Facebook `bandagordaofficial`, YouTube `@LaBandaGordaHD`, Spotify `6biY6yyLVZzisjmFLx0AP1`.
- Dependencies found: 23 `release_artists` rows, 237 `recordings` rows, 2 published biography documents, and 10 incoming editorial references.

### Personal draft already present

- UUID: `770d5443-ff68-46a3-ba3e-43ac3f1cd7c1`
- Current name: `José Virgilio Peña Suazo`
- Current slug: `jose-virgilio-pena-suazo`
- Status: `draft`
- Current birth place value `Dominican Republic` is not a city and must be corrected to Cotuí / Sánchez Ramírez.
- No biography document exists yet.

## Proposed canonical result

### José Peña Suazo (person)

- Reuse draft UUID `770d5443-ff68-46a3-ba3e-43ac3f1cd7c1`.
- Canonical name/headword: `José Peña Suazo`; preserve full personal name `José Virgilio Peña Suazo` in the corresponding personal-name fields.
- Slug: `jose-pena-suazo`.
- Type: `solo_artist`; primary role `singer`; primary genre `merengue`.
- Date of birth: `1967-01-18`; origin: Cotuí; province: Sánchez Ramírez.
- Socials: Instagram handle `josepenasuazo`; do not attach the group Spotify ID to the person. Apple Music/Shazam, Discogs, MusicBrainz and AllMusic identifiers remain research metadata unless the profile schema has a verified field for them.
- Biography: publish the supplied EN/ES person biographies after converting section labels to bold-only paragraphs and preserving canonical artist references.
- No solo album discography will be created. His authored songs, guest appearances and producer/presenter credits remain documented in biography/research until separately approved catalog work.

### La Banda Gorda (group)

- Reuse published UUID `b41d4bd2-9303-4834-885e-e7dee35a0287` as the group record; this preserves existing release and recording foreign keys.
- Canonical name/headword: `La Banda Gorda` (no generic prefix added).
- Slug: retain the legacy public slug `jose-pena-suazo-y-la-banda-gorda` for continuity. The application currently has no artist slug-level redirect resolver (the `artist_redirects` table is identity-history only and rejects self-redirects), so changing this UUID's slug would break the live page. The canonical display name becomes `La Banda Gorda`; a future URL-redirect migration may add `/artists/la-banda-gorda` without breaking the legacy path.
- Type: `group`; primary role `orchestra`; primary genre `merengue`; formation year `1994`; active status retained.
- Keep group identifiers: Spotify `6biY6yyLVZzisjmFLx0AP1`, Facebook handle `bandagordaofficial`, YouTube handle `@LaBandaGordaHD`. Instagram `josepenasuazo` belongs to the person and must not remain on the group.
- Clear personal birth/name fields from the group record; retain José Peña Suazo as a structured founder/leader relationship when the existing relationship model and dates are confirmed.
- Move all 23 `release_artists` associations and 237 recording associations to the group identity without deleting releases, recordings, credits, artwork or provenance. Preserve literal `credited_as` values such as `José Peña Suazo` where printed.
- Biography: publish the supplied EN/ES group biographies. Do not add unverified founding city, lineup, album years, or credits; keep the 1994 founding-date / 19-Apr-1994 debut tension explicit.

## Editorial-reference reassignment

The 10 incoming references to the combined UUID should be reassigned contextually, not globally:

- Fulanito EN/ES: `José Peña Suazo y La Banda Gorda` as a guest/group billing → `La Banda Gorda`.
- Krisspy EN/ES: announced merengue with the billed act → `La Banda Gorda`.
- Manolé y la Banda del Truco EN/ES: co-producer/musical director of the orchestra → `La Banda Gorda`.
- Pochy y su Cocoband EN/ES: tribute lineup listing the group → `La Banda Gorda`.
- La Muralla EN/ES: `Un Chin Chin de Cariño`, identified as a composition by Peña Suazo → `José Peña Suazo` (person), not the group.

Each reassignment must preserve the original occurrence ID only when the target semantic remains unchanged; otherwise create a new occurrence ID and update the paragraph node's `displayText` to the canonical name.

## URL and publication handling

- Keep `jose-pena-suazo-y-la-banda-gorda` as the group's legacy public URL while the record is reused for the group; this avoids a 404 because the current application has no artist slug-level redirect resolver.
- Create `jose-pena-suazo` as the canonical person URL.
- Record the split decision and the legacy-slug preservation. A future, separately approved URL-redirect feature can add `/artists/la-banda-gorda` without breaking the existing path.
- Publish both new EN/ES biographies only after the split manifest is approved and both documents pass the biography-format checks.

## Evidence basis

- Reconciled split report supplied by the editor (2026-11-16), including the Dominican press pass, Spotify/Apple Music/Deezer/MusicBrainz/Discogs checks, and the social leg.
- Current database inspection on 2026-11-16: UUIDs, profile fields, 23 release links, 237 recording links, 10 incoming editorial references, and the existing two combined biography documents.
- Key sources in the supplied report include Listín Club, Diario Libre profile, Discogs release/sleeve data, AllMusic, MusicBrainz, Spotify, Apple Music/Shazam, Deezer, and the artist's verified Instagram.

## Approval and execution record

Applied result: the published UUID `b41d4bd2-9303-4834-885e-e7dee35a0287` now presents as `La Banda Gorda` while retaining the legacy slug and all 23 release / 237 recording foreign keys. The draft UUID `770d5443-ff68-46a3-ba3e-43ac3f1cd7c1` now presents as `José Peña Suazo` at `jose-pena-suazo`, with published EN/ES biography documents. The group documents advanced to revisions 4 (EN) and 3 (ES); the person documents were created at revision 1 (EN/ES). Ten incoming references were reassigned contextually (8 group, 2 person), and the founder relationship was created. A split decision is recorded as executed. The application has no artist slug-level redirect resolver, so the legacy group slug was intentionally preserved to avoid a 404; adding a clean `/artists/la-banda-gorda` URL remains a separate routing task. Group MBID/Wikidata fields still need a separately approved identity correction because they were outside the approved split manifest.
