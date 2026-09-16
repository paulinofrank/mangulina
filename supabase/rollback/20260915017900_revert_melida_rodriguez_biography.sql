BEGIN;

-- Revierte 20260915017900_rewrite_melida_rodriguez_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'melida-rodriguez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'melida-rodriguez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Mélida Rodríguez was a Dominican bachata artist whose recordings have contributed to the rich and varied landscape of the genre. Bachata, which evolved from the working-class margins of Dominican society to become one of the most globally recognized Latin musical forms, has always been a space where artists of varying levels of visibility have added their voices to the genre''s ongoing conversation about love, loss, and longing. Rodríguez brought her own interpretation to the bachata tradition, and her music speaks to the genre''s enduring appeal as a vehicle for sincere emotional expression. While she did not occupy the highest levels of commercial visibility, her work is part of the broader Dominican bachata community that sustains the genre''s vitality through the contributions of many artists rather than a few dominant stars.","type":"text"}]}]}'::jsonb, 'published', id, 3 FROM artists WHERE slug = 'melida-rodriguez';
UPDATE artists SET bio_en = 'Mélida Rodríguez was a Dominican bachata artist whose recordings have contributed to the rich and varied landscape of the genre. Bachata, which evolved from the working-class margins of Dominican society to become one of the most globally recognized Latin musical forms, has always been a space where artists of varying levels of visibility have added their voices to the genre''s ongoing conversation about love, loss, and longing. Rodríguez brought her own interpretation to the bachata tradition, and her music speaks to the genre''s enduring appeal as a vehicle for sincere emotional expression. While she did not occupy the highest levels of commercial visibility, her work is part of the broader Dominican bachata community that sustains the genre''s vitality through the contributions of many artists rather than a few dominant stars.', bio_es = NULL, death_year = '1982', date_of_death = '1982-11-14'
       WHERE slug = 'melida-rodriguez';

COMMIT;
