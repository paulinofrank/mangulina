import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const result = await pool.query(`
    SELECT json_build_object(
      'genres_columns', (
        SELECT json_agg(column_name ORDER BY column_name)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'genres'
      ),
      'backup_tables', (
        SELECT coalesce(json_agg(tablename ORDER BY tablename), '[]'::json)
        FROM pg_tables
        WHERE schemaname = 'public'
          AND (tablename LIKE '%backup%' OR tablename LIKE '%validation%')
      ),
      'main_genres', (
        SELECT coalesce(json_agg(json_build_object('id', id, 'name', name, 'slug', slug, 'sort', sort_order, 'active', active) ORDER BY sort_order), '[]'::json)
        FROM public.genres WHERE level = 0 AND parent_id IS NULL AND active
      ),
      'child_genres', (
        SELECT coalesce(json_agg(json_build_object('id', g.id, 'name', g.name, 'parent', p.name, 'slug', g.slug, 'active', g.active) ORDER BY p.sort_order, g.sort_order), '[]'::json)
        FROM public.genres g JOIN public.genres p ON p.id = g.parent_id
        WHERE g.level = 1
      ),
      'inactive_rows', (
        SELECT coalesce(json_agg(json_build_object('id', id, 'name', name, 'slug', slug, 'level', level)), '[]'::json)
        FROM public.genres WHERE NOT active
      ),
      'jazz_rows', (
        SELECT coalesce(json_agg(json_build_object('id', id, 'name', name, 'slug', slug, 'parent_id', parent_id, 'level', level, 'active', active)), '[]'::json)
        FROM public.genres WHERE lower(name) = 'jazz'
      ),
      'christian_rows', (
        SELECT count(*) FROM public.genres
        WHERE lower(coalesce(name,'')) ~ '(christian|cristian)' OR lower(coalesce(slug,'')) ~ '(christian|cristian)'
      ),
      'total_recordings', (SELECT count(*) FROM public.recordings),
      'christian_recordings', (SELECT count(*) FROM public.recordings WHERE recording_context = 'christian'),
      'recording_context_values', (
        SELECT json_agg(json_build_object('value', recording_context, 'count', n))
        FROM (SELECT recording_context, count(*) n FROM public.recordings GROUP BY 1 ORDER BY 2 DESC) t
      ),
      'urban_fusion_46', (
        SELECT row_to_json(g) FROM (SELECT id, name, slug, parent_id, level, active FROM public.genres WHERE id = 46) g
      ),
      'urban_fusion_recording_refs', (SELECT count(*) FROM public.recordings WHERE genre_id = 46 OR subgenre_id = 46),
      'urban_fusion_mapping_refs', (SELECT count(*) FROM public.genre_import_mapping WHERE genre_id = 46 OR subgenre_id = 46),
      'jazz53_exists', (SELECT count(*) FROM public.genres WHERE id = 53),
      'pop_row', (
        SELECT row_to_json(g) FROM (SELECT id, name, slug, parent_id, level, active FROM public.genres WHERE lower(name) = 'pop' AND level = 0) g
      ),
      'validation_tables_content', (
        SELECT json_build_object(
          'promotions', (SELECT coalesce(json_agg(row_to_json(v)), '[]'::json) FROM (SELECT stage, captured_at FROM public.genre_taxonomy_migration_validation_20260612) v),
          'approved', (SELECT coalesce(json_agg(row_to_json(v)), '[]'::json) FROM (SELECT stage, captured_at FROM public.genre_taxonomy_final_validation_20260612) v)
        )
      ),
      'final_approved_validation_exists', (SELECT to_regclass('public.genre_taxonomy_final_approved_validation_20260612') IS NOT NULL),
      'subgenres_exists', (SELECT to_regclass('public.subgenres') IS NOT NULL),
      'subgenres_count', (SELECT count(*) FROM public.subgenres)
    ) AS report
  `);
  console.log(JSON.stringify(result.rows[0].report, null, 2));
} finally {
  await pool.end();
}
