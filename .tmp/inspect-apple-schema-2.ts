import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const r = await pool.query(`
    SELECT json_build_object(
      'artists_cols', (
        SELECT json_agg(column_name)
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'artists'
          AND column_name IN ('id', 'name', 'title', 'display_name')
      ),
      'recordings_artist_fk', (
        SELECT coalesce(json_agg(pg_get_constraintdef(oid)), '[]'::json)
        FROM pg_constraint
        WHERE conrelid = 'public.recordings'::regclass AND contype = 'f'
          AND pg_get_constraintdef(oid) LIKE '%artists%'
      ),
      'id_default', (
        SELECT column_default FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = 'apple_recording_candidates' AND column_name = 'id'
      ),
      'existing_candidates', (SELECT count(*) FROM public.apple_recording_candidates)
    ) AS r
  `);
  console.log(JSON.stringify(r.rows[0].r, null, 2));
} finally {
  await pool.end();
}
