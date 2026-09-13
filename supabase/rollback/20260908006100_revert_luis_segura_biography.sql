BEGIN;

-- Reverts 20260908006100_rewrite_luis_segura_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Luis Segura',
       sort_name = 'Segura, Luis',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1939-06-21',
       birth_year = 1939,
       date_of_death = NULL,
       birth_place = 'Mao',
       province = 'Valverde',
       first_name = 'Luis',
       middle_name = NULL,
       last_name = 'Segura',
       second_last_name = NULL,
       stage_name = 'Luis Segura',
       aliases = ARRAY['El Papa de la Bachata']::text[],
       occupations = '["composer","musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Luis Segura is widely regarded as one of the founding pillars of bachata, the deeply emotional guitar-driven genre that originated in the rural margins of the Dominican Republic before conquering the world. Born in 1939 in Mao, the capital of Valverde province in the Cibao region of the northwest, Segura grew up surrounded by the sounds of the countryside — the bolero, the son, and the raw acoustic expressions that would eventually coalesce into bachata.

He began performing and recording in the 1960s, a period when bachata was still dismissed by the Dominican urban elite as música de amargue, the music of bitterness, associated with poverty, heartbreak, and the lower classes. Rather than shying away from this stigma, Segura embraced the emotional directness that defined the genre. His voice carried an unmistakable ache, and his guitar work was fluid and conversational, perfectly matched to lyrics that explored unrequited love, longing, and the hardships of ordinary life.

His recording career spanned several decades and produced hundreds of songs, many of which became staples of Dominican popular music. Segura was instrumental in establishing the structures and emotional conventions of classic bachata at a time when the genre had no institutional support and little radio airplay. He performed in small clubs, neighborhood gatherings, and popular venues throughout the country, building an audience through direct human connection rather than media promotion.

As bachata eventually gained mainstream acceptance in the Dominican Republic and then internationally, Segura came to be recognized as one of its true originators. His contributions have been honored by music historians and fellow artists alike, and he remains a beloved figure whose recordings continue to be cherished by fans of traditional Dominican music.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'luis-segura';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Segura is widely regarded as one of the founding pillars of bachata, the deeply emotional guitar-driven genre that originated in the rural margins of the Dominican Republic before conquering the world. Born in 1939 in Mao, the capital of Valverde province in the Cibao region of the northwest, Segura grew up surrounded by the sounds of the countryside — the bolero, the son, and the raw acoustic expressions that would eventually coalesce into bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"He began performing and recording in the 1960s, a period when bachata was still dismissed by the Dominican urban elite as música de amargue, the music of bitterness, associated with poverty, heartbreak, and the lower classes. Rather than shying away from this stigma, Segura embraced the emotional directness that defined the genre. His voice carried an unmistakable ache, and his guitar work was fluid and conversational, perfectly matched to lyrics that explored unrequited love, longing, and the hardships of ordinary life.","type":"text"}]},{"type":"paragraph","content":[{"text":"His recording career spanned several decades and produced hundreds of songs, many of which became staples of Dominican popular music. Segura was instrumental in establishing the structures and emotional conventions of classic bachata at a time when the genre had no institutional support and little radio airplay. He performed in small clubs, neighborhood gatherings, and popular venues throughout the country, building an audience through direct human connection rather than media promotion.","type":"text"}]},{"type":"paragraph","content":[{"text":"As bachata eventually gained mainstream acceptance in the Dominican Republic and then internationally, Segura came to be recognized as one of its true originators. His contributions have been honored by music historians and fellow artists alike, and he remains a beloved figure whose recordings continue to be cherished by fans of traditional Dominican music.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'luis-segura'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
