import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT
      COUNT(*) n,
      MAX(classified_at) latest,
      MIN(classified_at) earliest,
      now() as current_time
    FROM public.recordings
    WHERE ai_reason LIKE 'genre-enrich:%'
  `);
  console.log("Timestamp info:", JSON.stringify(rows[0], null, 2));

  const { rows: sample } = await pool.query(`
    SELECT title, classified_at, ai_reason
    FROM public.recordings
    WHERE ai_reason LIKE 'genre-enrich:%'
    ORDER BY classified_at DESC
    LIMIT 3
  `);
  console.log("\nLatest enriched records:");
  for (const r of sample) console.log(r);
} finally {
  await pool.end();
}
