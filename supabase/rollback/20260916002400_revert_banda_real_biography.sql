BEGIN;

-- Revierte 20260916002400_rewrite_banda_real_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'banda-real' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'banda-real') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Banda Real is one of the most important and respected ensembles in the tradition of merengue típico, the rural, accordion-driven form of merengue that predates and underlies the more urbanized and internationally known versions of the genre. Operating within a tradition rooted in the Cibao valley and the folk culture of the Dominican interior, Banda Real has been a dedicated custodian of the rhythmic and melodic vocabulary that defines authentic Dominican merengue in its most traditional expression.","type":"text"}]},{"type":"paragraph","content":[{"text":"Their music incorporates the güira, tambora, and accordion — the three instruments that form the core of típico merengue — and their recordings have helped document and popularize this form for audiences both in the Dominican Republic and abroad. Banda Real has also engaged with broader tropical and folkloric sounds, demonstrating the range of Dominican popular music while always returning to their roots in traditional merengue.","type":"text"}]},{"type":"paragraph","content":[{"text":"They are widely regarded as one of the most authentic voices in Dominican regional music and have earned the respect of both folk purists and mainstream audiences.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'banda-real';
UPDATE artists SET bio_en = 'Banda Real is one of the most important and respected ensembles in the tradition of merengue típico, the rural, accordion-driven form of merengue that predates and underlies the more urbanized and internationally known versions of the genre. Operating within a tradition rooted in the Cibao valley and the folk culture of the Dominican interior, Banda Real has been a dedicated custodian of the rhythmic and melodic vocabulary that defines authentic Dominican merengue in its most traditional expression.

Their music incorporates the güira, tambora, and accordion — the three instruments that form the core of típico merengue — and their recordings have helped document and popularize this form for audiences both in the Dominican Republic and abroad. Banda Real has also engaged with broader tropical and folkloric sounds, demonstrating the range of Dominican popular music while always returning to their roots in traditional merengue.

They are widely regarded as one of the most authentic voices in Dominican regional music and have earned the respect of both folk purists and mainstream audiences.', bio_es = NULL,
       formation_year = NULL
       WHERE slug = 'banda-real';

COMMIT;
