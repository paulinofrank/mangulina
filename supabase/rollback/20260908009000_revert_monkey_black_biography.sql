BEGIN;

-- Reverts 20260908009000_rewrite_monkey_black_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Monkey Black',
       sort_name = 'Black, Monkey',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'urban-dembow',
       date_of_birth = '1986-07-26',
       birth_year = 1986,
       date_of_death = '2014-04-30',
       birth_place = 'Santo Domingo Este',
       province = 'Santo Domingo',
       first_name = 'Leonardo',
       middle_name = 'Michael',
       last_name = 'Flores',
       second_last_name = 'Ozuna',
       stage_name = 'Monkey Black',
       aliases = ARRAY['Monkey Black', 'Leonardo Michael Flores Ozuna']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Monkey Black, born in 1986 in Santo Domingo Este, was a Dominican rapper and urban artist whose brief but impactful career placed him among the pioneering voices of Dominican hip hop and dembow. Growing up in the eastern reaches of Santo Domingo, he was immersed in the street culture and musical ferment of a neighborhood that was becoming central to the Dominican urban music movement.

His music combined the raw energy of hip hop with the driving rhythms of dembow, the Dominican variation of reggaeton that was developing its own distinct identity during the years of his artistic maturity. Monkey Black connected with a generation of young Dominicans who saw in urban music a language for expressing their experiences, aspirations, and frustrations with an authenticity that mainstream Dominican popular music rarely offered.

His death in 2014 at the age of twenty-seven robbed Dominican hip hop of one of its most promising voices, and his memory has been kept alive by fans and fellow artists who recognize his place in the early history of Dominican urban music.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'monkey-black';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Monkey Black, born in 1986 in Santo Domingo Este, was a Dominican rapper and urban artist whose brief but impactful career placed him among the pioneering voices of Dominican hip hop and dembow. Growing up in the eastern reaches of Santo Domingo, he was immersed in the street culture and musical ferment of a neighborhood that was becoming central to the Dominican urban music movement.","type":"text"}]},{"type":"paragraph","content":[{"text":"His music combined the raw energy of hip hop with the driving rhythms of dembow, the Dominican variation of reggaeton that was developing its own distinct identity during the years of his artistic maturity. Monkey Black connected with a generation of young Dominicans who saw in urban music a language for expressing their experiences, aspirations, and frustrations with an authenticity that mainstream Dominican popular music rarely offered.","type":"text"}]},{"type":"paragraph","content":[{"text":"His death in 2014 at the age of twenty-seven robbed Dominican hip hop of one of its most promising voices, and his memory has been kept alive by fans and fellow artists who recognize his place in the early history of Dominican urban music.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'monkey-black'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
