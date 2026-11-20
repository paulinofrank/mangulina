# Mozaribe ↔ Frantoni Santana: founder relationship

Date: 2026-11-04. Requested correction: show Frantoni Santana as Mozaribe's founder in the structured artist relationships.

## Evidence and identity

- The live records are Frantoni Santana `efe31bc6-9074-49b2-ae8e-2844242dd8e1` (`frantoni-santana`) and Mozaribe `e3727fa9-0203-4011-b5f9-bf3476f67ad5` (`mozaribe`), both published.
- Frantoni recounts conceiving and forming Mozaribe with Carlos Jáquez in his 2026 interview transcribed at `E:\Entrevistas - Mangulina\Frantoni\20260918 - @TrayectoriaRD - FRANTONI SANTANA Y EL MERENGUE CON VIOLINES.txt`. The [J&N Publishing announcement](https://minayapr.com/j-n-publishing-compra-catalogo-de-mas-de-140-obras-del-iconico-compositor-dominicano-frantoni-santana/) likewise calls Mozaribe Santana's own group. His authorship is already linked in both Mozaribe biography documents.
- The existing `artist_relationships` table has no relationship between these two UUIDs in either direction. `founder_of` is an existing supported type. The UI projects an outgoing `founder_of` as Frantoni's founded project and an incoming one as Mozaribe's founder.

## Change manifest

Insert one `artist_relationships` row: `source_artist_id=efe31bc6-9074-49b2-ae8e-2844242dd8e1`, `target_artist_id=e3727fa9-0203-4011-b5f9-bf3476f67ad5`, `relationship_type=founder_of`, `start_year=NULL`, `end_year=NULL`. The precise formation year is unsettled, so it must not be inferred for this row. This is one shared relationship displayed on both pages. No biography, discography, other relation, artist status or application code changes.

## Result

Inserted relationship `7b406046-ae6e-47c8-bfe3-7425f9d6b559`. A read-back query returned exactly one matching `founder_of` row, with both years null. Targeted cache revalidation succeeded for the two artist slugs. Both Spanish public pages returned HTTP 200 and contained clickable links to each other; the Mozaribe page contained the founder label.

The live `artist_relationships` table lacks the unique constraint shown in the repository's original migration. An initial `ON CONFLICT (source_artist_id,target_artist_id,relationship_type)` insert therefore failed without writing anything. The successful insert used a `NOT EXISTS` guard, and read-back showed one row. This schema discrepancy is logged here only; no schema or security setting was changed.
