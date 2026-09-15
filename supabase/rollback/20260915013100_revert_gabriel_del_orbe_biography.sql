BEGIN;

-- Revierte 20260915013100_rewrite_gabriel_del_orbe_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'gabriel-del-orbe' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'gabriel-del-orbe') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Gabriel del Orbe was a Dominican composer born in 1888 in Concepción de la Vega, a city in the fertile Cibao valley that has long been a cradle of Dominican culture and music. Working in the European Romantic tradition and within the classical idiom, Del Orbe was among the generation of Dominican composers who sought to bring formal Western compositional techniques to bear on a national musical identity.","type":"text"}]},{"type":"paragraph","content":[{"text":"His works reflected the lush Romantic aesthetic of the late nineteenth and early twentieth centuries, with an emphasis on melody, harmonic richness, and emotional expressiveness. Concepción de la Vega''s cultural energy infused his musical imagination, even as his training oriented him toward European models. Del Orbe passed away in 1966, having lived through eight decades that witnessed the Dominican Republic''s most dramatic political and social upheavals — all of which formed the backdrop against which he quietly pursued his art.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'gabriel-del-orbe';
UPDATE artists SET bio_en = 'Gabriel del Orbe was a Dominican composer born in 1888 in Concepción de la Vega, a city in the fertile Cibao valley that has long been a cradle of Dominican culture and music. Working in the European Romantic tradition and within the classical idiom, Del Orbe was among the generation of Dominican composers who sought to bring formal Western compositional techniques to bear on a national musical identity.

His works reflected the lush Romantic aesthetic of the late nineteenth and early twentieth centuries, with an emphasis on melody, harmonic richness, and emotional expressiveness. Concepción de la Vega''s cultural energy infused his musical imagination, even as his training oriented him toward European models. Del Orbe passed away in 1966, having lived through eight decades that witnessed the Dominican Republic''s most dramatic political and social upheavals — all of which formed the backdrop against which he quietly pursued his art.', bio_es = NULL, second_last_name = NULL,
       birth_place = 'Concepción de la Vega', province = 'La Vega',
       instruments = ARRAY[]::text[] WHERE slug = 'gabriel-del-orbe';

COMMIT;
