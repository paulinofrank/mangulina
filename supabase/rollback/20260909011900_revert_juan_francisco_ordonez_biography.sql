BEGIN;

-- Revierte 20260909011900_rewrite_juan_francisco_ordonez_biography.sql
--
-- Aviso: el estado anterior devuelve el alias "Transporte Urbano" a las dos
-- personas que fundaron la banda, y el "El Terror" duplicado en la fila de
-- Luis "Terror" Días.

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-francisco-ordonez' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-francisco-ordonez')
   AND document_type = 'artist_biography';

UPDATE artists SET
  aliases = ARRAY['Transporte Urbano']::text[],
  bio_es  = NULL,
  bio_en  = 'Juan Francisco Ordóñez is a Dominican musician and composer whose work spans an impressively wide range of styles — from jazz and Latin jazz to rock alternativo, fusion, and bachata — reflecting both formal training and a genuine curiosity about the intersection of different musical traditions. Born in 1961 in Santo Domingo, he developed his musical sensibility during a period of rich creative ferment in Dominican cultural life and pursued a path that prioritized artistic exploration over commercial predictability.

His engagement with jazz and Latin jazz places him in a tradition of Dominican musicians who have looked beyond the island''s popular genres to engage with the broader currents of Afro-American and Latin American improvised music, and his fusion work demonstrates an appetite for synthesizing those influences with the rhythmic and melodic vocabulary of his homeland. Ordóñez has contributed to Dominican musical life not only through his recordings and performances but also through his role as an educator and cultural figure who has helped sustain interest in jazz and experimental music in a context where those genres require active advocacy to survive.

His career represents the more adventurous, experimentally inclined wing of Dominican musical culture.'
WHERE slug = 'juan-francisco-ordonez';

UPDATE artists
   SET aliases = ARRAY['El Terror', 'Transporte Urbano', 'El Terror', 'Luis Díaz', 'Luis Dias']::text[]
 WHERE slug = 'luis-terror-dias';

COMMIT;
