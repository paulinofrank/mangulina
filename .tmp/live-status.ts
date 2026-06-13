import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT
      (SELECT COUNT(*) FROM public.recordings WHERE genre_id IS NULL) AS remaining,
      (SELECT COUNT(*) FROM public.recordings WHERE ai_reason LIKE 'genre-enrich:%') AS enriched,
      ROUND(100.0 * (SELECT COUNT(*) FROM public.recordings WHERE ai_reason LIKE 'genre-enrich:%') / 17398, 1) AS percent,
      ROUND(100.0 * (SELECT COUNT(*) FROM public.recordings WHERE genre_id IS NOT NULL) / 17398, 1) AS total_with_genre
  `);
  console.log(JSON.stringify(rows[0], null, 2));
} finally {
  await pool.end();
}
