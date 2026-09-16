BEGIN;

-- Revierte 20260916002000_rewrite_alex_ferreira_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alex-ferreira' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'alex-ferreira') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Alex Ferreira is a Dominican singer-songwriter born in 1983 in Santo Domingo whose music represents one of the most distinctive voices in contemporary Dominican alternative and indie folk music. Working in a musical environment dominated by merengue, bachata, and urban Latin genres, Ferreira deliberately carved out a space for acoustic-driven songwriting that drew on Latin American singer-songwriter traditions, folk influences, and the textural interests of indie and alternative rock.","type":"text"}]},{"type":"paragraph","content":[{"text":"His sound has been described as tropical alternative — a label that captures the way his music remains rooted in the warmth and rhythmic sensibility of the Caribbean while reaching toward the introspective, layered aesthetics of global indie music. Ferreira''s lyrics are known for their literary quality and emotional intelligence, earning him a devoted following among listeners who value songwriting as a form of genuine artistic expression.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has performed extensively across the Dominican Republic and in other Latin American markets, building a reputation as one of the most thoughtful and original artists of his generation. His career stands as a reminder that Dominican music encompasses far more than its internationally recognized popular genres.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-ferreira';
UPDATE artists SET bio_en = 'Alex Ferreira is a Dominican singer-songwriter born in 1983 in Santo Domingo whose music represents one of the most distinctive voices in contemporary Dominican alternative and indie folk music. Working in a musical environment dominated by merengue, bachata, and urban Latin genres, Ferreira deliberately carved out a space for acoustic-driven songwriting that drew on Latin American singer-songwriter traditions, folk influences, and the textural interests of indie and alternative rock.

His sound has been described as tropical alternative — a label that captures the way his music remains rooted in the warmth and rhythmic sensibility of the Caribbean while reaching toward the introspective, layered aesthetics of global indie music. Ferreira''s lyrics are known for their literary quality and emotional intelligence, earning him a devoted following among listeners who value songwriting as a form of genuine artistic expression.

He has performed extensively across the Dominican Republic and in other Latin American markets, building a reputation as one of the most thoughtful and original artists of his generation. His career stands as a reminder that Dominican music encompasses far more than its internationally recognized popular genres.', bio_es = NULL,
       first_name = 'Alex', middle_name = NULL, second_last_name = NULL,
       occupations = '["songwriter","producer","guitarist"]'::jsonb
       WHERE slug = 'alex-ferreira';

COMMIT;
