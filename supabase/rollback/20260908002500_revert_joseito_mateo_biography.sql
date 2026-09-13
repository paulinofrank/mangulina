BEGIN;

-- Reverts 20260908002500_rewrite_joseito_mateo_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Joseíto Mateo',
       sort_name = 'Mateo, Joseíto',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1920-04-06',
       birth_year = 1920,
       date_of_death = '2018-06-01',
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'José',
       middle_name = NULL,
       last_name = 'Tamárez',
       second_last_name = 'Mateo',
       stage_name = 'Joseíto Mateo',
       aliases = ARRAY['El Rey del Merengue', 'Jose Tamarez Mateo']::text[],
       occupations = '["bandleader","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['bolero']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'joseitomateoelreydelmerengue',
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Joseíto Mateo was the undisputed king of Dominican merengue, a singer and cultural icon whose voice and personality became so intertwined with the national music that separating the man from the genre is almost impossible. Born in Santo Domingo in 1920, Mateo grew up surrounded by the sounds of early Dominican popular music and began his performing career in an era when merengue was still primarily performed by small acoustic ensembles before its electrification and modernization.

He became the preeminent voice of merengue at its most festive and life-affirming, his recordings capturing the joy, humor, and communal energy that made the genre a cornerstone of Dominican identity. Mateo''s longevity was extraordinary — he continued performing well into his later decades, his voice retaining remarkable power and expressiveness long after most singers would have retired.

He was a figure of enormous cultural significance, recognized by the Dominican state and by music lovers throughout the Spanish-speaking world as a living embodiment of Dominican musical heritage. Mateo passed away in 2018 at the age of ninety-seven, and his death prompted national mourning appropriate to the loss of someone who had given his country nearly a century of music and joy.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'joseito-mateo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joseito-mateo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joseito-mateo')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Joseíto Mateo was the undisputed king of Dominican merengue, a singer and cultural icon whose voice and personality became so intertwined with the national music that separating the man from the genre is almost impossible. Born in Santo Domingo in 1920, Mateo grew up surrounded by the sounds of early Dominican popular music and began his performing career in an era when merengue was still primarily performed by small acoustic ensembles before its electrification and modernization.","type":"text"}]},{"type":"paragraph","content":[{"text":"He became the preeminent voice of merengue at its most festive and life-affirming, his recordings capturing the joy, humor, and communal energy that made the genre a cornerstone of Dominican identity. Mateo''s longevity was extraordinary — he continued performing well into his later decades, his voice retaining remarkable power and expressiveness long after most singers would have retired.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was a figure of enormous cultural significance, recognized by the Dominican state and by music lovers throughout the Spanish-speaking world as a living embodiment of Dominican musical heritage. Mateo passed away in 2018 at the age of ninety-seven, and his death prompted national mourning appropriate to the loss of someone who had given his country nearly a century of music and joy.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joseito-mateo'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
