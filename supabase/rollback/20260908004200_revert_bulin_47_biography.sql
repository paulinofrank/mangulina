BEGIN;

-- Reverts 20260908004200_rewrite_bulin_47_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Bulin 47',
       sort_name = 'Bulin 47',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urban-dembow',
       date_of_birth = '1989-11-20',
       birth_year = 1989,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Hanthony',
       middle_name = 'Dawson',
       last_name = 'Hurtado',
       second_last_name = NULL,
       stage_name = 'Bulin 47',
       aliases = ARRAY['Hanthony Hurtado']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@Bulin47Music',
       facebook = 'Bulin47Oficcial',
       instagram = 'bulin47_oficial',
       disambiguation = NULL,
       bio_en = 'Bulin 47 is a Dominican entertainer who has carved out a unique space in the urban and dembow scene by combining musical performance with a sharp comedic sensibility. Born in 1989 in Santo Domingo, he became known not only for his dembow tracks but also for his ability to inject humor, irony, and social observation into his performances, creating a persona that resonates deeply with Dominican audiences who appreciate wit alongside rhythm.

His comedy-inflected approach to urban music sets him apart from more straightforwardly serious artists in the dembow space, and his videos and online content have generated significant viral traction. Bulin 47 represents a strand of Dominican popular culture that has always valued humor and performance as inseparable from musical entertainment, and he has channeled that tradition into a contemporary urban format that connects with younger audiences on social media platforms.

His popularity speaks to the breadth of Dominican urban music — a scene capacious enough to accommodate both the lyrical seriousness of artists like Lápiz Conciente and the playful energy of entertainers like Bulin 47.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'bulin-47';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Bulin 47 is a Dominican entertainer who has carved out a unique space in the urban and dembow scene by combining musical performance with a sharp comedic sensibility. Born in 1989 in Santo Domingo, he became known not only for his dembow tracks but also for his ability to inject humor, irony, and social observation into his performances, creating a persona that resonates deeply with Dominican audiences who appreciate wit alongside rhythm.","type":"text"}]},{"type":"paragraph","content":[{"text":"His comedy-inflected approach to urban music sets him apart from more straightforwardly serious artists in the dembow space, and his videos and online content have generated significant viral traction. Bulin 47 represents a strand of Dominican popular culture that has always valued humor and performance as inseparable from musical entertainment, and he has channeled that tradition into a contemporary urban format that connects with younger audiences on social media platforms.","type":"text"}]},{"type":"paragraph","content":[{"text":"His popularity speaks to the breadth of Dominican urban music — a scene capacious enough to accommodate both the lyrical seriousness of artists like Lápiz Conciente and the playful energy of entertainers like Bulin 47.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'bulin-47'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
