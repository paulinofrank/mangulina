import { createClient } from "@supabase/supabase-js";

export default async function handler(req, res) {
  const offset = Number(req.query.offset ?? 0);

  const sb = createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_SERVICE_ROLE_KEY
  );

  // Fetch 100 Apple Music links
  const { data: rows, error } = await sb
    .from("recording_platform_links")
    .select("recording_id, url")
    .eq("platform", "apple_music")
    .eq("link_type", "stream")
    .order("recording_id")
    .range(offset, offset + 99);

  if (error) return res.status(500).json({ error: error.message });

  if (!rows || rows.length === 0) {
    return res.json({ done: true });
  }

  // Process each row
  for (const row of rows) {
    try {
      const odesli = await fetchOdesli(row.url);

      if (!odesli) continue;

      await insertMissingPlatforms(sb, row.recording_id, odesli);
    } catch (err) {
      console.log("Error:", err.message);
    }
  }

  // Update checkpoint
  await sb
    .from("odesli_batch_progress")
    .update({ last_offset: offset + 100, updated_at: new Date().toISOString() })
    .eq("id", 1);

  return res.json({ nextOffset: offset + 100 });
}

// --- Odesli fetcher (serverless optimized) ---
async function fetchOdesli(appleUrl) {
  const encoded = encodeURIComponent(appleUrl);
  const url = `https://api.song.link/v1-alpha.1/links?url=${encoded}&songIfSingle=true&userCountry=US`;

  const resp = await fetch(url, {
    headers: { "User-Agent": "Mangulina/1.0" },
  });

  if (!resp.ok) return null;

  return await resp.json();
}

// --- Insert missing platforms ---
async function insertMissingPlatforms(sb, recording_id, odesli) {
  const PLATFORM_MAP = {
    youtube: "youtube",
    spotify: "spotify",
    deezer: "deezer",
    amazonMusic: "amazon_music",
    tidal: "tidal",
    pandora: "pandora",
    audiomack: "audiomack",
  };

  const { data: existing } = await sb
    .from("recording_platform_links")
    .select("platform")
    .eq("recording_id", recording_id);

  const existingSet = new Set(existing?.map((e) => e.platform) ?? []);

  for (const [key, platform] of Object.entries(PLATFORM_MAP)) {
    const link = odesli.linksByPlatform?.[key];
    if (!link?.url) continue;
    if (existingSet.has(platform)) continue;

    await sb.from("recording_platform_links").upsert({
      recording_id,
      platform,
      url: link.url,
      link_type: "stream",
      is_official: true,
      status: "approved_auto",
      confidence: 0.95,
      source: "songlink",
      checked_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    });
  }
}
