import "dotenv/config";
import pg from "pg";
import fs from "node:fs";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT
      a.name AS artist_name,
      COALESCE(rel.title, r.metadata->>'album', '(unknown)') AS album_name,
      r.title AS song_name,
      ROUND(r.duration / 1000.0, 2) AS duration_seconds
    FROM public.recordings r
    LEFT JOIN public.artists a ON a.id = r.artist_id
    LEFT JOIN public.releases rel ON rel.id = r.release_id
    WHERE r.genre_id IS NULL
    ORDER BY a.name, COALESCE(rel.title, r.metadata->>'album', ''), r.title
  `);

  console.log(`Found ${rows.length} skipped records\n`);
  console.log('Sample (first 20):');
  console.table(rows.slice(0, 20));

  // Export to CSV
  const csv = [
    ['Artist Name', 'Album Name', 'Song Name', 'Duration (seconds)'].join(','),
    ...rows.map(r => [
      `"${(r.artist_name || '').replace(/"/g, '""')}"`,
      `"${(r.album_name || '').replace(/"/g, '""')}"`,
      `"${(r.song_name || '').replace(/"/g, '""')}"`,
      r.duration_seconds
    ].join(','))
  ].join('\n');

  fs.writeFileSync('.tmp/skipped-ambiguous-export.csv', csv);
  console.log(`\n✓ Full list exported to: .tmp/skipped-ambiguous-export.csv`);
} finally {
  await pool.end();
}
