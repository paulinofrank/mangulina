# Family relationship update manifest — 15 November 2026

## Authorized scope

Apply the 15 entries marked VERIFICADO and the two label corrections from the editor-supplied audit `2e449184-c139-42d7-a51a-2a1f0d57310f/Pasted text.txt`. Leave the two PROBABLE entries and three DECISIÓN DE FORMA cases unchanged. Shared family records appear on both artists' profiles.

## New relationships

The editor-supplied audit provides the documentary sources and relationship direction. Store one normalized record per pair; the application renders the reverse perspective automatically.

| Pair | Canonical relationship | Source direction and label |
|---|---|---|
| Janiel Ponciano — Junior Ponciano | sibling | Either → Brother |
| Carolina Ponciano — Janiel Ponciano | uncle_aunt | Janiel → Aunt |
| Karen Ponciano — Janiel Ponciano | uncle_aunt | Janiel → Aunt |
| Ezequiel Ponciano — Junior Ponciano | cousin | Either → Cousin |
| Ezequiel Ponciano — Janiel Ponciano | cousin | Either → Cousin |
| Esteban Ponciano — Ezequiel Ponciano | sibling | Either → Brother |
| Ezequiel Ponciano — Yuleisy Canela | spouse/current | Ezequiel → Wife |
| Maridalia Hernández — Julio Alberto Hernández | grandparent | Maridalia → Grandfather |
| Alih Jey — Aníbal de Peña | parent | Alih Jey → Father |
| Martha Echenique — Didi Hernández | parent | Martha → Daughter |
| Marco Hernández — Jorge Taveras | uncle_aunt | Marco → Uncle |
| Lorenzo Zayas-Bazán — Roger Zayas-Bazán | sibling | Either → Brother |
| Mangione Molina — José Antonio Molina | uncle_aunt | Mangione → Uncle |
| Mangione Molina — Papa Molina | grandparent | Mangione → Grandfather |
| Mariela Mercado — Manuel Tejada | spouse/current | Mariela → Husband |

Existing records to update, preserving pair and relationship type:

| Pair | Current label implied by row | Set to |
|---|---|---|
| Indhira Martínez — Vickiana | Parent | Mother |
| Luis Armando Rivera González — Casandra Damirón | Spouse | Late husband (ended_by_death) |

Correction note: Vickiana is the mother of Indhira Martínez. The existing relationship row is correctly oriented Vickiana → Indhira with `relationship_type=parent`; the generic public label occurred because Vickiana's `artists.gender` was null. The editor corrected this fact, and `gender` was set to `female` so the relationship resolves as Mother/Daughter.

## Pre-write checks

- All 26 artist records exist and are published.
- The `artist_family_relationships` table uses normalized types (`parent`, `sibling`, `cousin`, `spouse`, `grandparent`, `uncle_aunt`, `great_uncle_aunt`) and spouse status (`current`, `former`, `ended_by_death`). `Granddaughter` is a supported editor label; directional family labels are resolved from artist gender.
- The two correction records exist: Vickiana → Indhira (`parent`, no status) and Casandra → Luis Armando (`spouse`, `ended_by_death`).
- Pair-level duplicate check and insertion/update will use the admin relationship workflow, which revalidates both artists' profile routes.

## Evidence

Relationship source descriptions and links are retained in the editor-supplied audit. This manifest records scope, mappings, and pre-write state; it does not independently upgrade those source grades.

## Applied result

Inserted 15 distinct normalized rows in `artist_family_relationships`. A post-write query confirmed exactly one row for each requested pair. Both label-correction targets already had the correct normalized values before this task: Vickiana → Indhira was `parent` (renders Mother on Indhira's page), and Casandra → Luis Armando was `spouse / ended_by_death` (renders Late husband on Casandra's page). No updates were needed for those two entries. The pairs were absent before insertion, so no existing relationship was overwritten.

All 15 relationship rows were re-saved through the Mangulina admin relationship editor without changing their canonical types or endpoints. Each successful update invoked route revalidation for both artists in the pair. The editor confirmed the relationships remain present. Public rendering was verified in both directions for Vickiana and Indhira: Indhira lists Vickiana as Mother; Vickiana lists Indhira as Daughter. The two pre-existing corrections required no relationship-row changes: Vickiana gender is female, and Casandra/Luis Armando remains spouse / ended_by_death. No unrelated records were changed.

