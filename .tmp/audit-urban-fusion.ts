import "dotenv/config";

import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const result = await pool.query(`
    SELECT json_build_object(
      'urban_fusion_row', (
        SELECT row_to_json(g) FROM (
          SELECT id, name, slug, parent_id, level, active
          FROM public.genres WHERE id = 46
        ) g
      ),
      'recording_references', (
        SELECT count(*) FROM public.recordings WHERE genre_id = 46 OR subgenre_id = 46
      ),
      'mapping_references', (
        SELECT count(*) FROM public.genre_import_mapping WHERE genre_id = 46 OR subgenre_id = 46
      ),
      'mapping_rows', (
        SELECT coalesce(json_agg(rows ORDER BY rows.source_label), '[]'::json)
        FROM (
          SELECT source_label, genre_id, genre_name, subgenre_id, subgenre_name, recording_context
          FROM public.genre_import_mapping
          WHERE genre_id = 46 OR subgenre_id = 46
        ) rows
      ),
      'active_children', (
        SELECT count(*) FROM public.genres WHERE active AND level = 1 AND parent_id IS NOT NULL
      ),
      'subgenres_legacy_row', (
        SELECT row_to_json(s) FROM (
          SELECT id, genre_id, name FROM public.subgenres
          WHERE lower(name) = 'fusion' AND genre_id = 10
        ) s
      ),
      'christian_legacy_subgenres', (
        SELECT coalesce(json_agg(rows ORDER BY rows.id), '[]'::json)
        FROM (
          SELECT s.id, s.genre_id, s.name, s.description
          FROM public.subgenres s
          LEFT JOIN public.genres g ON g.id = s.genre_id
          WHERE lower(coalesce(s.name, '')) ~ '(christian|cristian)'
             OR lower(coalesce(s.description, '')) ~ '(christian|cristian)'
             OR lower(coalesce(g.name, '')) ~ '(christian|cristian)'
        ) rows
      )
    ) AS report
  `);
  console.log(JSON.stringify(result.rows[0].report, null, 2));
} finally {
  await pool.end();
}
