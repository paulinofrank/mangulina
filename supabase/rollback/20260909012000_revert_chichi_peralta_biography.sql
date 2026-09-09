BEGIN;

-- Revierte 20260909012000_rewrite_chichi_peralta_biography.sql
--
-- Aviso: el estado anterior devuelve el alias "Son Familia" a la fila de
-- Jandy Feliz, donde no corresponde.

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'chichi-peralta' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chichi-peralta')
   AND document_type = 'artist_biography';

UPDATE artists SET
  bio_es = NULL,
  bio_en = 'Chichi Peralta is one of the most innovative and celebrated figures in Dominican popular music, an artist whose willingness to blend merengue with an extraordinary range of musical influences helped redefine what Dominican music could sound like for a global audience. Born in 1966 in Santo Domingo, he grew up immersed in the rhythms of merengue and Caribbean popular music before developing an artistic vision that extended far beyond the genre''s traditional boundaries.

He came to prominence as a percussionist and arranger before emerging as a bandleader and vocalist, founding Son Familia, an ensemble that became one of the most critically acclaimed acts in Dominican music history. Son Familia''s sound incorporated elements of jazz, Afro-Cuban music, Brazilian rhythm, folk, and electronic production into a framework rooted in merengue and Dominican tradition, creating an approach that was simultaneously accessible and deeply sophisticated.

Peralta''s albums from the 1990s and 2000s were landmark records in Dominican popular music, earning him Latin Grammy recognition and widespread praise from critics and fellow musicians. His work demonstrated that merengue was not a static form but a living tradition capable of absorbing and transforming new influences without losing its essential identity. Beyond his recording career, Peralta has been an active advocate for Dominican cultural heritage and a mentor to younger musicians.

He is widely regarded as one of the most important Dominican musicians of his generation — an artist who expanded the horizons of his country''s music while remaining deeply connected to its roots.'
WHERE slug = 'chichi-peralta';

UPDATE artists
   SET aliases = array_append(coalesce(aliases, '{}'::text[]), 'Son Familia')
 WHERE slug = 'jandy-feliz' AND NOT ('Son Familia' = ANY(coalesce(aliases, '{}'::text[])));

DELETE FROM artist_awards w
 USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id
   AND w.artist_id = (SELECT id FROM artists WHERE slug = 'chichi-peralta')
   AND a.name = 'Latin Grammy'
   AND ((cat.name = 'Best Merengue Album' AND w.year = 2001)
     OR (cat.name = 'Best Merengue/Bachata Album' AND w.year = 2006));

COMMIT;
