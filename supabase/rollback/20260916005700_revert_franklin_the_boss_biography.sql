BEGIN;

-- Revierte 20260916005700_rewrite_franklin_the_boss_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'franklin-the-boss' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'franklin-the-boss') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Franklin the Boss was a Dominican artist born in 1980 in Santo Domingo who worked in the merengue de calle and tropical traditions, genres that carry the raw, percussive energy of the street into the dance floor. Merengue de calle — street merengue — is a style defined by its driving rhythmic intensity and its connection to the working-class neighborhoods that have always been merengue''s most loyal constituency. Franklin the Boss brought that energy to his recordings and performances, connecting with audiences who valued the unpolished vitality that distinguishes merengue de calle from its more commercial counterparts. His death in 2025 marked the loss of a voice from that tradition, and his recordings remain as testimony to the enduring power of Dominican street merengue.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'franklin-the-boss';
UPDATE artists SET bio_en = 'Franklin the Boss was a Dominican artist born in 1980 in Santo Domingo who worked in the merengue de calle and tropical traditions, genres that carry the raw, percussive energy of the street into the dance floor. Merengue de calle — street merengue — is a style defined by its driving rhythmic intensity and its connection to the working-class neighborhoods that have always been merengue''s most loyal constituency. Franklin the Boss brought that energy to his recordings and performances, connecting with audiences who valued the unpolished vitality that distinguishes merengue de calle from its more commercial counterparts. His death in 2025 marked the loss of a voice from that tradition, and his recordings remain as testimony to the enduring power of Dominican street merengue.', bio_es = NULL, birth_place = 'Santo Domingo', province = 'Distrito Nacional',
       genres = ARRAY[]::text[] WHERE slug = 'franklin-the-boss';

COMMIT;
