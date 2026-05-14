import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';
import fetch from 'node-fetch';

/**
 * WIKIMUSIC.DO - FULL ARTIST SOCIAL SYNC
 * This script iterates through all artists, fetches external links from MusicBrainz,
 * and populates the database using the internal UUID while matching via MBID.
 */

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

// MusicBrainz requires 1 request per second (we use 1.2s to be safe)
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function runGlobalSync() {
  console.log("🚀 Starting Global Artist Enrichment...");

  // 1. Fetch all artists that have an MBID
  const { data: artists, error } = await supabase
    .from('artists')
    .select('id, name, mbid')
    .not('mbid', 'is', null);

  if (error || !artists) {
    console.error("❌ Failed to fetch artists from Supabase:", error?.message);
    return;
  }

  console.log(`📊 Found ${artists.length} artists to process.`);
  console.log(`⏱️ Estimated time: ~${Math.round((artists.length * 1.2) / 60)} minutes.\n`);

  let successCount = 0;
  let skipCount = 0;

  for (const artist of artists) {
    const mbid = artist.mbid;
    const url = `https://musicbrainz.org/ws/2/artist/${mbid}?fmt=json&inc=url-rels`;

    try {
      const res = await fetch(url, {
        headers: { 
          'User-Agent': 'WikiMusicDO/2.0 (https://wikimusic.do; fvpg@hotmail.com)' 
        }
      });

      if (!res.ok) {
        console.log(`⚠️  [SKIP] ${artist.name} - API returned ${res.status}`);
        skipCount++;
        continue;
      }

      const data: any = await res.json();
      
      const updates: any = {
        website: null,
        instagram: null,
        facebook: null,
        youtube: null,
        wikidata_id: null
      };

      let foundData = false;

      // The refined mapping logic based on our "Raw Test"
      data.relations?.forEach((rel: any) => {
        const type = rel.type;
        const resource = rel.url?.resource;
        if (!resource) return;

        // Support both "social network" and "social networking"
        if (type === 'social network' || type === 'social networking') {
          const link = resource.toLowerCase();
          if (link.includes('instagram.com')) {
            updates.instagram = resource;
            foundData = true;
          } else if (link.includes('facebook.com')) {
            updates.facebook = resource;
            foundData = true;
          }
        } 
        else if (type === 'official homepage') {
          updates.website = resource;
          foundData = true;
        } 
        else if (type === 'youtube') {
          updates.youtube = resource;
          foundData = true;
        } 
        else if (type === 'wikidata') {
          updates.wikidata_id = resource.split('/').pop();
          foundData = true;
        }
      });

      if (foundData) {
        // Update using the Internal ID (id), matching by mbid was for the test, 
        // but updating by PK (id) is standard practice.
        const { error: upError } = await supabase
          .from('artists')
          .update(updates)
          .eq('id', artist.id);

        if (upError) {
          console.error(`❌ DB Error for ${artist.name}:`, upError.message);
        } else {
          console.log(`✅ Synced: ${artist.name}`);
          successCount++;
        }
      } else {
        console.log(`⏭️  No new data for: ${artist.name}`);
        skipCount++;
      }

    } catch (err: any) {
      console.error(`❌ Connection error for ${artist.name}:`, err.message);
    }

    // Wait 1.2 seconds between requests to avoid being blocked by MusicBrainz
    await sleep(1200);
  }

  console.log(`\n--- 🏁 Sync Finished ---`);
  console.log(`✅ Successfully Updated: ${successCount}`);
  console.log(`⏭️  Skipped/No Data: ${skipCount}`);
}

runGlobalSync();