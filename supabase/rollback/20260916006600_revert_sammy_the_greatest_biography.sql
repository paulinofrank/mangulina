BEGIN;

-- Revierte 20260916006600_rewrite_sammy_the_greatest_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sammy-the-greatest') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sammy the Greatest is a Dominican DJ and producer born on March 11, 1991, who has built a presence in the urban Dominican club and dembow circuit. His work as a selector and remix producer has placed him within the community of DJs who shape how Dominican urban music sounds in nightclubs and parties, bridging recorded tracks with live crowd energy. His association with dembow and Latin urban music connects him to the driving force of contemporary Dominican popular culture, and his work as a producer has contributed remixes and club edits that extend the life of tracks beyond their original recordings. Sammy the Greatest represents the DJ-producer archetype that is central to how Dominican dembow and urban music is distributed and experienced by audiences.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sammy-the-greatest';
UPDATE artists SET bio_en = 'Sammy the Greatest is a Dominican DJ and producer born on March 11, 1991, who has built a presence in the urban Dominican club and dembow circuit. His work as a selector and remix producer has placed him within the community of DJs who shape how Dominican urban music sounds in nightclubs and parties, bridging recorded tracks with live crowd energy. His association with dembow and Latin urban music connects him to the driving force of contemporary Dominican popular culture, and his work as a producer has contributed remixes and club edits that extend the life of tracks beyond their original recordings. Sammy the Greatest represents the DJ-producer archetype that is central to how Dominican dembow and urban music is distributed and experienced by audiences.', bio_es = NULL WHERE slug = 'sammy-the-greatest';

COMMIT;
