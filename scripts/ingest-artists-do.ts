import 'dotenv/config';
import fetch from 'node-fetch';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const MB_BASE = 'https://musicbrainz.org/ws/2';
const USER_AGENT = 'DOMIDB/1.0 (domidb.org)';

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function fetchJSON(url: string) {
  console.log(`🔎 Fetching: ${url}`);
  const res = await fetch(url, {
    headers: { 'User-Agent': USER_AGENT }
  });
  console.log(`   → Status: ${res.status}`);
  if (!res.ok) {
    throw new Error(`MusicBrainz error: ${res.status} ${res.statusText}`);
  }
  return res.json();
}

async function fetchDominicanArtists(offset = 0, limit = 50) {
  const url = `${MB_BASE}/artist?query=country:DO&limit=${limit}&offset=${offset}&fmt=json`;
  return fetchJSON(url);
}

async function fetchArtistDetails(id: string) {
  const url = `${MB_BASE}/artist/${id}?inc=artist-rels+area-rels+aliases&fmt=json`;
  return fetchJSON(url);
}


function extractOriginRegion(full: any): string | null {
  return (
    full['begin-area']?.name ||
    full.relations?.find((r: any) => r.type === 'born in')?.place?.name ||
    full.area?.name ||
    null
  );
}

async function upsertArtist(full: any) {
  const origin_region = extractOriginRegion(full);

  console.log(`🎤 Upserting artist: ${full.name}`);
  console.log(`   → origin_region: ${origin_region}`);

  const { error } = await supabase.from('artists').upsert({
    id: full.id,
    name: full.name,
    sort_name: full['sort-name'],
    origin_region
  });

  if (error) {
    console.error('❌ Supabase insert error:', error);
  } else {
    console.log('   ✓ Inserted/updated');
  }
}

async function run() {
  console.log('🚀 Starting Dominican artist ingestion…');

  let offset = 0;
  const limit = 50;
  let total = 0;

  while (true) {
    console.log(`\n📄 Fetching page offset=${offset}`);
    const data = await fetchDominicanArtists(offset, limit);

    if (!data.artists || data.artists.length === 0) {
      console.log('No more artists.');
      break;
    }

    for (const artist of data.artists) {
      console.log(`\n➡ Fetching details for: ${artist.name} (${artist.id})`);
      const full = await fetchArtistDetails(artist.id);
      await upsertArtist(full);
      await sleep(1000);
      total++;
    }

    if (data.artists.length < limit) break;
    offset += limit;
  }

  console.log(`\n🎉 DONE — Imported ${total} Dominican artists.`);
}

run().catch((err) => {
  console.error('💥 Fatal error:', err);
});
