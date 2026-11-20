# Tony Medrano — profile execution manifest

**Date:** 2026-11-01  
**Scope:** New Tony Medrano artist profile and English/Spanish structured biographies.  
**Artist UUID:** `2543dade-e7a7-4e7a-9261-31a82d265fca`  
**Slug:** `tony-medrano`

## Authorization and limits

The editor supplied a Tony Medrano bio/life sheet for Mangulina. This execution created the artist profile as a draft and published its completed English and Spanish biography documents, as permitted by the artist-profile workflow. It did not publish the artist profile, import discography, upload an image, create structured membership with Los Hijos del Rey, or edit any other artist's record. No Supabase security settings, application code, or deployment were changed.

## Artist fields saved and verified in the admin form

| Field | Saved value | Evidence / decision |
|---|---|---|
| Name / Stage Name | Tony Medrano | Supplied sheet and releases; alternate documented billings retained as aliases |
| Sort name | Medrano, Tony | Form-compatible sort order |
| Slug | `tony-medrano` | New profile route slug |
| Aliases | `Thony Medrano; Tony Thony` | Sheet and 1988 / 1991 / 1996 release billings as summarized in the supplied report |
| Disambiguation | Dominican merengue singer from Baní | Distinguishes from unrelated namesakes |
| Personal-name fields | Empty | No reliable source in the supplied material establishes a legal full name; specifically excluded “Antonio Medrano” namesake |
| Gender | Male | Explicitly established in the supplied biographical research |
| Birthplace / Province | Baní / Peravia | Supplied report; Baní origin also corroborated in press and specialist sources |
| Date of birth / birth year | Empty | 3 November 1964 is marked provisional in the supplied sheet and comes from one specialist source; not treated as verified |
| Artist type | Solo Artist | Individual performer |
| Primary role | Singer | Form selector |
| Primary genre | Merengue | Supplied sheet and career/repertoire evidence |
| Additional genres / occupations | Empty | No additional values verified for this form |
| Instruments | Voice | Form selector |
| Tag | Secular | Repertoire classification |
| Spotify artist ID / social handles / website | Empty | No official matching account/ID was verified; do not populate candidates |
| Image | None | Supplied path `~/workspace/mangulina-artist-photos/thony-medrano-pick.jpg` was not present in the accessible attachment folder or checked Mangulina workspace locations |

## Biography documents

Both structured documents are saved as **published** while the artist remains **draft**, as required for a completed new profile.

| Locale | Status | Revision shown in admin |
|---|---|---:|
| English | Published | 4 |
| Spanish | Published | 4 |

The biographies identify Baní and the documented career path, distinguish the 1988 *Thony Medrano y Los Hijos del Rey* release by its billing rather than assert membership in a standing lineup, and place the conflicting «Viejo Año» release in the mid-1980s without assigning a composer whose attribution is disputed. They do not print the provisional birth date or an unverified full name. Catalog artists already named in the biographies are linked where verified; Orquesta Armonía and Orquesta Liberación remain plain text because no matching catalog rows were established during the editing session.

Each document was first published at revision 2. The date/composer corrections were saved as draft revision 3 and then published as revision 4; there is still one structured document per locale, not duplicate biography records.

## Research sources

- [Diario Libre — Tony Medrano regresa con nuevos temas](https://www.diariolibre.com/revista/tony-medrano-regresa-con-nuevos-temas-IB8641468): identifies him as a singer from Baní; covers his return, «Viejo Año», and «Yemayá» dedicated to Baní.
- [El Caribe — Tony Medrano se pone en salsa y merengue](https://www.elcaribe.com.do/gente/a-y-e/tony-medrano-se-pone-en-salsa-y-merengue/): corroborates his Baní roots and 2017 recording activity.
- [El Musicam — Tony Medrano profile and release history](https://elmusicam.blogspot.com/2018/10/esta-es-la-caratula-classica-del-mes_27.html): detailed career and release account, used with caution; the exact birth date is single-source/provisional.
- [Picoteando el Espectáculo — interview with Osiris Romero](https://picoteandoelespectaculo.blogspot.com/2020/11/el-merenguero-thony-medrano-reconoce.html): summarizes Medrano's account of leaving July Mateo “Rasputín”'s orchestra during an international tour and later regarding it as a youthful mistake.
- [El Nacional — history behind «Viejo Año»](https://elnacional.com.do/la-historia-detras-del-clasico-viejo-ano/): retrospective account of the merengue recording and its history; dates reported for its release vary across sources.
- [MusicBase — *Thony Medrano y Los Hijos del Rey*](https://musicbase.net/thony-medrano-y-los-hijos-del-rey-1sjh7pd): release billing and track list for the 1988 Karen Records LP.
- [Baní 2023 patronales program](https://fliphtml5.com/thylu/hpyc/Programa_Patronales_Ban%C3%AD_2023/6/) and [Baní 2025 patronales announcement](https://peraviavision.tv/2025/11/06/noticias/locales-noticias/comite-de-fiestas-patronales-bani-2025-y-alcaldia-municipal-anuncian-cartelera-artistica/): event listings only; biographies say he was listed/scheduled, not that the appearances were completed.

The attachment refers to separate `research-report.md` and `research-notes.md` files, but only `Pasted text.txt` was available in the supplied attachment folder. The claims unique to those missing files were not elevated beyond what the accessible sheet and sources support.

## Reciprocal-reference audit — pending authorization

The published Los Hijos del Rey biographies contain a verified plain-text mention of the 1988 Karen Records billing **“Thony Medrano y Los Hijos del Rey”**. The mention is contextual and refers to the same artist. It is not an `artistReference` in either locale:

| Owner artist | Owner UUID | Locale | Revision | Exact mention | Proposed change |
|---|---|---|---:|---|---|
| Los Hijos del Rey | `3c82ee60-d565-405d-8423-7895d3706122` | English | 5 | `Thony Medrano y Los Hijos del Rey` | Link only `Thony Medrano` to Tony Medrano using the canonical display name `Tony Medrano`; preserve the album billing in surrounding prose as appropriate |
| Los Hijos del Rey | `3c82ee60-d565-405d-8423-7895d3706122` | Spanish | 3 | `Thony Medrano y Los Hijos del Rey` | Same targeted reference repair |

The admin editor did not expose the two document UUIDs in its accessible state. These are shared changes to another published artist's biographies and were not made under the new-profile scope. Obtain the editor's explicit authorization for those exact two document updates, then record their UUIDs and resulting revisions before editing.

## Verification performed

- Selected the saved Tony Medrano record again in the admin form; confirmed its UUID in the selector, draft status, birthplace/province, male gender, solo-artist type, singer role, merengue primary genre, voice instrument, secular tag, empty extra genres, and blank date/Spotify/social fields.
- Opened the structured biography editor after reloading and confirmed English revision 2 and Spanish revision 2 are both published and contain the intended text and artist references.
- Read the published Los Hijos del Rey pages in both locales and confirmed the relevant mention appears as plain text; read the admin editor to record owner UUID and document revisions.
- No public Tony profile route was opened; no profile publication, discography import, manual cache refresh, site deployment, or broad production verification was performed.

