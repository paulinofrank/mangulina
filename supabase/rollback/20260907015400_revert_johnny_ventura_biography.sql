BEGIN;

-- Reverts 20260907015400_rewrite_johnny_ventura_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Johnny Ventura',
       sort_name = 'Ventura Soriano, Juan de Dios',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1940-03-08',
       birth_year = 1940,
       date_of_death = '2021-07-28',
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Juan',
       middle_name = 'de Dios',
       last_name = 'Ventura',
       second_last_name = 'Soriano',
       stage_name = 'Johnny Ventura',
       aliases = ARRAY['El Caballo Mayor', 'Juan de Dios Ventura Soriano', 'El Combo Show']::text[],
       occupations = '["bandleader","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@JohnnyVenturaOficial',
       facebook = 'JohnnyVenturaOficial',
       instagram = 'johnnyventuraoficial',
       disambiguation = NULL,
       bio_en = 'Johnny Ventura was one of the towering figures of Dominican merengue, an artist whose impact on his country''s music, culture, and public life was so immense that he transcended the role of entertainer to become a genuine national institution. Born in Santo Domingo in 1940, Ventura began his musical career as a young man with striking charisma and a voice that combined power with infectious energy, qualities that would make him one of the most beloved performers in Dominican history.

In the 1960s he revolutionized the presentation of merengue by forming the Combo Show, a stripped-down, highly energetic band that replaced the large orchestras typical of the era with a leaner ensemble that could move faster and perform with greater spontaneity. This innovation modernized merengue for a new generation and gave the genre the driving tempo and visceral excitement that would define it going forward.

Ventura''s recordings became anthems of Dominican identity — joyful, rhythmically irresistible, and infused with the spirit of a people who valued celebration as a form of resilience. He was also a committed public servant, serving as a politician and civic leader in Santo Domingo, bringing the same energy and commitment to public life that he brought to the stage. His friendships and collaborations with other great figures of Latin music, including Celia Cruz and Johnny Pacheco, placed him at the center of a golden era for Caribbean popular music.

Johnny Ventura passed away in July 2021, and the outpouring of grief from across the Dominican Republic and the broader Latin world testified to the depth of love he had earned through a lifetime of music and service.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'johnny-ventura';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Johnny Ventura was one of the towering figures of Dominican merengue, an artist whose impact on his country''s music, culture, and public life was so immense that he transcended the role of entertainer to become a genuine national institution. Born in Santo Domingo in 1940, Ventura began his musical career as a young man with striking charisma and a voice that combined power with infectious energy, qualities that would make him one of the most beloved performers in Dominican history.","type":"text"}]},{"type":"paragraph","content":[{"text":"In the 1960s he revolutionized the presentation of merengue by forming the Combo Show, a stripped-down, highly energetic band that replaced the large orchestras typical of the era with a leaner ensemble that could move faster and perform with greater spontaneity. This innovation modernized merengue for a new generation and gave the genre the driving tempo and visceral excitement that would define it going forward.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ventura''s recordings became anthems of Dominican identity — joyful, rhythmically irresistible, and infused with the spirit of a people who valued celebration as a form of resilience. He was also a committed public servant, serving as a politician and civic leader in Santo Domingo, bringing the same energy and commitment to public life that he brought to the stage. His friendships and collaborations with other great figures of Latin music, including Celia Cruz and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e005898c-4fcc-45da-b857-c6775e92fa52","displayText":"Johnny Pacheco","occurrenceId":"6e0e41e8-8bcf-4b1d-82be-560ea8b07807"}},{"text":", placed him at the center of a golden era for Caribbean popular music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Johnny Ventura passed away in July 2021, and the outpouring of grief from across the Dominican Republic and the broader Latin world testified to the depth of love he had earned through a lifetime of music and service.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'johnny-ventura'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'en'), '6e0e41e8-8bcf-4b1d-82be-560ea8b07807', 'artist', 'e005898c-4fcc-45da-b857-c6775e92fa52');

COMMIT;
