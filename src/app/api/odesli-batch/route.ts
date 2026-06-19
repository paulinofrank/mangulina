import { createClient } from "@supabase/supabase-js";

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const offset = Number(searchParams.get("offset") ?? 0);

    const sb = createClient(
      process.env.SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );

    // Fetch 100 Apple Music links
    const { data: rows, error } = await sb
      .from("recording_platform_links")
      .select("recording_id, url")
      .eq("platform", "apple_music")
      .eq("link_type", "stream")
      .order("recording_id")
      .range(offset, offset + 99);

    if (error) {
      return Response.json({ error: error.message }, { status: 500 });
    }

    if (!rows || rows.length === 0) {
      return Response.json({ done: true });
    }

    for (const row of rows) {
      try {
        const odesli = await fetchOdesli(row.url);
        if (!odesli) continue;
        await insertMissingPlatforms(sb, row.recording_id, odesli);
      } catch (err: any) {
        console.log("Error:", err.message);
      }
    }

    // Update checkpoint
    await sb
      .from("odesli_batch_progress")
      .update({
        last_offset: offset + 100,
        updated_at: new Date().toISOString(),
      })
      .eq("id", 1);

    return Response.json({ nextOffset: offset + 100 });
  } catch (err: any) {
    return Response.json(
      { error: "Unhandled exception", message: err.message, stack: err.stack },
      { status: 500 }
    );
  }
}

// --- Odesli fetcher ---
async function fetchOdesli(appleUrl: string) {
  const encoded = encodeURIComponent(appleUrl);
  const url = `https://api.song.link/v1-alpha.1/links?url=${encoded}&songIfSingle=true&userCountry=US`;

  const resp = await fetch(url, {
    headers: { "User-Agent": "Mangulina/1.0" },
  });

  if (!resp.ok) return null;
  return await resp.json();
}

// --- Insert missing platforms ---
async function insertMissingPlatforms(sb: any, recording_id: string, odesli: any) {
  const PLATFORM_MAP: Record<string, { platform: string; label: string; display_order: number }> = {
    youtube: { platform: "youtube", label: "YouTube", display_order: 1 },
    spotify: { platform: "spotify", label: "Spotify", display_order: 2 },
    deezer: { platform: "deezer", label: "Deezer", display_order: 4 },
    amazonMusic: { platform: "amazon_music", label: "Amazon Music", display_order: 5 },
    tidal: { platform: "tidal", label: "TIDAL", display_order: 6 },
    pandora: { platform: "pandora", label: "Pandora", display_order: 7 },
    audiomack: { platform: "audiomack", label: "Audiomack", display_order: 8 },
    boomplay: { platform: "boomplay", label: "Boomplay", display_order: 8 },
  };

  const { data: existing } = await sb
    .from("recording_platform_links")
    .select("platform")
    .eq("recording_id", recording_id);

  const existingSet = new Set(existing?.map((e: any) => e.platform) ?? []);

  for (const [key, config] of Object.entries(PLATFORM_MAP)) {
    const link = odesli.linksByPlatform?.[key];
    if (!link?.url) continue;
    if (existingSet.has(config.platform)) continue;

    await sb.from("recording_platform_links").upsert({
      recording_id,
      platform: config.platform,
      url: link.url,
      label: config.label,
      link_type: "stream",
      is_official: true,
      status: "approved_auto",
      display_order: config.display_order,
      confidence: 0.95,
      source: "songlink",
      checked_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    });
  }
}
