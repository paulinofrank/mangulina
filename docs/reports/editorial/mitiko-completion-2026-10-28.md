# Mítiko — profile creation completed (28 October 2026)

## Database change

| Record | Before | After |
| --- | --- | --- |
| `artists` `648cd724-dccf-4174-8d13-18b9cfd0ce1e` | Absent | Mítiko (`mitiko`), `solo_artist`, `draft`; personal name José Julio Bello Castillo; male; born in Santo Domingo in 1987; primary role `musician`, instrument `guitar`, other occupations `guitarist`, `composer`, `lyricist`, `producer`; primary genre `fusion`, other genre `bachata`; tag `secular`. |
| `editorial_documents` EN `b20736f2-e6a3-4a4c-94df-c88e31f65b32` | Absent | English artist biography, `published`, revision 1. |
| `editorial_documents` ES `12433f83-6c84-4b1f-859b-31ade027b65c` | Absent | Spanish artist biography, `published`, revision 1. |
| `editorial_entity_references` | No Mítiko biography relations | 12 occurrence relations from the two new biographies to four already published artists. |

No other artist, biography, discography, music-credit, relationship, media, schema, security or publication-state record was changed.

## Verification

- The pre-write duplicate check found no Mítiko record. The similarly named catalog artist José Bello is José Manuel Bello Suazo and was not reused.
- After saving, all artist values matched the frozen manifest; both documents matched the prepared content, were published at revision 1, and passed structured-document validation.
- Editorial integrity returned `blocking=0`, `warning=0`, `informational=0`. All 12 references have matching relation rows and published targets. `genres` does not repeat `primary_genre`; `occupations` does not repeat `primary_role`.
- Reloading the [Mangulina artist admin](https://mangulina.do/admin/artists) and selecting Mítiko showed the saved personal-name fields, 1987, Santo Domingo, male, musician, guitar, fusion, bachata, secular and draft status. The editor showed Spanish and English biographies as **published · revision 1** and rendered the linked artist names in the text.
- One targeted `POST /api/revalidate` request for `artists:["mitiko"]` returned HTTP 200 and `revalidated.artists=1`, `allArtists=false`. The public draft URL was not requested.

## Files created

- `mitiko-research-2026-10-28.md`: source and field evidence, exclusions and backward-link audit.
- `mitiko-profile-content.json`: bilingual source copy and form-compatible artist fields.
- `mitiko-profile-manifest.json`: frozen, pre-write after state, document JSON and reference targets.
- `mitiko-create-profile.ts`: prepare, execute and verify procedure used for this one artist.
- `mitiko-saved-verification.json`: saved row, documents, reference rows and integrity result.
- `mitiko-admin-facts.png`, `mitiko-admin-classification.png`, `mitiko-admin-biography-es.png`, `mitiko-admin-biography-body.png`: visual verification from the saved admin record.

## Open items

The source establishes the birth **year and city**, but not a complete date or the province selection. There is no verified active individual social handle, Spotify artist ID, or licensed individual portrait. Band social accounts were not copied to his individual record. No personal discography was imported.

The published Los Sufridos biography documents EN `b721d349-ea2e-4f18-9652-e3b5148073d5` and ES `4cf3dbc5-912a-4507-8f22-40b43cff3552` each contain two plain-text Mítiko mentions. They were left as text because they belong to another public artist and a link to Mítiko's draft page would yield a 404. Revisiting those mentions belongs with later authorization to publish Mítiko's artist record and update Los Sufridos' public biographies.

Primary sources and corrections are linked in the research report. In particular, the [Centro Cultural de España](https://ccesd.aecid.es/w/seis-d%C3%A9cadas-de-amargue-origen-y-evoluci%C3%B3n-de-la-bachata-1) supplies Santo Domingo and 1987, while [DISCOLAI](https://discolai.com/2019/03/08/melancolia-tropical-y-el-subelo-mawon-que-resuena-en-el-timpano/) and [Apple Music](https://music.apple.com/co/album/melancolia-tropical-single/1454848328) establish «Melancolia Tropical» as a single rather than an album.
