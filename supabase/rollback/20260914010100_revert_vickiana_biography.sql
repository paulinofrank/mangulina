BEGIN;

-- Revierte 20260914010100_rewrite_vickiana_biography.sql con los valores
-- que la fila tenía justo antes de aplicarla.
--
-- Aviso: la ficha ya tenía un documento en inglés (la migración lo dejó en
-- revisión 2) y su contenido anterior no se capturó. Este rollback borra los
-- dos documentos; el perfil vuelve a leer el espejo legacy bio_en, que sí se
-- restaura con su valor previo.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'vickiana' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vickiana') AND document_type = 'artist_biography';
UPDATE artists SET first_name = NULL, middle_name = NULL, last_name = NULL,
       second_last_name = NULL, province = 'Distrito Nacional', instagram = NULL,
       occupations = '[]'::jsonb, bio_en = 'Vickiana is a celebrated Dominican singer whose powerful voice and passionate stage presence made her one of the most popular female performers in the country''s mainstream music scene. Born in 1958 in Santo Domingo, she rose to prominence through a combination of vocal talent and natural showmanship, building a following that has remained loyal across multiple generations of Dominican music fans.

Her style draws on merengue, balada, and Latin pop, and she has shown a particular gift for large-scale emotional performances that translate effectively in both intimate venues and major concert settings. Vickiana became a familiar presence on Dominican television and radio, and her recordings received significant airplay throughout the 1980s and 1990s. She has remained an active performer well into the twenty-first century, continuing to connect with audiences who remember her from her peak years as well as newer fans discovering her catalog.

Her energy and commitment to performance have made her something of an institution in Dominican popular entertainment, an artist whose longevity speaks to the genuine depth of her connection with her audience.', bio_es = NULL
 WHERE slug = 'vickiana';
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND w.artist_id = (SELECT id FROM artists WHERE slug = 'vickiana')
   AND ((a.name = 'Premios Casandra' AND cat.name = 'Cantante Popular' AND w.year = 1985)
     OR (a.name = 'Premios Soberano' AND cat.name = 'Soberano al Mérito' AND w.year = 2015));
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Cantante Popular'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
