## Spotify reconciliation

The editor supplied the [23Thierno Spotify artist page](https://open.spotify.com/artist/7viEfLBuuWqXcL8Bb4plcg) and [Monotonía track page](https://open.spotify.com/track/5ghgXQGkOmtkx5Sk8gNG2J). The public Spotify track metadata confirms “Monotonía” by 23Thierno, from the same-titled 2025 single. Spotify artist ID `7viEfLBuuWqXcL8Bb4plcg` and track ID `5ghgXQGkOmtkx5Sk8gNG2J` supersede the earlier unresolved Spotify findings. Apple and Amazon corroborate the title, artist and year.

The public artist page linked nine distinct release pages, each checked directly. The table records the first artist in Spotify's page title. See the earlier billing table for the full release credits.

| Single | First artist in page title | Spotify source |
| --- | --- | --- |
| Love It | 23Thierno | [Spotify release](https://open.spotify.com/album/0ysLHZeV6JsszHSURJ02SV) |
| Monotonía | 23Thierno | [Spotify release](https://open.spotify.com/album/14nO1bPFmZwJP4snsovAaO) |
| Playa | 23Thierno | [Spotify release](https://open.spotify.com/album/2RLGU06I4OTQIDqoTahKJT) |
| Baby You | Angel Fire | [Spotify release](https://open.spotify.com/album/3uB3OrQP6p6swk9mfnJdGx) |
| Panas Falsos | 23Thierno | [Spotify release](https://open.spotify.com/album/4nkjsDLqhb9Y0kCKAOnvTd) |
| Le Jure | Angi Fire | [Spotify release](https://open.spotify.com/album/556VSgqmiNu5kYprG35M7B) |
| Mi Cocola | 23Thierno | [Spotify release](https://open.spotify.com/album/6ID4QgAbl6H8H8px0B6Ftd) |
| Nena | 23Thierno | [Spotify release](https://open.spotify.com/album/70mQzmYQHnpeaoz7tGRtU9) |
| With "U" | 23Thierno | [Spotify release](https://open.spotify.com/album/7lqTSBDHoAZNqKD4qaR1yw) |

This confirms Spotify coverage for the nine previously documented singles. The public page snapshot may omit releases visible in other Spotify views or markets. The five additional titles remain unverified. No database, application code or music data changed during this reconciliation.

# 23Thierno discography

## Spotify catalog update

The existing artist field `artists.spotify` already held the verified ID `7viEfLBuuWqXcL8Bb4plcg`. All nine Spotify single pages supplied a single track ID and an edition date matching Apple. The three published recordings gained Spotify platform links, Spotify track IDs in recording metadata, and Spotify album IDs in release and recording metadata. Before the update there were no Spotify platform links for these recordings. The public import table below records their Release and Recording UUIDs.

| Single | Verified Spotify track | Mangulina Spotify link row |
| --- | --- | --- |
| Love It | [Spotify track](https://open.spotify.com/track/1XCqN7KKS56X0iV8XJoEeZ) | fb128348-e838-4efd-b0e9-594cf847fd64 |
| Monotonía | [Spotify track](https://open.spotify.com/track/5ghgXQGkOmtkx5Sk8gNG2J) | Pending release import |
| Playa | [Spotify track](https://open.spotify.com/track/4VqzREfODC5JwHpA6MFDoM) | Pending release import |
| Baby You | [Spotify track](https://open.spotify.com/track/3hXwsQ9fnUddnsiGyhtB8H) | Pending release import |
| Panas Falsos | [Spotify track](https://open.spotify.com/track/2CEHf1dBQ2jsPR4YADH4pT) | Pending release import |
| Le Jure | [Spotify track](https://open.spotify.com/track/74Pkn13V2eOoIDZgWYWgNZ) | Pending release import |
| Mi Cocola | [Spotify track](https://open.spotify.com/track/7HK8fthFhe6LnjTuoNi59a) | Pending release import |
| Nena | [Spotify track](https://open.spotify.com/track/6wscLomYlyhpLFdz4gFruQ) | 910fd997-6165-400f-99e3-fb0371cc0fd4 |
| With "U" | [Spotify track](https://open.spotify.com/track/0fbTRcCDdQu8imCktmsGwr) | 0de1e67f-0f7e-4267-b618-10b8dd76b45e |

The six pending singles still require the classification and identity decisions documented in the Apple verification table. No application code, deployment, or storage changes were made in this update.

Research and proposed catalog manifest, 2026-11-11, Codex. Scope covers 23Thierno's releases, collaborations and documented creative credits across all years. Dated editions found span 2024–2026. Buena Música reports activity from 2019, which leaves the earlier release history open. No album, EP, compilation, live edition or soundtrack surfaced in the sources inspected. [Buena Música artist profile](https://www.buenamusica.com/23thierno/biografia) · [Amazon Music artist catalog](https://music.amazon.in/artists/B081JXB4XZ/23thierno)

## Mangulina baseline

- Artist `55c4969c-61a3-4541-aad6-00408493c88d`, slug `23thierno`, status `published`. The [published-artist fixture](../../../tests/search/fixtures/published-artists.json#L3999) records alias `23 Thierno`. Buena Música identifies the artist as Erlin De Jesús De Los Santos of San Cristóbal. [Artist profile](https://www.buenamusica.com/23thierno/biografia)
- A scoped production Supabase SELECT found zero Releases, Recordings or Track placements through the artist's primary, canonical and legacy release/recording artist links. It also found zero legacy portfolio credit or performer rows. Unlinked same-title catalog rows have not been ruled out.
- One historical Work credit exists. Credit `aff9bc07-1fd8-4dd1-8f74-d8034e262d26` is a superseded `arranger` assertion on “Cómo quisiera,” Work `8b81cf02-1b92-45a7-b762-155d9e2fdd14`. The linked Alex Bueno Recording is `bb2ecc6a-e88a-4fd2-aa72-205119032c0a`, with three appearances on releases `9a8d09a1-c51a-4789-a983-603089b4bed7`, `975b0558-9f39-46e2-b86e-ab543e90d8f9` and `3c02cc68-0231-4b75-9506-27f913643765`. Preserve the superseded assertion as historical evidence. The row provides no verified arrangement credit for this discography.

## Documented singles and proposed values

Dates describe the listed digital editions. Each row proposes a digital single and a track at disc 1, position 1, with a corresponding recording candidate. Love It's one-track program is provisional pending the product listing. Before values are absent from the UUID-scoped performance inventory. Resolve possible unlinked matches before assigning new identities. Durations, rights lines and genre strings below are source values. A rights line alone does not identify a label or a creator. Dashes indicate unavailable fields. All sources were checked on 2026-11-11.

| Edition date | Release and track title | Literal billing | Duration | Rights / genre evidence | Source and confidence |
| --- | --- | --- | --- | --- | --- |
| 2024-08-23 | Release: Le Jure (feat. 23Thierno). Track: Le Jure | Angi Fire & Dj Human Star feat. 23Thierno | — | ℗ 2024 Human Star Company. Apple R&B/Soul | Apple US release metadata was indexed, with title/year also visible on Apple DO's Monotonía page. Amazon lists it under Appears On. Exact date and rights provisional pending direct edition access. [Apple US](https://music.apple.com/us/album/le-jure-feat-23thierno-single/1850793544) · [Amazon artist catalog](https://music.amazon.in/artists/B081JXB4XZ/23thierno) |
| 2024-09-24 | Playa | 23Thierno & Yauri GM | 2:40 | ℗© 23Thierno per indexed Amazon product. Buena Música describes afrobeats | Single and billing supported by storefront catalog evidence. Exact date, duration and rights provisional from indexed product metadata. [Amazon product](https://music.amazon.in/albums/B0DH7Q4PNG) · [Apple DO linked listing](https://music.apple.com/do/album/playa-single/1768906384) · [Buena Música coverage](https://www.buenamusica.com/noticias/23thierno-estrena-su-cancion-playa) |
| 2024-10-09 | Panas Falsos | 23Thierno | 2:34 | ℗© 23Thierno | Verified as listed on the opened Amazon product. Apple DO also lists it as a 2024 single. [Amazon](https://music.amazon.in/albums/B0DJK3QQ6X) · [Apple DO linked listing](https://music.apple.com/do/album/panas-falsos-single/1772459087) |
| 2024-11-10 | With "U" | 23Thierno | 3:30 | ℗© 23Thierno | Single and title styling appear in both catalog listings. Exact date, duration and rights provisional from indexed Amazon product metadata. [Amazon](https://music.amazon.es/albums/B0DMBVML99) · [Apple DO linked listing](https://music.apple.com/do/album/with-u-single/1778551569) |
| 2024 | Love It | 23Thierno & Yauri GM | — | — | Amazon's opened artist catalog supports the single, billing and year. Product fetch failed. Track program and recording metadata need direct verification. [Amazon artist catalog](https://music.amazon.in/artists/B081JXB4XZ/23thierno) · [Amazon product link](https://music.amazon.in/albums/B0DPRW6LX5) |
| 2025-01-25 | Baby You | Angel Fire, 23Thierno & Johcrap Marfer | 2:45 | ℗ 2025 HUMAN STARS COMPANY. Apple R&B/Soul | Opened Apple US release verifies the date, count and rights line. Amazon corroborates billing. MTS lists the exact duration. [Apple US](https://music.apple.com/us/album/baby-you-single/1792961106) · [Amazon artist catalog](https://music.amazon.in/artists/B081JXB4XZ/23thierno) · [MTS Music](https://music.mts.ru/artist/22822355) |
| 2025-02-28 | Monotonía | 23Thierno | 2:29 | ℗ 23Thierno. Amazon also lists © LLC Records INC. Apple Afrobeat | Date, single, billing and ℗ agree on opened Apple DO and Amazon pages. Preserve the separate © line. [Apple DO](https://music.apple.com/do/album/monoton%C3%ADa-single/1794635111) · [Amazon](https://music.amazon.in/albums/B0DW6BLN28) |
| 2025-06-14 | Mi Cocola | 23Thierno & FlowYeraldy | 2:44 | ℗© 23Thierno | Opened Amazon US product verifies these listed values. Apple DO lists the single. Amazon France has a second ASIN with matching indexed date, billing, track count, duration and rights. [Amazon US](https://music.amazon.com/albums/B0FCD2Y2Q9) · [Amazon France](https://music.amazon.fr/albums/B0FCD3CSK5) · [Apple DO linked listing](https://music.apple.com/do/album/mi-cocola-single/1819294948) |
| 2026-02-27 | Nena | 23Thierno | — | — | Opened Amazon artist page gives the exact date and single billing. Apple DO corroborates title, year and single classification. Direct product fetch failed. [Amazon artist catalog](https://music.amazon.in/artists/B081JXB4XZ/23thierno) · [Apple DO linked listing](https://music.apple.com/do/album/nena-single/1878492745) |

The Apple DO links marked “linked listing” were extracted from the opened [Monotonía product page](https://music.apple.com/do/album/monoton%C3%ADa-single/1794635111). Their individual page fetches failed. Indexed product metadata is marked provisional where direct confirmation failed.

## Titles awaiting release evidence

| Title as reported | Evidence and open question |
| --- | --- |
| Tú con él / Tu Con El | Reported by Buena Música and Songkick. Date, edition, audio and exact release spelling unresolved. |
| Desahogo Sad | Reported by both profiles. Date, edition and audio unresolved. |
| No Me Haces Falta | Songkick reports Johcrap Marfer as featured. Mangulina's [October biography audit snapshot](ten-bios-before-2026-10-30.json) places it in 2024. Original upload, edition, date and billing remain provisional. |
| Bandida | Reported by both profiles and attributed to 23THIERNO on Ouvir Música. Date, edition and audio unresolved. |
| No Me Ames | Attributed to 23THIERNO by Ouvir Música. Artist connection and release history need independent evidence. Keep separate from “No Me Haces Falta.” |

[Buena Música biography](https://www.buenamusica.com/23thierno/biografia) · [Songkick artist page](https://www.songkick.com/artists/10354872-23thierno) · [Ouvir Música artist page](https://www.ouvirmusica.com.br/23thierno/)

## Credits, versions and dependencies

- Propose release billing as printed above. Four singles bill 23Thierno alone, four bill him jointly, and “Le Jure” bills him as featured. Review recording-level performer roles against track credits or label metadata before encoding them. Verified track-specific authorship, production and arrangement credits remain unknown.
- Apple bills **Angel Fire** on “Baby You” and **Angi Fire** on “Le Jure.” Songkick instead mentions Angel Fire for “Le Jure.” Apple also shows a different release that names Angel Fire and Angi Fire together. Preserve both spellings and separate contributor identities pending better evidence. Preserve **Dj Human Star** as billed. [Baby You and Apple catalog context](https://music.apple.com/us/album/baby-you-single/1792961106) · [Le Jure](https://music.apple.com/us/album/le-jure-feat-23thierno-single/1850793544) · [Songkick](https://www.songkick.com/artists/10354872-23thierno)
- “Mi Cocola” is one release candidate pending UPC, audio and edition comparison across Amazon ASINs. Storefront-specific IDs alone do not establish a separate release or recording. No separate clean, remix, live, or video recording was verified.
- Dependencies for a future import include Yauri GM, Johcrap Marfer, FlowYeraldy, Angel Fire, Angi Fire and Dj Human Star. The [October editorial check](five-bio-format-spec-2026-10-30.md#23thierno) reported no credible Mangulina matches. Recheck their current identities before any association. Any edits to shared records require separate approval.

## Coverage and editorial disposition

- Apple Music DO and US and Amazon Music were the main storefront evidence. Apple artist ID `1488079178` comes from the 23Thierno link on Apple DO's Monotonía page. Amazon artist ASIN is `B081JXB4XZ`. iTunes lookup was unavailable. Apple and Amazon may share distributor metadata.
- Spotify, Deezer, MusicBrainz and Discogs exact-name searches yielded no usable artist or release match. Direct results pages could not be inspected. Their catalog coverage is unknown. The 2026-11-11 [Mangulina audit](artists-without-spotify-id-2026-11-11.txt) also lists the artist without a Spotify ID.
- YouTube's handle page returned a title with no usable upload list. The [August editorial log](../YOUTUBE_SUBSCRIBE_PROGRESS_2026-08-23.md) records that the editor disputed the handle. The October biography snapshot's “Baby You” video claim remains unverified. No exact YouTube Music or Topic recording URL was established. No audio was auditioned.
- Buena Música provides release coverage and biography leads. Songkick and Ouvir Música supply additional titles with limited provenance. Searches did not surface usable coverage in Dominican newspaper or music archive sources. No physical release or liner notes were inspected.
- Nine Release candidates, nine Recording candidates and nine Track appearance candidates, including the provisional “Love It” track program. Zero verified new Works or Work credits, zero proposed Release Groups, and zero proposed canonical Recording credits pending track-level evidence. The actual counts of Works, Release Groups and canonical Recording credits are unknown. Five further titles are held as leads.
- Before any import, reconcile possible unlinked matches, verify exact edition and audio metadata, obtain UPC/ISRC where available, confirm official artwork, and map each recording's genre and applicable subgenre to the current taxonomy. Release billing associations require editorial review of identities and scope. Track and edition destinations should be checked against the exact recording. Catalog writes require approval of the actual manifest under [the discography protocol](../../discography.md#7-review-gates).
- Only this report was created. Production access was limited to scoped Supabase reads. No Mangulina production site requests, refreshes or deployments. No database, application code or music data changed.

## Import preflight after editorial approval

The editor approved applying the manifest on 2026-11-11. The scoped exact-title check returned no matching Release rows. Three Recording titles collide with recordings assigned to other performers: “Nena” by Aramis Camilo (`781cda6a-2520-4df4-a3e4-f81dda1b0df4`), “Playa” by Mula (`5a4fbc4e-2934-4d09-91ca-b0eaffb5021a`), and “Baby You” by Poeta Callejero (`be64b650-a4b9-4b2f-9dc7-4821efd542ad`). There is no evidence to reuse those recordings. The six collaborator names returned no exact matches in `artists`.

The genre check found the active Urban category (`10`). It did not identify a direct Afrobeat or R&B match, and the profile's broad genre is insufficient to assign the same classification across all nine tracks. Official artwork thumbnails are visible in storefront listings. The high-resolution originals have not been retrieved and verified for the storage pipeline. The approved manifest still lacks required recording genre assignments and verified original artwork. No import was applied.

## Apple edition verification, 2026-11-12

The Dominican iTunes lookup returned all nine collections and all nine tracks, one per collection. It confirmed every date above and resolved “Love It” to **2024-12-09**. The 23Thierno artist ID is `1488079178`. The values below supersede provisional program and duration fields. Apple's track title for “Le Jure” includes “(feat. 23Thierno)”; retain that literal value as source metadata and preserve Amazon's shorter title evidence. [Apple artist](https://music.apple.com/do/artist/23thierno/1488079178) · [Dominican iTunes release lookup](https://itunes.apple.com/lookup?id=1488079178&entity=album&country=DO&limit=200)

| Title | Apple collection / track ID | Duration (ms) | Apple genre | Mangulina proposal |
| --- | --- | ---: | --- | --- |
| Le Jure | 1850793544 / 1850793549 | 168043 | R&B/Soul | Hold. No direct category and lead billing identities unresolved. |
| Playa | 1768906384 / 1768906387 | 159600 | Músicas del mundo | Hold. Buena Música describes tropical Afrobeats, supporting Fusion / Afro-Caribbean (`12/54`) as a possible editorial classification. |
| Panas Falsos | 1772459087 / 1772459088 | 153480 | Americana | Hold. No corresponding taxonomy category. Seek track-level evidence before mapping. |
| With "U" | 1778551569 / 1778551570 | 209577 | Electrónica | Electronic (`56`). |
| Love It | 1836725383 / 1836725384 | 225341 | Electrónica | Electronic (`56`). Preserve the co-billing for Yauri GM as sourced text pending identity resolution. |
| Baby You | 1792961106 / 1792961107 | 165405 | R&B/Soul | Hold. No direct category and co-billing identities unresolved. |
| Monotonía | 1794635111 / 1794635112 | 148800 | Afrobeat | Hold for editorial decision on whether Fusion / Afro-Caribbean (`12/54`) applies. |
| Mi Cocola | 1819294948 / 1819294949 | 164302 | Afrobeat | Hold for the same classification decision and co-billing identity review. |
| Nena | 1878492745 / 1878492748 | 139806 | Hip-hop | Urban / Rap-Hip Hop (`10/43`). |

The edition artwork linked by iTunes was retrieved at 3000 × 3000. Sharp decoded all nine JPEGs and verified 18 WebP variants at 150 × 150 and 300 × 300. Source lookup payloads and staged artwork are local in [23thierno-preflight](../../../23thierno-preflight/). No storage uploads were made.

The prior approval covers applying the catalog manifest. Public visibility is a separate gate under the repository protocol. `releases.status` describes the edition and offers no editorial draft state. Mangulina's song-directory projection uses the owning artist's published status for recordings without a published Work, so writing the proposed recordings would expose them to the public catalog. A partial public batch would create three Releases, three Recordings and three Track placements with the values above and use the existing artist UUID. Before public entry, explicitly authorize that batch or the eventual full set. No database, application code, music data, or production storage changed in this continuation.

## Applied public batch, 2026-11-12

The editor explicitly approved public entry for the three singles below. The artist-scoped baseline had zero owned release and recording rows. A rolled-back rehearsal passed before the guarded import committed all nine new rows in a single database transaction.

| Single | Release UUID | Recording UUID | Track UUID |
| --- | --- | --- | --- |
+| Nena | `e9a8c231-38b0-4de5-8c51-001878492745` | `e9a8c232-38b0-4de5-8c51-001878492745` | `e9a8c233-38b0-4de5-8c51-001878492745` |
| With "U" | `e9a8c231-38b0-4de5-8c51-001778551569` | `e9a8c232-38b0-4de5-8c51-001778551569` | `e9a8c233-38b0-4de5-8c51-001778551569` |
| Love It | `e9a8c231-38b0-4de5-8c51-001836725383` | `e9a8c232-38b0-4de5-8c51-001836725383` | `e9a8c233-38b0-4de5-8c51-001836725383` |

Each Release was created as an Official single, with the date above and `has_cover_image=true`. Each Recording uses the duration and genre mapping in the Apple verification table. Each Track is disc 1, position 1. Apple IDs, source URLs and literal artist billing are recorded in Release and Recording metadata. “Love It” retains Yauri GM in that billing text while the canonical collaborator identity awaits verification. The batch created zero Works, Release Groups or canonical credit rows.

For each Release UUID the original JPEG and both WebP variants were uploaded to the established storage paths and retrieved byte-for-byte. The production database readback confirmed three Releases, three Recordings, three Track placements and three matches in the public song projection. Both English and Spanish public artist profile responses contained all three titles. The checks used two artist page requests and no deployment or manual cache refresh. The remaining six singles and five leads are pending editorial review.
