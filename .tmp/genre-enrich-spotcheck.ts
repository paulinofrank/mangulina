import "dotenv/config";
import pg from "pg";
const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });
const { rows } = await pool.query(`
  SELECT r.title, a.name artist, g.name genre, r.ai_confidence conf, r.ai_reason
  FROM public.recordings r
  JOIN public.genres g ON g.id = r.genre_id
  LEFT JOIN public.artists a ON a.id = r.artist_id
  WHERE r.ai_reason LIKE 'genre-enrich:%'
  ORDER BY random() LIMIT 12`);
for (const r of rows) console.log(`${r.genre} (${r.conf}) | "${r.title}" — ${r.artist} | ${r.ai_reason}`);
await pool.end();
