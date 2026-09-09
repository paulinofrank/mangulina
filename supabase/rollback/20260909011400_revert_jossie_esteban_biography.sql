BEGIN;

-- Revierte 20260909011400_rewrite_jossie_esteban_biography.sql

-- 1. Referencias y documentos editoriales
DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jossie-esteban-y-la-patrulla-15' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jossie-esteban-y-la-patrulla-15')
   AND document_type = 'artist_biography';

-- 2. Campos y espejo legacy: estado anterior a la reescritura
UPDATE artists SET
  birth_place = 'Santo Domingo',
  province    = 'Distrito Nacional',
  birth_year  = NULL,
  aliases     = ARRAY['La Patrulla 15', 'Jossie Esteban', 'Ringo Martinez'],
  bio_es      = NULL,
  bio_en      = 'Jossie Esteban y La Patrulla 15 was one of the most beloved merengue acts to emerge from the Dominican Republic, a group whose energetic performances and infectious recordings made them a fixture of Dominican popular culture during their most active years. Jossie Esteban, as the charismatic frontman, projected a joyful exuberance that translated effectively both on record and in live performance, and La Patrulla 15 provided tight, driving musical support that gave the group''s merengues their characteristic momentum.

Their music exemplified the celebratory, communal spirit of merengue at its most festive, capturing the essence of Dominican social life and its love of dance and collective enjoyment. The group achieved significant commercial success in the Dominican Republic and in diaspora markets, and their recordings from their peak period are remembered with great affection by fans who associate their music with specific moments and occasions in Dominican life.

Jossie Esteban y La Patrulla 15 stand as representatives of a particularly vibrant era in Dominican merengue.'
WHERE slug = 'jossie-esteban-y-la-patrulla-15';

-- 3. Relaciones documentadas
DELETE FROM artist_relationships
 WHERE target_artist_id = (SELECT id FROM artists WHERE slug = 'jossie-esteban-y-la-patrulla-15')
   AND ((source_artist_id = (SELECT id FROM artists WHERE slug = 'alberto-ringo-martinez')
         AND relationship_type = 'founder_of')
     OR (source_artist_id = (SELECT id FROM artists WHERE slug = 'henry-hierro')
         AND relationship_type = 'member_of'));

COMMIT;
