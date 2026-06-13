import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const client = await pool.connect();
  try {
    console.log("Testing write permission...");

    // Test 1: Simple INSERT
    const res1 = await client.query(
      `INSERT INTO public.recordings (id, title, views, recording_context)
       VALUES ($1, $2, $3, $4)
       ON CONFLICT (id) DO NOTHING`,
      ["00000000-0000-0000-0000-000000000001", "TEST_RECORD", 0, "secular"]
    );
    console.log("INSERT test:", res1.rowCount, "row(s) inserted");

    // Test 2: Try to UPDATE
    const res2 = await client.query(
      `UPDATE public.recordings
       SET genre_id = 1
       WHERE id = $1`,
      ["00000000-0000-0000-0000-000000000001"]
    );
    console.log("UPDATE test:", res2.rowCount, "row(s) updated");

    // Test 3: Transaction test
    await client.query("BEGIN");
    const res3 = await client.query(
      `UPDATE public.recordings
       SET ai_confidence = 0.99
       WHERE id = $1`,
      ["00000000-0000-0000-0000-000000000001"]
    );
    await client.query("COMMIT");
    console.log("TRANSACTION test:", res3.rowCount, "row(s) updated in transaction");

    // Check if write actually happened
    const { rows } = await client.query(
      `SELECT id, genre_id, ai_confidence FROM public.recordings WHERE id = $1`,
      ["00000000-0000-0000-0000-000000000001"]
    );
    console.log("Verification:", JSON.stringify(rows));

    // Cleanup
    await client.query(`DELETE FROM public.recordings WHERE id = $1`, ["00000000-0000-0000-0000-000000000001"]);
  } finally {
    client.release();
  }
} catch (e) {
  console.error("ERROR:", e instanceof Error ? e.message : e);
} finally {
  await pool.end();
}
