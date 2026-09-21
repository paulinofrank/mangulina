BEGIN;

-- Revierte 20260916005400_rewrite_dary_hezz_biography.sql con los documentos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dary-hezz' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'dary-hezz') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Dary Hezz is a young Dominican urban, dembow, and reggaeton artist born in 2003 in Santo Domingo who has grown up within the fully formed ecosystem of Dominican urban music. By the time Dary Hezz was a teenager, Dominican dembow had already produced major international figures and established a clear aesthetic identity, giving younger artists both a template and a challenge — how to add something genuinely new to a tradition that had already reached global audiences. His music participates in the ongoing evolution of that sound, bringing the energy and perspective of a generation that grew up with streaming, social media, and instant global access to music from everywhere. Dary Hezz represents the continuing renewal of Dominican urban music with each new cohort of emerging artists.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'dary-hezz';
UPDATE artists SET bio_en = 'Dary Hezz is a young Dominican urban, dembow, and reggaeton artist born in 2003 in Santo Domingo who has grown up within the fully formed ecosystem of Dominican urban music. By the time Dary Hezz was a teenager, Dominican dembow had already produced major international figures and established a clear aesthetic identity, giving younger artists both a template and a challenge — how to add something genuinely new to a tradition that had already reached global audiences. His music participates in the ongoing evolution of that sound, bringing the energy and perspective of a generation that grew up with streaming, social media, and instant global access to music from everywhere. Dary Hezz represents the continuing renewal of Dominican urban music with each new cohort of emerging artists.', bio_es = NULL WHERE slug = 'dary-hezz';

COMMIT;
