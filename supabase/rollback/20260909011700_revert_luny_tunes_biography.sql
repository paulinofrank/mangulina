BEGIN;

-- Revierte 20260909011700_rewrite_luny_tunes_biography.sql
--
-- Aviso: el estado anterior incluye la relación invertida
--   Luny Tunes --member_of--> Luny
-- es decir el dúo como miembro de uno de sus propios integrantes.

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luny-tunes' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luny-tunes')
   AND document_type = 'artist_biography';

UPDATE artists SET
  bio_es = NULL,
  bio_en = 'Luny Tunes is one of the most consequential production teams in the history of reggaeton, a duo whose innovative work in the early 2000s helped transform the genre from a regional underground movement into a global commercial phenomenon. The team consists of Francisco Saldaña, known as Luny, and Víctor Cabrera, known as Tunes, both of Dominican origin, who developed a production aesthetic that combined hard-hitting percussion patterns with melodic sensibility and an instinct for crossover appeal.

Working from studios in Puerto Rico, where the reggaeton scene was most concentrated, Luny Tunes produced a string of landmark recordings in the early to mid-2000s that defined the sound of the genre during its critical breakthrough period. They worked with virtually every significant reggaeton artist of that era, including Daddy Yankee, Wisin y Yandel, Don Omar, and Tego Calderón, and their fingerprints are on some of the most influential records in Latin urban music history.

The compilation series Mas Flow, which they produced, is considered a foundational document of commercial reggaeton and introduced many artists who would go on to shape the genre for years. Luny Tunes'' contribution to the internationalization of reggaeton — a genre that by the 2020s had become one of the most consumed musical styles on the planet — cannot be overstated. They brought Dominican production sensibility to a Puerto Rican genre and helped make the resulting fusion a genuinely pan-Caribbean and global sound.'
WHERE slug = 'luny-tunes';

-- Restaura la relación tal como estaba, invertida incluida
DELETE FROM artist_relationships r
 USING artists m, artists d
 WHERE r.source_artist_id = m.id AND r.target_artist_id = d.id
   AND m.slug = 'luny' AND d.slug = 'luny-tunes' AND r.relationship_type = 'member_of';

INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type)
SELECT d.id, m.id, 'member_of'
  FROM artists d, artists m WHERE d.slug = 'luny-tunes' AND m.slug = 'luny'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = d.id
                     AND r.target_artist_id = m.id AND r.relationship_type = 'member_of');

COMMIT;
