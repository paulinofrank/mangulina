BEGIN;

-- Revierte 20260915014400_rewrite_aisha_syed_castro_biography.sql con los documentos y
-- el premio que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'aisha-syed-castro' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aisha-syed-castro') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Aisha Syed Castro is one of the most remarkable classical musicians to emerge from the Dominican Republic in recent decades, a violinist of international caliber whose technical brilliance and musical intelligence have earned her recognition on some of the world''s most prestigious stages. Born in 1989 in Santo Domingo, she demonstrated exceptional talent from childhood and pursued rigorous musical training that eventually took her to leading conservatories in Europe, where she developed her craft under the guidance of master teachers.","type":"text"}]},{"type":"paragraph","content":[{"text":"Syed Castro has performed with major orchestras and in prestigious concert halls across Europe, the Americas, and Asia, establishing herself as a soloist of the first rank in the international classical music community. Her repertoire spans the standard violin literature from the Baroque through the Romantic and into the contemporary, and her recordings have received critical acclaim from classical music journals and media outlets that rarely focus on Dominican artists.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her success represents a remarkable achievement for Dominican classical music — a field that has produced distinguished musicians but rarely received the international recognition that Syed Castro has earned through sheer excellence. She has become an ambassador for Dominican culture in the classical music world and an inspiration for young Dominican musicians with aspirations beyond the tropical and urban genres that dominate the country''s musical landscape.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aisha-syed-castro';
UPDATE artists SET bio_en = 'Aisha Syed Castro is one of the most remarkable classical musicians to emerge from the Dominican Republic in recent decades, a violinist of international caliber whose technical brilliance and musical intelligence have earned her recognition on some of the world''s most prestigious stages. Born in 1989 in Santo Domingo, she demonstrated exceptional talent from childhood and pursued rigorous musical training that eventually took her to leading conservatories in Europe, where she developed her craft under the guidance of master teachers.

Syed Castro has performed with major orchestras and in prestigious concert halls across Europe, the Americas, and Asia, establishing herself as a soloist of the first rank in the international classical music community. Her repertoire spans the standard violin literature from the Baroque through the Romantic and into the contemporary, and her recordings have received critical acclaim from classical music journals and media outlets that rarely focus on Dominican artists.

Her success represents a remarkable achievement for Dominican classical music — a field that has produced distinguished musicians but rarely received the international recognition that Syed Castro has earned through sheer excellence. She has become an ambassador for Dominican culture in the classical music world and an inspiration for young Dominican musicians with aspirations beyond the tropical and urban genres that dominate the country''s musical landscape.', bio_es = NULL WHERE slug = 'aisha-syed-castro';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Violinista Internacional'
   AND w.year = 2009 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'aisha-syed-castro');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Violinista Internacional'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
