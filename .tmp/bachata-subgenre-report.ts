import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT
      COALESCE(sg.name, '(no subgenre)') AS subgenre,
      COALESCE(sg.id, null) AS subgenre_id,
      COALESCE(sg.slug, '') AS slug,
      COUNT(r.id)::int AS count,
      ROUND(100.0 * COUNT(r.id) / (SELECT COUNT(*) FROM public.recordings WHERE genre_id = 2), 1) AS percent_of_bachata
    FROM public.recordings r
    LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
    WHERE r.genre_id = 2
    GROUP BY sg.id, sg.name, sg.slug
    ORDER BY COUNT(r.id) DESC
  `);

  console.log(`Bachata Summary by Subgenre\n`);
  console.table(rows.map(r => ({
    Subgenre: r.subgenre,
    Count: r.count,
    'Percent (%)': r.percent_of_bachata
  })));

  const total = rows.reduce((sum, r) => sum + r.count, 0);
  console.log(`\nTotal Bachata recordings: ${total}`);

  // Additional breakdown
  const withSubgenre = rows.filter(r => r.subgenre_id !== null).reduce((sum, r) => sum + r.count, 0);
  const withoutSubgenre = rows.filter(r => r.subgenre_id === null).reduce((sum, r) => sum + r.count, 0);

  console.log(`  With subgenre assigned: ${withSubgenre} (${(100 * withSubgenre / total).toFixed(1)}%)`);
  console.log(`  Without subgenre: ${withoutSubgenre} (${(100 * withSubgenre / total).toFixed(1)}%)`);

  // Show subgenres with IDs
  console.log(`\nSubgenre Details:`);
  rows.forEach(r => {
    if (r.subgenre_id) {
      console.log(`  ${r.subgenre_id}: ${r.subgenre} (${r.slug}) - ${r.count} recordings`);
    }
  });
} finally {
  await pool.end();
}
