import 'dotenv/config';
import fetch from 'node-fetch';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const MB_BASE = 'https://musicbrainz.org/ws/2';

// Sleep helper to respect MBz rate limits
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function fetchRelease(mbid: string) {
  const url = `${MB_BASE}/release/${mbid}?inc=release-groups&fmt=json`;

  const res = await fetch(url, {
    headers: { 'User-Agent': 'Mangulina/1.0 (mangulina.com)' }
  });

  if (!res.ok) {
    throw new Error(`MBz error ${res.status} for release ${mbid}`);
  }

  return res.json();
}

async function run() {
  console.log("Fetching all releases with missing release_group_id…");

  const { data: releases, error } = await supabase
    .from("releases")
    .select("id, mbid")
    .is("release_group_id", null);

  if (error) {
    console.error("Error fetching releases:", error);
    return;
  }

  if (!releases || releases.length === 0) {
    console.log("No releases missing release_group_id.");
    return;
  }

  console.log(`Found ${releases.length} releases to backfill.`);

  for (const rel of releases) {
    if (!rel.mbid) {
      console.log(`Skipping release with no MBID: ${rel.id}`);
      continue;
    }

    console.log(`\n🎵 Release ${rel.mbid}`);

    try {
      const full = await fetchRelease(rel.mbid);
      await sleep(1000); // MBz rate limit

      const rg = full["release-group"];
      if (!rg) {
        console.log(" → No release-group found in MBz");
        continue;
      }

      const rg_mbid = rg.id;
      const title = rg.title;
      const primary_type = rg["primary-type"] || null;
      const secondary_types = rg["secondary-types"] || [];
      const disambiguation = rg.disambiguation || null;

      console.log(` → Release Group: ${title} (${rg_mbid})`);

      // 1. Upsert release group
      const { data: rgRow, error: rgErr } = await supabase
        .from("release_groups")
        .upsert(
          {
            mbid: rg_mbid,
            title,
            primary_type,
            secondary_types,
            disambiguation
          },
          { onConflict: "mbid" }
        )
        .select()
        .single();

      if (rgErr) {
        console.error("Error upserting release group:", rgErr);
        continue;
      }

      // 2. Update release with release_group_id
      await supabase
        .from("releases")
        .update({ release_group_id: rgRow.id })
        .eq("id", rel.id);

      console.log(" → Updated release with release_group_id");

    } catch (err) {
      console.error("Error processing release:", err);
      continue;
    }
  }

  console.log("\n🎉 DONE — release groups backfilled.");
}

run();
