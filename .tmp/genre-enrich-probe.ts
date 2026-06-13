import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const result = await pool.query(`
    SELECT json_build_object(
      'genre_id_level_usage', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT g.level, count(*) n FROM public.recordings r JOIN public.genres g ON g.id = r.genre_id
          GROUP BY g.level ORDER BY g.level
        ) t
      ),
      'genre_distribution', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT g.name, g.id, count(*) n FROM public.recordings r JOIN public.genres g ON g.id = r.genre_id
          GROUP BY g.name, g.id ORDER BY n DESC
        ) t
      ),
      'import_mapping_columns', (
        SELECT json_agg(column_name ORDER BY ordinal_position)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'genre_import_mapping'
      ),
      'import_mapping_sample', (
        SELECT coalesce(json_agg(row_to_json(t)), '[]'::json) FROM (
          SELECT * FROM public.genre_import_mapping LIMIT 60
        ) t
      ),
      'metadata_keys', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT k AS key, count(*) n
          FROM public.recordings r, jsonb_object_keys(r.metadata) k
          WHERE r.genre_id IS NULL AND r.metadata IS NOT NULL
          GROUP BY k ORDER BY n DESC LIMIT 30
        ) t
      ),
      'null_with_artist', (SELECT count(*) FROM public.recordings WHERE genre_id IS NULL AND artist_id IS NOT NULL),
      'null_artist_primary_genre', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT a.primary_genre, count(*) n
          FROM public.recordings r JOIN public.artists a ON a.id = r.artist_id
          WHERE r.genre_id IS NULL
          GROUP BY a.primary_genre ORDER BY n DESC LIMIT 30
        ) t
      ),
      'null_artist_genres_array', (
        SELECT count(*) FROM public.recordings r JOIN public.artists a ON a.id = r.artist_id
        WHERE r.genre_id IS NULL AND a.genres IS NOT NULL AND array_length(a.genres, 1) > 0
      ),
      'null_with_platform_links', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT l.platform, count(DISTINCT r.id) n
          FROM public.recordings r JOIN public.recording_platform_links l ON l.recording_id = r.id
          WHERE r.genre_id IS NULL
          GROUP BY l.platform ORDER BY n DESC
        ) t
      ),
      'null_context_dist', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT recording_context, count(*) n FROM public.recordings WHERE genre_id IS NULL
          GROUP BY 1 ORDER BY 2 DESC
        ) t
      ),
      'sample_null_rows', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT r.id, r.title, a.name AS artist, r.recording_year, r.recording_context
          FROM public.recordings r LEFT JOIN public.artists a ON a.id = r.artist_id
          WHERE r.genre_id IS NULL ORDER BY r.views DESC LIMIT 15
        ) t
      ),
      'sample_metadata', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT r.metadata FROM public.recordings r
          WHERE r.genre_id IS NULL AND r.metadata IS NOT NULL LIMIT 3
        ) t
      )
    ) AS report
  `);
  console.log(JSON.stringify(result.rows[0].report, null, 2));
} finally {
  await pool.end();
}
