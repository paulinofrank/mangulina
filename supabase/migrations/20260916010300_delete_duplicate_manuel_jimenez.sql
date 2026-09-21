BEGIN;

-- Elimina la ficha duplicada manuel-de-jesus-jimenez-ortega: es la misma persona que manuel-jimenez. Se añade el nombre civil como alias y se reasignan los eventos de visita.

UPDATE artists SET aliases = array_append(coalesce(aliases, '{}'), 'Manuel de Jesús Jiménez Ortega') WHERE slug = 'manuel-jimenez' AND NOT ('Manuel de Jesús Jiménez Ortega' = ANY(coalesce(aliases, '{}')));

UPDATE artist_view_events SET artist_id = (SELECT id FROM artists WHERE slug = 'manuel-jimenez') WHERE id IN ('e8cd391f-37b8-46a1-b665-7400902384fd', 'b414a927-2cdf-4133-a7ab-c767aabe8ff6', '6868d1c5-2461-4334-b1a3-f7c317624306', '7c820f47-9726-46f2-b225-e2a2371dcbdc');

DELETE FROM artists WHERE slug = 'manuel-de-jesus-jimenez-ortega';

COMMIT;
