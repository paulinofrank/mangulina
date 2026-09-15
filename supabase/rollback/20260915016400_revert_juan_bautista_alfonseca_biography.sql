BEGIN;

-- Revierte 20260915016400_rewrite_juan_bautista_alfonseca_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-bautista-alfonseca' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-bautista-alfonseca') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Bautista Alfonseca holds a singular place in Dominican musical history as one of the founding fathers of merengue. Born in Santo Domingo in 1810, he was a military bandmaster and composer whose work in the mid-nineteenth century helped codify the rhythmic and structural elements that would define merengue as a national genre. Alfonseca composed music for military bands and civic occasions, but his lasting contribution was the role he played in shaping the danceable, percussion-driven style that merengue would become.","type":"text"}]},{"type":"paragraph","content":[{"text":"He worked at the intersection of European classical training and Dominican popular sensibility, a combination that gave early merengue its distinctive character — structured enough to be performed by formal ensembles yet earthy enough to fill a dance floor. His death in 1875 came before merengue achieved its full national stature, but the foundations he helped build proved enduring. Today Alfonseca is remembered as a patriot of both music and nation, a composer whose work was inseparable from the identity of the Dominican people.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-bautista-alfonseca';
UPDATE artists SET bio_en = 'Juan Bautista Alfonseca holds a singular place in Dominican musical history as one of the founding fathers of merengue. Born in Santo Domingo in 1810, he was a military bandmaster and composer whose work in the mid-nineteenth century helped codify the rhythmic and structural elements that would define merengue as a national genre. Alfonseca composed music for military bands and civic occasions, but his lasting contribution was the role he played in shaping the danceable, percussion-driven style that merengue would become.

He worked at the intersection of European classical training and Dominican popular sensibility, a combination that gave early merengue its distinctive character — structured enough to be performed by formal ensembles yet earthy enough to fill a dance floor. His death in 1875 came before merengue achieved its full national stature, but the foundations he helped build proved enduring. Today Alfonseca is remembered as a patriot of both music and nation, a composer whose work was inseparable from the identity of the Dominican people.', bio_es = NULL, second_last_name = NULL
       WHERE slug = 'juan-bautista-alfonseca';

COMMIT;
