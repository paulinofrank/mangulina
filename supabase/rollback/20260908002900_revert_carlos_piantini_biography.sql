BEGIN;

-- Reverts 20260908002900_rewrite_carlos_piantini_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Carlos Piantini',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = NULL,
       ended = TRUE,
       primary_role = 'instrumentalist',
       primary_genre = 'instrumental',
       date_of_birth = '1927-05-09',
       birth_year = 1927,
       date_of_death = '2010-03-26',
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["conductor"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend', 'instrumental']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Carlos Piantini was a distinguished figure in Dominican instrumental and classical music, a musician whose dedication to the formal traditions of European art music helped lay groundwork for serious music education and performance in the Dominican Republic during the twentieth century. Born in 1927 in Santo Domingo, he pursued a level of musical training and professionalism that was genuinely rare in the Dominican context of his era and contributed to the development of institutional musical life in the country.

His work as an instrumental musician and his involvement in the country''s classical music infrastructure helped elevate standards and expand opportunities for Dominican musicians who wished to pursue careers beyond the popular music sphere. Piantini was active across a long career that saw significant changes in Dominican cultural life, and his contributions to the classical and instrumental tradition earned him lasting respect among musicians and music educators.

He passed away in 2010, having spent more than eight decades contributing to the richness of Dominican musical culture in ways that may be less visible than popular stardom but are no less significant for the country''s artistic heritage.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'carlos-piantini';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-piantini')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-piantini')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Carlos Piantini was a distinguished figure in Dominican instrumental and classical music, a musician whose dedication to the formal traditions of European art music helped lay groundwork for serious music education and performance in the Dominican Republic during the twentieth century. Born in 1927 in Santo Domingo, he pursued a level of musical training and professionalism that was genuinely rare in the Dominican context of his era and contributed to the development of institutional musical life in the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"His work as an instrumental musician and his involvement in the country''s classical music infrastructure helped elevate standards and expand opportunities for Dominican musicians who wished to pursue careers beyond the popular music sphere. Piantini was active across a long career that saw significant changes in Dominican cultural life, and his contributions to the classical and instrumental tradition earned him lasting respect among musicians and music educators.","type":"text"}]},{"type":"paragraph","content":[{"text":"He passed away in 2010, having spent more than eight decades contributing to the richness of Dominican musical culture in ways that may be less visible than popular stardom but are no less significant for the country''s artistic heritage.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'carlos-piantini'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
