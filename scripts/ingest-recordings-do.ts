import "dotenv/config";
import { createClient } from "@supabase/supabase-js";

// --------------------------------------------------
// SUPABASE
// --------------------------------------------------
const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

// --------------------------------------------------
// HELPERS
// --------------------------------------------------
const sleep = (ms: number) =>
  new Promise(resolve => setTimeout(resolve, ms));

function uuid(v: any): string | null {
  if (!v) return null;

  const s = String(v).trim().toLowerCase();

  return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.test(
    s
  )
    ? s
    : null;
}

// --------------------------------------------------
// SAFE FETCH (retry + resilience)
// --------------------------------------------------
async function safeFetch(url: string, retries = 3): Promise<any> {
  for (let attempt = 1; attempt <= retries; attempt++) {
    try {
      const res = await fetch(url, {
        headers: {
          "User-Agent": "domidb/1.0 (contact: you@example.com)",
        },
      });

      if (!res.ok) {
        throw new Error(`HTTP ${res.status}`);
      }

      return await res.json();
    } catch (err: any) {
      console.log(
        `⚠️ Fetch failed (${attempt}/${retries}):`,
        err.message
      );

      if (attempt === retries) {
        console.log("❌ Skipping URL:", url);
        return null;
      }

      await sleep(2000 * attempt);
    }
  }

  return null;
}

// --------------------------------------------------
// ARTIST RESOLUTION
// --------------------------------------------------
async function resolveArtistId(mbid: any) {
  const clean = uuid(mbid);

  if (!clean) return null;

  const { data } = await supabase
    .from("artists")
    .select("id")
    .eq("mbid", clean)
    .maybeSingle();

  return data?.id ?? null;
}

// --------------------------------------------------
// MUSICBRAINZ FETCHERS
// --------------------------------------------------
async function fetchReleaseGroups(artistMBID: string) {
  const json = await safeFetch(
    `https://musicbrainz.org/ws/2/release-group?artist=${artistMBID}&fmt=json&limit=100`
  );

  if (!json) return [];

  return json["release-groups"] || [];
}

async function fetchReleases(groupId: string) {
  await sleep(1000);

  const json = await safeFetch(
    `https://musicbrainz.org/ws/2/release?release-group=${groupId}&inc=recordings+artist-credits&fmt=json&limit=100`
  );

  if (!json) return [];

  return json.releases || [];
}

// --------------------------------------------------
// PROCESS ARTIST
// --------------------------------------------------
async function processArtist(artist: any) {
  console.log(`🎤 ${artist.name}`);

  const groups = await fetchReleaseGroups(artist.mbid);

  if (!groups.length) {
    console.log("⚠️ No release groups");
    return;
  }

  for (const g of groups) {
    const releases = await fetchReleases(g.id);

    for (const r of releases) {
      // --------------------------------------------------
      // RELEASE
      // --------------------------------------------------
      const { data: release, error: releaseErr } = await supabase
        .from("releases")
        .upsert(
          {
            mbid: uuid(r.id),
            title: r.title ?? "Unknown",
            metadata: {
              mb_release_id: r.id ?? null,
              mb_group_id: g.id ?? null,
              source: "musicbrainz",
            },
          },
          {
            onConflict: "mbid",
          }
        )
        .select()
        .maybeSingle();

      if (releaseErr || !release) {
        console.log("[RELEASE ERROR]", releaseErr?.message);
        continue;
      }

      // --------------------------------------------------
      // TRACKS
      // --------------------------------------------------
      const tracks =
        r.media?.flatMap((m: any) => m.tracks || []) || [];

      if (!tracks.length) {
        continue;
      }

      for (const t of tracks) {
        const recMBID = uuid(t.recording?.id);

        if (!recMBID) continue;

        // --------------------------------------------------
        // RECORDING
        // --------------------------------------------------
        const { data: recording, error: recErr } = await supabase
          .from("recordings")
          .upsert(
            {
              mbid: recMBID,
              title: t.title ?? "Unknown",
              release_id: release.id,
              duration: t.length ?? null,
              metadata: {
                mb_recording_id: t.recording?.id ?? null,
                source: "musicbrainz",
              },
            },
            {
              onConflict: "mbid",
            }
          )
          .select()
          .maybeSingle();

        if (recErr || !recording) {
          console.log("[RECORDING ERROR]", recErr?.message);
          continue;
        }

        // --------------------------------------------------
        // CREDITS
        // --------------------------------------------------
        const credits = t.recording?.["artist-credit"] || [];

        for (let i = 0; i < credits.length; i++) {
          const c = credits[i];

          const artistId = await resolveArtistId(
            c?.artist?.id
          );

          const { error: creditErr } = await supabase
            .from("recording_credits")
            .upsert(
              {
                recording_id: recording.id,
                artist_id: artistId,
                role: c?.role || "performer",
                position: i,
                metadata: {
                  mb_artist_id: c?.artist?.id ?? null,
                  mb_name: c?.name ?? null,
                  source: "musicbrainz",
                },
              },
              {
                onConflict: "recording_id,artist_id,role",
              }
            );

          if (creditErr) {
            console.log("[CREDIT ERROR]", creditErr.message);
          }
        }
      }
    }
  }
}

// --------------------------------------------------
// FETCH ARTISTS
// --------------------------------------------------
async function fetchArtists() {
  const { data, error } = await supabase
    .from("artists")
    .select("*")
    .order("id", { ascending: true })
    .range(500, 599); // de 100 en 100 para no saturar MusicBrainz y para poder reanudar fácilmente en caso de errores

  if (error) throw error;

  return data || [];
}

// --------------------------------------------------
// RUN
// --------------------------------------------------
(async () => {
  console.log("🚀 Starting ingestion");

  const artists = await fetchArtists();

  for (const artist of artists) {
    try {
      await processArtist(artist);
    } catch (err: any) {
      console.log(
        `❌ Artist failed: ${artist.name}`,
        err.message
      );
    }
  }

  console.log("✅ DONE");
})();