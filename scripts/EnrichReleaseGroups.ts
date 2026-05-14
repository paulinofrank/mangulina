import fetch from "node-fetch";
import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// MusicBrainz polite rate limit: 1 request per second
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function fetchReleaseGroup(mbid) {
  const url = `https://musicbrainz.org/ws/2/release-group/${mbid}?fmt=json`;

  const res = await fetch(url, {
    headers: {
      "User-Agent": "Mangulina/1.0 ( https://mangulina.com )"
    }
  });

  if (!res.ok) {
    console.error(`Failed to fetch ${mbid}: ${res.status}`);
    return null;
  }

  return res.json();
}

async function enrichReleaseGroups() {
  console.log("Fetching release_group IDs from database…");

  const { data: groups, error } = await supabase
    .from("release_groups")
    .select("id, title")
    .is("title", null); // only enrich empty rows

  if (error) {
    console.error("Error fetching release_groups:", error);
    return;
  }

  console.log(`Found ${groups.length} release_groups to enrich.`);

  for (const g of groups) {
    console.log(`Fetching metadata for ${g.id}…`);

    const rg = await fetchReleaseGroup(g.id);
    await sleep(1000); // MusicBrainz rate limit

    if (!rg) continue;

    const payload = {
      title: rg.title || null,
      type: rg["primary-type"] || null,
      primary_type: rg["primary-type"] || null,
      secondary_types: rg["secondary-types"] || [],
      disambiguation: rg.disambiguation || null,
      mbid: rg.id || g.id,
      metadata: rg
    };

    console.log(`Updating release_group ${g.id} → ${payload.title}`);

    const { error: updateError } = await supabase
      .from("release_groups")
      .update(payload)
      .eq("id", g.id);

    if (updateError) {
      console.error(`Failed to update ${g.id}:`, updateError);
    }
  }

  console.log("Enrichment complete.");
}

enrichReleaseGroups();
