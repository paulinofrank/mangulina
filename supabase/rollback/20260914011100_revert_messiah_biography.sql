BEGIN;

-- Revierte 20260914011100_rewrite_messiah_biography.sql con los documentos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'messiah' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'messiah') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Messiah is a Dominican Latin trap and urban artist who emerged from Santiago de los Caballeros to become one of the more distinctive voices in the genre''s Spanish-language iteration. Born in 1990, he grew up in the cultural capital of the Cibao region, a city with a long tradition of producing important Dominican musical figures across many genres.","type":"text"}]},{"type":"paragraph","content":[{"text":"Messiah represents a younger generation of Dominican artists who absorbed the aesthetics of American trap music and remade them through a Caribbean lens, producing a sound that is simultaneously global in its sonic references and distinctly Latin in its flavor and sensibility. His music deals in the themes common to the genre — street life, ambition, loyalty, and romantic conquest — but his delivery and production choices give his work a personality that sets him apart within a crowded field.","type":"text"}]},{"type":"paragraph","content":[{"text":"He built his following through digital platforms and strategic collaborations with other Latin urban and trap artists, and his releases have found audiences throughout the Dominican Republic and across the Latin urban diaspora. Messiah is part of an exciting new wave of Dominican artists redefining what Dominican music can sound like for an international generation.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'messiah';
UPDATE artists SET bio_en = 'Messiah is a Dominican Latin trap and urban artist who emerged from Santiago de los Caballeros to become one of the more distinctive voices in the genre''s Spanish-language iteration. Born in 1990, he grew up in the cultural capital of the Cibao region, a city with a long tradition of producing important Dominican musical figures across many genres.

Messiah represents a younger generation of Dominican artists who absorbed the aesthetics of American trap music and remade them through a Caribbean lens, producing a sound that is simultaneously global in its sonic references and distinctly Latin in its flavor and sensibility. His music deals in the themes common to the genre — street life, ambition, loyalty, and romantic conquest — but his delivery and production choices give his work a personality that sets him apart within a crowded field.

He built his following through digital platforms and strategic collaborations with other Latin urban and trap artists, and his releases have found audiences throughout the Dominican Republic and across the Latin urban diaspora. Messiah is part of an exciting new wave of Dominican artists redefining what Dominican music can sound like for an international generation.', bio_es = NULL WHERE slug = 'messiah';

COMMIT;
