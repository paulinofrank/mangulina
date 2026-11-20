# Marcel Piel Morena — field and source manifest

Date: 2026-11-12. Scope: create only the draft artist profile and publish its completed English and Spanish biography documents. No discography, cover art, image upload, other artist edit, or artist-profile publication is authorized.

## Identity and proposed fields

| Field | Before | Proposed | Evidence and limit |
| --- | --- | --- | --- |
| Artist | absent | Marcel Piel Morena; slug `marcel-piel-morena`; `solo_artist` | Official Facebook/Instagram and Spotify supplied by editor, opened directly. |
| Personal name | absent | Luz / Marcela / de la Cruz / Peralta | ONAPI notice E/2021-67700 associates the MARCEL PIEL MORENA business name with LUZ MARCELA DE LA CRUZ PERALTA. A Dominican government audit also identifies her as Marcel. |
| Birth | absent | 1972-12-15, Miches, El Seibo | Revista Miradas, July 2021, p. 65, gives full date/place. Her Spotify artist bio confirms 15 December and Miches; it does not give the year. The year is therefore supported by one full-date published source, not two independent full-date sources. |
| Gender | absent | female | Press and self-presentation explicitly describe her as a woman and female singer. |
| Role and styles | absent | singer; primary merengue; additional bachata; secular | Contemporary interviews document a merengue career, 2017 bachata album, and secular repertoire. No duplicate genre/role. `Bacharengue` is a stage concept, not a canonical genre value. |
| Socials | absent | Facebook `MarcelPielMorena`; Instagram `marcelpielmorena`; YouTube `@ProduccionesMar`; Spotify `1gLylNM042mZN0IvNbYWix` | All four editor-supplied pages opened in Chrome. The YouTube handle is a producer channel with a 17-year-old Marcel Selena video, not an exclusively personal channel. |
| Image | absent | leave unset | No locally supplied or rights-cleared artist portrait for this task. |
| Alias | absent | `Marcel Tu Piel Morena` | Más Vip, May 2017. |

## Key sources consulted

- ONAPI, public trademark bulletin, 15 December 2021, registration E/2021-67700: https://www.onapi.gov.do/transparencia/index.php/institucional/publicaciones/3516-boletines-de-registros-publicados-del-2020-al-2026/2160-publicaciones-2020-2022/1695-2021-pub/2079-diciembre-pub-2021?download=10862%3Apublicacion-15-de-diciembre-2021
- Revista Miradas, July 2021, p. 65: https://fliphtml5.com/lwyzi/psvv/MIRADAS_REP%C3%9ABLICA_DOMINICANA_JULIO_2021/65/
- Spotify artist page and own biographical note: https://open.spotify.com/artist/1gLylNM042mZN0IvNbYWix
- Facebook public page and in-profile search (`cumpleaños`, `feliz cumpleaños`): https://www.facebook.com/MarcelPielMorena ; search produced an unrelated sister birthday and a 2018 party post dated December 12, not evidence of her birth date.
- Instagram verified creator profile: https://www.instagram.com/marcelpielmorena/
- Producciones Mar YouTube channel: https://www.youtube.com/@ProduccionesMar
- Más Vip, 15 May 2017, interview and album details: https://masvip.com.do/2017/05/15/marcel-tu-piel-morena-se-va-a-mexico-a-lanzar-produccion-vacia-de-amor/
- El Telégrafo, 2018 interview (origin of stage nickname, Ecuador tour, 2018 single): https://www.eltelegrafo.com.ec/component/k2/espectaculos/1/marcel-pielmorena-cantante
- Más Vip, 15 August 2018, «No Guardo Luto»: https://masvip.com.do/2018/08/15/te-contamos-porque-marcel-no-guarda-luto/
- El Caribe, 22 November 2017, «Inagotable» show: https://www.elcaribe.com.do/gente/a-y-e/marcel-llega-inagotable-a-casa-de-teatro/
- El Buen Día, 27 December 2024, «Todo por Ellas» and producer/foundation: https://elbuendia.com/entretenimiento/canales-y-digitales-proyectaran-concierto-marcel-piel-morena/
- Cibao Noticias, 5 November 2025, «Que hablen de mí»: https://www.cibaonoticias.com/marcel-piel-morena-promueve-su-mas-reciente-cover-que-hablen-de-mi/
- El Caribe, 2026, «Jaime» cover: https://www.elcaribe.com.do/gente/marcel-piel-morena-presenta-su-version-en-bacharengue-de-jaime/
- Hard Rock Café venue calendar, future 26 November 2026 show: https://cafe.hardrock.com/santo-domingo/event-calendar.aspx

## Editorial decisions and unresolved work

- Do not repeat unverified prize claims or present the planned 26 November show as already performed.
- The 2017 press says fifteen years and thirteen productions; another contemporaneous interview says seventeen years; 2026 publicity says over three decades. These are not compatible as a single precise career duration. The biographies use dated career milestones, not an invented start year.
- The 2017 source names the album «Vacía de Amor» and eight tracks; this task does not import releases or credits. The 2018 «No Guardo Luto» is described as a single, not a confirmed full album.
- Backward-reference audit: José El Calvo's EN/ES published biographies mention singer “Marcel” with «Vamo hablar Inglés»; identity matches this artist, but editing that published artist's two documents requires expanded authorization. Other matches for Marcela/Marcelo/Marcelino refer to different people or songs. Leave both José El Calvo documents unchanged; report IDs/revisions separately.
- Do not use the profile URL of this draft artist as a preview; verify through admin/database only.

## Execution and checks

- Created `artists.id = 2a69eb5f-d05d-4df1-b02c-2a7e5aeb9823` with exactly the profile fields above and `status = draft`. Its `has_image` remains false. Legacy `bio_es` and `bio_en` mirrors match the review copy in `marcel-piel-morena-biographies-2026-11-12.md`.
- Created and published structured Spanish biography `683aac73-1c07-4070-a910-0389ae70bdc2` and English biography `1ce73e3b-3a11-4a0f-941e-50e12a55372f`, both revision 1. Both documents passed `validate_editorial_document_v1` before save.
- Each biography has four canonical artist-reference rows: Joe Veras, Cromo X, La India Canela and Yailin La Más Viral. The persisted reference counts and targets matched the planned nodes.
- Read back all profile fields from the database. `primary_genre = merengue` and `genres = [bachata]`; `primary_role = singer` and `occupations = []`. Spotify ID and social handles persisted in the required forms.
- Opened the saved profile in the Chrome admin editor. The form showed draft, Miches / El Seibo, 1972-12-15, female, singer, secular, merengue plus bachata, voice, all three handles, Spotify ID and no image. Opened both biography language tabs; each showed the expected first and last paragraphs and `published · revision 1`.
- No public draft URL was opened; no public refresh, deployment or discography write was performed.
- Pending shared-link work, not changed at the end of the initial task: José El Calvo `ced86e3a-4e99-4cee-ab0a-ad6ede956ea0`, English document `d37fbb02-f031-4958-ba6f-742e5f17d87a` revision 4 and Spanish document `6c99539a-d1d6-4e6b-ae0a-646d1576b05c` revision 2, each has the plain-text mention of the singer Marcel on «Vamo hablar Inglés». Those published documents required expanded authorization to replace the mentions with artist references.

## Follow-up scope and manifest — editor authorization, 2026-11-12

The editor supplied `C:\Users\fvpg\OneDrive\Downloads\unknown-woman-wavy-hair-sparkle-20261112-watercolor-600x600.jpg`, requested it for this artist, explicitly authorized updating links in other biographies, and then instructed publication at completion.

1. Upload that supplied 600×600 watercolor image through the artist admin image control; this changes Marcel's media object and `has_image`, not any other image. The file was visually inspected before upload. The admin reported success as `2a69eb5f-d05d-4df1-b02c-2a7e5aeb9823.webp` and displayed the portrait on Marcel's selected draft profile.
2. José El Calvo (`ced86e3a-4e99-4cee-ab0a-ad6ede956ea0`) has exactly two verified backward mentions in published structured biographies, both in the paragraph about «Vamo hablar Inglés». English document `d37fbb02-f031-4958-ba6f-742e5f17d87a` revision 4: `with the singer Marcel,` → `with the singer Marcel Piel Morena,` plus one artistReference to `2a69eb5f-d05d-4df1-b02c-2a7e5aeb9823`. Spanish document `6c99539a-d1d6-4e6b-ae0a-646d1576b05c` revision 2: `con la cantante Marcel,` → `con la cantante Marcel Piel Morena,` plus the same target. Preserve every other paragraph and pre-existing artist reference. Update only the corresponding legacy mirror phrases. Both proposed JSON documents passed schema validation before writing.
3. Publish only Marcel's artist row (`draft` → `published`) after the links are saved, then perform targeted cache refresh and verify both locale pages. No discography, unrelated profile, schema or security changes are part of the follow-up.

The second search of structured biographies found no other identity-supported plain-text mentions of this Marcel; matches for Marcela, Marcelo and Marcelino were excluded.

## Follow-up execution and public verification

- The admin image upload saved the supplied portrait as `2a69eb5f-d05d-4df1-b02c-2a7e5aeb9823.webp`; `artists.has_image` is true and the image appears on the public ficha.
- José El Calvo's English document `d37fbb02-f031-4958-ba6f-742e5f17d87a` was saved as published revision 5 (previously 4); its Spanish document `6c99539a-d1d6-4e6b-ae0a-646d1576b05c` as published revision 3 (previously 2). Each has one canonical artist reference to Marcel. Their `artists.bio_en` and `artists.bio_es` mirrors received only the matching name-phrase correction. The other document nodes and references were retained.
- Marcel's `artists.status` was changed from `draft` to `published` in the admin editor; the editor confirmed the update. A database readback confirmed `status = published` and `has_image = true`.
- Opened the live Spanish and English Marcel pages. Both rendered the submitted portrait, completed structured biography, Spotify player, identity and birth fields, primary role and genre, and links to four existing artists. Opened José El Calvo's live Spanish and English pages and confirmed the «Vamo hablar Inglés» sentence now links `Marcel Piel Morena` to Marcel's locale-specific page. Fresh public responses already reflected the changes, so no separate cache refresh was needed.
- No discography, schema, security or unrelated artist records were changed in this follow-up.

## Website correction — 2026-11-12

The editor reported that `https://liinks.co/marcelpielmorena`, previously saved as the artist's website, was broken or empty. A direct browser visit redirected to `https://www.liinks.co/marcelpielmorena` and displayed Liinks' **Not Found** page with “No user was found for this url.” The web reader also could not access it. This was an erroneous active link; its presence in a source or profile list had not established that it resolved to a live artist page.

Changed only Marcel's `artists.website` from `https://liinks.co/marcelpielmorena` to `NULL` in the administrative profile editor. The editor confirmed the update; a database readback confirmed `website = NULL` and `status = published`. The live Spanish ficha no longer displays an Official Website link. The URL above is retained here solely as failed-link evidence, not as a usable website.

Added a pre-save verification rule to `docs/ARTIST_PROFILE_WORKFLOW.md`: open the exact external destination, check useful content and artist identity, record the result, leave failed fields blank, then verify the rendered public link after save. No other Marcel field, biography or discography was changed.
