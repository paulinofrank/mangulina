BEGIN;

-- Revierte 20260914010000_rewrite_henry_santos_biography.sql
-- Aviso: devuelve el alias "Aventura" a dos personas cuando el grupo tiene fila
-- propia, y el end_year 2011 que ignora los regresos del grupo.

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'henry-santos' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'henry-santos')
   AND document_type = 'artist_biography';

UPDATE artists SET
  aliases = ARRAY['Aventura']::text[],
  bio_es  = NULL,
  bio_en  = 'Henry Santos is a Dominican bachata artist born in 1979 in Moca, a city in the Espaillat province of the Cibao region. He first gained widespread recognition as a member of Aventura, the New York-based Dominican group that transformed bachata from a regional Caribbean genre into a global phenomenon in the early 2000s. As one of the group''s vocalists and performers, Santos contributed to landmark recordings that introduced bachata to audiences in Europe, Asia, and across the Americas, fundamentally changing the genre''s international profile.

After pursuing a solo career, he demonstrated that his appeal extended beyond his work with Aventura, releasing urban bachata and tropical recordings that maintained his connection to Dominican musical roots while embracing contemporary production styles. Santos occupies a significant place in the story of bachata''s global rise — one of the artists who carried the genre out of the Dominican Republic and into the mainstream of world popular music.'
WHERE slug = 'henry-santos';

UPDATE artists SET aliases = array_append(aliases, 'Aventura')
 WHERE slug = 'romeo-santos' AND NOT ('Aventura' = ANY(aliases));

UPDATE artist_relationships r
   SET end_year = 2011, notes = 'Second lead vocals and songwriter'
  FROM artists s, artists g
 WHERE r.source_artist_id = s.id AND r.target_artist_id = g.id
   AND s.slug = 'henry-santos' AND g.slug = 'aventura' AND r.relationship_type = 'founder_of';

COMMIT;
