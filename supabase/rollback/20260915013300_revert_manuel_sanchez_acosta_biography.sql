BEGIN;

-- Revierte 20260915013300_rewrite_manuel_sanchez_acosta_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-sanchez-acosta' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'manuel-sanchez-acosta') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Manuel Sánchez Acosta was a Dominican musician born in 1914 whose remarkably long life — he passed away in 2006 at the age of ninety-two — made him a living archive of Dominican musical history. Active during a period that encompassed the rise of recorded music, the Trujillo dictatorship, the political upheavals of the 1960s, and the globalization of Dominican culture in the late twentieth century, Sánchez Acosta was a witness to and participant in the full arc of modern Dominican popular music. His career connected him to the earliest traditions of Dominican performance and the social networks of musicians who kept those traditions alive across generations. His longevity and dedication to music made him a figure of respect within Dominican musical circles, and his passing marked the end of a direct link to the very earliest years of the art form.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-sanchez-acosta';
UPDATE artists SET bio_en = 'Manuel Sánchez Acosta was a Dominican musician born in 1914 whose remarkably long life — he passed away in 2006 at the age of ninety-two — made him a living archive of Dominican musical history. Active during a period that encompassed the rise of recorded music, the Trujillo dictatorship, the political upheavals of the 1960s, and the globalization of Dominican culture in the late twentieth century, Sánchez Acosta was a witness to and participant in the full arc of modern Dominican popular music. His career connected him to the earliest traditions of Dominican performance and the social networks of musicians who kept those traditions alive across generations. His longevity and dedication to music made him a figure of respect within Dominican musical circles, and his passing marked the end of a direct link to the very earliest years of the art form.', bio_es = NULL,
       date_of_birth = '1914-08-14',
       primary_role = 'singer',
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[] WHERE slug = 'manuel-sanchez-acosta';

COMMIT;
