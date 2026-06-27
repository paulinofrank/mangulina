"use client";

import { useCallback, useEffect, useMemo, useState } from "react";

import { getSupabaseClient } from "@/lib/supabase";

type ArtistStatus =
  | "draft"
  | "published"
  | "hidden"
  | "needs_review"
  | "duplicate";

type SpotlightArtist = {
  id: string;
  name: string;
  stage_name?: string | null;
  slug?: string | null;
  status?: ArtistStatus | string | null;
};

type FeaturedArtistRow = {
  artist_id?: string | null;
};

type AdminWriteResponse = {
  ok: boolean;
  artistId?: string;
  error?: string;
};

export default function AdminHomepageSpotlight() {
  const supabase = useMemo(() => getSupabaseClient(), []);
  const [artists, setArtists] = useState<SpotlightArtist[]>([]);
  const [featuredId, setFeaturedId] = useState("");
  const [mounted, setMounted] = useState(false);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [status, setStatus] = useState("");

  const fetchSpotlightData = useCallback(async () => {
    setLoading(true);

    const { data: artistsData, error: artistsError } = await supabase
      .from("artists")
      .select("id, name, stage_name, slug, status")
      .order("name", { ascending: true });

    if (artistsError) {
      console.error("Error fetching artists:", artistsError);
      setStatus(`Error loading artists: ${artistsError.message}`);
    } else {
      setArtists((artistsData ?? []) as SpotlightArtist[]);
    }

    const { data: featuredData, error: featuredError } = await supabase
      .from("featured_artist")
      .select("artist_id")
      .maybeSingle();

    if (featuredError) {
      console.error("Error fetching featured artist:", featuredError);
    }

    const featuredRow = featuredData as FeaturedArtistRow | null;
    setFeaturedId(featuredRow?.artist_id ? String(featuredRow.artist_id) : "");
    setLoading(false);
  }, [supabase]);

  useEffect(() => {
    setMounted(true);
    void fetchSpotlightData();
  }, [fetchSpotlightData]);

  const controlsLoading = mounted && loading;
  const updateDisabled = mounted
    ? Boolean(loading || saving || !featuredId)
    : false;

  async function updateFeatured() {
    if (!featuredId) return;

    setSaving(true);
    setStatus("");

    const response = await fetch("/api/admin/featured-artist", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ artistId: featuredId }),
    });

    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error updating spotlight: ${result.error || response.statusText}`);
    } else {
      setStatus("Homepage spotlight updated.");
    }

    setSaving(false);
  }

  return (
    <section className="mt-6 rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <div className="mb-4 flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
            Homepage Spotlight
          </h2>
          <p className="mt-2 text-sm text-gray-500">
            Choose the artist featured in the homepage spotlight section.
          </p>
        </div>

        {status && (
          <p className="rounded-lg border border-gray-100 bg-gray-50 px-3 py-2 text-xs text-gray-600">
            {status}
          </p>
        )}
      </div>

      <div className="grid gap-3 sm:grid-cols-[1fr_auto]">
        <select
          value={featuredId ?? ""}
          onChange={(event) => setFeaturedId(event.target.value)}
          disabled={controlsLoading}
          className="rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm outline-none transition focus:border-[#002D62] disabled:cursor-not-allowed disabled:opacity-50"
        >
          <option value="">
            {controlsLoading ? "Loading artists..." : "-- Select Featured Artist --"}
          </option>

          {artists.map((artist) => (
            <option key={artist.id} value={artist.id}>
              {artist.name}
              {artist.status && artist.status !== "published"
                ? ` - ${artist.status}`
                : ""}
            </option>
          ))}
        </select>

        <button
          type="button"
          onClick={updateFeatured}
          disabled={updateDisabled}
          className="rounded-lg bg-[#002D62] px-5 py-2 text-sm text-white transition hover:bg-[#CE1126] disabled:cursor-not-allowed disabled:opacity-40"
        >
          {saving ? "Updating..." : "Update Spotlight"}
        </button>
      </div>
    </section>
  );
}
