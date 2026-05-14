import { createClient } from "@supabase/supabase-js";
import fetch from "node-fetch";

import {
  SUPABASE_URL,
  SUPABASE_SERVICE_ROLE_KEY,
  MUSICBRAINZ_USER_AGENT,
  DELAY_MS,
  TEST_MODE,
  TEST_LIMIT,
  COVER_ART_BUCKET,
  sleep,
  log
} from "./utils.js";

import { upsertReleaseGroup } from "./modules/releaseGroup.js";
import { upsertRelease } from "./modules/release.js";
import { upsertRecording } from "./modules/recording.js";
import { upsertTrack } from "./modules/track.js";
import {
  fetchCoverArtMetadata,
  downloadImage,
  uploadToStorage
} from "./modules/coverArt.js";

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

async function fetchReleasesToProcess() {
  let query = supabase
    .from("releases")
    .select("id, mbid, metadata, release_group_id")
    .order("release_group_id", { ascending: true });

  if (TEST_MODE) query = query.limit(TEST_LIMIT);

  const { data, error } = await query;
  if (error) throw error;
  return data || [];
}

async function fetchMBRelease(mbid: string) {
  const url = `https://musicbrainz.org/ws/2/release/${mbid}?inc=recordings+release-groups+isrcs&fmt=json`;

  const res = await fetch(url, {
    headers: { "User-Agent": MUSICBRAINZ_USER_AGENT }
  });

  if (!res.ok) {
    throw new Error(`MB fetch failed: ${res.status}`);
  }

  return res.json();
}

async function recordFailure(
  entityType: string,
  entityMbid: string,
  operation: string,
  errorObj: any,
  payload: any = null
) {
  try {
    await supabase.from("ingest_failures").insert({
      entity_type: entityType,
      entity_mbid: entityMbid,
      operation,
      error_message: errorObj.message || String(errorObj),
      payload: payload || {},
      retry_count: 0
    });
  } catch (e: any) {
    log("Failed to write ingest_failures:", e.message);
  }
}

async function processReleaseRow(row: any) {
  const releaseMbid = row.mbid;
  log("Processing release:", releaseMbid);

  try {
    const mbRelease = await fetchMBRelease(releaseMbid);

    // Release group
    const rgMbid = mbRelease["release-group"]?.id || null;
    let releaseGroupRecord = null;

    if (rgMbid) {
      releaseGroupRecord = await upsertReleaseGroup(
        supabase,
        rgMbid,
        mbRelease["release-group"]
      );
      log("Upserted release_group:", releaseGroupRecord?.mbid);
    }

    // Cover art
    let coverPath: string | null = null;

    try {
      const caMeta = await fetchCoverArtMetadata(releaseMbid);
      const front = caMeta.images?.find((img: any) => img.front);

      if (front?.image) {
        const buffer = await downloadImage(front.image);
        const ext = front.image.split(".").pop()?.split("?")[0] || "jpg";
        const path = `${releaseMbid}/front.${ext}`;

        await uploadToStorage(
          supabase,
          COVER_ART_BUCKET,
          path,
          buffer,
          front.mime || "image/jpeg"
        );

        coverPath = `${COVER_ART_BUCKET}/${path}`;
        log("Uploaded cover art:", coverPath);
      }
    } catch (e: any) {
      log("Cover art failed:", e.message);
      await recordFailure("cover_art", releaseMbid, "fetch_upload", e);
    }

    // Release
    const releaseRecord = await upsertRelease(
      supabase,
      releaseMbid,
      mbRelease,
      releaseGroupRecord?.id || null,
      coverPath
    );

    log("Upserted release:", releaseRecord?.mbid);

    // Tracks + recordings
    for (const medium of mbRelease.media || []) {
      for (const t of medium.tracks || []) {
        try {
          const recId = t.recording?.id || null;

          let recordingRecord = null;
          if (recId) {
            recordingRecord = await upsertRecording(
              supabase,
              recId,
              t.recording
            );
            log("Upserted recording:", recordingRecord?.mbid);
          }

          const trackRecord = await upsertTrack(
            supabase,
            t.id || null,
            releaseRecord.id,
            recordingRecord?.id || null,
            {
              position: t.position,
              length: t.length,
              "medium-position": medium.position,
              ...t
            }
          );

          log("Upserted track:", trackRecord?.mbid || trackRecord?.id);
        } catch (e: any) {
          log("Track failed:", e.message);
          await recordFailure("track", releaseMbid, "upsert", e, t);
        }
      }
    }
  } catch (err: any) {
    log("Failed processing release:", releaseMbid, err.message);
    await recordFailure("release", releaseMbid, "process", err, row);
  }
}

async function main() {
  log("Starting ingestion. TEST_MODE:", TEST_MODE, "LIMIT:", TEST_LIMIT);

  const rows = await fetchReleasesToProcess();
  log("Releases to process:", rows.length);

  for (const row of rows) {
    await processReleaseRow(row);
    log(`Sleeping ${DELAY_MS}ms`);
    await sleep(DELAY_MS);
  }

  log("Ingestion complete.");
}

main();
