BEGIN;

-- Reverts 20260907015600_rewrite_eddy_herrera_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Eddy Herrera',
       sort_name = 'Herrera de los Ríos, Eduardo',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1964-04-30',
       birth_year = 1964,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Eduardo',
       middle_name = NULL,
       last_name = 'Herrera',
       second_last_name = 'de los Ríos',
       stage_name = 'Eddy Herrera',
       aliases = ARRAY['El Galan del Merengue', 'Eduardo Herrera']::text[],
       occupations = '["bandleader","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://eddyherrera.com',
       youtube = '@EddyHerreraOficial',
       facebook = 'EddyHerreraOficial',
       instagram = 'eddy_herrera',
       disambiguation = NULL,
       bio_en = 'Eddy Herrera is one of the most beloved figures in Dominican merengue, a singer whose combination of smooth vocal delivery, romantic themes, and danceable rhythms earned him a devoted following that has spanned decades. Born in 1964 in Santiago de los Caballeros, he grew up in the heart of the Cibao region, where merengue is not merely music but a way of life.

He rose to fame in the 1980s and 1990s — the golden era of commercial merengue — recording a series of hits that became staples at parties, weddings, and dance halls across the Dominican Republic and the diaspora. Songs like Pegame Tu Vicio and Amor a Primera Vista became crossover successes, reaching audiences far beyond the island''s shores and establishing Herrera as an international Latin music star.

What set him apart from many of his contemporaries was his ability to balance the high-energy demands of merengue with a romantic sensitivity that connected deeply with listeners. His live performances were known for their electricity and warmth, and he cultivated a reputation as a consummate entertainer. Over the years he continued recording and touring, maintaining his popularity across generations of fans. His influence on merengue romántico is profound, and he is widely regarded as one of the genre''s defining voices.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'eddy-herrera';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Eddy Herrera is one of the most beloved figures in Dominican merengue, a singer whose combination of smooth vocal delivery, romantic themes, and danceable rhythms earned him a devoted following that has spanned decades. Born in 1964 in Santiago de los Caballeros, he grew up in the heart of the Cibao region, where merengue is not merely music but a way of life.","type":"text"}]},{"type":"paragraph","content":[{"text":"He rose to fame in the 1980s and 1990s — the golden era of commercial merengue — recording a series of hits that became staples at parties, weddings, and dance halls across the Dominican Republic and the diaspora. Songs like Pegame Tu Vicio and Amor a Primera Vista became crossover successes, reaching audiences far beyond the island''s shores and establishing Herrera as an international Latin music star.","type":"text"}]},{"type":"paragraph","content":[{"text":"What set him apart from many of his contemporaries was his ability to balance the high-energy demands of merengue with a romantic sensitivity that connected deeply with listeners. His live performances were known for their electricity and warmth, and he cultivated a reputation as a consummate entertainer. Over the years he continued recording and touring, maintaining his popularity across generations of fans. His influence on merengue romántico is profound, and he is widely regarded as one of the genre''s defining voices.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'eddy-herrera'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
