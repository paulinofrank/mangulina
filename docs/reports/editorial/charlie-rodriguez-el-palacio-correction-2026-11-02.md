# Charlie Rodríguez — «El Palacio» attribution correction

## Scope

Correct the published English and Spanish biography documents of Charlie Rodríguez (`5bb869a0-495d-4831-b44f-a6a9f074d3f7`). No artist status, discography, Work, Recording, release or credit changes. Preserve all other artists' records.

## Evidence

- [Mario Díaz's first-person account (2013)](https://panoramanacionalrd.blogspot.com/2013/08/conozca-la-trayectoria-del-compositor.html?m=0) says Charlie Rodríguez recorded his «El Palacio» with an arrangement by Manuel Tejada, and that he became known as its composer.
- [Mario Díaz's first-person account (2015)](https://nadamasfarandula.blogspot.com/2015/07/) gives the complete title «Si yo tuviera un palacio», 1985, Charlie Rodríguez and Manuel Tejada.
- [Diario Libre coverage of the Chamber of Deputies recognition (2025)](https://www.diariolibre.com/revista/musica/2025/09/03/juan-valdez-y-mario-diaz-homenajeados-por-la-camara-de-diputados/3232380) lists «El palacio», recorded by Charlie Rodríguez, among Mario Díaz's compositions.
- [La Crónica coverage of Máximo Jiménez's interview (2025)](https://lacronica.do/mario-diaz-la-musica-no-nace-de-algoritmos-nace-del-corazon/) confirms the full song title, common title and Mario's authorship.
- [Mangulina's Mario Díaz biography](https://www.mangulina.do/es/artists/mario-diaz) already gives the correct credit; Charlie's biographies contradict it.

## Change manifest

| Record | Before | After |
| --- | --- | --- |
| Charlie EN biography `e8d39f31-1bf4-4098-a3cd-c3807047ca87`, rev 4 | “El Palacio, written by Ramón Díaz” | «Si yo tuviera un palacio» (known as «El Palacio»), written by linked Mario Díaz, arranged by linked Manuel Tejada; preserve the 1985 album context. |
| Charlie ES biography `b8dbb077-1b57-465d-80e8-313beeb82729`, rev 2 | “El Palacio, escrita por Ramón Díaz” | «Si yo tuviera un palacio» (conocida como «El Palacio»), escrita por Mario Díaz y arreglada por Manuel Tejada. |
| Legacy mirrors | Wrong author in both locales | Match the corrected biographies. |

Both biography documents also contain unlinked mentions of existing Mangulina artists and unsupported editorial judgments (for example, the claim that one television program was “the only television that mattered”). Rewrite the two Charlie biographies within the same artist scope around verified career milestones, add a proper concluding Legacy/Legado section and structured references, and omit these judgments. Preserve the confirmed 1985 LP and El Equipo history. No backward or reciprocal edits to other artists. A targeted `works.preferred_title ILIKE '%palacio%'` audit found no Work row for this song; no catalog credit needs changing within this scope.

Additional sources for the bounded rewrite: [Listín Diario interview via Ticket Express (2011)](https://www.ticketexpress.com.do/ShowContent.aspx?ID=495) places Charlie's entry into El Equipo in 1981; [El Día (2017)](https://eldia.com.do/charlie-rodriguez-y-diony-fernandez-rememoraran-epoca-de-el-equipo-en-lucia/) documents later joint performances; [1985 copyright registration transcription](https://www.copyrightencyclopedia.com/la-gozaita-yo-quiero-mas-fiesta-por-el-amor-de-ella-%5Bet-al%5D/) identifies the «Cójelo León» LP (Cima LP 73) and its publication year. The first-person 2015 account describes the demo cassette presented during the new orchestra's rehearsal.

## Completed and verified

- Charlie Rodríguez's artist UUID and publication status were unchanged. Both structured biographies and their legacy mirrors now identify Mario Díaz as the writer and Manuel Tejada as the arranger of «Si yo tuviera un palacio» («El Palacio»).
- EN document `e8d39f31-1bf4-4098-a3cd-c3807047ca87`: published, revision 6. ES document `b8dbb077-1b57-465d-80e8-313beeb82729`: published, revision 4. Each has nine matching artist-reference nodes and relation rows, with zero missing or wrong-name links; neither contains the old Ramón Díaz credit.
- Saved each biography through the admin Publish action after the database update, triggering the existing targeted cache revalidation. Opened and checked both public pages; the corrected Mario Díaz and Manuel Tejada links render in both locales.
- Screenshot of the corrected public Spanish page: `charlie-rodriguez-el-palacio-public-es-2026-11-02.png` in this directory.
- No Work, Recording, release, or music credit record was changed. A Work-title search found no «El Palacio» / «Si yo tuviera un palacio» catalog record to correct.
