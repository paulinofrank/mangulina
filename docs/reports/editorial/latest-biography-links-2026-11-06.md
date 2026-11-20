# Link audit of latest artist biographies — 2026-11-06

Scope: structured English and Spanish biographies attached to artist records created 5–6 November 2026. Reviewed: Plan Perfecto Music, JUDÁ, Kiko el Presidente, Freisis Frías, Juancho Viloria, JACÓ, La Barbie del Acordeón, Grupo Cañaveral and Mozaribe (18 documents). Artist rows without biographies (Pedro Rymer, Ismael Olmo) are outside this biography audit. The editor explicitly requested linking all identified existing artists in these latest biographies. No artist facts, publication statuses or discography records are in scope.

## Verified omissions to repair

| Biography owner | Locale/document UUID | Before | After | Target artist UUID | Evidence of identity |
| --- | --- | --- | --- | --- | --- |
| Freisis Frías | EN `fc900b78-0fb7-487a-b11d-72167f191956`, ES `ca89088c-6988-4946-a56c-64fd89f69c3e`; revision 1 | Plain `Rocío Crooke` | Linked `Rocío Crooke` | `0bb19f71-3458-41c8-9de5-eea527d85d26` | Published artist record describes Dominican worship singer. |
| Grupo Cañaveral | EN `065b0092-7ede-4fed-b349-ccbb1047db9b`, ES `bfff2b36-ad6b-408f-b6bd-de4f41375c2b`; revision 1 | Plain `4.40` | Linked canonical `Grupo 440`, retaining Juan Luis Guerra link | `9761143c-4e04-4590-8fa7-fe82674a6cf7` | Published artist record is the group founded by Juan Luis Guerra; `4.40` is a listed alias. |
| Grupo Cañaveral | Same documents | Plain `Luis Mansilla` | Linked `Luis Mansilla` | `593123d8-0cdc-46d7-918b-fc43047a8ac1` | Published artist record identifies recording/mixing engineer and Alex Mansilla's brother. |

Each change adds an `artistReference` node and matching `editorial_entity_references` row; biography revision increments from 1 to 2. The legacy Markdown mirror is updated to the same wording. Exact proposed documents are in `latest-biography-links-proposed-2026-11-06.json`.

## Findings left unlinked

- `Dominic` is a substring of *Dominican/dominicana*, not a person mention. `Santana` in Betsaida Santana and Frantoni Santana does not identify the catalog artist named Santana.
- People and groups such as Omar David Silvestre Rosario, Betsaida Santana, Miel San Marcos, Andrés Mofi, Bartolo Alvarado and Carlos Jáquez have no matching artist row established by this audit. Names alone do not justify linking to a different person.
- Existing artistReference nodes, including Chris Disla, Grupo Grace, Krisspy, Shelow Shaq, Wilfrido Vargas, Los Beduinos, Antony Santos, Joe Veras, Fefita la Grande, Frantoni Santana and Fernando Villalona, remain unchanged.

No new biographical claims are introduced. No unrelated artist records are edited.

## Applied and checked

- Freisis Frías EN and ES: each published biography moved from revision 1 to 2; `Rocío Crooke` now has a reference node and matching relation row.
- Grupo Cañaveral EN and ES: each published biography moved from revision 1 to 2; `Grupo 440` and `Luis Mansilla` now have reference nodes and matching relation rows. The legacy Markdown mirrors reflect the visible wording change from `4.40` to the canonical group name.
- Validation: all four proposed documents passed `validateEditorialDocument(1, ...)`. Database checks found matching node/row counts (4/4 for each Freisis locale, 16/16 for each Cañaveral locale), zero unmatched nodes or rows, zero display-name mismatches, and exact equality of all four legacy mirrors with the structured documents.
- Targeted cache refresh succeeded for `freisis-frias` and `alex-mansilla-y-el-grupo-canaveral`. Both language versions of both public pages visibly rendered the new artist links at their intended URLs.
- An initial large SQL transaction was not executed because its tool confirmation expired. A read confirmed all revisions were still 1 before the smaller, successful writes. No partial change from that attempt remained.
