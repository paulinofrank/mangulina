BEGIN;

-- Revierte 20260915010500_rewrite_maffio_biography.sql con los documentos y
-- premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'maffio' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'maffio') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Maffio is a Dominican-born musician and producer whose career has straddled the worlds of urban music, reggaeton, Latin pop, and merengue with impressive fluency. Born in 1986 in Santo Domingo, he spent formative years in Canada, an experience that gave him a bicultural perspective and exposed him to a wide range of musical influences beyond the Dominican and Caribbean sounds of his upbringing.","type":"text"}]},{"type":"paragraph","content":[{"text":"He returned to the Latin music world with a production sensibility that drew on both the rhythms of his homeland and the international currents he had absorbed abroad. Maffio established himself as a sought-after songwriter and producer, working with major artists across the Latin urban spectrum and contributing to numerous hit records. As a performer, his smooth vocal style and instinct for melody have given his solo recordings a polished appeal that translates well across radio, streaming, and live performance.","type":"text"}]},{"type":"paragraph","content":[{"text":"His ability to function as both a creative producer behind the scenes and a front-facing artist has made him a versatile figure in the industry, and his collaborations with artists from across Latin America have kept his name in circulation throughout the 2010s and beyond. Maffio represents a generation of Dominican musicians who are equally comfortable operating in local and international contexts.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'maffio';
UPDATE artists SET bio_en = 'Maffio is a Dominican-born musician and producer whose career has straddled the worlds of urban music, reggaeton, Latin pop, and merengue with impressive fluency. Born in 1986 in Santo Domingo, he spent formative years in Canada, an experience that gave him a bicultural perspective and exposed him to a wide range of musical influences beyond the Dominican and Caribbean sounds of his upbringing.

He returned to the Latin music world with a production sensibility that drew on both the rhythms of his homeland and the international currents he had absorbed abroad. Maffio established himself as a sought-after songwriter and producer, working with major artists across the Latin urban spectrum and contributing to numerous hit records. As a performer, his smooth vocal style and instinct for melody have given his solo recordings a polished appeal that translates well across radio, streaming, and live performance.

His ability to function as both a creative producer behind the scenes and a front-facing artist has made him a versatile figure in the industry, and his collaborations with artists from across Latin America have kept his name in circulation throughout the 2010s and beyond. Maffio represents a generation of Dominican musicians who are equally comfortable operating in local and international contexts.', bio_es = NULL WHERE slug = 'maffio';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Fusion Album'
   AND w.year = 2012 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'maffio');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Traditional Pop Vocal Album'
   AND w.year = 2014 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'maffio');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Fusion Album'
   AND w.year = 2016 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'maffio');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Latin Pop Song of the Year'
   AND w.year = 2024 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'maffio');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Fusion Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Traditional Pop Vocal Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Fusion Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Latin Pop Song of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
