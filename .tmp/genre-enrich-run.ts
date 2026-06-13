/**
 * Genre enrichment runner.
 * Fills recordings.genre_id (NULL only) using ONLY existing level-0 genres,
 * combining recording-level internet evidence (Apple Music / Deezer / iTunes
 * search / MusicBrainz) with artist priors. Updates only when confidence >= 0.80.
 *
 * Usage: npx tsx .tmp/genre-enrich-run.ts [--max-batches N]
 * Checkpoint: .tmp/genre-enrich-checkpoint.json (cursor = last recording id)
 */
import "dotenv/config";
import fs from "node:fs";
import pg from "pg";

const CHECKPOINT = ".tmp/genre-enrich-checkpoint.json";
const BATCH_SIZE = 100;
const CONF_THRESHOLD = 0.8;
const maxBatchesArg = process.argv.indexOf("--max-batches");
const MAX_BATCHES = maxBatchesArg > -1 ? Number(process.argv[maxBatchesArg + 1]) : Infinity;

// ---- taxonomy (level-0 genre ids, verified against genres table) ----
const G = {
  merengue: 1, bachata: 2, salsa: 5, ballads: 7, instrumental: 9,
  urban: 10, folklore: 11, fusion: 12, worship: 13, jazz: 36,
  rock: 55, electronic: 56, reggae: 57, pop: 58,
} as const;
const GENRE_NAME: Record<number, string> = {
  1: "Merengue", 2: "Bachata", 5: "Salsa", 7: "Ballads", 9: "Instrumental",
  10: "Urban", 11: "Folklore", 12: "Fusion", 13: "Worship", 36: "Jazz",
  55: "Rock", 56: "Electronic", 57: "Reggae", 58: "Pop",
};

// artists.primary_genre -> level-0 genre id
const PRIOR: Record<string, number | null> = {
  merengue: G.merengue, bachata: G.bachata, salsa: G.salsa, urban: G.urban,
  rap: G.urban, dembow: G.urban, trap: G.urban, "hip-hop": G.urban,
  ballads: G.ballads, bolero: G.ballads, pop: G.pop, rock: G.rock,
  jazz: G.jazz, classical: G.instrumental, folklore: G.folklore,
  electronic: G.electronic, fusion: G.fusion, other: null,
};

// MusicBrainz artist genre tags -> level-0 genre id
function mbGenreToId(tag: string): number | null {
  const t = tag.toLowerCase().trim();
  if (/merengue|merenhouse|mambo|perico ripiao|pambiche/.test(t)) return G.merengue;
  if (/bachata/.test(t)) return G.bachata;
  if (/salsa\b/.test(t)) return G.salsa;
  if (/bolero|balada|romantic|singer-songwriter|trova/.test(t)) return G.ballads;
  if (/dembow|reggaeton|reggaetón|trap|drill|rap|hip.?hop|r&b|urban/.test(t)) return G.urban;
  if (/son\b|salve|folclor|folk|palos|atabales|traditional/.test(t)) return G.folklore;
  if (/latin pop|pop latino|christian pop|^pop$/.test(t)) return G.pop;
  if (/jazz/.test(t)) return G.jazz;
  if (/classical|chamber|orchestral|cinematic|instrumental|piano/.test(t)) return G.instrumental;
  if (/gospel|worship|adoraci/.test(t)) return G.worship;
  if (/rock|metal|punk|alternative/.test(t)) return G.rock;
  if (/electro|house|edm|dance/.test(t)) return G.electronic;
  if (/reggae\b/.test(t)) return G.reggae;
  if (/fusi[oó]n|world/.test(t)) return G.fusion;
  return null;
}

// Platform genre labels -> classified evidence
type LabelKind =
  | { kind: "specific"; id: number }
  | { kind: "tropical" }   // generic tropical umbrella
  | { kind: "latin" }      // generic latin umbrella
  | { kind: "pop" }        // generic pop umbrella
  | { kind: "christian" }  // lyrical, not musical
  | { kind: "unknown" };

function classifyLabel(raw: string): LabelKind {
  const l = raw.toLowerCase().trim();
  if (!l) return { kind: "unknown" };
  if (/bachata/.test(l)) return { kind: "specific", id: G.bachata };
  if (/merengue|mambo/.test(l)) return { kind: "specific", id: G.merengue };
  if (/^salsa$|salsa dura|salsa rom/.test(l)) return { kind: "specific", id: G.salsa };
  if (/urbano latino|latin rap|hip.?hop|reggaeton|reggaetón|dembow|^rap$|trap|r&b|soul/.test(l)) return { kind: "specific", id: G.urban };
  if (/baladas y boleros|bolero|singer\/songwriter|singer-songwriter/.test(l)) return { kind: "specific", id: G.ballads };
  if (/jazz/.test(l)) return { kind: "specific", id: G.jazz };
  if (/rock|metal|punk|alternative|alternativo/.test(l)) return { kind: "specific", id: G.rock };
  if (/electronic|dance|house|techno|edm/.test(l)) return { kind: "specific", id: G.electronic };
  if (/reggae\b|dancehall/.test(l)) return { kind: "specific", id: G.reggae };
  if (/classical|instrumental|new age|soundtrack|orchestral|films\/games/.test(l)) return { kind: "specific", id: G.instrumental };
  if (/folk|world\b|raíces|raices/.test(l)) return { kind: "specific", id: G.folklore };
  if (/christian|gospel|ccm|worship|religious/.test(l)) return { kind: "christian" };
  if (/m[uú]sica tropical|^tropical$|salsa y tropical/.test(l)) return { kind: "tropical" };
  if (/pop latino|latin pop|^pop$|k-pop/.test(l)) return { kind: "pop" };
  if (/^latin$|^latino$|latin music|worldwide|world/.test(l)) return { kind: "latin" };
  return { kind: "unknown" };
}

// title keywords (recording-level signal)
function titleKeyword(title: string): number | null {
  const t = title.toLowerCase();
  if (/\bmerengues?\b|\bpambiche\b|\bperico ripiao\b|\bmambo\b/.test(t)) return G.merengue;
  if (/\bbachatas?\b/.test(t)) return G.bachata;
  if (/\bsalsa\b/.test(t)) return G.salsa;
  if (/\bboleros?\b/.test(t)) return G.ballads;
  if (/\bdembow\b|\breggaet[oó]n\b/.test(t)) return G.urban;
  return null;
}

const TROPICAL_SET = new Set<number>([G.merengue, G.bachata, G.salsa, G.ballads, G.folklore, G.fusion]);

type Evidence = {
  labels: { source: string; raw: string; kind: LabelKind }[];
  prior: number | null;        // from artists.primary_genre
  mbPrior: number | null;      // from artists.genres (MusicBrainz)
  titleKw: number | null;
};
type Decision = { genreId: number; conf: number; reason: string } | { skip: string };

function decide(ev: Evidence): Decision {
  const specifics = ev.labels.filter((l) => l.kind.kind === "specific") as { source: string; raw: string; kind: { kind: "specific"; id: number } }[];
  const specificIds = [...new Set(specifics.map((s) => s.kind.id))];
  const has = (k: string) => ev.labels.some((l) => l.kind.kind === k);
  const labelStr = ev.labels.map((l) => `${l.source}=${l.raw}`).join(", ");
  const agrees = (id: number) => ev.prior === id || ev.mbPrior === id;
  const priorConflicts = (id: number) => ev.prior !== null && ev.prior !== id;

  // conflicting specific labels from different sources -> ambiguous
  if (specificIds.length > 1) return { skip: `conflicting specific labels: ${labelStr}` };

  if (specificIds.length === 1) {
    const id = specificIds[0];
    if (ev.titleKw && ev.titleKw !== id) return { skip: `title keyword vs platform label conflict: ${labelStr}, title→${GENRE_NAME[ev.titleKw]}` };
    let conf = 0.88;
    if (agrees(id) || (ev.titleKw === id)) conf = 0.93;
    else if (priorConflicts(id)) conf = 0.73;
    if (conf >= CONF_THRESHOLD) return { genreId: id, conf, reason: `${labelStr} → ${GENRE_NAME[id]}` };
    return { skip: `specific label conflicts with artist prior (${labelStr}, prior=${GENRE_NAME[ev.prior!]})` };
  }

  if (ev.titleKw) {
    const id = ev.titleKw;
    if (priorConflicts(id)) return { skip: `title keyword ${GENRE_NAME[id]} conflicts with prior ${GENRE_NAME[ev.prior!]}` };
    const conf = agrees(id) ? 0.9 : 0.85;
    return { genreId: id, conf, reason: `title keyword → ${GENRE_NAME[id]}${labelStr ? ` (${labelStr})` : ""}` };
  }

  // generic tropical umbrella: trust artist prior within tropical family
  if (has("tropical")) {
    const id = ev.prior ?? ev.mbPrior;
    if (id && TROPICAL_SET.has(id)) {
      let conf = ev.prior ? 0.82 : 0.8;
      if (ev.prior && ev.mbPrior === ev.prior) conf = 0.86;
      return { genreId: id, conf, reason: `${labelStr} + artist prior → ${GENRE_NAME[id]}` };
    }
    return { skip: `tropical label but artist prior ${id ? GENRE_NAME[id] : "missing"} not tropical (${labelStr})` };
  }

  // christian label: lyrical info; musical genre comes from artist prior, Worship as fallback
  if (has("christian")) {
    const id = ev.prior ?? ev.mbPrior;
    if (id) return { genreId: id, conf: 0.8, reason: `${labelStr} + artist prior → ${GENRE_NAME[id]} (christian context)` };
    return { genreId: G.worship, conf: 0.82, reason: `${labelStr}, no concrete artist prior → Worship fallback` };
  }

  // generic pop umbrella
  if (has("pop")) {
    if (ev.prior === G.pop || ev.prior === G.ballads) {
      return { genreId: ev.prior, conf: 0.82, reason: `${labelStr} + artist prior → ${GENRE_NAME[ev.prior]}` };
    }
    const id = ev.prior ?? ev.mbPrior;
    if (id) return { genreId: id, conf: 0.8, reason: `${labelStr} + artist prior → ${GENRE_NAME[id]}` };
    return { skip: `pop label without usable artist prior (${labelStr})` };
  }

  // generic latin umbrella: trust any concrete artist prior
  if (has("latin")) {
    const id = ev.prior ?? ev.mbPrior;
    if (id) {
      let conf = 0.8;
      if (ev.prior && ev.mbPrior === ev.prior) conf = 0.83;
      return { genreId: id, conf, reason: `${labelStr} + artist prior → ${GENRE_NAME[id]}` };
    }
    return { skip: `latin label without artist prior (${labelStr})` };
  }

  if (ev.labels.length > 0) return { skip: `unmapped labels: ${labelStr}` };
  return { skip: "no recording-level evidence found" };
}

// ---- helpers ----
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
let lastItunesCall = 0;
async function itunesFetch(url: string): Promise<any | null> {
  // iTunes API: ~20 req/min shared across lookup+search
  for (let attempt = 0; attempt < 4; attempt++) {
    const wait = lastItunesCall + 3300 - Date.now();
    if (wait > 0) await sleep(wait);
    lastItunesCall = Date.now();
    try {
      const res = await fetch(url, { headers: { "User-Agent": "mangulina-genre-enrich/1.0" } });
      if (res.status === 403 || res.status === 429) { await sleep(20000 * (attempt + 1)); continue; }
      if (!res.ok) return null;
      return await res.json();
    } catch { await sleep(5000); }
  }
  return null;
}
async function deezerFetch(url: string): Promise<any | null> {
  for (let attempt = 0; attempt < 3; attempt++) {
    try {
      const res = await fetch(url);
      if (res.status === 429) { await sleep(5000); continue; }
      if (!res.ok) return null;
      const j: any = await res.json();
      if (j?.error?.code === 4) { await sleep(5000); continue; } // quota
      return j;
    } catch { await sleep(3000); }
  }
  return null;
}
let lastMbCall = 0;
async function mbFetch(url: string): Promise<any | null> {
  const wait = lastMbCall + 1100 - Date.now();
  if (wait > 0) await sleep(wait);
  lastMbCall = Date.now();
  try {
    const res = await fetch(url, { headers: { "User-Agent": "Mangulina/1.0 (genre enrichment)" } });
    if (!res.ok) return null;
    return await res.json();
  } catch { return null; }
}

const norm = (s: string) =>
  s.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase()
    .replace(/[^a-z0-9ñ ]+/g, " ").replace(/\s+/g, " ").trim();
function sim(a: string, b: string): number {
  const A = new Set(norm(a).split(" ")), B = new Set(norm(b).split(" "));
  if (!A.size || !B.size) return 0;
  let inter = 0;
  for (const t of A) if (B.has(t)) inter++;
  return inter / Math.min(A.size, B.size);
}

// ---- main ----
type Checkpoint = {
  lastId: string | null;
  processed: number; updated: number; skipped: number;
  batches: number;
  ambiguous: { id: string; title: string; artist: string; reason: string }[];
  batchSeconds: number[];
};
const cp: Checkpoint = fs.existsSync(CHECKPOINT)
  ? JSON.parse(fs.readFileSync(CHECKPOINT, "utf8"))
  : { lastId: null, processed: 0, updated: 0, skipped: 0, batches: 0, ambiguous: [], batchSeconds: [] };

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL, max: 4 });

const { rows: totalRows } = await pool.query(`SELECT count(*)::int n FROM public.recordings WHERE genre_id IS NULL`);
let remaining = totalRows[0].n;
console.log(`[start] NULL genre_id remaining: ${remaining}; resuming after id ${cp.lastId ?? "(beginning)"}`);

let batchesRun = 0;
while (batchesRun < MAX_BATCHES) {
  const t0 = Date.now();
  const { rows } = await pool.query(
    `SELECT r.id, r.title, r.mbid, a.name AS artist, a.primary_genre, a.genres AS mb_genres,
            apple.external_id AS apple_id,
            dz.external_id AS deezer_ext, dz.url AS deezer_url
     FROM public.recordings r
     LEFT JOIN public.artists a ON a.id = r.artist_id
     LEFT JOIN LATERAL (
       SELECT external_id FROM public.recording_platform_links l
       WHERE l.recording_id = r.id AND l.platform = 'apple_music' AND l.external_id ~ '^[0-9]+$'
       ORDER BY l.confidence DESC NULLS LAST LIMIT 1) apple ON true
     LEFT JOIN LATERAL (
       SELECT external_id, url FROM public.recording_platform_links l
       WHERE l.recording_id = r.id AND l.platform = 'deezer'
       ORDER BY l.confidence DESC NULLS LAST LIMIT 1) dz ON true
     WHERE r.genre_id IS NULL AND ($1::uuid IS NULL OR r.id > $1::uuid)
     ORDER BY r.id
     LIMIT $2`,
    [cp.lastId, BATCH_SIZE],
  );
  if (rows.length === 0) { console.log("[done] no more NULL-genre recordings past cursor"); break; }

  // 1) Apple lookups for the whole batch in chunks of 150 ids
  const appleGenre = new Map<string, string>(); // trackId -> primaryGenreName
  const appleIds = rows.filter((r: any) => r.apple_id).map((r: any) => r.apple_id);
  for (let i = 0; i < appleIds.length; i += 150) {
    const data = await itunesFetch(`https://itunes.apple.com/lookup?id=${appleIds.slice(i, i + 150).join(",")}&country=US`);
    for (const t of data?.results ?? []) {
      if (t.trackId && t.primaryGenreName) appleGenre.set(String(t.trackId), t.primaryGenreName);
    }
  }

  // 2) Deezer for rows without apple evidence
  const deezerAlbumGenres = new Map<string, string[]>(); // albumId -> names
  async function deezerGenres(row: any): Promise<string[] | null> {
    const id = row.deezer_ext && /^\d+$/.test(row.deezer_ext) ? row.deezer_ext : row.deezer_url?.match(/track\/(\d+)/)?.[1];
    if (!id) return null;
    const tr = await deezerFetch(`https://api.deezer.com/track/${id}`);
    if (!tr?.album?.id) return tr ? [] : null;
    const key = String(tr.album.id);
    if (!deezerAlbumGenres.has(key)) {
      const al = await deezerFetch(`https://api.deezer.com/album/${tr.album.id}`);
      deezerAlbumGenres.set(key, (al?.genres?.data ?? []).map((g: any) => g.name));
      await sleep(150);
    }
    return deezerAlbumGenres.get(key)!;
  }

  let updated = 0, skipped = 0;
  const updates: { id: string; genreId: number; conf: number; reason: string }[] = [];

  for (const row of rows) {
    const labels: Evidence["labels"] = [];
    const apple = row.apple_id ? appleGenre.get(row.apple_id) : undefined;
    if (apple) labels.push({ source: "apple", raw: apple, kind: classifyLabel(apple) });

    if (labels.length === 0 && (row.deezer_ext || row.deezer_url)) {
      const dg = await deezerGenres(row);
      if (dg) {
        if (dg.length === 0) labels.push({ source: "deezer", raw: "Latin Music", kind: { kind: "latin" } }); // verified latin catalog track, no album genre
        for (const name of dg) labels.push({ source: "deezer", raw: name, kind: classifyLabel(name) });
      }
    }

    // iTunes search for rows with no link-based evidence
    if (labels.length === 0 && row.artist) {
      const term = encodeURIComponent(`${row.title} ${row.artist}`).slice(0, 250);
      const data = await itunesFetch(`https://itunes.apple.com/search?term=${term}&entity=song&limit=8&country=US&media=music`);
      const match = (data?.results ?? []).find((t: any) =>
        sim(t.trackName ?? "", row.title) >= 0.75 && sim(t.artistName ?? "", row.artist) >= 0.6);
      if (match?.primaryGenreName) labels.push({ source: "itunes-search", raw: match.primaryGenreName, kind: classifyLabel(match.primaryGenreName) });
    }

    // MusicBrainz recording genres/tags as last resort
    if (labels.length === 0 && row.mbid) {
      const data = await mbFetch(`https://musicbrainz.org/ws/2/recording/${row.mbid}?inc=genres+tags&fmt=json`);
      const tags = [...(data?.genres ?? []), ...(data?.tags ?? [])].filter((t: any) => (t.count ?? 0) >= 1);
      for (const t of tags.slice(0, 5)) labels.push({ source: "musicbrainz", raw: t.name, kind: classifyLabel(t.name) });
    }

    const prior = row.primary_genre ? (PRIOR[row.primary_genre] ?? null) : null;
    let mbPrior: number | null = null;
    for (const g of row.mb_genres ?? []) { mbPrior = mbGenreToId(g); if (mbPrior) break; }
    const ev: Evidence = { labels, prior, mbPrior, titleKw: titleKeyword(row.title ?? "") };
    const d = decide(ev);
    if ("genreId" in d) {
      updates.push({ id: row.id, genreId: d.genreId, conf: d.conf, reason: d.reason });
    } else {
      skipped++;
      cp.ambiguous.push({ id: row.id, title: row.title, artist: row.artist, reason: d.skip });
    }
    cp.lastId = row.id;
  }

  // apply updates (never overwrite non-null)
  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    for (const u of updates) {
      const res = await client.query(
        `UPDATE public.recordings
         SET genre_id = $1, ai_confidence = $2, ai_reason = $3, classified_at = now()
         WHERE id = $4 AND genre_id IS NULL`,
        [u.genreId, u.conf, `genre-enrich: ${u.reason}`, u.id],
      );
      updated += res.rowCount ?? 0;
    }
    await client.query("COMMIT");
  } catch (e) {
    await client.query("ROLLBACK");
    throw e;
  } finally {
    client.release();
  }

  cp.processed += rows.length;
  cp.updated += updated;
  cp.skipped += skipped;
  cp.batches += 1;
  const secs = (Date.now() - t0) / 1000;
  cp.batchSeconds.push(Math.round(secs));
  fs.writeFileSync(CHECKPOINT, JSON.stringify(cp, null, 2));

  remaining -= rows.length;
  const avg = cp.batchSeconds.slice(-10).reduce((a, b) => a + b, 0) / Math.min(cp.batchSeconds.length, 10);
  const etaMin = Math.round((remaining / BATCH_SIZE) * avg / 60);
  const dist: Record<string, number> = {};
  for (const u of updates) dist[GENRE_NAME[u.genreId]] = (dist[GENRE_NAME[u.genreId]] ?? 0) + 1;
  console.log(`[batch ${cp.batches}] updated=${updated} skipped=${skipped} | ${JSON.stringify(dist)} | cursor=${cp.lastId} | remaining≈${remaining} | ${Math.round(secs)}s | ETA ~${etaMin} min`);
  if (skipped > 0) {
    for (const a of cp.ambiguous.slice(-Math.min(skipped, 3))) console.log(`   skip: "${a.title}" — ${a.artist}: ${a.reason}`);
  }
  batchesRun++;
}

console.log(`[totals] processed=${cp.processed} updated=${cp.updated} skipped=${cp.skipped} (ambiguous list in ${CHECKPOINT})`);
await pool.end();
