BEGIN;

-- Revierte 20260915010700_rewrite_luny_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'luny' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luny') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luny, born Francisco Saldaña in 1979 in the Dominican Republic, is one half of the landmark reggaeton production duo Luny Tunes, whose work in the early 2000s fundamentally shaped the sound and commercial trajectory of the genre. As a solo entity, Luny represents the production-side genius that made Luny Tunes so influential — a deep understanding of rhythm, melody, and arrangement that allowed the duo to craft tracks that were simultaneously danceable and emotionally resonant.","type":"text"}]},{"type":"paragraph","content":[{"text":"His Dominican roots brought a particular sensibility to the predominantly Puerto Rican reggaeton world, and his ability to absorb and synthesize Caribbean musical influences from multiple traditions gave his productions a richness that set them apart from more formulaic competitors. Luny has continued to work as a producer and musical presence in the Latin urban space following the duo''s most prolific period, maintaining connections to an industry he helped build.","type":"text"}]},{"type":"paragraph","content":[{"text":"His contributions to Latin music — through Luny Tunes'' catalog and his ongoing work — represent one of the most significant Dominican creative achievements in the history of popular music.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luny';
UPDATE artists SET bio_en = 'Luny, born Francisco Saldaña in 1979 in the Dominican Republic, is one half of the landmark reggaeton production duo Luny Tunes, whose work in the early 2000s fundamentally shaped the sound and commercial trajectory of the genre. As a solo entity, Luny represents the production-side genius that made Luny Tunes so influential — a deep understanding of rhythm, melody, and arrangement that allowed the duo to craft tracks that were simultaneously danceable and emotionally resonant.

His Dominican roots brought a particular sensibility to the predominantly Puerto Rican reggaeton world, and his ability to absorb and synthesize Caribbean musical influences from multiple traditions gave his productions a richness that set them apart from more formulaic competitors. Luny has continued to work as a producer and musical presence in the Latin urban space following the duo''s most prolific period, maintaining connections to an industry he helped build.

His contributions to Latin music — through Luny Tunes'' catalog and his ongoing work — represent one of the most significant Dominican creative achievements in the history of popular music.', bio_es = NULL,
       date_of_birth = '1979-06-18' WHERE slug = 'luny';

COMMIT;
