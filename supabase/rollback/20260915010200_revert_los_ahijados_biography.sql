BEGIN;

-- Revierte 20260915010200_rewrite_los_ahijados_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'los-ahijados' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-ahijados') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Los Ahijados — The Godchildren — is a Dominican music group that has worked in the genres of son, bolero, and tropical, occupying a distinctive place within Dominican popular music through their engagement with the more intimate and romantic end of the Caribbean musical spectrum. Son and bolero are genres that demand subtlety and emotional restraint alongside rhythmic precision, and a group working in these traditions necessarily has a different aesthetic from the high-energy merengue ensembles that dominate Dominican popular culture. Their name carries a sense of affection and familial connection that suits the intimate emotional character of bolero and the rhythmically elegant world of son.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'los-ahijados';
UPDATE artists SET bio_en = 'Los Ahijados — The Godchildren — is a Dominican music group that has worked in the genres of son, bolero, and tropical, occupying a distinctive place within Dominican popular music through their engagement with the more intimate and romantic end of the Caribbean musical spectrum. Son and bolero are genres that demand subtlety and emotional restraint alongside rhythmic precision, and a group working in these traditions necessarily has a different aesthetic from the high-energy merengue ensembles that dominate Dominican popular culture. Their name carries a sense of affection and familial connection that suits the intimate emotional character of bolero and the rhythmically elegant world of son.', bio_es = NULL, formation_year = NULL, primary_genre = 'salsa' WHERE slug = 'los-ahijados';

COMMIT;
