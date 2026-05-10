import 'dotenv/config';
import fetch from 'node-fetch';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const MB_BASE = 'https://musicbrainz.org/ws/2';
const CAA_BASE = 'https://coverartarchive.org';
const USER_AGENT = 'DOMIDB/1.0 (domidb.org)';

const ARTIST_DELAY = 2000;   // 2 seconds between artists
const RECORDING_DELAY = 1500; // 1.5 seconds between recording detail fetches
const RELEASE_DELAY = 1500;  // 1.5 seconds between release fetches
const RETRY_DELAY = 2500;    // retry wait
const MAX_RECORDINGS = 300;  // stop after 300 total recordings

let globalRecordingCount = 0;

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function fetchJSON(url: string, retries = 5): Promise<any> {
  try {
    const res = await fetch(url, { headers: { 'User-Agent': USER_AGENT } });
    if (!res.ok) throw new Error(`MB request failed: ${res.status} ${res.statusText}`);
    return res.json();
  } catch (err: any) {
    if (retries > 0) {
      console.log(`   ⚠️ ${err.code || err.message} — retrying in 2.5s…`);
      await sleep(RETRY_DELAY);
      return fetchJSON(url, retries - 1);
    }
    console.log(`   ❌ Failed after retries: ${url}`);
    throw err;
  }
}

// Step 1 — Fetch list of recordings for an artist
async function fetchRecordingsForArtist(artistId: string, limit = 20) {
  const url = `${MB_BASE}/recording?artist=${artistId}&limit=${limit}&fmt=json`;
  return fetchJSON(url);
}

// Step 2 — Fetch full recording details including releases
async function fetchRecordingDetails(recordingId: string) {
  const url = `${MB_BASE}/recording/${recordingId}?inc=releases&fmt=json`;
  return fetchJSON(url);
}

async function fetchRelease(releaseId: string) {
  const url = `${MB_BASE}/release/${releaseId}?inc=recordings+artists+release-groups&fmt=json`;
  return fetchJSON(url);
}

async function fetchCoverArt(releaseId: string): Promise<string | null> {
  const url = `${CAA_BASE}/release/${releaseId}/front`;
  try {
    const res = await fetch(url);
    return res.ok ? url : null;
  } catch {
    return null;
  }
}

async function upsertReleaseGroup(rg: any) {
  if (!rg) return;
  const { error } = await supabase.from('release_groups').upsert({
    id: rg.id,
    title: rg.title,
    type: rg['primary-type'] || null
  });
  if (error) console.error('Supabase error upserting release_group:', error);
}

async function upsertRelease(release: any, coverUrl: string | null) {
  const { error } = await supabase.from('releases').upsert({
    id: release.id,
    title: release.title,
    release_year: release.date ? parseInt(release.date.slice(0, 4)) : null,
    country: release.country || null,
    label: release.label_info?.[0]?.label?.name || null,
    release_group_id: release['release-group']?.id || null,
    cover_image_url: coverUrl
  });
  if (error) console.error('Supabase error upserting release:', error);
}

async function upsertRecording(recording: any, releaseId: string, artistId: string) {
  const year = recording.first_release_date
    ? parseInt(recording.first_release_date.slice(0, 4))
    : null;

  const { error } = await supabase.from('recordings').upsert({
    id: recording.id,
    title: recording.title,
    duration: recording.length || null,
    recording_year: year,
    release_id: releaseId,
    artist_id: artistId
  });
  if (error) console.error('Supabase error upserting recording:', error);
}

async function processArtist(artist: { id: string; name: string }) {
  if (globalRecordingCount >= MAX_RECORDINGS) return;

  console.log(`\n🎤 Processing recordings for ${artist.name} (${artist.id})`);

  const data = await fetchRecordingsForArtist(artist.id, 20);
  const recs = data.recordings || [];

  if (recs.length === 0) {
    console.log('  ⚠️ No recordings found.');
    return;
  }

  let countForArtist = 0;

  for (const rec of recs) {
    if (globalRecordingCount >= MAX_RECORDINGS) break;

    console.log(`  🎵 Recording: ${rec.title}`);

    // Step 2 — fetch full recording details to get releases
    const fullRec = await fetchRecordingDetails(rec.id);
    await sleep(RECORDING_DELAY);

    const releaseId = fullRec.releases?.[0]?.id || null;
    if (!releaseId) {
      console.log('    ⚠️ No release found, skipping.');
      continue;
    }

    // Fetch release details
    const release = await fetchRelease(releaseId);
    await sleep(RELEASE_DELAY);

    if (release['release-group']) {
      await upsertReleaseGroup(release['release-group']);
    }

    const coverUrl = await fetchCoverArt(releaseId);

    await upsertRelease(release, coverUrl);
    await upsertRecording(fullRec, releaseId, artist.id);

    countForArtist++;
    globalRecordingCount++;

    console.log(`    ✓ Saved (${globalRecordingCount}/${MAX_RECORDINGS})`);
  }

  console.log(`  ✅ Done: ${countForArtist} recordings for ${artist.name}`);
}

async function run() {
  console.log('Loading Dominican artists from Supabase…');

  const { data: artists, error } = await supabase.from('artists').select('id, name');

  if (error) {
    console.error('Error fetching artists from Supabase:', error);
    return;
  }

  if (!artists || artists.length === 0) {
    console.log('No artists found. Run ingest-artists-do.ts first.');
    return;
  }

  console.log(`Found ${artists.length} artists. Fetching recordings…`);

  for (const artist of artists) {
    if (globalRecordingCount >= MAX_RECORDINGS) break;
    await processArtist(artist);
    await sleep(ARTIST_DELAY);
  }

  console.log(`\n🎉 DONE — Ingested ${globalRecordingCount} recordings.`);
}

run().catch((e) => console.error('Fatal error:', e));
