import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT current_database() AS db,
           current_schema() AS schema,
           current_user AS user,
           inet_server_addr() AS server,
           version() AS version
  `);
  console.log("Connected to:", JSON.stringify(rows[0], null, 2));

  // Check if genre_enrich updates exist
  const { rows: updates } = await pool.query(`
    SELECT COUNT(*) n FROM public.recordings
    WHERE ai_reason LIKE 'genre-enrich:%'
  `);
  console.log("Records with genre-enrich audit trail:", updates[0].n);

  // Check sample of what we're trying to update
  const { rows: sample } = await pool.query(`
    SELECT COUNT(*) n FROM public.recordings WHERE genre_id IS NULL LIMIT 1
  `);
  console.log("Current NULL genre_id count:", sample[0].n);
} finally {
  await pool.end();
}
