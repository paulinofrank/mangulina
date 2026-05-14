import 'dotenv/config';
import fetch from 'node-fetch';
import { createClient } from '@supabase/supabase-js';

// Initialize Supabase
const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const MB_BASE = 'https://musicbrainz.org/ws/2';
const USER_AGENT = 'WikiMusicDO/1.2 (https://wikimusic.do; fvpg@hotmail.com)';

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function fetchJSON(url: string, retries = 3): Promise<any> {
  try {
    const res = await fetch(url, {
      headers: {
        'User-Agent': USER_AGENT,
        'Accept': 'application/json',
      },
    });

    if (res.status === 429 || res.status === 503) {
      if (retries > 0) {
        console.warn(`⚠️ Rate limited on ${url}. Retrying in 20s... (${retries} left)`);
        await sleep(20000);
        return fetchJSON(url, retries - 1);
      }
    }

    if (!res.ok) throw new Error(`MB Error: ${res.status} ${res.statusText}`);
    return await res.json();
  } catch (err) {
    if (retries > 0) {
      console.warn(`⚠️ Error on ${url}: ${(err as Error).message}. Retrying in 5s... (${retries} left)`);
      await sleep(5000);
      return fetchJSON(url, retries - 1);
    }
    throw err;
  }
}

// Get all existing MBIDs from Supabase so we only insert missing ones
async function getExistingMBIDs(): Promise<Set<string>> {
  const { data, error } = await supabase
    .from('artists')
    .select('mbid');

  if (error) {
    console.error('❌ Error fetching existing MBIDs from Supabase:', error.message);
    throw error;
  }

  const set = new Set<string>();
  for (const row of data || []) {
    if (row.mbid) set.add(row.mbid);
  }
  console.log(`📊 Existing artists in DB (by mbid): ${set.size}`);
  return set;
}

// Map MusicBrainz full artist JSON → your artists table schema
function mapArtistData(full: any) {
  const relations = full.relations || [];
  const getUrl = (type: string) =>
    relations.find((r: any) => r.type === type)?.url?.resource || null;

  const wikidata = relations.find((r: any) => r.type === 'wikidata')?.url?.resource;
  const wikidata_id = wikidata ? wikidata.split('/').pop() : null;

  const allAliases = full.aliases?.map((a: any) => a.name) || [];
  const pseudonyms = full.aliases
    ?.filter((a: any) => a.type === 'Artist name' || a.type === 'Search hint')
    .map((a: any) => a.name) || [];

  return {
    // DO NOT set id → let Supabase generate it
    mbid: full.id, // MusicBrainz UUID
    name: full.name,
    sort_name: full['sort-name'],
    type: full.type || 'Person',
    bio: full.annotation?.text || null,
    image_url: null, // will be filled later from Wikidata
    birth_year: full['life-span']?.begin
      ? parseInt(full['life-span'].begin.split('-')[0])
      : null,
    death_year: full['life-span']?.end
      ? parseInt(full['life-span'].end.split('-')[0])
      : null,
    origin_region: full.area?.name || null,
    wikidata_id,
    first_name: null,
    middle_name: null,
    last_name: null,
    second_last_name: null,
    stage_name: full.name,
    date_of_birth:
      full['life-span']?.begin?.length === 10 ? full['life-span'].begin : null,
    place_of_birth: full['begin-area']?.name || null,
    website: getUrl('official homepage'),
    youtube: getUrl('youtube'),
    facebook: getUrl('facebook'),
    instagram: getUrl('instagram'),
    aliases: allAliases,
    pseudonyms: pseudonyms,
  };
}

async function upsertArtist(full: any) {
  const data = mapArtistData(full);

  const { error } = await supabase.from('artists').upsert(data, {
    onConflict: 'mbid', // key in your schema
  });

  if (error) {
    console.error(`❌ Supabase Error for ${data.name}:`, error.message);
  } else {
    console.log(`✅ Synced: ${data.name}`);
  }
}

async function run() {
  console.log('🚀 Starting incremental MusicBrainz ingestion (only missing artists)…');

  const existing = await getExistingMBIDs();

  let offset = 0;
  const limit = 100; // max MBz page size

  while (true) {
    console.log(`\n--- Fetching Page (Offset: ${offset}) ---`);
    const searchUrl = `${MB_BASE}/artist?query=country:DO&limit=${limit}&offset=${offset}&fmt=json`;

    let searchData: any;
    try {
      searchData = await fetchJSON(searchUrl);
    } catch (e: any) {
      console.error('💥 Critical failure fetching artist list:', e.message);
      break;
    }

    if (!searchData.artists || searchData.artists.length === 0) {
      console.log('ℹ️ No artists returned, stopping.');
      break;
    }

    // Handle partial pages (should only happen due to transient issues)
    if (searchData.artists.length < limit && offset + limit < searchData.count) {
      console.warn(
        `⚠️ Partial page at offset ${offset} (${searchData.artists.length}/${limit}). Retrying this page…`
      );
      await sleep(5000);
      continue; // retry same offset
    }

    for (const artist of searchData.artists) {
      // Skip if we already have this MBID
      if (existing.has(artist.id)) {
        console.log(`⏩ Skipping existing: ${artist.name}`);
        continue;
      }

      const detailsUrl = `${MB_BASE}/artist/${artist.id}?inc=aliases+url-rels&fmt=json`;

      try {
        console.log(`🔎 Fetching details for: ${artist.name} (${artist.id})…`);
        const full = await fetchJSON(detailsUrl);

        if (artist.annotation) full.annotation = artist.annotation;

        await upsertArtist(full);
        existing.add(artist.id); // mark as now present
        await sleep(1500); // be nice to MBz
      } catch (e: any) {
        console.error(`💥 Failed: ${artist.name}. Error: ${e.message}`);

        console.log(`📝 Saving basic entry for ${artist.name}`);
        const { error } = await supabase.from('artists').upsert(
          {
            mbid: artist.id,
            name: artist.name,
            sort_name: artist['sort-name'],
            type: artist.type || 'Person',
          },
          { onConflict: 'mbid' }
        );

        if (error) {
          console.error(`❌ Supabase basic upsert error for ${artist.name}:`, error.message);
        } else {
          existing.add(artist.id);
        }

        await sleep(3000);
      }
    }

    // Stop when we've covered the full count
    if (offset + limit >= searchData.count) {
      console.log('✅ Reached end of result set.');
      break;
    }

    offset += limit;
    await sleep(1500); // small pause between pages
  }

  console.log('\n🎉 Incremental ingestion finished.');
}

run().catch((err) => console.error('💥 Fatal Script Error:', err));
