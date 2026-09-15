BEGIN;

-- Revierte 20260915015800_rewrite_luis_alberti_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'luis-alberti' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-alberti') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Alberti was a Dominican composer, pianist, and bandleader born in 1906 in San Pedro de Macorís whose musical legacy is built on one of the most famous merengue compositions in history. Alberti led one of the leading Dominican dance orchestras of the mid-twentieth century, a big-band ensemble that brought merengue into the age of the ballroom and recording studio with sophistication and swing.","type":"text"}]},{"type":"paragraph","content":[{"text":"His orchestra''s sound reflected the influence of American big-band jazz while remaining unmistakably rooted in Dominican rhythmic traditions — a synthesis that gave the music a cosmopolitan elegance without sacrificing its popular energy. Alberti''s most celebrated composition, Compadre Pedro Juan, became a standard of the Dominican repertoire, a melody so deeply embedded in national consciousness that it transcended the popular music world to become something approaching a folk anthem.","type":"text"}]},{"type":"paragraph","content":[{"text":"He also worked in bolero, reflecting the genre''s dominance in Latin American romantic music during the postwar decades. Alberti passed away in 1976, but his compositions have never stopped being played, a testament to the timeless quality of his musical imagination.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luis-alberti';
UPDATE artists SET bio_en = 'Luis Alberti was a Dominican composer, pianist, and bandleader born in 1906 in San Pedro de Macorís whose musical legacy is built on one of the most famous merengue compositions in history. Alberti led one of the leading Dominican dance orchestras of the mid-twentieth century, a big-band ensemble that brought merengue into the age of the ballroom and recording studio with sophistication and swing.

His orchestra''s sound reflected the influence of American big-band jazz while remaining unmistakably rooted in Dominican rhythmic traditions — a synthesis that gave the music a cosmopolitan elegance without sacrificing its popular energy. Alberti''s most celebrated composition, Compadre Pedro Juan, became a standard of the Dominican repertoire, a melody so deeply embedded in national consciousness that it transcended the popular music world to become something approaching a folk anthem.

He also worked in bolero, reflecting the genre''s dominance in Latin American romantic music during the postwar decades. Alberti passed away in 1976, but his compositions have never stopped being played, a testament to the timeless quality of his musical imagination.', bio_es = NULL,
       birth_place = 'San Pedro de Macorís', province = 'San Pedro de Macorís', aliases = ARRAY['Orquesta Generalisimo Trujillo']::text[]
       WHERE slug = 'luis-alberti';

COMMIT;
