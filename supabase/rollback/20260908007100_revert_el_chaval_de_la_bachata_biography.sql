BEGIN;

-- Reverts 20260908007100_rewrite_el_chaval_de_la_bachata_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'El Chaval de la Bachata',
       sort_name = 'Mora Mercedes, Linar Espinal',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1978-12-04',
       birth_year = 1978,
       date_of_death = NULL,
       birth_place = 'Dajabón',
       province = 'Dajabón',
       first_name = 'Linar',
       middle_name = 'Espinal',
       last_name = 'Mora',
       second_last_name = 'Mercedes',
       stage_name = 'El Chaval de la Bachata',
       aliases = ARRAY['Linar Espinal', 'Los Infantiles del Amargue']::text[],
       occupations = '["composer","musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@ElChavaldelaBachata',
       facebook = 'elchavaldelabachata01',
       instagram = 'elchavaldelabachata',
       disambiguation = NULL,
       bio_en = 'El Chaval de la Bachata, born Nelson Suriel in 1978 in Dajabón — the border city where the Dominican Republic meets Haiti — is one of the most successful and enduring figures in the world of romantic bachata. His nickname, meaning roughly the young one of bachata, was given to him early in his career to reflect both his youth and his natural command of the genre, and it stuck as he grew into one of its most respected practitioners.

El Chaval developed a vocal style characterized by warmth, expressiveness, and a genuine emotional connection to the stories his songs tell — the heartaches, longings, and joys that are bachata''s eternal subject matter. His recordings in the late 1990s and 2000s produced numerous hits that became staples of the bachata repertoire, and his live performances earned him a reputation as an artist who delivers without fail.

Hailing from the border region, he brought to his music a sense of cultural complexity — Dajabón is a place where Dominican and Haitian cultures have coexisted in tension and intimacy for generations — that informs the depth of his artistry. El Chaval de la Bachata remains active and respected, a fixture of the genre he helped define.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'el-chaval-de-la-bachata';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"El Chaval de la Bachata, born Nelson Suriel in 1978 in Dajabón — the border city where the Dominican Republic meets Haiti — is one of the most successful and enduring figures in the world of romantic bachata. His nickname, meaning roughly the young one of bachata, was given to him early in his career to reflect both his youth and his natural command of the genre, and it stuck as he grew into one of its most respected practitioners.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Chaval developed a vocal style characterized by warmth, expressiveness, and a genuine emotional connection to the stories his songs tell — the heartaches, longings, and joys that are bachata''s eternal subject matter. His recordings in the late 1990s and 2000s produced numerous hits that became staples of the bachata repertoire, and his live performances earned him a reputation as an artist who delivers without fail.","type":"text"}]},{"type":"paragraph","content":[{"text":"Hailing from the border region, he brought to his music a sense of cultural complexity — Dajabón is a place where Dominican and Haitian cultures have coexisted in tension and intimacy for generations — that informs the depth of his artistry. El Chaval de la Bachata remains active and respected, a fixture of the genre he helped define.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
