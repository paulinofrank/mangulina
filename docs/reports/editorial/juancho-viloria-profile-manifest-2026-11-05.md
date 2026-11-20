# Juancho Viloria — profile creation manifest (2026-11-05)

Scope: new profile for the Wilfrido Vargas trumpeter and singer Juan José Viloria Villamán. Create one draft artist and published Spanish and English biography documents. No release, recording, track, credit, media, relationship, or other artist changes are authorized.

## Identity check

The only existing Viloria artist is Ángel Viloria y su Conjunto Típico Cibaeño (`c6551ff1-ed33-4191-9c51-f89eec7d2be9`), a distinct historical act. A later típico conga player also called Guancho Viloria is not merged into this profile. Search of `public.artists` found no Juancho Viloria row.

## Proposed new artist fields

| Field | Before | Proposed | Basis |
| --- | --- | --- | --- |
| name / stage_name | absent | Juancho Viloria | Wilfrido discography, 2026 press and interviews |
| slug / status | absent | `juancho-viloria` / `draft` | profile workflow |
| personal names | absent | Juan / José / Viloria / Villamán | 2026 press and supplied research sheet citing Discogs/sleeves |
| type / gender | absent | `solo_artist` / `male` | individual musician; male identification in contemporary coverage |
| primary_role / occupations | absent | `musician` / singer, bandleader, composer | sleeve credits and press; do not duplicate primary role |
| instruments | absent | trumpet, voice | sleeve and Fania credits |
| primary_genre / genres | absent | merengue / empty | documented repertoire; no extra genre established |
| artist_tags | absent | secular, christian | documented commercial merengue and later congregational music; classification concerns repertoire |
| date_of_birth, birth_year, birth_place, province | absent | null | precise birth data and birthplace not sufficiently corroborated |
| socials, Spotify, image | absent | null / no image | no unambiguous official account, Spotify ID, or reusable portrait supplied |

## Biographical evidence and boundaries

- Fania's [«Reventó» album page](https://fania.com/record/revento/) specifically credits Juancho's chorus on Héctor Lavoe's «Por Qué No Puedo Ser Feliz» (1985).
- [La Nación Dominicana](https://lanaciondominicana.com/noticia/juancho-viloria-trompetista-y-corista-clave-de-wilfrido-vargas-y-sus-beduinos/124709/) identifies his full name, trumpeter/singer role, Wilfrido years, own orchestra, Yoskar Sarante and later Christian ministry. Its precise 2001 transition is single-source and should be phrased cautiously.
- [Telenord](https://www.telenord.com.do/secciones/deportes-2/38566-yoskar-sarante-el-bachatero-que-revive-gracias-al-lazaro-amor-a-medio-tiempo.html) independently places Yoskar at the front of Juancho's group.
- The supplied research sheet identifies Fania LP «Juancho y Miguelito» (JM 618), 1982, from sleeve research; [a separate physical-disc catalog](https://salsamixmax.blogspot.com/2014/01/lp-i-j.html) confirms title, label and catalog number. Its 1982 date is consistent with that catalog but another Fania discography lists 1983, so the biography will say early 1980s.
- [Joseph Cáceres' 2012 reader correspondence](https://merengala.blogspot.com/2012/06/0-false-18-pt-18-pt-0-0-false-false_03.html) documents recognition of his Wilfrido role and Christian singing by 2012. Reader comments are not used as proof of detailed career chronology.
- The supplied research sheet's sleeve-level guest writer credits, 1974 entry detail, birthplace, parents, 'absolute pitch' explanation, and departure narrative are research leads. They are not needed in the biography until independently checked at source level.

## Backward-reference audit

Nine published biography documents currently mention Juancho/Guancho: Alberto Plata (EN/ES), Los Beduinos (EN/ES), Sony Ovalles (EN/ES), Wilfrido Vargas (EN/ES), and Yoskar Sarante (EN/ES) — ten documents total. These belong to five other artists. Each mention needs contextual identity review and a separately authorized shared-record edit before conversion to `artistReference`. This manifest does not authorize those edits. The Alberto Plata wording raises a chronology question and requires special review.

No discography import is included. All Work, Recording, Release, Release Group, Track and credit write counts: zero.

## Execution and verification

Created `public.artists.id = f6fe1fc3-620d-41ba-825d-5cc67c10468e` with `status = draft`. Created two `artist_biography` documents: ES `70ad3991-1fdf-4ca7-b14c-9397c5ffdc79`, EN `72f6b71a-3006-469a-8b65-4c4f51df3b3c`; both `status = published`, `revision = 1`. Each document has nine blocks and six artist reference nodes, with six matching relationship rows. The profile stores `genres = []` and occupations excluding the primary `musician` role. No Spotify/social IDs, image, birth date or birthplace were invented.

Both documents passed `public.validate_editorial_document_v1` before the write. A single database transaction created the artist and documents and asserted both document statuses. A post-write query confirmed fields, statuses and reference counts. The admin editor visually displayed Juancho as DRAFT, the stored name components, role, instruments, tags and genre, and both language documents as published revision 1. The public draft URL was not opened. No deployment or cache refresh was performed.

The ten backward mentions in five other artists' published biographies remain unlinked pending separate scope approval. No other artist rows or documents were changed. No relationship row with Los Beduinos was created because it would affect the shared group record. Interview media links and discography are research leads, not imported in this profile task.
