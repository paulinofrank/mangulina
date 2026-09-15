BEGIN;

-- Revierte 20260915015000_rewrite_sandy_gabriel_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sandy-gabriel' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sandy-gabriel') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sandy Gabriel is a Dominican jazz musician born in 1974 in Puerto Plata, the northern coastal city that has contributed significantly to Dominican musical life across multiple genres. His work in jazz, Latin jazz, and fusion reflects a deep engagement with the improvisational and harmonic traditions that define jazz as a creative practice, filtered through a Caribbean sensibility that draws on the rhythmic richness of Puerto Plata''s musical environment. Gabriel has contributed to Dominican jazz culture through his recordings and performances, working in a tradition that values musical sophistication and artistic risk-taking alongside the communicative power of melody and groove. He represents the jazz tradition in the Dominican north, a region whose musical contribution extends well beyond the merengue for which it is best known.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sandy-gabriel';
UPDATE artists SET bio_en = 'Sandy Gabriel is a Dominican jazz musician born in 1974 in Puerto Plata, the northern coastal city that has contributed significantly to Dominican musical life across multiple genres. His work in jazz, Latin jazz, and fusion reflects a deep engagement with the improvisational and harmonic traditions that define jazz as a creative practice, filtered through a Caribbean sensibility that draws on the rhythmic richness of Puerto Plata''s musical environment. Gabriel has contributed to Dominican jazz culture through his recordings and performances, working in a tradition that values musical sophistication and artistic risk-taking alongside the communicative power of melody and groove. He represents the jazz tradition in the Dominican north, a region whose musical contribution extends well beyond the merengue for which it is best known.', bio_es = NULL, second_last_name = NULL,
       birth_place = 'Puerto Plata', province = 'Puerto Plata',
       date_of_birth = NULL,
       birth_year = 1974 WHERE slug = 'sandy-gabriel';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Concierto del Año'
   AND w.year = 2012 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'sandy-gabriel');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premio Nacional de Música' AND cat.name = 'Jazz'
   AND w.year = 2003 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'sandy-gabriel');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Concierto del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premio Nacional de Música' AND cat.name = 'Jazz'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM awards a WHERE a.name = 'Premios Casandra'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);
DELETE FROM awards a WHERE a.name = 'Premio Nacional de Música'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);

COMMIT;
