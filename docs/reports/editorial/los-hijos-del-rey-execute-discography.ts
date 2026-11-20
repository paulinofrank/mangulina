import fs from 'node:fs';
import assert from 'node:assert/strict';
import { randomUUID, createHash } from 'node:crypto';
import dotenv from 'dotenv';
import sharp from 'sharp';
import { createClient } from '@supabase/supabase-js';

dotenv.config({ quiet: true });

const base = 'docs/reports/editorial/';
const manifestBytes = fs.readFileSync(base + 'los-hijos-del-rey-discography-manifest.json');
const manifest = JSON.parse(manifestBytes.toString('utf8'));
const coversManifest = JSON.parse(fs.readFileSync(base + 'los-hijos-del-rey-covers-manifest.json', 'utf8'));

const aid = manifest.artist_id;
assert.equal(aid, '3c82ee60-d565-405d-8423-7895d3706122');

const hash = (v: Buffer) => createHash('sha256').update(v).digest('hex');
const check = (r: any) => {
  if (r.error) throw new Error(r.error.message);
  return r.data;
};

const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL ?? process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { persistSession: false, autoRefreshToken: false } }
);

const executionFile = base + 'los-hijos-del-rey-execution-manifest.json';
const mode = process.argv[2];

const slugify = (s: string) =>
  s
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');

const LEAD_PERFORMER_ROLE_ID = 'c648475e-7d6a-4f08-9781-3f470b572537';

const KNOWN_ARTISTS: Record<string, string> = {
  'Fernando Villalona': 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd',
  'Raulín Rosendo': 'faf3e4cb-808e-419c-87ff-5126eed85e73',
  'Sergio Vargas': '059a9e99-5d11-433e-97b9-9c35e57908f1',
  'July Mateo "Rasputín"': '052b710d-e91f-41c6-94ac-480100f95f5b'
};

async function run() {
  if (mode === 'prepare') {
    console.log('=== MODE: PREPARE ===');
    assert.ok(!fs.existsSync(executionFile), 'Execution identities already frozen');
    assert.equal(manifest.releases.length, 13);

    // Verify baseline
    const artist = check(await db.from('artists').select('*').eq('id', aid).single());
    assert.ok(artist, 'Artist must exist');
    console.log(`Verified artist: ${artist.name} (${artist.status})`);

    const existingRels = check(await db.from('releases').select('*').eq('release_artist_id', aid));
    assert.equal(existingRels.length, 0, 'Releases already exist for artist');

    const existingRecs = check(await db.from('recordings').select('*').eq('artist_id', aid));
    assert.equal(existingRecs.length, 0, 'Recordings already exist for artist');

    // Verify the 18 shared recordings in releases 11 & 12
    const sharedRecIds = [
      ...manifest.releases[10].tracks.map((t: any) => t.existing_recording_id),
      ...manifest.releases[11].tracks.map((t: any) => t.existing_recording_id)
    ];
    assert.equal(sharedRecIds.length, 18);
    const existingShared = check(await db.from('recordings').select('id, title').in('id', sharedRecIds));
    assert.equal(existingShared.length, 18, 'All 18 shared recordings must exist in DB');

    const out: any = {
      approved_by: 'Editor Fabuloso Yes to 13-release, 119-track, 13-cover manifest, 2026-11-01',
      approved_proposal_sha256: hash(manifestBytes),
      created_at: new Date().toISOString(),
      artist_id: aid,
      baseline: {
        artist,
        releases: existingRels,
        recordings: existingRecs,
        shared_recordings_count: existingShared.length
      },
      releases: [],
      release_artists: [],
      recordings: [],
      tracks: [],
      recording_credits: []
    };

    // Build entities
    for (let i = 0; i < manifest.releases.length; i++) {
      const r = manifest.releases[i];
      const releaseId = randomUUID();
      const coverMeta = coversManifest.find((c: any) => c.index === i);
      assert.ok(coverMeta, `Cover manifest missing for index ${i}`);

      // Release slug
      let relSlug = slugify(r.title);
      if (r.title === 'Los Hijos Del Rey') {
        relSlug = `los-hijos-del-rey-${r.release_year}`;
      } else if (!relSlug.includes('los-hijos-del-rey')) {
        relSlug = `${relSlug}-los-hijos-del-rey`;
      }

      const releaseRow = {
        id: releaseId,
        title: r.title,
        slug: relSlug,
        type: 'album',
        release_artist_id: aid,
        release_year: r.release_year,
        year: r.release_year,
        date: `${r.release_year}-01-01`,
        label: r.label,
        catalog_number: r.catalog_number,
        country: 'DO',
        status: 'Official',
        has_cover_image: true,
        metadata: {
          format: r.format,
          catalog_number: r.catalog_number,
          label: r.label,
          apple_collection_id: r.apple_collection_id ?? null,
          spotify_album_id: r.spotify_album_id ?? null,
          discogs_master_id: r.discogs_master_id ?? null,
          discogs_release_id: r.discogs_release_id ?? null,
          notes: r.notes ?? null,
          cover_source: {
            url: r.cover_art,
            sha256: coverMeta.sha256
          }
        }
      };

      out.releases.push({
        id: releaseId,
        index: i,
        year: r.release_year,
        title: r.title,
        slug: relSlug,
        after: releaseRow,
        cover: {
          source_file: coverMeta.filepath,
          sha256: coverMeta.sha256,
          sizes: [150, 300]
        }
      });

      // Primary release_artist: Los Hijos del Rey
      out.release_artists.push({
        id: randomUUID(),
        release_id: releaseId,
        artist_id: aid,
        role: 'primary',
        credited_as: 'Los Hijos del Rey',
        display_order: 0
      });

      // Co-billed release_artists where applicable
      if (r.title.includes('Fernandito') && KNOWN_ARTISTS['Fernando Villalona']) {
        out.release_artists.push({
          id: randomUUID(),
          release_id: releaseId,
          artist_id: KNOWN_ARTISTS['Fernando Villalona'],
          role: 'primary',
          credited_as: 'Fernando Villalona',
          display_order: 1
        });
      }
      if (r.title.includes('Raulín') && KNOWN_ARTISTS['Raulín Rosendo']) {
        out.release_artists.push({
          id: randomUUID(),
          release_id: releaseId,
          artist_id: KNOWN_ARTISTS['Raulín Rosendo'],
          role: 'primary',
          credited_as: 'Raulín Rosendo',
          display_order: r.title.includes('Fernandito') ? 2 : 1
        });
      }
      if (r.title.includes('Sergio Vargas') && KNOWN_ARTISTS['Sergio Vargas']) {
        out.release_artists.push({
          id: randomUUID(),
          release_id: releaseId,
          artist_id: KNOWN_ARTISTS['Sergio Vargas'],
          role: 'primary',
          credited_as: 'Sergio Vargas',
          display_order: 1
        });
      }

      // Process tracks
      for (const t of r.tracks) {
        const trackId = randomUUID();
        let recordingId: string;

        if (t.existing_recording_id) {
          // Shared recording from Sergio Vargas
          recordingId = t.existing_recording_id;
        } else {
          // New recording
          recordingId = randomUUID();
          const recSlug = `los-hijos-del-rey-${slugify(t.title)}-${r.release_year}`;

          const recordingRow = {
            id: recordingId,
            title: t.title,
            slug: recSlug,
            artist_id: aid,
            release_id: releaseId,
            duration: t.duration_ms,
            recording_year: r.release_year,
            recording_context: 'secular',
            genre_id: t.genre_id,
            subgenre_id: t.subgenre_id,
            metadata: {
              source: 'Official liner notes and releases',
              literal_composer: t.composer ?? null,
              literal_lead_vocalist: t.lead_vocalist ?? null,
              original_position: t.position
            }
          };

          out.recordings.push({
            id: recordingId,
            release_id: releaseId,
            title: t.title,
            after: recordingRow
          });

          // Lead vocalist credit
          if (t.lead_vocalist) {
            const vocalArtistId = KNOWN_ARTISTS[t.lead_vocalist] ?? null;
            out.recording_credits.push({
              id: randomUUID(),
              recording_id: recordingId,
              artist_id: vocalArtistId,
              role: 'lead_performer',
              role_id: LEAD_PERFORMER_ROLE_ID,
              credited_as: t.lead_vocalist,
              position: 1,
              display_order: 0,
              metadata: {
                role_name: 'Voz principal',
                composer: t.composer ?? null
              }
            });
          }
        }

        // Track appearance
        out.tracks.push({
          id: trackId,
          release_id: releaseId,
          recording_id: recordingId,
          disc_number: 1,
          track_number: t.position,
          position: t.position,
          title_override: t.title,
          length: t.duration_ms,
          metadata: {
            position: t.position,
            is_shared: Boolean(t.existing_recording_id)
          }
        });
      }
    }

    assert.equal(out.releases.length, 13);
    assert.equal(out.recordings.length, 101);
    assert.equal(out.tracks.length, 119);
    assert.equal(new Set(out.recordings.map((x: any) => x.after.slug)).size, 101);
    assert.equal(new Set(out.releases.map((x: any) => x.after.slug)).size, 13);

    fs.writeFileSync(executionFile, JSON.stringify(out, null, 2));
    console.log(`Execution manifest written to ${executionFile}`);
    console.log(`Summary: Releases=${out.releases.length}, NewRecordings=${out.recordings.length}, Tracks=${out.tracks.length}, Credits=${out.recording_credits.length}, ReleaseArtists=${out.release_artists.length}`);

  } else if (mode === 'covers') {
    console.log('=== MODE: COVERS ===');
    const m = JSON.parse(fs.readFileSync(executionFile, 'utf8'));
    assert.equal(hash(manifestBytes), m.approved_proposal_sha256);

    const verification: any[] = [];

    for (const r of m.releases) {
      console.log(`Uploading covers for release ${r.index + 1}/13: ${r.title} (${r.id})...`);
      const srcBuf = fs.readFileSync(r.cover.source_file);
      assert.equal(hash(srcBuf), r.cover.sha256);

      // 1. Upload original high-res to cover-art-originals/{id}.jpg
      const origPath = `${r.id}.jpg`;
      const { error: origErr } = await db.storage
        .from('cover-art-originals')
        .upload(origPath, srcBuf, { contentType: 'image/jpeg', upsert: true });
      if (origErr) throw new Error(`Failed to upload ${origPath}: ${origErr.message}`);

      const origUrl = db.storage.from('cover-art-originals').getPublicUrl(origPath).data.publicUrl;
      const origResp = await fetch(origUrl);
      assert.equal(origResp.status, 200, `Original URL unreachable: ${origUrl}`);
      verification.push({ release_id: r.id, path: origPath, bucket: 'cover-art-originals', status: origResp.status });

      // 2. Process and upload WebP variants (300px, 150px) to cover-art
      for (const size of r.cover.sizes) {
        const webpPath = `${size}px/${r.id}.webp`;
        const webpBuf = await sharp(srcBuf)
          .rotate()
          .resize(size, size, { fit: 'contain', background: '#ffffff' })
          .webp({ quality: 90 })
          .toBuffer();

        const { error: webpErr } = await db.storage
          .from('cover-art')
          .upload(webpPath, webpBuf, { contentType: 'image/webp', upsert: true });
        if (webpErr) throw new Error(`Failed to upload ${webpPath}: ${webpErr.message}`);

        const webpUrl = db.storage.from('cover-art').getPublicUrl(webpPath).data.publicUrl;
        const webpResp = await fetch(webpUrl);
        assert.equal(webpResp.status, 200, `WebP URL unreachable: ${webpUrl}`);
        verification.push({ release_id: r.id, path: webpPath, bucket: 'cover-art', size, status: webpResp.status });
      }
    }

    fs.writeFileSync(base + 'los-hijos-del-rey-cover-verification.json', JSON.stringify(verification, null, 2));
    console.log(`Uploaded and verified 13 originals + 26 WebP variants (39 files total in Supabase Storage)!`);

  } else if (mode === 'import') {
    console.log('=== MODE: IMPORT ===');
    const m = JSON.parse(fs.readFileSync(executionFile, 'utf8'));
    assert.equal(hash(manifestBytes), m.approved_proposal_sha256);

    // 1. Insert releases (idempotent check)
    const { data: existingRels } = await db.from('releases').select('id').in('id', m.releases.map((r: any) => r.id));
    const existingRelIds = new Set((existingRels ?? []).map((r: any) => r.id));
    const releasesToInsert = m.releases.filter((r: any) => !existingRelIds.has(r.id)).map((r: any) => r.after);
    if (releasesToInsert.length > 0) {
      console.log(`Inserting ${releasesToInsert.length} releases...`);
      const { error: relErr } = await db.from('releases').insert(releasesToInsert);
      if (relErr) throw new Error(`Failed to insert releases: ${relErr.message}`);
    } else {
      console.log(`All ${m.releases.length} releases already present in DB.`);
    }

    // 2. Insert release_artists (idempotent check)
    const { data: existingRAs } = await db.from('release_artists').select('id').in('id', m.release_artists.map((r: any) => r.id));
    const existingRAIds = new Set((existingRAs ?? []).map((r: any) => r.id));
    const rasToInsert = m.release_artists.filter((r: any) => !existingRAIds.has(r.id));
    if (rasToInsert.length > 0) {
      console.log(`Inserting ${rasToInsert.length} release_artists relations...`);
      const { error: raErr } = await db.from('release_artists').insert(rasToInsert);
      if (raErr) throw new Error(`Failed to insert release_artists: ${raErr.message}`);
    } else {
      console.log(`All ${m.release_artists.length} release_artists already present in DB.`);
    }

    // 3. Insert recordings (idempotent check)
    const { data: existingRecs } = await db.from('recordings').select('id').in('id', m.recordings.map((r: any) => r.id));
    const existingRecIds = new Set((existingRecs ?? []).map((r: any) => r.id));
    const recordingsToInsert = m.recordings.filter((r: any) => !existingRecIds.has(r.id)).map((r: any) => r.after);
    if (recordingsToInsert.length > 0) {
      console.log(`Inserting ${recordingsToInsert.length} recordings...`);
      for (let i = 0; i < recordingsToInsert.length; i += 50) {
        const chunk = recordingsToInsert.slice(i, i + 50);
        const { error: recErr } = await db.from('recordings').insert(chunk);
        if (recErr) throw new Error(`Failed to insert recordings chunk ${i}: ${recErr.message}`);
      }
      console.log('Recordings inserted.');
    } else {
      console.log(`All ${m.recordings.length} recordings already present in DB.`);
    }

    // 4. Insert tracks (idempotent check)
    const { data: existingTrks } = await db.from('tracks').select('id').in('id', m.tracks.map((t: any) => t.id));
    const existingTrkIds = new Set((existingTrks ?? []).map((t: any) => t.id));
    const tracksToInsert = m.tracks.filter((t: any) => !existingTrkIds.has(t.id));
    if (tracksToInsert.length > 0) {
      console.log(`Inserting ${tracksToInsert.length} tracks...`);
      for (let i = 0; i < tracksToInsert.length; i += 50) {
        const chunk = tracksToInsert.slice(i, i + 50);
        const { error: trkErr } = await db.from('tracks').insert(chunk);
        if (trkErr) throw new Error(`Failed to insert tracks chunk ${i}: ${trkErr.message}`);
      }
      console.log('Tracks inserted.');
    } else {
      console.log(`All ${m.tracks.length} tracks already present in DB.`);
    }

    // 5. Insert recording_credits (only canonical credits where artist_id is non-null)
    const canonicalCredits = m.recording_credits.filter((c: any) => c.artist_id !== null);
    const { data: existingCreds } = await db.from('recording_credits').select('id').in('id', canonicalCredits.map((c: any) => c.id));
    const existingCredIds = new Set((existingCreds ?? []).map((c: any) => c.id));
    const creditsToInsert = canonicalCredits.filter((c: any) => !existingCredIds.has(c.id));
    if (creditsToInsert.length > 0) {
      console.log(`Inserting ${creditsToInsert.length} canonical recording_credits...`);
      for (let i = 0; i < creditsToInsert.length; i += 50) {
        const chunk = creditsToInsert.slice(i, i + 50);
        const { error: credErr } = await db.from('recording_credits').insert(chunk);
        if (credErr) throw new Error(`Failed to insert credits chunk ${i}: ${credErr.message}`);
      }
      console.log('Canonical recording credits inserted.');
    } else {
      console.log(`All ${canonicalCredits.length} canonical recording_credits already present in DB.`);
    }

    console.log('DATABASE IMPORT COMPLETED SUCCESSFULLY!');

  } else if (mode === 'verify') {
    console.log('=== MODE: VERIFY ===');
    const m = JSON.parse(fs.readFileSync(executionFile, 'utf8'));

    // Check artist
    const artist = check(await db.from('artists').select('*').eq('id', aid).single());
    assert.equal(artist.name, 'Los Hijos del Rey');

    // Check releases
    const releases = check(await db.from('releases').select('*').eq('release_artist_id', aid).order('release_year'));
    assert.equal(releases.length, 13, `Expected 13 releases, found ${releases.length}`);
    console.log(`Verified 13 releases in DB for ${artist.name}`);

    // Check release_artists
    const relIds = releases.map((r: any) => r.id);
    const relArtists = check(await db.from('release_artists').select('*').in('release_id', relIds));
    assert.equal(relArtists.length, m.release_artists.length, `Expected ${m.release_artists.length} release_artists, found ${relArtists.length}`);
    console.log(`Verified ${relArtists.length} release_artist entries in DB`);

    // Check recordings
    const recordings = check(await db.from('recordings').select('*').eq('artist_id', aid));
    assert.equal(recordings.length, 101, `Expected 101 recordings, found ${recordings.length}`);
    console.log(`Verified 101 new recordings in DB`);

    // Check tracks
    const tracks = check(await db.from('tracks').select('*').in('release_id', relIds));
    assert.equal(tracks.length, 119, `Expected 119 tracks, found ${tracks.length}`);
    console.log(`Verified 119 tracks linked across all 13 releases`);

    // Check shared tracks (releases 11 and 12)
    const rel11 = releases.find((r: any) => r.slug.includes('la-quiero-a-morir') || r.release_year === 1986);
    const rel12 = releases.find((r: any) => r.slug.includes('si-algun-dia-la-ves') || r.release_year === 1987);
    const trks11 = tracks.filter((t: any) => t.release_id === rel11.id);
    const trks12 = tracks.filter((t: any) => t.release_id === rel12.id);
    assert.equal(trks11.length, 8);
    assert.equal(trks12.length, 10);

    // Verify all 18 shared tracks point to recordings whose artist is Sergio Vargas
    const sharedTrackRecIds = [...trks11.map((t: any) => t.recording_id), ...trks12.map((t: any) => t.recording_id)];
    const sharedRecs = check(await db.from('recordings').select('id, artist_id, title').in('id', sharedTrackRecIds));
    assert.equal(sharedRecs.length, 18);
    for (const s of sharedRecs) {
      assert.equal(s.artist_id, '059a9e99-5d11-433e-97b9-9c35e57908f1', `Recording ${s.title} must belong to Sergio Vargas`);
    }
    console.log('Verified 18 shared tracks correctly point to canonical Sergio Vargas recordings without duplicate audio rows');

    // Test RPC get_artist_discography
    const rpcRes = await db.rpc('get_artist_discography', { artist_uuid: aid });
    assert.ok(rpcRes.data && rpcRes.data.length > 0, 'RPC get_artist_discography must return data');
    console.log(`RPC get_artist_discography returned ${rpcRes.data.length} tracks across the discography!`);

    const result = {
      date: new Date().toISOString(),
      artist_id: aid,
      artist_name: artist.name,
      artist_status: artist.status,
      releases_count: releases.length,
      recordings_count: recordings.length,
      tracks_count: tracks.length,
      release_artists_count: relArtists.length,
      shared_recordings_reused: 18,
      covers_verified: 13,
      rpc_discography_rows: rpcRes.data.length,
      releases: releases.map((r: any) => ({
        id: r.id,
        year: r.release_year,
        title: r.title,
        slug: r.slug,
        tracks_count: tracks.filter((t: any) => t.release_id === r.id).length,
        has_cover_image: r.has_cover_image
      }))
    };

    fs.writeFileSync(base + 'los-hijos-del-rey-discography-import-verification.json', JSON.stringify(result, null, 2));
    console.log('Verification artifact written to docs/reports/editorial/los-hijos-del-rey-discography-import-verification.json');

  } else if (mode === 'refresh') {
    console.log('=== MODE: REFRESH ===');
    const m = JSON.parse(fs.readFileSync(executionFile, 'utf8'));
    if (!process.env.REVALIDATION_TOKEN) {
      console.log('No REVALIDATION_TOKEN present in environment. Skipping remote edge cache purge.');
      return;
    }
    const releaseSlugs = m.releases.map((r: any) => r.slug);
    const res = await fetch('https://mangulina.do/api/revalidate', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${process.env.REVALIDATION_TOKEN}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        artists: ['los-hijos-del-rey'],
        releases: releaseSlugs
      })
    });
    console.log(`Revalidate response: ${res.status}`);
    const body = await res.text();
    console.log(`Body: ${body}`);
  } else {
    throw new Error('Unknown mode. Expected prepare, covers, import, verify, or refresh.');
  }
}

run().catch((err) => {
  console.error('EXECUTION ERROR:', err);
  process.exit(1);
});
