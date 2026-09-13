BEGIN;

-- Revierte 20260908004800_pepe_rosario_siblings.sql.
--
-- Se comprobó antes de aplicar que ninguno de los dos pares existía, así que
-- borrarlos no destruye trabajo anterior. NO TOCA el par Rafa-Toño, que ya
-- estaba registrado y no lo creó esta migración.

DELETE FROM artist_family_relationships r
 USING artists p, artists o
 WHERE p.slug = 'pepe-rosario'
   AND o.slug IN ('tono-rosario', 'rafa-rosario')
   AND r.relationship_type = 'sibling'
   AND r.pair_low = LEAST(p.id, o.id)
   AND r.pair_high = GREATEST(p.id, o.id);

COMMIT;
