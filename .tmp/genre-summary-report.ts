import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT
      g.id,
      g.name AS genre,
      g.slug,
      COUNT(r.id)::int AS count,
      ROUND(100.0 * COUNT(r.id) / (SELECT COUNT(*) FROM public.recordings), 1) AS percent_of_all,
      ROUND(100.0 * COUNT(r.id) / (SELECT COUNT(*) FROM public.recordings WHERE genre_id IS NOT NULL), 1) AS percent_of_assigned
    FROM public.genres g
    LEFT JOIN public.recordings r ON r.genre_id = g.id
    WHERE g.level = 0 AND g.active
    GROUP BY g.id, g.name, g.slug
    ORDER BY COUNT(r.id) DESC
  `);

  console.log(`Genre Summary (${rows.length} genres)\n`);
  console.table(rows);

  const totalWithGenre = rows.reduce((sum, r) => sum + r.count, 0);
  const totalNull = (await pool.query(`SELECT COUNT(*) FROM public.recordings WHERE genre_id IS NULL`)).rows[0].count;
  const grandTotal = totalWithGenre + totalNull;

  console.log(`\nTotals:`);
  console.log(`  With genre: ${totalWithGenre} (${(100 * totalWithGenre / grandTotal).toFixed(1)}%)`);
  console.log(`  Still NULL: ${totalNull} (${(100 * totalNull / grandTotal).toFixed(1)}%)`);
  console.log(`  Grand total: ${grandTotal}`);
} finally {
  await pool.end();
}
