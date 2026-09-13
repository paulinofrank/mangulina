BEGIN;

-- Reverts 20260908004000_rewrite_mozart_la_para_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Mozart la Para',
       sort_name = 'Para, Mozart la',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urban-rap-hip-hop',
       date_of_birth = '1988-01-31',
       birth_year = 1988,
       date_of_death = NULL,
       birth_place = 'Santo Domingo Este',
       province = 'Santo Domingo',
       first_name = 'Erickson',
       middle_name = NULL,
       last_name = 'Fernández',
       second_last_name = NULL,
       stage_name = 'Mozart La Para',
       aliases = ARRAY['Mozart la Para', 'Erickson Fernández']::text[],
       occupations = '["songwriter"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urban-reggaeton', 'urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@MozartLaPara',
       facebook = 'MozartLaPara',
       instagram = 'mozartlapara',
       disambiguation = NULL,
       bio_en = 'Mozart la Para is one of the most recognizable names in Dominican hip hop and urban music, a rapper and entertainer who built his reputation through a combination of sharp lyricism, comedic instincts, and an ability to connect with audiences across different demographics. Born in 1988 in Santo Domingo Este, he grew up on the eastern edge of the capital city in a neighborhood that shaped his worldview and provided the raw material for much of his art.

He emerged in the early 2010s as part of a new wave of Dominican rappers who were pushing the country''s urban music scene beyond the influence of Puerto Rican reggaeton toward something more locally rooted. Mozart la Para''s style blends rapid-fire delivery with humor and social observation, creating a signature tone that is both entertaining and pointed. He became known for his freestyle skills and his ability to generate viral moments on social media, which helped him build a substantial following well beyond the Dominican Republic.

His collaborations with other Latin urban artists expanded his reach throughout the Americas and into the Spanish-speaking diaspora in the United States. He has released multiple projects that performed strongly in Dominican markets and has become one of the most followed Dominican urban artists on digital platforms, representing a new generation that is defining Dominican hip hop on its own terms.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'mozart-la-para';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Mozart la Para is one of the most recognizable names in Dominican hip hop and urban music, a rapper and entertainer who built his reputation through a combination of sharp lyricism, comedic instincts, and an ability to connect with audiences across different demographics. Born in 1988 in Santo Domingo Este, he grew up on the eastern edge of the capital city in a neighborhood that shaped his worldview and provided the raw material for much of his art.","type":"text"}]},{"type":"paragraph","content":[{"text":"He emerged in the early 2010s as part of a new wave of Dominican rappers who were pushing the country''s urban music scene beyond the influence of Puerto Rican reggaeton toward something more locally rooted. Mozart la Para''s style blends rapid-fire delivery with humor and social observation, creating a signature tone that is both entertaining and pointed. He became known for his freestyle skills and his ability to generate viral moments on social media, which helped him build a substantial following well beyond the Dominican Republic.","type":"text"}]},{"type":"paragraph","content":[{"text":"His collaborations with other Latin urban artists expanded his reach throughout the Americas and into the Spanish-speaking diaspora in the United States. He has released multiple projects that performed strongly in Dominican markets and has become one of the most followed Dominican urban artists on digital platforms, representing a new generation that is defining Dominican hip hop on its own terms.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'mozart-la-para'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
