BEGIN;

-- Reverts 20260908008700_rewrite_felix_del_rosario_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Félix del Rosario',
       sort_name = 'del Rosario, Félix',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1934-06-12',
       birth_year = 1934,
       date_of_death = '2012-10-26',
       birth_place = 'San Francisco de Macorís',
       province = 'Duarte',
       first_name = 'Félix',
       middle_name = NULL,
       last_name = 'del Rosario',
       second_last_name = NULL,
       stage_name = 'Félix del Rosario',
       aliases = ARRAY['Los Magos del Ritmo', 'Felix del Rosario y Sus Magos del Ritmo']::text[],
       occupations = '["musician","arranger","bandleader","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['jazz']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Félix del Rosario was a Dominican bandleader and musician born in 1934 in San Francisco de Macorís whose orchestra became one of the most celebrated and commercially successful merengue bands of the mid to late twentieth century. Del Rosario led his group Los Magos with a combination of musical discipline and showmanship that kept the band at the top of Dominican popular music across several decades, navigating the stylistic shifts in merengue from its big-band era through the faster, more percussive styles that emerged in the 1970s and 1980s.

His work also incorporated Latin jazz elements, reflecting the influence of New York Latin music on Dominican bandleaders who watched with keen interest as salsa and Latin jazz transformed the sound of Spanish-speaking New York. San Francisco de Macorís, a city in the Cibao with a proud musical heritage, gave Del Rosario his roots, and he carried that regional identity with pride throughout his career. He passed away in 2012, having spent nearly eight decades enriching Dominican musical life as a performer, bandleader, and ambassador of merengue.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'felix-del-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Félix del Rosario was a Dominican bandleader and musician born in 1934 in San Francisco de Macorís whose orchestra became one of the most celebrated and commercially successful merengue bands of the mid to late twentieth century. Del Rosario led his group Los Magos with a combination of musical discipline and showmanship that kept the band at the top of Dominican popular music across several decades, navigating the stylistic shifts in merengue from its big-band era through the faster, more percussive styles that emerged in the 1970s and 1980s.","type":"text"}]},{"type":"paragraph","content":[{"text":"His work also incorporated Latin jazz elements, reflecting the influence of New York Latin music on Dominican bandleaders who watched with keen interest as salsa and Latin jazz transformed the sound of Spanish-speaking New York. San Francisco de Macorís, a city in the Cibao with a proud musical heritage, gave Del Rosario his roots, and he carried that regional identity with pride throughout his career. He passed away in 2012, having spent nearly eight decades enriching Dominican musical life as a performer, bandleader, and ambassador of merengue.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'felix-del-rosario'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
