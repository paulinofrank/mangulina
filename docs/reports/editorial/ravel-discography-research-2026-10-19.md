# Ravel — discography research and proposed first batch

Date: 2026-10-19. Artist UUID: dacae9ad-a2cd-4d80-9404-123e775642cf. Research by Codex using public catalog pages, browser inspection, physical sleeve/label photographs and targeted read-only Mangulina inventory. Authorization: research and proposal; no import approved in this task.

## Findings proposed for editorial review

| Proposed edition | Date precision | Label / catalog | Tracks | Cover |
| --- | --- | --- | --- | --- |
| Con sentimiento, Venezuelan vinyl LP | 1992, year only | Orbe 604576 | 9 | Sleeve photograph |
| Llego El Tipo!! Por Siaca!!, CD | 1994, year proposed | Camino Records 317 | 10 | Catalog artwork |
| Alma Ritmo Y Pueblo, CD | 1997, year proposed | Merengazo Records / RMM 82150 | 10 | Catalog artwork |
| La mujer de mi vida, CD | 1999, year proposed | Merengazo Records / RMM 82299 | 8 | Catalog artwork |
| Como Tu Lo Querias, digital manifestation | 1999 supplier year | LF Productions; Amazon B09C19XLL2 | 10 | DSP artwork with Camino branding |

First batch: 5 proposed Releases, 47 Track appearances and 47 proposed Recording candidates, 5 covers. No Works or Release Groups proposed. No canonical contributor-credit writes proposed; literal credits retained for identity/scope review. Final Recording count remains subject to identity checks before import. Sixth album Mejor Que Nunca (2000) has a further 10 documented tracks and a sixth cover, but is held for version/credit review. This is a researched first batch, not a complete career discography.

Machine-readable field-level proposal: ravel-discography-manifest.json. It contains before=null for proposed releases, edition facts, evidence references, ordered programs, durations, source composer labels, album personnel lists, cover provenance and SHA-256 hashes, exclusions and execution constraints. No permanent catalog UUIDs fabricated.

## Primary physical evidence

Source: https://www.ebay.com/itm/115352876658 . The listing's current photographs were opened and downloaded; no purchase or seller contact. Actual images, rather than the seller's title alone, establish Orbe catalog 604576, Venezuela and printed ℗ 1992. Side labels establish A1–A5/B1–B4 order and literal writers/arrangers. Files: ravel-covers/con-sentimiento-0.webp (front), -1.webp (rear), -2.webp (side A), -3.webp (side B). The release metadata and image URLs are preserved in ravel-con-sentimiento-ebay.json; checksums in ravel-covers/manifest.json.

| Side | Title | Writer exactly credited on label | Arranger exactly credited |
| --- | --- | --- | --- |
| A1 | Bella Bella | Charlie Mosquea | Jaime Querol |
| A2 | Bailar Pegado | Autor No Identificado | Juan Valdez |
| A3 | Pa’ Mi Fieston | Confesor Rosario | Jaime Querol |
| A4 | Por No Hablar Por Hablar | Canela | Sandy Jorge |
| A5 | Parece Que Estoy Enamorado | Ravel | Juan Valdez |
| B1 | No Basta | Franco de Vita | Henry Hierro |
| B2 | Ella Quiere Que La’priete | Polo Tovar | Jaime Querol |
| B3 | Mi Carrito | Carlos Araujo | Ramón Orlando |
| B4 | Ven Apagame | Rento Arias | Juan Valdez |

Label statement: “Producción Musical de Ravel para Juan & Nelson. Lic. J&N Records, Corp. New York.” A2 sleeve uses D.R.; neither wording supplies a writer identity. Other sleeve musician, engineering, studio, design and production credits remain preserved photographically pending careful transcription and identity review. Source spellings such as Querol and Rento Arias are not silently matched to similarly named artists. Printed durations differ slightly from DSP timings and remain separate assertions.

## Directly inspected catalog evidence

- https://www.allmusic.com/album/llego-el-tipo%21%21-por-siaca%21%21-mw0001884987 : full ten-track sequence, composer labels, album personnel, Camino 317 CD, supplier date October 11, 1994, artwork. Browser succeeded where web reader failed.
- https://www.allmusic.com/album/alma-ritmo-y-pueblo-mw0000593199 : ten-track program, album personnel, supplier date April 22, 1997, CD Merengazo/RMM 82150 and separate cassette edition, artwork. Only CD proposed.
- https://www.allmusic.com/album/mujer-de-mi-vida-mw0000049247 : eight-track program, personnel, 1999 CD Merengazo/RMM 82299, artwork. Cover explicitly says La mujer de mi vida; shortened supplier title preserved as source_title.
- https://www.allmusic.com/album/mejor-que-nunca-mw0000618954 : ten-track program, personnel, 2000 CD Merengazo/RMM 284083, artwork. Held, not imported.
- https://www.allmusic.com/album/como-tu-lo-querias-mw0000996042 : 1994 CD Camino 1234, supplier October 12, 1994. No tracklist and only placeholder cover on that page. This edition is held separately.
- https://music.amazon.in/albums/B09C19XLL2 : inspected ten tracks, durations and ℗© 1999 LF Productions. Browser artwork retrieved and visually checked. Catalog January 1, 1999 is not treated as an established original-release day. Physical Camino 1994 and digital 1999 are not collapsed into one edition.
- https://www.allmusic.com/album/con-sentimiento-mw0000991752 : 1993 Jn Records 746 CD with supplier July 21, 1993. No program/cover available there; held separately from photographed 1992 LP.
- https://www.allmusic.com/album/no-basta-mw0001083448 : 1991 12-inch single, Jn Records 740; complete side/program and artwork unavailable.
- https://www.allmusic.com/album/la-mazorca-mw0001087819 : 1991 12-inch single, Jn Records 556; complete side/program and artwork unavailable. Neither single is misclassified as an album.

AllMusic browser captures and covers: ravel-allmusic-evidence.json and ravel-covers/manifest.json. Browser sections were opened separately because collapsing panels can hide their contents. Full dates remain supplier assertions rather than fabricated original-release precision.

## Title, credit and identity issues

1. Alma catalog renders “Amiga del Alama” and “Si Entenderias”; a separately opened discographic program at https://fevmusical.blogspot.com/2017/05/1997-ravel-alma-ritmo-y-pueblo-merengazo.html gives “Amiga Del Alma” and “Si Entendieras”. Literal variants remain in the manifest for editorial review. Do not silently promote likely supplier typos into settled canonical titles.
2. Mujer includes a medley whose supplier title has encoding artifacts “TÝ” / “RazÛn”. Manifest preserves literal text and a proposed character repair, requiring review. “Public Domain” is not an identified composer. Component Work links are not proposed.
3. Mejor Que Nunca track 5 is “Amiga del Alma”, 4:49; Alma has the similarly titled track at 4:34. Duration/title do not establish whether these are the same performance, rerecording, edit or metadata discrepancy. Hold until version evidence resolves identity.
4. Mejor personnel list incorrectly appears to label Crispin Fernández and Luisín del Rosario with vocal alto/tenor roles. A commercial personnel description instead describes tenor instruments, but this is insufficient for automatic correction; retain literal sources and do not import those roles.
5. Composer labels for track-specific claims remain distinct from broad album contributor lists. Do not spread every arranger, musician or producer across all tracks. Do not turn “D.R.” or “Public Domain” into an artist. Do not infer identities for G. Ravel, Carlos, Geremias, Abelito or other abbreviated names.
6. Provider artist catalogs also contain classical and Brazilian/gospel homonyms. Quimeras, Terra, Sonhos De Deus, O Melhor de 2 and unrelated releases are excluded from the proposed batch unless independently tied to this merenguero.

## Recent digital leads and access limits

Apple indexed pages describe 2025 “Sus Mas Grandes Existos” (12 tracks, GREGORI COMPANY MUSIC), “QUE ES LO QUE TU ME STA” (8 tracks, RAVEL MUSIC), “MERENGUE CALIENTE” EP (6 tracks) and “AY PENA PENITA PENA” single. Public live browser for https://music.apple.com/us/album/que-es-lo-que-tu-me-sta/1808309604 returned page not found; public iTunes lookup returned no album objects for all four IDs. Cached/indexed descriptions alone were not used to manufacture complete programs. All four remain discovery leads, not proposed imports.

Search also found contemporary Billboard/RMM advertisements for Alma and La mujer de mi vida, but web reader returned 403 and browser PDF exposed no extractable text during this run. These are leads, not claimed inspected corroboration:
https://www.worldradiohistory.com/Archive-All-Music/Billboard/90s/1997/Billboard-1997-10-25-B.pdf
https://www.worldradiohistory.com/Archive-All-Music/Billboard/90s/1999/BB-1999-06-26.pdf

The artist's autobiographical post mentions album number 18 and other productions; this is not proof that 18 independently identified editions have been accounted for. Early Los Reyes del Caribe / Los Bravos recordings, the Loko Records production and the 2021 album remain research gaps. Various-artists compilations and collaborations are not imported as full artist-led albums or altered as shared records.

## Inventory and checks

Targeted database inventory: zero releases through release_artists, zero direct recordings, zero recording_credits for the target artist. Artist name/stage-name search found only Ravel UUID above. Exact/normalized release-title candidate search for the scoped albums found none. No claim of a catalog-wide fuzzy duplicate audit. Before any execution, refresh identity and relation checks and abort on changes.

Builder checks passed: 5 releases, 47 ordered track appearances, all five proposed covers downloaded with hashes, and complete expected track counts (9/10/10/8/10). Six album artworks were visually inspected including the held Mejor Que Nunca. Existing Works/Recordings are not matched by title, duration or provider IDs alone.

No database, biographies, artist fields, music data, application code, security or publication states changed. Only local research files and cover evidence were created. Production access was limited to read-only Supabase inventory; no Mangulina page crawl, deployment or cache refresh.

Approval pending under docs/discography.md Gate B: review the five-release/47-appearance manifest and its title corrections/credit limitations before catalog writes. Held editions are explicitly excluded.
