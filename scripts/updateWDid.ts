import 'dotenv/config';
import fetch from 'node-fetch';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const MB_BASE = 'https://musicbrainz.org/ws/2';
const WIKI_API = 'https://www.wikidata.org/w/api.php';

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

/**
 * Fetches Wikidata ID from MusicBrainz with a retry mechanism for socket hang-ups
 */
async function fetchFromMB(mbid: string, retries = 3): Promise<string | null> {
  const url = `${MB_BASE}/artist/${mbid}?inc=url-rels&fmt=json`;
  
  for (let i = 0; i < retries; i++) {
    try {
      const res = await fetch(url, {
        headers: { 'User-Agent': 'WikiMusicSync/1.1 (https://wikimusic.do; contact@wikimusic.do)' },
        timeout: 15000 
      });

      if (!res.ok) return null;
      const data: any = await res.json();

      const wikidataRel = data.relations?.find((rel: any) => rel.type === 'wikidata');
      if (wikidataRel?.url?.resource) {
        return wikidataRel.url.resource.split('/').pop() || null;
      }
      return null;
    } catch (err: any) {
      if (i === retries - 1) throw err;
      const wait = (i + 1) * 2000;
      console.log(`\n  ⚠️ Socket error for ${mbid}. Retrying in ${wait/1000}s... (${err.code})`);
      await sleep(wait);
    }
  }
  return null;
}

/**
 * Fallback: Search Wikidata by name if the MBz link is missing
 */
async function searchWikidataByName(name: string): Promise<string | null> {
  try {
    const params = new URLSearchParams({
      action: 'wbsearchentities',
      search: name,
      language: 'en',
      format: 'json',
      origin: '*'
    });

    const res = await fetch(`${WIKI_API}?${params.toString()}`, {
      headers: { 'User-Agent': 'WikiMusicSync/1.1 (https://wikimusic.do)' }
    });

    const data: any = await res.json();
    return data.search?.[0]?.id || null;
  } catch (err) {
    console.error(`  ❌ Search failed for ${name}`);
    return null;
  }
}

async function run() {
  console.log('🚀 Starting Resilient Wikidata Backfill...');

  // 1. Get artists who have MBID but no Wikidata ID
  const { data: artists, error } = await supabase
    .from('artists')
    .select('id, name, mbid')
    .not('mbid', 'is', null)
    .is('wikidata_id', null);

  if (error) {
    console.error('Supabase error:', error);
    return;
  }

  console.log(`Found ${artists?.length || 0} artists to process.\n`);

  for (const artist of artists || []) {
    process.stdout.write(`🎤 ${artist.name}... `);

    try {
      // Try MusicBrainz first
      let qid = await fetchFromMB(artist.mbid!);
      await sleep(1000); // MBz rate limit compliance

      // If MBz fails, try Wikidata Search
      if (!qid) {
        process.stdout.write(' (MBz link missing, searching Wiki...) ');
        qid = await searchWikidataByName(artist.name);
      }

      if (qid) {
        const { error: updateError } = await supabase
          .from('artists')
          .update({ wikidata_id: qid })
          .eq('id', artist.id);

        if (updateError) {
          console.log(`❌ DB Error: ${updateError.message}`);
        } else {
          console.log(`✅ QID: ${qid}`);
        }
      } else {
        console.log('ℹ️ No ID found in either source.');
      }
    } catch (err: any) {
      console.log(`❌ Skipped due to persistent error: ${err.message}`);
    }
  }

  console.log('\n🎉 Process complete. Check your DB for updated Wikidata IDs.');
}

run();