import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });
try {
  const r = await pool.query(`
    SELECT recording_id, apple_id, apple_name, apple_artist_name, apple_album_name,
           apple_genre_names, apple_release_date, apple_isrc, confidence, reason,
           raw->>'artworkUrl' AS artwork
    FROM public.apple_recording_candidates
    ORDER BY checked_at DESC
  `);
  console.log(JSON.stringify(r.rows, null, 2));
} finally {
  await pool.end();
}
