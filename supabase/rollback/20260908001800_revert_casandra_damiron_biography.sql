BEGIN;

-- Reverts 20260908001800_rewrite_casandra_damiron_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Casandra Damirón',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1919-03-12',
       birth_year = 1919,
       date_of_death = '1983-12-05',
       birth_place = 'Barahona',
       province = 'Barahona',
       first_name = 'Cassandra',
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Casandra Damirón was a pioneering figure in Dominican popular music, a singer of extraordinary talent and cultural significance whose artistry helped shape the national repertoire during the mid-twentieth century. Born in 1919 in Barahona, a coastal city in the country''s southwestern region, she came of age in a musical environment shaped by merengue, bolero, and the folk traditions of the Afro-Dominican south.

Her voice was a compelling instrument — rich, expressive, and authoritative — and she used it to interpret a wide range of material, from romantic ballads to driving merengues, with a consistency and depth that set her above many of her contemporaries. Damirón became one of the most celebrated female vocalists of her era, performing on radio, in clubs, and at major cultural events throughout the Dominican Republic, and her recordings circulated widely across the Caribbean.

She was part of a generation of Dominican artists who worked to establish a distinct national musical identity during the Trujillo era and its aftermath, navigating complex political terrain while maintaining their artistic integrity. Her contributions to Dominican cultural life were recognized by audiences and critics alike, and she is regarded today as one of the founding mothers of Dominican popular song.

She passed away in 1983 after a career spanning more than four decades, leaving behind a legacy of recordings that continue to be celebrated as cornerstones of the national musical heritage.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'casandra-damiron';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Casandra Damirón was a pioneering figure in Dominican popular music, a singer of extraordinary talent and cultural significance whose artistry helped shape the national repertoire during the mid-twentieth century. Born in 1919 in Barahona, a coastal city in the country''s southwestern region, she came of age in a musical environment shaped by merengue, bolero, and the folk traditions of the Afro-Dominican south.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her voice was a compelling instrument — rich, expressive, and authoritative — and she used it to interpret a wide range of material, from romantic ballads to driving merengues, with a consistency and depth that set her above many of her contemporaries. Damirón became one of the most celebrated female vocalists of her era, performing on radio, in clubs, and at major cultural events throughout the Dominican Republic, and her recordings circulated widely across the Caribbean.","type":"text"}]},{"type":"paragraph","content":[{"text":"She was part of a generation of Dominican artists who worked to establish a distinct national musical identity during the Trujillo era and its aftermath, navigating complex political terrain while maintaining their artistic integrity. Her contributions to Dominican cultural life were recognized by audiences and critics alike, and she is regarded today as one of the founding mothers of Dominican popular song.","type":"text"}]},{"type":"paragraph","content":[{"text":"She passed away in 1983 after a career spanning more than four decades, leaving behind a legacy of recordings that continue to be celebrated as cornerstones of the national musical heritage.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'casandra-damiron'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
