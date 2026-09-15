BEGIN;

-- Revierte 20260915013200_rewrite_puerto_plata_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'puerto-plata' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'puerto-plata') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Puerto Plata — the artist known by the name of his beloved home city — was a Dominican musician born in 1923 in the northern coastal city of Puerto Plata. His long career placed him among the elder statesmen of Dominican popular music, a living link to the earliest days of recorded merengue and tropical music on the island. His music reflected the distinctive character of the Cibao north coast, where Caribbean rhythms, African heritage, and Spanish colonial culture blended into a uniquely Dominican sound.","type":"text"}]},{"type":"paragraph","content":[{"text":"He performed for generations of audiences and witnessed the transformation of Dominican music from live regional performances to internationally distributed recordings. He passed away in 2020 at the remarkable age of ninety-seven, having outlived nearly all of his contemporaries and left behind a body of work that stands as testament to the endurance of Dominican musical tradition.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'puerto-plata';
UPDATE artists SET bio_en = 'Puerto Plata — the artist known by the name of his beloved home city — was a Dominican musician born in 1923 in the northern coastal city of Puerto Plata. His long career placed him among the elder statesmen of Dominican popular music, a living link to the earliest days of recorded merengue and tropical music on the island. His music reflected the distinctive character of the Cibao north coast, where Caribbean rhythms, African heritage, and Spanish colonial culture blended into a uniquely Dominican sound.

He performed for generations of audiences and witnessed the transformation of Dominican music from live regional performances to internationally distributed recordings. He passed away in 2020 at the remarkable age of ninety-seven, having outlived nearly all of his contemporaries and left behind a body of work that stands as testament to the endurance of Dominican musical tradition.', bio_es = NULL, first_name = 'José',
       occupations = '["guitarist"]'::jsonb,
       instruments = ARRAY[]::text[] WHERE slug = 'puerto-plata';

COMMIT;
