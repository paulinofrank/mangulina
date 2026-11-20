# Plan Perfecto Music — profile manifest, 2026-11-06

Scope: one new group profile, bilingual biography documents. No discography import, other-artist edits, media upload, or public profile publication.

## Identity and fields

| Field | Proposed value | Evidence |
| --- | --- | --- |
| `name`, `stage_name` | Plan Perfecto Music | Official YouTube channel and 2022 press; the streaming name is Plan Perfecto. |
| `aliases` | Plan Perfecto | Spotify artist page and self-titled album. |
| `type` | group | Official Spotify biography names the band and founding members. |
| `slug` | plan-perfecto | Normalized principal name; no existing artist matched name or Spotify ID on 2026-11-06. |
| `birth_place`, `province` | La Romana, La Romana | 2022 Ciudadania RD press identifies founder's church in La Romana and says the band formed there. This is group origin, not individual birthplace. |
| `formation_year` | 2016 | Official Spotify biography says conceived late 2015 and formed in 2016. |
| `primary_role`, `primary_genre` | singer, worship | Official band description and releases; category follows existing group JUDÁ. |
| `genres`, `occupations` | [], [] | No duplicate of primary fields. |
| `gender`, `artist_tags` | other, [christian] | Mixed group; explicitly Christian worship repertoire. |
| `instagram`, `facebook` | planperfectomusic | Official video description links these accounts. |
| `spotify` | 5dfeX7kkKCf1cg5FqRy0eo | Spotify artist biography matches founding members, label and repertoire. |
| `website` | https://linktr.ee/PlanPerfectoMusic | Artist's Linktree provided in source sheet; no independent fetch from web tool. Leave blank if not otherwise validated. |
| `youtube` | blank | Official channel exists; handle not verified. |
| `status` | draft | Profile workflow. |
| English and Spanish biography status | published | Profile workflow; artist stays draft. |

## Sources and decisions

- [Spotify artist](https://open.spotify.com/artist/5dfeX7kkKCf1cg5FqRy0eo): official description of origin, founders and members. It says the album originated in November 2016, while [Spotify album metadata](https://open.spotify.com/album/1nbxfJvGnB8nOV0mr3lZ86) dates the digital issue 25 February 2017. Biography distinguishes recording/launch from digital release.
- [Ciudadania RD, 25 July 2022](https://ciudadaniard.com/plan-perfecto-music-presenta-nuevo-sencillo-tu-casa/): group formation in La Romana, «Tu Casa» and personnel. Its chart claim lacks named chart/date, so no Top 10 claim in biography.
- [Official «Hay Poder» video, 13 October 2022](https://www.youtube.com/watch?v=O5XInQq_ENo): writer, producer, session musicians, label and social accounts. Chris Disla is a session guitarist on this recording, not established as a permanent member. He has an existing published Mangulina artist row, so biographies reference him.
- [BuenaSuerte, 2022](https://blog.buenasuerte.com/plan-perfecto-music-declara-hay-poder/): «Hay Poder» and personnel.
- [Official «Fuego en el Altar» video, 17 November 2023](https://www.youtube.com/watch?v=UgDWFm1NoMc): composition/production and date. Spotify classifies it as a 2023 single.
- [En Reproducción, 2023](https://blogenreproduccion.blogspot.com/2023/02/plan-perfecto-tu-reino-video.html): «Tu Reino» and personnel.

Unverified: YouTube handle, original album launch date in Puerto Rico beyond artist account, dated chart rankings, current exact member roster, image rights. No associated music catalog writes.

## Saved and verified

- Artist UUID `893e9668-29c8-47be-875b-b88fdf6650ef`: newly inserted as `draft`, name `Plan Perfecto Music`, group, origin/province La Romana, formation year 2016, `singer`, `worship`, `christian`, Spotify `5dfeX7kkKCf1cg5FqRy0eo`, Instagram/Facebook handle `planperfectomusic`. No image, YouTube handle or website saved.
- Spanish biography UUID `2bdbf0e6-7929-42ae-976e-065f9e74365a`: `published`, revision 1, nine blocks, one `artistReference` to published Chris Disla.
- English biography UUID `3676532b-860d-4de7-81c0-1c092bc4e5c2`: `published`, revision 1, nine blocks, one `artistReference` to published Chris Disla.
- Both structured documents passed `validateEditorialDocument(1, ...)` and were visually checked in Mangulina admin as published revision 1. No pre-existing biography mentions of Plan Perfecto were found in the database, so no reciprocal edits were needed.
- Targeted cache refresh: `npm run revalidate -- --artists plan-perfecto` succeeded, reporting one artist refreshed. No deployment or broad cache sweep was performed.
