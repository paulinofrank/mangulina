BEGIN;

-- Reverts 20260908002200_rewrite_yoskar_sarante_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Yoskar Sarante',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1970-01-02',
       birth_year = 1970,
       date_of_death = '2019-01-28',
       birth_place = 'Bani',
       province = 'Peravia',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['El prabu']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = 'yoskarsaranteoficial',
       disambiguation = NULL,
       bio_en = 'Yoskar Sarante was one of the most gifted and emotionally compelling bachata singers of his generation, an artist whose voice carried the raw ache and romantic longing that define the genre at its most powerful. Born in 1970 in Baní, a city in the southern province of Peravia, he grew up immersed in the sounds of bachata during a period when the genre was transitioning from its marginalized, working-class roots to a wider national and international acceptance.

Sarante possessed a vocal quality that was immediately recognizable — tender yet intense, capable of turning a simple lyric into a deeply felt confession. He recorded prolifically throughout the 1990s and 2000s, building a devoted following across the Dominican Republic and among Dominican communities abroad, particularly in the United States and Europe. His romantic style placed him in a lineage of bachata traditionalists who prioritized emotional sincerity over production gloss, and fans responded to the authenticity he brought to every performance.

Sarante continued performing and recording into the 2010s, remaining a consistent presence on the Dominican music scene even as newer artists and styles competed for attention. His death in 2019 at the age of 49 prompted an outpouring of grief from fans and fellow musicians who recognized in him a genuine custodian of bachata''s soulful core. He is remembered as one of the genre''s most heartfelt interpreters.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'yoskar-sarante';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Yoskar Sarante was one of the most gifted and emotionally compelling bachata singers of his generation, an artist whose voice carried the raw ache and romantic longing that define the genre at its most powerful. Born in 1970 in Baní, a city in the southern province of Peravia, he grew up immersed in the sounds of bachata during a period when the genre was transitioning from its marginalized, working-class roots to a wider national and international acceptance.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sarante possessed a vocal quality that was immediately recognizable — tender yet intense, capable of turning a simple lyric into a deeply felt confession. He recorded prolifically throughout the 1990s and 2000s, building a devoted following across the Dominican Republic and among Dominican communities abroad, particularly in the United States and Europe. His romantic style placed him in a lineage of bachata traditionalists who prioritized emotional sincerity over production gloss, and fans responded to the authenticity he brought to every performance.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sarante continued performing and recording into the 2010s, remaining a consistent presence on the Dominican music scene even as newer artists and styles competed for attention. His death in 2019 at the age of 49 prompted an outpouring of grief from fans and fellow musicians who recognized in him a genuine custodian of bachata''s soulful core. He is remembered as one of the genre''s most heartfelt interpreters.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'yoskar-sarante'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
