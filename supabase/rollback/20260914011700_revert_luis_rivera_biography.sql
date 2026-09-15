BEGIN;

-- Revierte 20260914011700_rewrite_luis_rivera_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-armando-rivera-gonzalez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Armando Rivera González was a Dominican musician and composer born in 1901 in San Fernando de Monte Cristi, a northern coastal city whose relative isolation gave its cultural life a distinctive regional character. Rivera González worked across classical composition, merengue, bolero, and zarzuela — the Spanish operetta tradition that maintained a devoted following in Latin American musical culture well into the twentieth century.","type":"text"}]},{"type":"paragraph","content":[{"text":"This breadth of engagement made him a culturally amphibious figure, equally at home in the formal concert hall and in the more popular spaces where merengue and bolero were the languages of everyday feeling. His zarzuela work in particular connected Dominican musical culture to a Hispanic theatrical tradition with deep roots in Spain and its former colonies, demonstrating the ways in which Dominican music was always part of a wider Spanish-language artistic conversation.","type":"text"}]},{"type":"paragraph","content":[{"text":"Rivera González passed away in 1986 at the age of eighty-four, having spent eight decades contributing to Dominican musical culture from its early twentieth-century formation through its mid-century flowering.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luis-armando-rivera-gonzalez';
UPDATE artists SET bio_en = 'Luis Armando Rivera González was a Dominican musician and composer born in 1901 in San Fernando de Monte Cristi, a northern coastal city whose relative isolation gave its cultural life a distinctive regional character. Rivera González worked across classical composition, merengue, bolero, and zarzuela — the Spanish operetta tradition that maintained a devoted following in Latin American musical culture well into the twentieth century.

This breadth of engagement made him a culturally amphibious figure, equally at home in the formal concert hall and in the more popular spaces where merengue and bolero were the languages of everyday feeling. His zarzuela work in particular connected Dominican musical culture to a Hispanic theatrical tradition with deep roots in Spain and its former colonies, demonstrating the ways in which Dominican music was always part of a wider Spanish-language artistic conversation.

Rivera González passed away in 1986 at the age of eighty-four, having spent eight decades contributing to Dominican musical culture from its early twentieth-century formation through its mid-century flowering.', bio_es = NULL,
       occupations = '[]'::jsonb WHERE slug = 'luis-armando-rivera-gonzalez';
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'El Soberano'
   AND w.year = 1985 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'luis-armando-rivera-gonzalez');

COMMIT;
