BEGIN;

-- Revierte 20260914011500_rewrite_luis_miguel_del_amargue_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'luis-miguel-del-amargue' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-miguel-del-amargue') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Miguel del Amargue is a Dominican bachata and tropical artist connected to Azua de Compostela, the capital of Azua province in the southwestern Dominican Republic. His artistic name — del Amargue, meaning roughly of the bitterness — embraces the emotional vocabulary of classic bachata, a genre defined by its frank expression of heartache, longing, and romantic suffering. Working within this tradition, Luis Miguel del Amargue has built a following among listeners who appreciate the raw emotional honesty that authentic bachata demands. His connection to the southwestern region of the country gives his music a flavor distinct from the urban Santo Domingo sound, rooted in the rural communities where bachata has always had its most devoted and unsentimental audience.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luis-miguel-del-amargue';
UPDATE artists SET bio_en = 'Luis Miguel del Amargue is a Dominican bachata and tropical artist connected to Azua de Compostela, the capital of Azua province in the southwestern Dominican Republic. His artistic name — del Amargue, meaning roughly of the bitterness — embraces the emotional vocabulary of classic bachata, a genre defined by its frank expression of heartache, longing, and romantic suffering. Working within this tradition, Luis Miguel del Amargue has built a following among listeners who appreciate the raw emotional honesty that authentic bachata demands. His connection to the southwestern region of the country gives his music a flavor distinct from the urban Santo Domingo sound, rooted in the rural communities where bachata has always had its most devoted and unsentimental audience.', bio_es = NULL, last_name = 'Fuentes' WHERE slug = 'luis-miguel-del-amargue';
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND cat.name = 'Bachatero del Año'
   AND w.artist_id = (SELECT id FROM artists WHERE slug = 'luis-miguel-del-amargue')
   AND ((a.name = 'Premios Casandra' AND w.year = 2010) OR (a.name = 'Premios Soberano' AND w.year = 2025));

COMMIT;
