import 'dotenv/config';
import fetch from 'node-fetch';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const MB_BASE = 'https://musicbrainz.org/ws/2';

// Helper: avoid rate limits
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function fetchArtistDetails(id: string) {
  const url = `${MB_BASE}/artist/${id}?inc=artist-rels+area-rels+begin-area+aliases&fmt=json`;
  const res = await fetch(url, {
    headers: { 'User-Agent': 'DOMIDB/1.0 (domidb.org)' }
  });
  return res.json();
}

async function run() {
  console.log('Fetching all artists from Supabase…');

  const { data: artists, error } = await supabase
    .from('artists')
    .select('id, name');

  if (error) {
    console.error('Error fetching artists:', error);
    return;
  }

  if (!artists || artists.length === 0) {
    console.log('No artists found.');
    return;
  }

  console.log(`Found ${artists.length} artists. Backfilling…`);

  for (const artist of artists) {
    console.log(`\n🎤 ${artist.name} (${artist.id})`);

    const full = await fetchArtistDetails(artist.id);
    await sleep(1000); // respect MBz rate limits

    // Extract birthplace from multiple possible sources
    const origin_region =
      full['begin-area']?.name ||
      full.relations?.find((r: any) => r.type === 'born in')?.place?.name ||
      full.area?.name ||
      null;

    console.log(' → origin_region:', origin_region);

    await supabase
      .from('artists')
      .update({ origin_region })
      .eq('id', artist.id);
  }

  console.log('\n🎉 DONE — origin_region backfilled for all artists.');
}

run();
