# Dhariana — discography research and proposed import

20October2026 · Codex · Artist UUID `00652f5d-1e5f-436a-b12a-7e309a3deebc`.

Research and proposal only. No database, application code, biographies, music data, publication state or storage objects changed. Local evidence and proposal files created. Artist is now published in the live read-only inventory; preserve that independently changed state. Scoped inventory: zero artist recordings, zero release billing relations, zero Track appearances. Two preliminary inventory queries failed because releases has no artist_id; corrected relational inventory returned the counts above. No hidden assertion of a successful failed query.

## Concrete proposed batch

Frozen manifest: `dhariana-discography-manifest.json`. All22 Recordings,22 Tracks and6 Releases have proposed UUIDs and before=null. Six primary billing relations and six covers proposed. No Works, ReleaseGroups, contributor profiles or canonical contributor-credit rows in this batch. Every observed contributor credit is retained literally with source context; canonical identity/scope resolution is deferred rather than guessed. Refresh duplicate and shared-record preconditions before approved execution.

| Edition | Date supported | Category | Tracks |
|---|---|---|---:|
| Ven A Amarme, Top Hits TH-AMF2372, US LP |1985, year precision|Album|8|
| Señora de Nadie - Éxitos Salsa y Merengue,3513466 Records DK|2023-03-19 digital edition|Compilation|10|
| Mal Amante|2023-05-12 digital edition|Single|1|
| Emocion|2025-03-15 digital edition|Single|1|
| No te quejes|2025-03-15 digital edition|Single|1|
| Señor Amargura|2025-09-21 digital edition|Single|1|

Digital edition dates do not establish original composition, session or first song release. Apple preserves2022-03-04 at Emocion track level while the selected collection is2025; retain both assertions. The originalLP eight performances are not linked to digital recordings or platforms without exact-version evidence. Proposed durations are null for the LP; no borrowed digital timings.

## LP: directly inspected physical scans

https://www.discogs.com/release/15381162-Dhariana-Ven-A-Amarme

Chrome succeeded where the web reader could not access Discogs. Downloaded and visually read all four scans: front, rear and both labels. Label ℗1985, Top Hits, TH-AMF2372,33⅓RPM stereo. Manufactured/distributed by TH Records & Tapes, Inc.; production Promo-Arte. Author credits are printed parenthetically on labels, with no split between composer and lyricist. Preserve literal names and variants.

|Position|Sleeve title|Author printed on sleeve|Arrangement|
|---|---|---|---|
|A1|No Puedo Mas No|Anthony Rios|Manuel Tejada|
|A2|Se Hace Pedazos|Carlos Baez Brugal|Manuel Tejada|
|A3|A Esa|Marisela Tavares|Manuel Tejada|
|A4|Porque No Olvidas Tu Olvido|Carlos Baez Brugal|Bertico Sosa|
|B1|Cuando|Marisela Tavares|Manuel Tejada|
|B2|Que Casa Es Esta|Carlos Baez Brugal|Manuel Tejada|
|B3|Ven A Amarme|Marisela Tavares|Manuel Tejada|
|B4|Dimelo Tu|Dhariana|Bertico Sosa|

Discogs incorrectly transcribes B1 as Guano; both sleeve and label read Cuando. Label A2 says Se Hace Pedazo; sleeve plural preserved as proposed title. Label abbreviates Carlos B. Brugal. Do not infer that digital same-title recordings are identical or transfer these credits to them automatically.

Rear credits: musical direction Manuel Tejada; recording studio EMCA—Santo Domingo; engineers July Ruiz and Salvador Morales; mix Salvador Morales; art/design/photography Julio Méndez and Diana Mena; a Promo-Arte production for TH Records. Barcode digits not confidently transcribed; no invented barcode.

## Digital credits and program

Every one of the33 digital track appearances was opened through Spotify’s View credits. Files `dhariana-exitos-credits.json`, `dhariana-senora-credits.json` and `dhariana-single-spotify.json` retain relevant credit-dialog text. These are provider assertions, not independently verified personal identities. No Studio Personnel role silently converted to engineer/producer. Do not normalize name variants into a person by spelling alone.

Señora de Nadie program in order; Spotify calls each listed person both Lyricist and Composer:

1. Si tienes otra Mujer — Geraldo Hernandez.
2. Te Alimente — Jose Portorreal.
3. Porque contigo No — WILLIAM CRUZ.
4. Y que paso contigo — Rosa Padron.
5. Cachondeando — Jose Portorreal.
6. Mama ese es el Ladron — Mercedes Arelis Reynoso.
7. Es Mejor dejarlo Asi — Charlie Mosquea.
8. Cínico — Antonio Lopez.
9. Todo Miel — Jose Portorreal.
10. Señora de Nadie — Rosa Padron.

Apple title punctuation/accent variants and exact millisecond durations are preserved per track in the manifest. No automatic spelling rewrite of source assertions.

Singles:

- Mal Amante: Alicia Baroni—Lyricist; Dioni Fernández—Composer.
- No te quejes and Emocion: Mercedes Arelis Reynoso—Lyricist/Composer; Dhariana la coqueta—Studio Personnel; Jose Portorreal—Studio Producer.
- Señor Amargura: Daniel Vazques Pichardo—Composer; Massiel Portorreal—Lyricist and Vocal Engineer; Dhariana la coqueta—Studio Personnel.

No canonical mapping from Dioni Fernández to the group Dioni Fernández y El Equipo. No inference that Mercedes Arelis Reynoso is Dhariana’s personal name based on songwriting credits.

## Held material and source conflicts

- Exitos:19 tracks, cover retained, https://open.spotify.com/album/1FN8n7dwAq6k6Bez99Emf3 . Provider displays1985-04-16 but ℗/©2021; program includes Los Caminos del Mar, introduced in2017. Cannot assign1985 to the full digital product. Exact release date remains unresolved, not automatically replaced with2021. DistroKid’s own product link https://distrokid.com/hyperfollow/dharianalacoqueta1/exitos points to this Spotify release, Apple1599235699 (lookup currently empty) and Deezer278633742. Six same-title tracks overlap LP; three overlap Señora de Nadie. Different provider IDs, similar durations and titles do not settle performance identity. All19 tracks and credits retained in held manifest; no new duplicates proposed from this edition.
- Material credit conflicts: digital No puedo mas, No lists Mercedes Arelis Reynoso/Manuel Tejada, while originalLP credits Anthony Rios with arrangement by Manuel Tejada. Digital Se hace Pedazos and Que Casa es Esta? split Carlos Baez Brugal as lyricist and Manuel Tejada as composer, unlike sleeve’s author/arranger presentation. Digital A Esa/Ven a Amarme/Cuando show Yolanda Marisela Tavares/Tavarez and Manuel Tejada under composition fields. Do not flatten these accounts or equate roles. Preserve competing source assertions; source priority favors original physical credits for that physical edition.
- Ven A Amarme Panama1985, Top Hits THL-005: identified in original’s other-versions listing; separate scan/recording validation pending. No additional edition import.
- Raul Santi, Como Un Picaflor / Gracias Por Amarme, FM180451, Colombia1987: direct Discogs page https://www.discogs.com/release/11930092-Raul-Santi-Como-Un-Picaflor-Gracias-Por-Amarme credits Dhariana featured on sideB and Raúl Santi as writer. Shared external-performer release outside artist-led batch; source-label inspection and scope expansion needed. No changes to Raúl Santi or his catalog.
- Second album under Alfa Records and a fifteen-hit compilation appear in a2011 biography https://laverdaddelahistoria.blogspot.com/2011/04/artista-dominicana-dhariana-invitada.html?m=0 . Not enough product evidence to identify them with current digital titles. No guessed title/date/program.

## Source coverage and files

Official artist accounts previously identity-verified; Spotify artist and product pages inspected in Chrome. Apple artist/album/song lookup responses saved: `dhariana-discography-apple.json`, five `dhariana-apple-<collection ID>.json` plus empty Exitos1599235699 lookup. Original URLs and retrieval timestamps in files. These storefronts share distributor metadata and are not independent evidence for original dates.

InternetArchive API search Dhariana returned two unrelated homonyms, no relevant music; saved in `dhariana-discography-archive.json`. Discogs search exposed one artist, two LP editions and the1987 duet. Physical dates for originalLP supported by printed phonographic year; exact day unknown. No claim of exhaustive historical coverage or listening/audio comparison.

Seven release cover candidates downloaded and visually inspected; three additional LP source scans show the rear and both labels. Six proposed cover binaries have SHA256 in manifest; Exitos cover remains research-only. `dhariana-vinyl-image-sources.json` preserves original image URLs. Other evidence: `dhariana-ven-a-amarme-discogs.txt`, `dhariana-exitos-spotify.json`, `dhariana-senora-spotify.json`, credit files, research fetch/download scripts and manifest builder. All new files scoped under docs/reports/editorial/dhariana*. No preexisting historical reports overwritten.

Production: scoped read-only database inventory only; no Mangulina site crawl, cache refresh, writes or deployment in this task. No imports yet. GateB requires approval of the exact six-release/22-track manifest before import; original profile exception does not cover discographies. Unresolved material stays held regardless of approval of this batch.
