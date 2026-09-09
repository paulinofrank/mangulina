BEGIN;

-- Revierte 20260909011800_rewrite_michel_camilo_biography.sql

-- 1. Referencias y documentos editoriales
DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'michel-camilo' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'michel-camilo')
   AND document_type = 'artist_biography';

-- 2. Espejo legacy: texto anterior a la reescritura
UPDATE artists SET
  bio_es = NULL,
  bio_en = 'Michel Camilo is arguably the most internationally celebrated Dominican instrumentalist of his generation, a pianist and composer whose brilliance has illuminated concert halls and jazz stages around the world for more than four decades. Born in Santo Domingo in 1954, Camilo displayed extraordinary musical talent as a child, studying at the National Conservatory of Music before moving to New York City in the late 1970s to pursue a career on the global stage.

In New York he absorbed the jazz tradition with the same hunger he had brought to classical training, and the synthesis of those worlds became his artistic signature. His playing is characterized by breathtaking technical velocity paired with deep musicality — a combination that has drawn comparisons to the great pianists of both jazz and classical traditions.

Camilo''s recordings, including landmark albums that paired him with flamenco guitarist Tomatito in an unlikely but electrifying collaboration, have won Grammy Awards and introduced his music to audiences far beyond Latin America. His compositions move fluidly between Latin jazz, classical structure, and the rhythmic fire of Dominican and Caribbean music, reflecting a musical intelligence that refuses to be confined by genre.

A professor and advocate for music education as well as a performer, Camilo has represented Dominican artistry at the highest levels of international music culture, earning a place among the elite pianists of his era.'
WHERE slug = 'michel-camilo';

-- 3. Las tres adjudicaciones añadidas
DELETE FROM artist_awards w
 USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id
   AND w.artist_id = (SELECT id FROM artists WHERE slug = 'michel-camilo')
   AND ((a.name = 'Grammy' AND cat.name = 'Best Latin Jazz Album' AND w.year = 2004)
     OR (a.name = 'Latin Grammy' AND cat.name = 'Best Latin Jazz Album' AND w.year = 2000)
     OR (a.name = 'Gobierno de la República Dominicana'
         AND cat.name = 'Orden Heráldica de Cristóbal Colón' AND w.year = 1992));

-- 4. Las dos categorías nuevas, solo si nadie más las usa
DELETE FROM award_categories cat
 USING awards a
 WHERE cat.award_id = a.id
   AND a.name IN ('Grammy', 'Latin Grammy')
   AND cat.name = 'Best Latin Jazz Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
