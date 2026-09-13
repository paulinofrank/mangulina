BEGIN;

-- Corrige las cuatro contradicciones de FECHA COMPLETA que la primera auditoría
-- no podía ver, porque solo comparaba años.
-- 
-- Verificadas una por una contra fuentes externas; las tres veces que había
-- forma de comprobarlo, la fila tiene razón y la prosa está mal.
-- 
--   rene-del-risco-bermudez  texto "October 2, 1937"  ->  fila y Wikipedia: 9 DE MAYO
--   rene-del-risco-bermudez  texto "thirty-four"      ->  mayo 1937 a diciembre 1972 = 35
--   rubby-perez              texto "April 14, 1956"   ->  fila, BuenaMusica y Revista
--                                                         Pandora: 8 DE MARZO, en Haina
--   tatico-henriquez         texto "33 years"         ->  julio 1943 a mayo 1976 = 32
-- 
-- SE QUITA ADEMÁS LA CAUSA DE MUERTE en las dos fichas que la traían: "died in a
-- car accident" en René del Risco y el mismo giro en Tatico Henríquez. Es la
-- regla de siempre, la misma que apliqué a Eladio Romero Santos, a Jerry Vargas
-- y a Fernando Villalona. Que murió y cuándo se queda; cómo, no.
--
-- El documento y el espejo markdown se mueven juntos: la página pública sirve
-- el documento, pero una ficha en borrador cae al espejo, y dejar los dos
-- diciendo cosas distintas es un fallo invisible hasta que alguien lo lee.
--
-- Solo cambia texto. Ningún nodo artistReference se toca, así que los enlaces
-- y sus occurrence_id quedan como estaban y editorial_entity_references no se
-- reconstruye.
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.
--
-- PARA REVERTIR: supabase/rollback/20260908000100_revert_correct_full_date_contradictions.sql

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Born on October 2, 1937, in San Pedro de Macorís', 'Born on May 9, 1937, in San Pedro de Macorís')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rene-del-risco-bermudez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Born on October 2, 1937, in San Pedro de Macorís' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Born on October 2, 1937, in San Pedro de Macorís', 'Born on May 9, 1937, in San Pedro de Macorís'),
       updated_at = now()
 WHERE slug = 'rene-del-risco-bermudez'
   AND position('Born on October 2, 1937, in San Pedro de Macorís' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'His life was tragically cut short when he died in a car accident in Santo Domingo in 1972, at only thirty-four years of age.', 'He died in Santo Domingo in December 1972, at thirty-five.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rene-del-risco-bermudez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('His life was tragically cut short when he died in a car accident in Santo Domingo in 1972, at only thirty-four years of age.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'His life was tragically cut short when he died in a car accident in Santo Domingo in 1972, at only thirty-four years of age.', 'He died in Santo Domingo in December 1972, at thirty-five.'),
       updated_at = now()
 WHERE slug = 'rene-del-risco-bermudez'
   AND position('His life was tragically cut short when he died in a car accident in Santo Domingo in 1972, at only thirty-four years of age.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Born on April 14, 1956, in Haina', 'Born on March 8, 1956, in Haina')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rubby-perez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Born on April 14, 1956, in Haina' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Born on April 14, 1956, in Haina', 'Born on March 8, 1956, in Haina'),
       updated_at = now()
 WHERE slug = 'rubby-perez'
   AND position('Born on April 14, 1956, in Haina' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'His career was tragically cut short when he died in 1976 at just 33 years of age, leaving behind a body of work that was too brief but remains profoundly influential.', 'He died in May 1976, at thirty-two, leaving a body of work that was too brief but remains profoundly influential.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'tatico-henriquez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('His career was tragically cut short when he died in 1976 at just 33 years of age, leaving behind a body of work that was too brief but remains profoundly influential.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'His career was tragically cut short when he died in 1976 at just 33 years of age, leaving behind a body of work that was too brief but remains profoundly influential.', 'He died in May 1976, at thirty-two, leaving a body of work that was too brief but remains profoundly influential.'),
       updated_at = now()
 WHERE slug = 'tatico-henriquez'
   AND position('His career was tragically cut short when he died in 1976 at just 33 years of age, leaving behind a body of work that was too brief but remains profoundly influential.' in bio_en) > 0;

COMMIT;
