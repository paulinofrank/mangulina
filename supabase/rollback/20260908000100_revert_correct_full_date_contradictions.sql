BEGIN;

-- Revierte 20260908000100_correct_full_date_contradictions.sql.
--
-- Devuelve el texto anterior, con el registro conversacional que el editor
-- rechazó. Se conserva solo porque toda migración de este repositorio tiene
-- que ser reversible.

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Born on May 9, 1937, in San Pedro de Macorís', 'Born on October 2, 1937, in San Pedro de Macorís')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rene-del-risco-bermudez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Born on May 9, 1937, in San Pedro de Macorís' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Born on May 9, 1937, in San Pedro de Macorís', 'Born on October 2, 1937, in San Pedro de Macorís'),
       updated_at = now()
 WHERE slug = 'rene-del-risco-bermudez'
   AND position('Born on May 9, 1937, in San Pedro de Macorís' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'He died in Santo Domingo in December 1972, at thirty-five.', 'His life was tragically cut short when he died in a car accident in Santo Domingo in 1972, at only thirty-four years of age.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rene-del-risco-bermudez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('He died in Santo Domingo in December 1972, at thirty-five.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'He died in Santo Domingo in December 1972, at thirty-five.', 'His life was tragically cut short when he died in a car accident in Santo Domingo in 1972, at only thirty-four years of age.'),
       updated_at = now()
 WHERE slug = 'rene-del-risco-bermudez'
   AND position('He died in Santo Domingo in December 1972, at thirty-five.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Born on March 8, 1956, in Haina', 'Born on April 14, 1956, in Haina')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rubby-perez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Born on March 8, 1956, in Haina' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Born on March 8, 1956, in Haina', 'Born on April 14, 1956, in Haina'),
       updated_at = now()
 WHERE slug = 'rubby-perez'
   AND position('Born on March 8, 1956, in Haina' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'He died in May 1976, at thirty-two, leaving a body of work that was too brief but remains profoundly influential.', 'His career was tragically cut short when he died in 1976 at just 33 years of age, leaving behind a body of work that was too brief but remains profoundly influential.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'tatico-henriquez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('He died in May 1976, at thirty-two, leaving a body of work that was too brief but remains profoundly influential.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'He died in May 1976, at thirty-two, leaving a body of work that was too brief but remains profoundly influential.', 'His career was tragically cut short when he died in 1976 at just 33 years of age, leaving behind a body of work that was too brief but remains profoundly influential.'),
       updated_at = now()
 WHERE slug = 'tatico-henriquez'
   AND position('He died in May 1976, at thirty-two, leaving a body of work that was too brief but remains profoundly influential.' in bio_en) > 0;

COMMIT;
