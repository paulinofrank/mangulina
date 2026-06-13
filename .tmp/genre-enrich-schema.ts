import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const result = await pool.query(`
    SELECT json_build_object(
      'recordings_columns', (
        SELECT json_agg(json_build_object('col', column_name, 'type', data_type, 'nullable', is_nullable) ORDER BY ordinal_position)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'recordings'
      ),
      'genres_columns', (
        SELECT json_agg(json_build_object('col', column_name, 'type', data_type) ORDER BY ordinal_position)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'genres'
      ),
      'artists_columns', (
        SELECT json_agg(json_build_object('col', column_name, 'type', data_type) ORDER BY ordinal_position)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'artists'
      ),
      'rpl_columns', (
        SELECT json_agg(json_build_object('col', column_name, 'type', data_type) ORDER BY ordinal_position)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'recording_platform_links'
      ),
      'fkeys', (
        SELECT coalesce(json_agg(json_build_object(
          'table', tc.table_name, 'col', kcu.column_name,
          'ref_table', ccu.table_name, 'ref_col', ccu.column_name)), '[]'::json)
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
        JOIN information_schema.constraint_column_usage ccu ON ccu.constraint_name = tc.constraint_name AND ccu.table_schema = tc.table_schema
        WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_schema = 'public'
          AND tc.table_name IN ('recordings','recording_platform_links')
      ),
      'genres_all', (
        SELECT json_agg(json_build_object('id', id, 'name', name, 'slug', slug, 'parent_id', parent_id, 'level', level, 'active', active) ORDER BY level, parent_id NULLS FIRST, sort_order)
        FROM public.genres
      ),
      'null_genre_count', (SELECT count(*) FROM public.recordings WHERE genre_id IS NULL),
      'total_recordings', (SELECT count(*) FROM public.recordings)
    ) AS report
  `);
  console.log(JSON.stringify(result.rows[0].report, null, 2));
} finally {
  await pool.end();
}
