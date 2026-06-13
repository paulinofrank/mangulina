import "dotenv/config";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });

try {
  const { rows } = await pool.query(`
    SELECT r.id, r.title, l.platform, l.external_id, l.url, l.confidence, l.status
    FROM public.recordings r
    JOIN public.recording_platform_links l ON l.recording_id = r.id
    WHERE r.genre_id IS NULL AND l.platform = 'apple_music'
    ORDER BY r.id
    LIMIT 300
  `);
  const withId = rows.filter((r: any) => r.external_id && /^\d+$/.test(r.external_id));
  console.log(`apple link rows: ${rows.length}, numeric external_id: ${withId.length}`);
  console.log("status values:", [...new Set(rows.map((r: any) => r.status))]);
  console.log("sample url:", rows[0]?.url);

  // batch lookup first 200 ids on iTunes
  const ids = withId.slice(0, 200).map((r: any) => r.external_id).join(",");
  const res = await fetch(`https://itunes.apple.com/lookup?id=${ids}&country=US`);
  const data: any = await res.json();
  const genres: Record<string, number> = {};
  for (const t of data.results ?? []) {
    const g = t.primaryGenreName ?? "(none)";
    genres[g] = (genres[g] ?? 0) + 1;
  }
  console.log(`itunes results: ${data.resultCount}`);
  console.log("apple genre distribution:", JSON.stringify(genres, null, 2));

  // deezer sample: 5 tracks
  const { rows: dz } = await pool.query(`
    SELECT r.id, r.title, l.external_id, l.url
    FROM public.recordings r
    JOIN public.recording_platform_links l ON l.recording_id = r.id
    WHERE r.genre_id IS NULL AND l.platform = 'deezer'
    LIMIT 5
  `);
  for (const t of dz) {
    const id = t.external_id ?? t.url?.match(/track\/(\d+)/)?.[1];
    if (!id) { console.log("deezer no id", t.url); continue; }
    const tr: any = await (await fetch(`https://api.deezer.com/track/${id}`)).json();
    let albumGenres = null;
    if (tr?.album?.id) {
      const al: any = await (await fetch(`https://api.deezer.com/album/${tr.album.id}`)).json();
      albumGenres = al?.genres?.data?.map((g: any) => g.name);
    }
    console.log("deezer:", t.title, "->", JSON.stringify(albumGenres));
  }
} finally {
  await pool.end();
}
