BEGIN;

-- Revierte 20260909011200_rewrite_las_chicas_del_can_biography.sql
-- Devuelve la ficha al relleno legacy en inglés, sin documentos, sin año de
-- formación y sin la certificación de ventas.

-- 1. Referencias y documentos editoriales
DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'las-chicas-del-can' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'las-chicas-del-can')
   AND document_type = 'artist_biography';

-- 2. Espejo legacy y año de formación: estado anterior a la reescritura
UPDATE artists SET
  birth_year = NULL,
  bio_es = NULL,
  bio_en = 'Las Chicas del Can were a groundbreaking all-female merengue group that emerged from the Dominican Republic in the early 1980s, becoming one of the most beloved and historically significant ensembles in the genre''s history. At a time when merengue was almost entirely a male-dominated space — both in terms of performance and the social settings where it was consumed — Las Chicas del Can broke through with energy, talent, and sheer force of personality.

Founded and led by Wilfrido Vargas, who recognized the commercial and cultural potential of an all-women merengue band, the group evolved into an institution in its own right, with lead vocalist Sandra Reyes becoming the face of Dominican merengue for a generation. Their recordings were enormously popular across the Caribbean, Latin America, and among Latinos in the United States, and their concerts were celebrated events.

Songs like El Africano — a cover that became iconic — demonstrated their ability to take material from anywhere and make it Dominican. Beyond their commercial success, Las Chicas del Can hold a lasting place in history as pioneers who challenged gender norms in Dominican music and proved that women could lead — not merely accompany — one of the country''s defining popular art forms.'
WHERE slug = 'las-chicas-del-can';

-- 3. La certificación de ventas añadida
DELETE FROM artist_awards w
 USING award_categories cat, awards aw
 WHERE w.category_id = cat.id
   AND cat.award_id = aw.id
   AND aw.name = 'Sales Certifications'
   AND cat.name = 'Platinum Records'
   AND w.artist_id = (SELECT id FROM artists WHERE slug = 'las-chicas-del-can')
   AND w.year = 1988;

COMMIT;
