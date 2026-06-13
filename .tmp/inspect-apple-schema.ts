import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const result = await pool.query(`
    SELECT json_build_object(
      'link_tables', (
        SELECT coalesce(json_agg(tablename ORDER BY tablename), '[]'::json)
        FROM pg_tables
        WHERE schemaname = 'public'
          AND (tablename LIKE '%link%' OR tablename LIKE '%platform%' OR tablename LIKE '%apple%')
      ),
      'rpl_columns', (
        SELECT coalesce(json_agg(json_build_object('name', column_name, 'type', data_type) ORDER BY ordinal_position), '[]'::json)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'recording_platform_links'
      ),
      'recordings_url_columns', (
        SELECT coalesce(json_agg(column_name ORDER BY column_name), '[]'::json)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'recordings'
          AND (column_name LIKE '%url%' OR column_name LIKE '%apple%')
      ),
      'apple_platform_values', (
        SELECT coalesce(json_agg(t), '[]'::json) FROM (
          SELECT platform, link_type, status, count(*) AS n
          FROM public.recording_platform_links
          WHERE platform ILIKE '%apple%' OR url ILIKE '%apple.com%'
          GROUP BY 1, 2, 3 ORDER BY 4 DESC
        ) t
      ),
      'all_platform_values', (
        SELECT coalesce(json_agg(t), '[]'::json) FROM (
          SELECT platform, count(*) AS n
          FROM public.recording_platform_links
          GROUP BY 1 ORDER BY 2 DESC
        ) t
      ),
      'apple_sample_urls', (
        SELECT coalesce(json_agg(url), '[]'::json) FROM (
          SELECT url FROM public.recording_platform_links
          WHERE platform ILIKE '%apple%' OR url ILIKE '%apple.com%'
          LIMIT 5
        ) t
      ),
      'candidates_columns', (
        SELECT coalesce(json_agg(json_build_object('name', column_name, 'type', data_type) ORDER BY ordinal_position), '[]'::json)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'apple_recording_candidates'
      ),
      'candidates_constraints', (
        SELECT coalesce(json_agg(json_build_object('name', conname, 'def', pg_get_constraintdef(oid))), '[]'::json)
        FROM pg_constraint
        WHERE conrelid = 'public.apple_recording_candidates'::regclass
      ),
      'recordings_title_cols', (
        SELECT coalesce(json_agg(column_name ORDER BY column_name), '[]'::json)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'recordings'
          AND column_name IN ('id', 'title', 'name', 'artist_id', 'artist_name')
      )
    ) AS report
  `);
  console.log(JSON.stringify(result.rows[0].report, null, 2));
} finally {
  await pool.end();
}
