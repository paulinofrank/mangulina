BEGIN;

-- Revierte 20260916010000_create_yiyo_sarante.sql eliminando la ficha nueva, sus premios y el parentesco.

DELETE FROM artist_family_relationships WHERE artist_id = (SELECT id FROM artists WHERE slug = 'yiyo-sarante') OR related_artist_id = (SELECT id FROM artists WHERE slug = 'yiyo-sarante');
DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'yiyo-sarante');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yiyo-sarante') AND document_type = 'artist_biography';
DELETE FROM artists WHERE slug = 'yiyo-sarante';

COMMIT;
