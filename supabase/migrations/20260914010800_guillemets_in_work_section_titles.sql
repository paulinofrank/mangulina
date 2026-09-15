BEGIN;

-- Regla 4b: los títulos de sección que nombran una obra van entre « ».
-- Corrige dos fichas escritas hoy: «Sentimiento» (Teodoro Reyes) y
-- «Apágame la vela» (Vinicio Franco). Documentos en y es y espejo legacy.

UPDATE editorial_documents SET document = jsonb_set(document, '{content,8,content,0,text}', '"«Sentimiento»"'::jsonb), revision = revision + 1, updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'teodoro-reyes') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**Sentimiento**', '**«Sentimiento»**') WHERE slug = 'teodoro-reyes';
UPDATE editorial_documents SET document = jsonb_set(document, '{content,8,content,0,text}', '"«Sentimiento»"'::jsonb), revision = revision + 1, updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'teodoro-reyes') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**Sentimiento**', '**«Sentimiento»**') WHERE slug = 'teodoro-reyes';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Apágame la vela»"'::jsonb), revision = revision + 1, updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vinicio-franco') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**Apágame la vela**', '**«Apágame la vela»**') WHERE slug = 'vinicio-franco';
UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Apágame la vela»"'::jsonb), revision = revision + 1, updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vinicio-franco') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**Apágame la vela**', '**«Apágame la vela»**') WHERE slug = 'vinicio-franco';

COMMIT;
