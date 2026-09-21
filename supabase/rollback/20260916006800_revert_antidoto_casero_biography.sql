BEGIN;

-- Revierte 20260916006800_rewrite_antidoto_casero_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'antidoto-casero' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'antidoto-casero') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Antídoto Casero is a Dominican music group that has worked in the genres of fusion Afro-Caribbean music, alternative, and reggae, representing the creative edges of Dominican popular culture where global musical influences meet local traditions. Their name — Home Remedy — suggests an organic, grassroots approach to music-making that aligns with the alternative and reggae aesthetic of independence from commercial mainstream formulas. By fusing Afro-Caribbean rhythmic and cultural elements with reggae and alternative rock sensibilities, the group participates in a broader tradition of Caribbean musical synthesis that has always found new possibilities in the encounter between African-rooted rhythm and whatever other musical currents happen to be in the air.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'antidoto-casero';
UPDATE artists SET bio_en = 'Antídoto Casero is a Dominican music group that has worked in the genres of fusion Afro-Caribbean music, alternative, and reggae, representing the creative edges of Dominican popular culture where global musical influences meet local traditions. Their name — Home Remedy — suggests an organic, grassroots approach to music-making that aligns with the alternative and reggae aesthetic of independence from commercial mainstream formulas. By fusing Afro-Caribbean rhythmic and cultural elements with reggae and alternative rock sensibilities, the group participates in a broader tradition of Caribbean musical synthesis that has always found new possibilities in the encounter between African-rooted rhythm and whatever other musical currents happen to be in the air.', bio_es = NULL, primary_role = 'singer', primary_genre = 'fusion', genres = ARRAY['reggae']::text[] WHERE slug = 'antidoto-casero';

COMMIT;
