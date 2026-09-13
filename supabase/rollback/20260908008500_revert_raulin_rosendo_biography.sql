BEGIN;

-- Reverts 20260908008500_rewrite_raulin_rosendo_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Raulín Rosendo',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1957-08-30',
       birth_year = 1957,
       date_of_death = NULL,
       birth_place = 'San Pedro de Macorís',
       province = 'San Pedro de Macorís',
       first_name = 'Raúl',
       middle_name = NULL,
       last_name = 'Martínez',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['Raulin Rosendo']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@RaulinRosendo-xz6hf',
       facebook = 'morenaraulin',
       instagram = 'raulinrosendooficial',
       disambiguation = NULL,
       bio_en = 'Raulín Rosendo was a significant figure in Dominican popular music whose career spanned the middle decades of the twentieth century and touched on several of the key genres that defined the country''s sonic identity. Born in 1957 in San Pedro de Macorís, a city in the eastern province that has produced a remarkable number of distinguished Dominican artists, he developed his musical gifts in an environment shaped by merengue, bolero, and the rhythmic traditions of the Afro-Dominican east.

His work as a performer and interpreter helped keep the popular music traditions of his region alive and accessible to new generations of listeners. San Pedro de Macorís has long been a cultural crossroads where Caribbean musical currents converge, and Rosendo''s output reflected that diversity with an ease that spoke to deep personal familiarity with the music.

Though less internationally celebrated than some of his contemporaries, he was a respected and beloved figure within Dominican musical circles and contributed meaningfully to the preservation and popularization of mid-century Dominican popular song.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'raulin-rosendo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Raulín Rosendo was a significant figure in Dominican popular music whose career spanned the middle decades of the twentieth century and touched on several of the key genres that defined the country''s sonic identity. Born in 1957 in San Pedro de Macorís, a city in the eastern province that has produced a remarkable number of distinguished Dominican artists, he developed his musical gifts in an environment shaped by merengue, bolero, and the rhythmic traditions of the Afro-Dominican east.","type":"text"}]},{"type":"paragraph","content":[{"text":"His work as a performer and interpreter helped keep the popular music traditions of his region alive and accessible to new generations of listeners. San Pedro de Macorís has long been a cultural crossroads where Caribbean musical currents converge, and Rosendo''s output reflected that diversity with an ease that spoke to deep personal familiarity with the music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Though less internationally celebrated than some of his contemporaries, he was a respected and beloved figure within Dominican musical circles and contributed meaningfully to the preservation and popularization of mid-century Dominican popular song.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'raulin-rosendo'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
