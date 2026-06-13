import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

const queries: Array<[string, string]> = [
  [
    "1. Main genre counts",
    `SELECT g.name AS genre, count(r.id) AS recordings
     FROM public.genres g
     LEFT JOIN public.recordings r ON r.genre_id = g.id
     WHERE g.active AND g.level = 0 AND g.parent_id IS NULL
     GROUP BY g.id, g.name, g.sort_order
     ORDER BY g.sort_order`,
  ],
  [
    "2. Subgenre counts",
    `SELECT parent.name AS parent_genre, child.name AS subgenre, count(r.id) AS recordings
     FROM public.genres child
     JOIN public.genres parent ON parent.id = child.parent_id
     LEFT JOIN public.recordings r ON r.subgenre_id = child.id
     WHERE parent.active AND child.active AND child.level = 1
     GROUP BY parent.id, parent.name, parent.sort_order, child.id, child.name, child.sort_order
     ORDER BY parent.sort_order, child.sort_order`,
  ],
  [
    "3. Christian rows in genres (expected 0)",
    `SELECT count(*) AS christian_rows_remaining
     FROM public.genres
     WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
        OR lower(coalesce(slug, '')) ~ '(christian|cristian)'`,
  ],
  [
    "4. Christian recordings by genre",
    `SELECT g.name AS genre, sg.name AS subgenre, count(*) AS recordings
     FROM public.recordings r
     LEFT JOIN public.genres g ON g.id = r.genre_id
     LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
     WHERE r.recording_context = 'christian'
     GROUP BY g.name, sg.name
     ORDER BY recordings DESC, g.name`,
  ],
  [
    "5. Worship recording counts",
    `SELECT g.name AS genre, count(r.id) AS recordings
     FROM public.genres g
     LEFT JOIN public.recordings r ON r.genre_id = g.id
     WHERE g.id = 13
     GROUP BY g.id, g.name`,
  ],
  [
    "6. Invalid parent/child relationships (expected 0 rows)",
    `SELECT r.id, r.title, r.genre_id, r.subgenre_id
     FROM public.recordings r
     LEFT JOIN public.genres g ON g.id = r.genre_id
     LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
     WHERE (r.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
        OR (r.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM r.genre_id OR NOT sg.active))
     LIMIT 20`,
  ],
  [
    "7. Null classifications",
    `SELECT
        count(*) FILTER (WHERE genre_id IS NULL) AS genre_id_null,
        count(*) FILTER (WHERE subgenre_id IS NULL) AS subgenre_id_null,
        count(*) FILTER (WHERE recording_context IS NULL) AS recording_context_null,
        count(*) AS total_recordings
     FROM public.recordings`,
  ],
  [
    "8. recording_context values (expected only secular/christian)",
    `SELECT recording_context, count(*) AS recordings
     FROM public.recordings GROUP BY 1 ORDER BY 2 DESC`,
  ],
  [
    "9. Legacy subgenres table status (dropped; backup retained)",
    `SELECT
        to_regclass('public.subgenres')::text AS subgenres_table,
        (SELECT count(*) FROM public.subgenres_backup_before_drop) AS backup_rows`,
  ],
  [
    "10. Invalid import mapping relationships (expected 0)",
    `SELECT count(*) AS invalid_mappings
     FROM public.genre_import_mapping m
     LEFT JOIN public.genres g ON g.id = m.genre_id
     LEFT JOIN public.genres sg ON sg.id = m.subgenre_id
     WHERE (m.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
        OR (m.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM m.genre_id OR NOT sg.active))`,
  ],
];

try {
  for (const [title, sql] of queries) {
    const { rows } = await pool.query(sql);
    console.log(`\n=== ${title} ===`);
    console.table(rows);
  }
} finally {
  await pool.end();
}
