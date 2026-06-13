import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT
      (SELECT COUNT(*) FROM public.recordings WHERE genre_id IS NULL) AS remaining_null,
      (SELECT COUNT(*) FROM public.recordings) AS total,
      (SELECT COUNT(*) FROM public.recordings WHERE ai_reason LIKE 'genre-enrich:%') AS enriched,
      ROUND(100.0 * (SELECT COUNT(*) FROM public.recordings WHERE ai_reason LIKE 'genre-enrich:%') / 17398, 1) AS percent_complete
  `);
  console.log(JSON.stringify(rows[0], null, 2));

  // Check if any records have been updated in the last 1 hour
  const { rows: recent } = await pool.query(`
    SELECT COUNT(*) FROM public.recordings
    WHERE classified_at > now() - interval '1 hour'
  `);
  console.log("Records updated in last 1 hour:", recent[0].count);
} finally {
  await pool.end();
}
