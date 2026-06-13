import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT json_build_object(
      'artist_mb_genres', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT g AS genre, count(*) n
          FROM public.artists a, unnest(a.genres) g
          WHERE EXISTS (SELECT 1 FROM public.recordings r WHERE r.artist_id = a.id AND r.genre_id IS NULL)
          GROUP BY g ORDER BY n DESC LIMIT 40
        ) t
      ),
      'coverage', (
        SELECT row_to_json(t) FROM (
          SELECT
            count(*) FILTER (WHERE apple.recording_id IS NOT NULL) AS has_apple,
            count(*) FILTER (WHERE apple.recording_id IS NULL AND dz.recording_id IS NOT NULL) AS deezer_only,
            count(*) FILTER (WHERE apple.recording_id IS NULL AND dz.recording_id IS NULL) AS no_apple_no_deezer,
            count(*) FILTER (WHERE r.mbid IS NOT NULL) AS has_mbid,
            count(*) AS total
          FROM public.recordings r
          LEFT JOIN LATERAL (SELECT recording_id FROM public.recording_platform_links l WHERE l.recording_id = r.id AND l.platform='apple_music' AND l.external_id ~ '^[0-9]+$' LIMIT 1) apple ON true
          LEFT JOIN LATERAL (SELECT recording_id FROM public.recording_platform_links l WHERE l.recording_id = r.id AND l.platform='deezer' LIMIT 1) dz ON true
          WHERE r.genre_id IS NULL
        ) t
      ),
      'title_keywords', (
        SELECT row_to_json(t) FROM (
          SELECT
            count(*) FILTER (WHERE title ~* '\\mmerengue\\M') AS kw_merengue,
            count(*) FILTER (WHERE title ~* '\\mbachata\\M') AS kw_bachata,
            count(*) FILTER (WHERE title ~* '\\msalsa\\M') AS kw_salsa,
            count(*) FILTER (WHERE title ~* '\\m(dembow|reggaeton)\\M') AS kw_urban,
            count(*) FILTER (WHERE title ~* '\\mbolero\\M') AS kw_bolero
          FROM public.recordings WHERE genre_id IS NULL
        ) t
      ),
      'no_link_artist_prior', (
        SELECT json_agg(row_to_json(t)) FROM (
          SELECT a.primary_genre, count(*) n
          FROM public.recordings r
          JOIN public.artists a ON a.id = r.artist_id
          WHERE r.genre_id IS NULL
            AND NOT EXISTS (SELECT 1 FROM public.recording_platform_links l WHERE l.recording_id = r.id AND l.platform IN ('apple_music','deezer'))
          GROUP BY 1 ORDER BY 2 DESC
        ) t
      )
    ) AS report
  `);
  console.log(JSON.stringify(rows[0].report, null, 2));
} finally {
  await pool.end();
}
