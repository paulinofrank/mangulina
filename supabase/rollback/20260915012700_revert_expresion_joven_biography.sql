BEGIN;

-- Revierte 20260915012700_rewrite_expresion_joven_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'expresion-joven' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'expresion-joven') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Expresión Joven was a Dominican musical group associated with the nueva canción and trova movements, genres characterized by their emphasis on thoughtful, socially conscious songwriting and acoustic musical settings rooted in folk traditions. The group emerged during a period when politically engaged music was a significant cultural force across Latin America, and their work reflected the aspirations and anxieties of young Dominicans seeking a musical language that spoke honestly about their society. Drawing on the folk traditions of the Dominican Republic as well as the broader pan-Latin American nueva canción movement associated with artists like Silvio Rodríguez and Mercedes Sosa, Expresión Joven created music that was intimate in its instrumentation and serious in its intentions, offering a deliberate counterpoint to the commercially dominant dance music of their era. Their recordings represent an important but often overlooked thread in Dominican musical history — the tradition of politically committed, artistically ambitious song that has always existed alongside the more commercially visible tropical and popular genres.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'expresion-joven';
UPDATE artists SET bio_en = 'Expresión Joven was a Dominican musical group associated with the nueva canción and trova movements, genres characterized by their emphasis on thoughtful, socially conscious songwriting and acoustic musical settings rooted in folk traditions. The group emerged during a period when politically engaged music was a significant cultural force across Latin America, and their work reflected the aspirations and anxieties of young Dominicans seeking a musical language that spoke honestly about their society. Drawing on the folk traditions of the Dominican Republic as well as the broader pan-Latin American nueva canción movement associated with artists like Silvio Rodríguez and Mercedes Sosa, Expresión Joven created music that was intimate in its instrumentation and serious in its intentions, offering a deliberate counterpoint to the commercially dominant dance music of their era. Their recordings represent an important but often overlooked thread in Dominican musical history — the tradition of politically committed, artistically ambitious song that has always existed alongside the more commercially visible tropical and popular genres.', bio_es = NULL,
       formation_year = NULL,
       birth_year = NULL,
       death_year = NULL,
       ended = false WHERE slug = 'expresion-joven';

COMMIT;
