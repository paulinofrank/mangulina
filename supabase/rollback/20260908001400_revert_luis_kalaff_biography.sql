BEGIN;

-- Reverts 20260908001400_rewrite_luis_kalaff_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Luis Kalaff',
       sort_name = 'Kalaff, Luis',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1916-10-11',
       birth_year = 1916,
       date_of_death = '2010-07-02',
       birth_place = 'Pimentel',
       province = 'Duarte',
       first_name = 'Luis',
       middle_name = NULL,
       last_name = 'Kalaff',
       second_last_name = 'Pérez',
       stage_name = 'Luis Kalaff',
       aliases = ARRAY[]::text[],
       occupations = '["composer","musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['folklore', 'bolero', 'folklore-salve']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Luis Kalaff was one of the most versatile and enduring figures in Dominican popular music. Born in 1916 in Pimentel, a small town in the Duarte province, he came of age during a period when Dominican musical identity was still being forged from a rich mixture of African rhythms, Spanish melodic traditions, and indigenous influences. Kalaff became a master practitioner of several genres, excelling in merengue, bolero, and the deeply spiritual salve, a genre rooted in Afro-Dominican religious ceremony.

His mastery of traditional forms made him a living archive of Dominican musical heritage at a time when many of those sounds risked being overshadowed by modernization. Throughout his long career — which spanned much of the twentieth century — Kalaff demonstrated a remarkable ability to move between the celebratory energy of merengue and the tender introspection of the bolero with equal conviction.

He was not simply a performer reproducing established forms; he was an interpreter who brought personal feeling and regional sensibility to everything he recorded and performed. His work helped document and preserve the sonic landscape of the Cibao valley and its surroundings, giving future generations a reference point for what Dominican rural and popular music sounded like in its most organic state.

Kalaff lived to the age of 94, passing away in 2010, and left behind a body of recordings that continues to serve as essential listening for anyone seeking to understand the full breadth of Dominican musical tradition.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'luis-kalaff';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Kalaff was one of the most versatile and enduring figures in Dominican popular music. Born in 1916 in Pimentel, a small town in the Duarte province, he came of age during a period when Dominican musical identity was still being forged from a rich mixture of African rhythms, Spanish melodic traditions, and indigenous influences. Kalaff became a master practitioner of several genres, excelling in merengue, bolero, and the deeply spiritual salve, a genre rooted in Afro-Dominican religious ceremony.","type":"text"}]},{"type":"paragraph","content":[{"text":"His mastery of traditional forms made him a living archive of Dominican musical heritage at a time when many of those sounds risked being overshadowed by modernization. Throughout his long career — which spanned much of the twentieth century — Kalaff demonstrated a remarkable ability to move between the celebratory energy of merengue and the tender introspection of the bolero with equal conviction.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was not simply a performer reproducing established forms; he was an interpreter who brought personal feeling and regional sensibility to everything he recorded and performed. His work helped document and preserve the sonic landscape of the Cibao valley and its surroundings, giving future generations a reference point for what Dominican rural and popular music sounded like in its most organic state.","type":"text"}]},{"type":"paragraph","content":[{"text":"Kalaff lived to the age of 94, passing away in 2010, and left behind a body of recordings that continues to serve as essential listening for anyone seeking to understand the full breadth of Dominican musical tradition.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'luis-kalaff'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
