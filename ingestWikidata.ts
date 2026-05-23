#!/usr/bin/env ts-node
/**
 * Mangulina — Wikidata Artist Enrichment
 * =======================================
 * Fetches real data from Wikidata for every artist that already
 * has a wikidata_id stored in Supabase, then updates the record.
 *
 * Fields updated:
 *   birth_year        ← P569 (year always)
 *   date_of_birth     ← P569 (full date only when precision = day)
 *   death_year        ← P570 (year always)
 *   origin_region     ← P19  label  (only when column is currently NULL)
 *   first_name        ← P735 label [0]
 *   middle_name       ← P735 label [1]
 *   last_name         ← P734 label [0]
 *   second_last_name  ← P734 label [1]
 *   website           ← P856  (raw string)
 *   youtube           ← P2397 (raw ID)
 *   facebook          ← P2013 (raw ID)
 *   instagram         ← P2003 (raw username)
 *   occupations       ← P106  labels[]
 *   genres            ← P136  labels[]  (raw Wikidata labels)
 *
 * Fields NEVER touched:
 *   birth_day, birth_month  → GENERATED ALWAYS computed columns
 *   updated_at              → managed by DB trigger
 *   all other columns
 *
 * Requirements:
 *   npm install @supabase/supabase-js dotenv
 *   Node >= 18  (uses built-in fetch)
 *
 * Usage:
 *   npx ts-node ingestWikidata.ts
 */

import { createClient } from "@supabase/supabase-js";
import * as dotenv from "dotenv";

dotenv.config();

// ─────────────────────────────────────────────────────────────
// CONFIG
// ─────────────────────────────────────────────────────────────

const SUPABASE_URL = process.env.SUPABASE_URL ?? process.env.NEXT_PUBLIC_SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  throw new Error(
    "Missing env vars. Ensure SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are set in .env"
  );
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

const WD_ENTITY_BASE = "https://www.wikidata.org/wiki/Special:EntityData";
const WD_API_BASE    = "https://www.wikidata.org/w/api.php";
const USER_AGENT     = "MangulinaIngest/1.0 (fvpg@hotmail.com)";
const DELAY_MS       = 1300; // stay safely under Wikidata's 1 req/sec limit

// ─────────────────────────────────────────────────────────────
// TYPES
// ─────────────────────────────────────────────────────────────

interface ArtistRow {
  id:             string;
  name:           string;
  wikidata_id:    string;
  origin_region:  string | null;
}

interface ArtistUpdate {
  birth_year?:       number;
  date_of_birth?:    string;        // ISO "YYYY-MM-DD"
  death_year?:       number;
  origin_region?:    string;
  first_name?:       string;
  middle_name?:      string;
  last_name?:        string;
  second_last_name?: string;
  website?:          string;
  youtube?:          string;
  facebook?:         string;
  instagram?:        string;
  occupations?:      string[];
  genres?:           string[];
}

type EnrichResult = "updated" | "skipped" | "error";

// ─────────────────────────────────────────────────────────────
// WIKIDATA FETCH HELPERS
// ─────────────────────────────────────────────────────────────

async function fetchEntityJson(wikidataId: string): Promise<any> {
  const url = `${WD_ENTITY_BASE}/${wikidataId}.json`;
  const res = await fetch(url, {
    headers: { "User-Agent": USER_AGENT },
  });
  if (res.status === 404) throw new Error("404 — entity not found");
  if (!res.ok)            throw new Error(`HTTP ${res.status}`);
  const json = (await res.json()) as any;
  return json.entities?.[wikidataId] ?? null;
}

/**
 * Resolve up to 50 Q-IDs per request.
 * Returns a map of { Q123: "label in es or en" }.
 * Prefers Spanish; falls back to English.
 */
async function fetchLabels(qids: string[]): Promise<Record<string, string>> {
  if (qids.length === 0) return {};

  const result: Record<string, string> = {};

  for (let i = 0; i < qids.length; i += 50) {
    const batch = qids.slice(i, i + 50);
    const url   = new URL(WD_API_BASE);
    url.searchParams.set("action",    "wbgetentities");
    url.searchParams.set("ids",       batch.join("|"));
    url.searchParams.set("props",     "labels");
    url.searchParams.set("languages", "en|es");
    url.searchParams.set("format",    "json");

    const res = await fetch(url.toString(), {
      headers: { "User-Agent": USER_AGENT },
    });
    if (!res.ok) continue;

    const json = (await res.json()) as any;
    for (const qid of batch) {
      const ent = json.entities?.[qid];
      if (!ent) continue;
      const label =
        ent.labels?.en?.value ??
        ent.labels?.es?.value ??
        null;
      if (label) result[qid] = label;
    }
  }

  return result;
}

// ─────────────────────────────────────────────────────────────
// CLAIM PARSERS
// ─────────────────────────────────────────────────────────────

/** Returns the plain-string values for a property (e.g. P856, P2397). */
function getStrings(claims: any, prop: string): string[] {
  return (claims[prop] ?? [])
    .filter(
      (c: any) =>
        c.mainsnak?.snaktype === "value" &&
        c.mainsnak?.datavalue?.type === "string"
    )
    .map((c: any) => c.mainsnak.datavalue.value as string);
}

/** Returns Q-IDs for entity-reference properties (e.g. P19, P106, P136). */
function getQids(claims: any, prop: string): string[] {
  return (claims[prop] ?? [])
    .filter(
      (c: any) =>
        c.mainsnak?.snaktype === "value" &&
        c.mainsnak?.datavalue?.type === "wikibase-entityid"
    )
    .map((c: any) => `Q${c.mainsnak.datavalue.value["numeric-id"]}`);
}

/**
 * Parses a Wikidata time claim (P569 or P570).
 * Returns { year } always, plus { date: "YYYY-MM-DD" } when precision = day (11).
 * Validates year is within 1800–3000 (matches the artists.birth_year check constraint).
 */
function parseDate(claims: any, prop: string): { year?: number; date?: string } {
  const claim = (claims[prop] ?? []).find(
    (c: any) =>
      c.mainsnak?.snaktype === "value" &&
      c.mainsnak?.datavalue?.type === "time"
  );
  if (!claim) return {};

  const tv         = claim.mainsnak.datavalue.value;
  const raw: string = tv.time;       // e.g. "+1941-06-07T00:00:00Z"
  const precision: number = tv.precision; // 9=year 10=month 11=day

  // Strip leading sign before parsing
  const normalised = raw.replace(/^[+-]/, "");
  const year        = parseInt(normalised.substring(0, 4), 10);

  if (isNaN(year) || year < 1800 || year > 3000) return {};

  if (precision >= 11) {
    // Day-level: safe to store full date
    const datePart = normalised.substring(0, 10); // "YYYY-MM-DD"
    return { year, date: datePart };
  }

  return { year };
}

// ─────────────────────────────────────────────────────────────
// PER-ARTIST ENRICHMENT
// ─────────────────────────────────────────────────────────────

async function enrichArtist(artist: ArtistRow): Promise<EnrichResult> {
  // ── 1. Fetch entity ───────────────────────────────────────
  let entity: any;
  try {
    entity = await fetchEntityJson(artist.wikidata_id);
  } catch (err) {
    console.warn(`  ⚠  Cannot fetch ${artist.wikidata_id}: ${err}`);
    return "error";
  }

  if (!entity) {
    console.warn(`  ⚠  Entity ${artist.wikidata_id} not found in response`);
    return "error";
  }

  const claims = entity.claims ?? {};
  const update: ArtistUpdate = {};

  // ── 2. Dates (no label lookup needed) ────────────────────
  const birth = parseDate(claims, "P569");
  if (birth.year)  update.birth_year    = birth.year;
  if (birth.date)  update.date_of_birth = birth.date;

  const death = parseDate(claims, "P570");
  if (death.year)  update.death_year = death.year;

  // ── 3. Plain-string social fields ────────────────────────
  const [website]   = getStrings(claims, "P856");
  const [youtube]   = getStrings(claims, "P2397");
  const [facebook]  = getStrings(claims, "P2013");
  const [instagram] = getStrings(claims, "P2003");

  if (website)   update.website   = website;
  if (youtube)   update.youtube   = youtube;
  if (facebook)  update.facebook  = facebook;
  if (instagram) update.instagram = instagram;

  // ── 4. Collect all Q-IDs that need label resolution ──────
  const givenQids  = getQids(claims, "P735"); // given names
  const familyQids = getQids(claims, "P734"); // family names
  const placeQids  = getQids(claims, "P19");  // place of birth
  const occQids    = getQids(claims, "P106"); // occupations
  const genreQids  = getQids(claims, "P136"); // genres

  const allQids = [
    ...new Set([
      ...givenQids,
      ...familyQids,
      ...placeQids,
      ...occQids,
      ...genreQids,
    ]),
  ];

  // ── 5. Single batched label call ──────────────────────────
  const labels = await fetchLabels(allQids);

  // ── 6. Names ──────────────────────────────────────────────
  if (givenQids[0]  && labels[givenQids[0]])  update.first_name       = labels[givenQids[0]];
  if (givenQids[1]  && labels[givenQids[1]])  update.middle_name      = labels[givenQids[1]];
  if (familyQids[0] && labels[familyQids[0]]) update.last_name        = labels[familyQids[0]];
  if (familyQids[1] && labels[familyQids[1]]) update.second_last_name = labels[familyQids[1]];

  // ── 7. Origin region (P19) — only when column is NULL ────
  if (artist.origin_region === null && placeQids[0] && labels[placeQids[0]]) {
    update.origin_region = labels[placeQids[0]];
  }

  // ── 8. Occupations & genres ───────────────────────────────
  const occupations = occQids.map((q) => labels[q]).filter(Boolean) as string[];
  if (occupations.length > 0) update.occupations = occupations;

  const genres = genreQids.map((q) => labels[q]).filter(Boolean) as string[];
  if (genres.length > 0) update.genres = genres;

  // ── 9. Nothing to write? ──────────────────────────────────
  if (Object.keys(update).length === 0) {
    console.log(`  ⏭  No data found — ${artist.name}`);
    return "skipped";
  }

  // ── 10. Write to Supabase ─────────────────────────────────
  const { error: dbError } = await supabase
    .from("artists")
    .update(update)
    .eq("id", artist.id);

  if (dbError) {
    console.error(`  ✗  DB error for ${artist.name}: ${dbError.message}`);
    return "error";
  }

  const fields = Object.keys(update).join(", ");
  console.log(`  ✅ ${artist.name} — ${fields}`);
  return "updated";
}

// ─────────────────────────────────────────────────────────────
// ENTRY POINT
// ─────────────────────────────────────────────────────────────

async function main(): Promise<void> {
  const t0 = Date.now();

  console.log("═══════════════════════════════════════════════════");
  console.log("  Mangulina — Wikidata Artist Enrichment");
  console.log(`  Started : ${new Date().toLocaleString()}`);
  console.log("═══════════════════════════════════════════════════\n");

  // Fetch only artists that have a wikidata_id
  const { data: artists, error: fetchError } = await supabase
    .from("artists")
    .select("id, name, wikidata_id, origin_region")
    .not("wikidata_id", "is", null)
    .order("name");

  if (fetchError || !artists) {
    console.error("❌ Failed to fetch artists:", fetchError?.message);
    process.exit(1);
  }

  console.log(`  ${artists.length} artists with wikidata_id found.\n`);

  let updated  = 0;
  let skipped  = 0;
  let errors   = 0;

  for (let i = 0; i < artists.length; i++) {
    const artist = artists[i] as ArtistRow;
    console.log(`[${i + 1}/${artists.length}] ${artist.name}  (${artist.wikidata_id})`);

    const result = await enrichArtist(artist);
    if      (result === "updated") updated++;
    else if (result === "skipped") skipped++;
    else                           errors++;

    // Respect Wikidata rate limit between artists
    if (i < artists.length - 1) {
      await new Promise((r) => setTimeout(r, DELAY_MS));
    }
  }

  const elapsed = Math.round((Date.now() - t0) / 1000);

  console.log("\n═══════════════════════════════════════════════════");
  console.log("  DONE");
  console.log(`  ✅ Updated : ${updated}`);
  console.log(`  ⏭  Skipped : ${skipped}`);
  console.log(`  ✗  Errors  : ${errors}`);
  console.log(`  ⏱  Elapsed : ${Math.floor(elapsed / 60)}m ${elapsed % 60}s`);
  console.log("═══════════════════════════════════════════════════");
}

main().catch((err) => {
  console.error("Fatal:", err);
  process.exit(1);
});
