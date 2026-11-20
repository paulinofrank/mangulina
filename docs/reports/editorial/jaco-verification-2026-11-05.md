# JACÓ — profile creation and verification

Date: 2026-11-05. Scope: new artist JACÓ only; no discography import, media upload, other-artist edit or profile publication.

## Records changed

- Artist: none → `36390269-eb30-404d-876c-c72bc3336dcc`, slug `jaco`, status `draft`.
- Spanish biography: none → `ac4afa6d-6f8e-460b-acf8-ebd308278583`, status `published`, final revision 2.
- English biography: none → `7dc5b3ea-2029-4ae1-b772-3323b42d26ee`, status `published`, final revision 2.
- Revision 2 corrected an initially plain-text and mis-spelled mention of Antony Santos in both biographies to the canonical `artistReference` (`28a3745e-90d6-45cd-b8bd-798028f8deb8`). Both documents also link Joe Veras (`aec32df5-cc5a-43c2-ac33-02bc8caa1cf5`). No existing artist records were edited.

## Profile fields

- Presentation and stage name `JACÓ`; personal fields `Miguel` / `Ángel` / `Fulgencio` / `de la Rosa`, as stated in his Spotify artist biography and Flow Magazine.
- Provenance: El Valle, Hato Mayor. Province `Hato Mayor`; `birth_place`, `date_of_birth` and `birth_year` left blank because origin is not proof of birth and no birth date was verified.
- `solo_artist`; primary role `singer`; other occupation `composer` from his own Instagram description; `voice`; male; primary genre `bachata`; no duplicate additional genre; `secular` based on the documented romantic repertoire.
- Facebook numeric ID `61591755186177`; Instagram `jacooficialrd`; YouTube `@jacooficialrd`; Spotify artist ID `5c7S93jf2DMCM69ydZSF0O`. The official Facebook page cross-links Instagram, YouTube and Spotify; YouTube cross-links Instagram and TikTok.
- No portrait or website stored. No rights-cleared portrait was supplied. TikTok `@jacooficialrd` was verified in the YouTube channel links but the artist form has no TikTok field.

## Evidence and limits

- Spotify artist: https://open.spotify.com/artist/5c7S93jf2DMCM69ydZSF0O — full name, El Valle origin, 2026 catalogue and self-description.
- Official Facebook: https://www.facebook.com/profile.php?id=61591755186177 — account identity and cross-links. About > Details had no birthplace or birthday. Searches within the profile for `Cumpleaños`, `cumple` and `años` returned no result.
- Instagram: https://www.instagram.com/jacooficialrd/ — artist/composer self-description and current activity.
- Official YouTube: https://www.youtube.com/@jacooficialrd — videos, official artist channel and release listings.
- Flow Magazine: https://flowmag.com/jaco-salta-de-tiktok-a-la-bachata-original-con-su-primer-sencillo-amor-de-barrio/ — hometown, emergence, «Amor de Barrio», production, Río San Juan video and television performance.
- Joe Veras's public video: https://www.instagram.com/joeverasoficial/reel/DfBGsBSRWbB/ — public support for JACÓ.
- Authorship of «Amor de Barrio» differs between the promotional article and the official video description; no composer credit was asserted in the biographies or catalog.
- Announced «La Serpiente» had not yet reached its November 6 release date, so it was omitted.

## Checks

- Pre-write duplicate search found no JACÓ record; backward search found no prior structured biography mention of JACÓ, the handle or full name.
- Both final JSON documents passed `validate_editorial_document_v1` before revision 2.
- Database readback: draft artist; two published revision-2 biography documents; two artist reference rows per locale; exact legacy Markdown mirrors; no primary genre/genre or primary role/occupation duplication.
- Admin visual readback after reloading and reselecting JACÓ: correct draft badge, personal names, province, type, role, genre, instrument, tag, handles and Spotify ID. Both language tabs showed `published · revision 2` and linked artist names.
- Production usage: scoped Supabase artist/document writes and one admin page for visual readback. No public draft URL was opened, no cache refresh or deployment was triggered.

The initial field manifest and revision-1 texts are preserved in `jaco-profile-manifest-2026-11-05.json`. The exact revision-2 documents and reason are preserved in `jaco-biography-link-correction-2026-11-05.json`.
