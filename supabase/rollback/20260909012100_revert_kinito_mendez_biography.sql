BEGIN;

-- Revierte 20260909012100_rewrite_kinito_mendez_biography.sql
--
-- Aviso: el estado anterior devuelve el apellido paterno equivocado, los dos
-- alias de banda, y la relación founder_of invertida (la banda como fundadora
-- de su fundador).

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'kinito-mendez' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'kinito-mendez')
   AND document_type = 'artist_biography';

UPDATE artists SET
  last_name        = 'Méndez',
  second_last_name = NULL,
  aliases          = ARRAY['La Coco Band', 'La Rokabanda']::text[],
  bio_es           = NULL,
  bio_en           = 'Kinito Méndez is one of the Dominican Republic''s most beloved merengue entertainers, born in 1963 in Padre Las Casas, a municipality in the Azua province. He built his career on a style that combined traditional merengue rhythms with sharp social observation and a talent for comedy and storytelling that made his recordings feel like windows into everyday Dominican life.

His songs chronicled the experiences, frustrations, and joys of ordinary Dominicans with affection and humor, earning him a mass following that crossed regional, class, and generational lines. Méndez had a knack for capturing the mood of the moment — whether writing about social issues, cultural quirks, or romantic misadventures — and transforming those observations into irresistible songs.

He was especially celebrated for his work during the holiday season, and his Christmas merengues became an enduring part of Dominican festive culture, played year after year as an essential part of the seasonal soundtrack. Kinito Méndez is regarded as one of the people''s artists of Dominican merengue — a musician who spoke to and for his community with intelligence, warmth, and an unfailing sense of rhythm.'
WHERE slug = 'kinito-mendez';

-- Las tres relaciones creadas
DELETE FROM artist_relationships r
 USING artists k, artists g
 WHERE r.source_artist_id = k.id AND r.target_artist_id = g.id
   AND k.slug = 'kinito-mendez'
   AND ((g.slug = 'rokabanda' AND r.relationship_type = 'founder_of')
     OR (g.slug = 'rikarena' AND r.relationship_type = 'founder_of')
     OR (g.slug = 'pochy-y-su-cocoband' AND r.relationship_type = 'member_of'));

-- Y la invertida que había antes
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year)
SELECT b.id, k.id, 'founder_of', 1991, 1995
  FROM artists b, artists k WHERE b.slug = 'rokabanda' AND k.slug = 'kinito-mendez'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = b.id
                     AND r.target_artist_id = k.id AND r.relationship_type = 'founder_of');

COMMIT;
