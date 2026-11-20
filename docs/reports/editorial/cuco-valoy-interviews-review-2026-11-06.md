# Cuco Valoy interview review — 2026-11-06

## Scope and authorization

The editor requested updates to all biographies materially affected by six supplied Cuco Valoy interview transcripts. Intended changes: the published English and Spanish biographies of Cuco Valoy (`c11c2dda-ffa1-4f09-9d24-00dc4473bc8d`), Los Ahijados (`f6f95f0f-e008-47b9-8b4c-10fe5508bfd9`), Martín Valoy (`6eccc3e7-82bf-435f-8ae1-ea7e8a721560`), Ramón Orlando (`02f23257-1cf6-4a4c-8df1-1f9aa630a2c3`), and Raulín Rosendo (`faf3e4cb-808e-419c-87ff-5126eed85e73`). No discography, credit, identifier, or publication-status change is authorized or planned.

## Evidence and proposed changes

| Owner | Finding | Evidence | Proposed change |
|---|---|---|---|
| Cuco Valoy | Birth in San Miguel de Manoguayabo; father Santiago Reynoso; mother died when Cuco was four; childhood tambora made from a tin | 2022-06-13 Silvio Mora interview, 5:07–7:51, 20:46–23:05; 2026-09-26 Tony Dandrades interview, 7:17–9:17; [Listín Diario 2024](https://listindiario.com/entretenimiento/musica/20240625/cuco-valoy-jardinero-manoguayabo-rego-semillas-son-salsa-merengue-mundo_814200.html) | Enrich early life without equating limited general schooling with lack of any music study. |
| Cuco Valoy, Los Ahijados, Martín Valoy | Current bios wrongly place adoption of son montuno and the duo name in the mid-1960s. They performed as Los Ahijados by 1958. | 2023-08-19 10 Preguntas interview, 0:34–31:37; 2026-09-26 Tony Dandrades interview, 21:07–23:00; [contemporaneous 1958 press cited by Acento](https://acento.com.do/cultura/reconociendo-hijo-del-pueblo-al-brujo-cuco-valoy-llamado-tambien-pupi-quisqueya-8444846.html); [Revista Global](https://revistaglobal.org/wp-content/uploads/2024/12/G104-v19.pdf) | Correct all six language versions to a late-1950s chronology; describe the Buscando Estrellas naming and the early self-financed recording. |
| Cuco Valoy, Ramón Orlando | Ramón Orlando studied piano at his father's urging and became pianist, arranger and musical director of Los Virtuosos, formed in 1975. | 2022-06-15 Silvio Mora interview, 0:00–4:49; 2023-08-19 10 Preguntas interview, 31:40–2:21:10; [Cámara de Diputados, acta 2017](https://camaradediputados.gob.do/download/160/2017-segunda-legislatura-ordinaria/4325/acta-13-del-martes-17-de-octubre-de-2017.pdf) | Clarify the father-son division of work and founding date. Repair Ramón's existing hanging headings/empty paragraphs. |
| Ramón Orlando | Biography says birth year 1959 while structured field says 1960. | Existing structured field; [65th birthday report in 2025](https://la91fm.com/noticia/el-maestro-ramon-orlando-cumplio-65-anos) | Harmonize biography year to 1960; do not change the structured birth date. |
| Raulín Rosendo | Current biography jumps from early work to Los Hijos del Rey, omitting Los Virtuosos. | 2023-08-19 10 Preguntas interview, Los Virtuosos passage; [photograph caption in Salsa desde mi balcón, 1976](https://ign.gob.do/wp-content/uploads/2024/11/SALSA-DESDE-MI-BALCON-final-digital.pdf); [Color Visión retrospective](https://colorvision.com.do/raulin-rosendo-y-fernandito-villalona-juntos-en-el-show-del-mediodia/) | Add the 1976 Los Virtuosos stage with a linked Cuco Valoy reference before Los Hijos del Rey. |
| Cuco Valoy | «Juliana» was composed during a New York recording session; «El Brujo» drew on a santera's consultations; «Los Frutos del Carnaval» followed Colombian carnival experiences. | 2023-08-19 10 Preguntas interview, 31:40–2:21:10; 2026-09-26 Tony Dandrades interview, 23:00–end; [iASO Records](https://www.iasorecords.com/artists/cuco-valoy) | Add concise song-origin context, avoiding unverified personal allegations and subjective superlatives. |

## Reviewed without proposed edits

The 2022-06-15 interview discusses Gaby Arias's passage from Chocolate to Cuco's orchestra and then Los Kenton. The existing Los Kenton biography already documents his period; no separate Gaby Arias profile is present. Henry García's published biographies already describe the core Cuco/Ramón collaborations. The 2025-04-23 interview discusses Los Compadres and a recollection of «Baja y tapa la olla», without establishing a new credit or date. Political opinions, accusations against named people, personal conflicts, live audience figures and uncertain transcriptions are excluded.

## Verification gate

Before writing: preserve existing artist references and their occurrence IDs; create a new relation row for the Raulín-to-Cuco reference; validate all ten revised documents against schema v1. After each biography save: synchronize its markdown mirror, verify revision increments, publication status, references, and targeted cache refresh. This report is the change manifest.

## Completed write and checks

Saved the ten published biography documents and synchronized their `artists.bio_en`/`bio_es` mirrors. Revisions: Cuco Valoy EN 5→6, ES 4→5; Los Ahijados EN 3→4, ES 2→3; Martín Valoy EN 3→4, ES 1→2; Ramón Orlando EN 5→6, ES 4→5; Raulín Rosendo EN 5→6, ES 3→4. All ten documents passed `validateEditorialDocument(1, ...)`; every reference occurrence and target matched its relation row after saving. All five affected artist paths were refreshed through the targeted revalidation endpoint. The five Spanish and five English public pages displayed the revised text in the browser.

The exact saved document JSON and compatibility mirrors are archived in `cuco-valoy-final-documents-2026-11-06.json`. Artist publication status, discography, music credits and security settings were unchanged.
