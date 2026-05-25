// ingest_wikipedia_awards.mjs
// npm install node-fetch cheerio @supabase/supabase-js dotenv

import "dotenv/config";
import fetch from "node-fetch";
import * as cheerio from "cheerio";
import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// ---- CONFIG ----
const USER_AGENT =
  "Domidb/1.0 (https://domidb.com; contact: fvpg@hotmail.com)";
const REQUEST_DELAY_MS = 1500;
const MAX_RETRIES = 4;
const INITIAL_BACKOFF_MS = 2000;

// ---- Utility ----
function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

// ---- Safe fetch with retries ----
async function safeFetch(url) {
  let attempt = 0;
  let backoff = INITIAL_BACKOFF_MS;

  while (attempt <= MAX_RETRIES) {
    try {
      const res = await fetch(url, {
        headers: { "User-Agent": USER_AGENT },
      });

      if (res.status === 429 || res.status >= 500) {
        console.warn(
          `Status ${res.status} from ${url}, retry ${attempt + 1}/${MAX_RETRIES + 1}`
        );
        if (attempt === MAX_RETRIES) throw new Error("Max retries reached");
        await sleep(backoff);
        backoff *= 2;
        attempt++;
        continue;
      }

      if (!res.ok) throw new Error(`HTTP ${res.status} for ${url}`);
      return res;
    } catch (err) {
      console.warn(
        `Fetch error on ${url}, retry ${attempt + 1}/${MAX_RETRIES + 1}: ${err.message}`
      );
      if (attempt === MAX_RETRIES) throw err;
      await sleep(backoff);
      backoff *= 2;
      attempt++;
    }
  }
}

// ---- Get Wikipedia URL from Wikidata ----
async function getWikipediaUrlFromWikidata(qid) {
  const url = `https://www.wikidata.org/wiki/Special:EntityData/${qid}.json`;

  try {
    const res = await safeFetch(url);
    const data = await res.json();

    const entity = data.entities?.[qid];
    if (!entity) return null;

    const title = entity.sitelinks?.enwiki?.title;
    if (!title) return null;

    return `https://en.wikipedia.org/wiki/${title}`;
  } catch (err) {
    console.warn(`Failed to fetch Wikidata for ${qid}: ${err.message}`);
    return null;
  }
}

// ---- Scrape awards from Wikipedia ----
async function scrapeAwardsFromWikipedia(url) {
  console.log(`Fetching Wikipedia page: ${url}`);
  const res = await safeFetch(url);
  const html = await res.text();
  const $ = cheerio.load(html);

  const awards = [];

  $("table.wikitable").each((_, table) => {
    const headers = [];
    $(table)
      .find("th")
      .each((_, th) => headers.push($(th).text().trim().toLowerCase()));

    const hasYear = headers.some((h) => h.includes("year"));
    const hasAward = headers.some((h) => h.includes("award"));
    const hasCategory = headers.some((h) => h.includes("category"));

    if (!hasYear || !hasAward || !hasCategory) return;

    $(table)
      .find("tr")
      .each((_, row) => {
        const cells = $(row).find("td");
        if (cells.length < 3) return;

        const yearText = $(cells[0]).text().trim();
        const awardText = $(cells[1]).text().trim();
        const categoryText = $(cells[2]).text().trim();
        const workText = cells[3] ? $(cells[3]).text().trim() : null;
        const resultText = cells[4] ? $(cells[4]).text().trim() : null;

        if (!awardText || !categoryText) return;

        const year = parseInt(yearText, 10);
        const won =
          resultText?.toLowerCase().includes("win") ||
          resultText?.toLowerCase().includes("won")
            ? true
            : resultText?.toLowerCase().includes("nomin")
            ? false
            : true;

        awards.push({
          year: Number.isNaN(year) ? null : year,
          award: awardText,
          category: categoryText,
          work: workText || null,
          won,
        });
      });
  });

  console.log(`Found ${awards.length} award rows on ${url}`);
  return awards;
}

// ---- DB helpers ----
async function upsertAward(name) {
  const { data } = await supabase
    .from("awards")
    .select("id")
    .eq("name", name)
    .maybeSingle();

  if (data) return data.id;

  const { data: inserted } = await supabase
    .from("awards")
    .insert({ name })
    .select()
    .single();

  return inserted.id;
}

async function upsertCategory(awardId, name) {
  const { data } = await supabase
    .from("award_categories")
    .select("id")
    .eq("award_id", awardId)
    .eq("name", name)
    .maybeSingle();

  if (data) return data.id;

  const { data: inserted } = await supabase
    .from("award_categories")
    .insert({ award_id: awardId, name })
    .select()
    .single();

  return inserted.id;
}

async function insertArtistAward(artistId, awardId, categoryId, entry) {
  await supabase.from("artist_awards").insert({
    artist_id: artistId,
    award_id: awardId,
    category_id: categoryId,
    year: entry.year,
    work: entry.work,
    won: entry.won,
    source: "Wikipedia",
  });
}

// ---- Per-artist ingestion ----
async function ingestWikipediaAwardsForArtist(artist) {
  console.log(`\n=== Processing ${artist.name} (${artist.wikidata_id}) ===`);

  await sleep(REQUEST_DELAY_MS);

  const wikiUrl = await getWikipediaUrlFromWikidata(artist.wikidata_id);
  if (!wikiUrl) {
    console.log(`No Wikipedia page for ${artist.name}`);
    return;
  }

  const awards = await scrapeAwardsFromWikipedia(wikiUrl);
  if (!awards.length) {
    console.log(`No awards found for ${artist.name}`);
    return;
  }

  for (const entry of awards) {
    try {
      const awardId = await upsertAward(entry.award);
      const categoryId = await upsertCategory(awardId, entry.category);
      await insertArtistAward(artist.id, awardId, categoryId, entry);
    } catch (err) {
      console.error(`Error inserting award for ${artist.name}: ${err.message}`);
    }
  }

  console.log(`Done with ${artist.name}`);
}

// ---- Batch runner ----
async function runBatch() {
  console.log("Starting Wikipedia awards ingestion…");

  const { data: artists, error } = await supabase
    .from("artists")
    .select("id, name, wikidata_id")
    .not("wikidata_id", "is", null)
    .limit(2000);

  if (error) {
    console.error("Error fetching artists:", error);
    process.exit(1);
  }

  console.log(`Found ${artists.length} artists with Wikidata IDs`);

  for (const artist of artists) {
    try {
      await ingestWikipediaAwardsForArtist(artist);
    } catch (err) {
      console.error(`Fatal error for ${artist.name}: ${err.message}`);
    }
  }

  console.log("Wikipedia awards ingestion completed.");
}

runBatch().catch((err) => {
  console.error("Unexpected error:", err);
  process.exit(1);
});
