# Hansel — proposed public-profile correction (2026-11-11)

Scope: artist `5ac3a5ea-c385-4db3-97cf-be8610ad2e91` (`hansel`), published; two published biography documents (EN `49017614-a036-494e-97b3-62fef839e5cb`, ES `09ae40de-1dd2-4004-b269-77267502ba42`), both revision 2. Proposed changes only. No database, media, music data, application code, or publication status has been changed.

## Evidence and decisions

- Hansel and Jhensen are different singers: the host of a 2021 music program explicitly introduced them as separate guests, assigning «Niña de Fuego» and «Quien después de mí» to Hansel. Source: https://www.dominicanoahora.com/variedades/aracelis-diaz-celebra-tercer-aniversario-de-su-programa-musicalizando-y-mas/ . Hansel's Facebook search also showed a 2014 post referring to Jhensen in Puerto Rico as another person. Remove the erroneous alias `Hansel Jhensen`.
- Hansel's own Facebook profile is https://www.facebook.com/hansel.cantantedominicano/ . It displays Santiago de los Caballeros as both current city and home city; neither establishes birth city. The existing `Santo Domingo` birthplace and province lack corroboration and conflict with this source. Clear both birth fields pending a birth-specific source. The Facebook profile search for `cumpleaños` returned family birthday posts, not a verified birthday for Hansel.
- Spotify https://open.spotify.com/artist/3Jo9urwUevcDVto6jIBaGC is a matching artist identity: its 2012 «20 Grandes Exitos» release includes «Quien Despues De Mi», «Niña De Fuego» and «Te Perdono», independently identified with Hansel by 2011 Dominican press. Spotify currently displays zero monthly listeners and the listed tracks were unavailable in the inspected session; this affects playback, not the identity match. Add the artist ID, not a track or album ID.
- A collector's LP inventory lists Hansel's Bronco LP under «Te Perdono - Niña De Fuego», catalogue 123, without a year: https://www.iasa-online.de/files/Brand_Sammelverzeichnis_Latin_Schalllplatten.pdf . The supplied bio sheet reports a physical «Hansel» LP and a 1982 date, supported by a 2026 anniversary post, but the original sleeve was not independently inspected in this review. Biography can mention the Bronco LP and songs; hold the exact release title, catalogue interpretation, and 1982 year from definitive discography claims.
- 2011 performance and repertoire: https://www.elcaribe.com.do/sin-categoria/sergio-hernandez-noche-baladas-boleros/ . 2015 «Baladas de Oro» billing: https://lacronica.do/baladas-de-oro-con-musica-romantica/ . 2021 identity and songs: above press article.
- The supplied sheet reports a «Cuchú Cuchá» sleeve credit for Hansel and «Me Enamoré», but the sleeve image was not supplied here. The existing Hansel bio already describes group membership. Keep the affiliation in biography; hold a structured `member_of` relationship and group-bio addition until sleeve inspection or equivalent direct evidence. This avoids enlarging this change into a shared-record edit.
- A further independent press check after the approved write found Fausto Polanco explicitly describing Hansel, of Santiago, as an interpreter with La Patrulla 15: https://eldia.com.do/ringo-martinez-un-creador-de-talentos-en-puerto-rico/ . This reinforces the retained affiliation and hometown description. It does not establish his birth city or authorize a new shared relationship in this manifest. The article's band-founding chronology differs from the current group biography, so no formation date was imported here.
- The current biography's Bobby Valentín production, Pedrito Rivera Toledo/José Pujals arrangements and Carlos Cimatto authorship are not supported by inspected liner notes. Remove those credit claims from biography; do not alter any music credits. «Aquel Niño de Fuego» is an erroneous title; use «Niña de Fuego». Remove «¿Pero dime quién?» because it is not corroborated. Avoid claims of a continental hit or residence in Santo Domingo.
- The existing personal-name fields (`Alejandro Anselmo Núñez`) are not independently corroborated. Preserve them for now to avoid erasing potentially editor-sourced information; omit the full name from public prose and flag the fields for editorial verification. Preserve the supported professional alias `Hansel Núñez`.

## Exact proposed fields

| Record | Before | After |
|---|---|---|
| artists.facebook | `hansel.cantantedominicanoJhensen` | `hansel.cantantedominicano` |
| artists.spotify | null | `3Jo9urwUevcDVto6jIBaGC` |
| artists.aliases | `["Hansel Núñez","Hansel Jhensen"]` | `["Hansel Núñez"]` |
| artists.birth_place | `Santo Domingo` | null |
| artists.province | `Santo Domingo` | null |
| EN/ES editorial documents | published revision 2, text containing unsupported claims and incorrect song title | published revision 3, exact prose in `hansel-biographies-proposed-2026-11-11.md`; artist references to the published Jossie Esteban y La Patrulla 15, Anthony Ríos and Vickiana rows |
| artists.bio_en / bio_es | legacy Markdown mirrors of old prose | Markdown mirrors of proposed text |

Unchanged: name fields, artist status `published`, role, gender, primary genre, tags, image, discography, media, other artists. No release/recording/work/credit rows are proposed.

## Review gate

The artist is already public. `AGENTS.md` and `docs/discography.md` Gate B/C require approval of this concrete manifest for public biography publication and removal of an alias. Upon approval, compare live revisions and fields with this baseline, apply only these changes, verify EN/ES document revisions and derived references, perform one targeted refresh, and spot-check the public profile in both locales. If any baseline has changed, stop and reconcile before writing.

## Execution and verification

- Editor approved the full manifest in the current chat on 2026-11-11. The database baseline still matched immediately before the write.
- Both proposed documents passed `public.validate_editorial_document_v1` before the write. A single guarded transaction applied the exact fields and called `public.upsert_editorial_document` for both locales; SQL retained in `hansel-approved-save-2026-11-11.sql`. The same transaction updated the legacy Markdown mirrors. No music data or other artist rows were written.
- Readback: artist remained `published`; Facebook `hansel.cantantedominicano`; Spotify `3Jo9urwUevcDVto6jIBaGC`; aliases `["Hansel Núñez"]`; birth_place and province null. EN and ES documents are `published` revision 3, each with four reference rows, all pointing to published artists. The erroneous alias and song titles are absent from both documents.
- One targeted `npm run revalidate -- --artists hansel` succeeded after an initial sandbox network failure. Response: `artists=1`, `songs=0`, `releases=0`, `allArtists=false`. No deployment or broad refresh.
- Live browser checks: Spanish `/es/artists/hansel` and English `/artists/hansel` both displayed the new biography and links to Jossie Esteban y La Patrulla 15, Anthony Ríos and Vickiana. The technical sheet showed the corrected Facebook link and sole remaining alias. The Spotify embed resolved to the intended artist, but Spotify displayed unavailable tracks in the research session.
- Unresolved: exact DOB/birth city; corroboration of the retained structured personal name; original Bronco and «Cuchú Cuchá» sleeves for full credits and dates. The group membership has been retained in biography but no shared structured relationship or group-bio update was made.
