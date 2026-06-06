"use client";

import Link from "next/link";
import { useCallback, useEffect, useMemo, useState } from "react";

import { getSupabaseClient } from "@/lib/supabase";

type ArtistStatus =
  | "draft"
  | "published"
  | "hidden"
  | "needs_review"
  | "duplicate";

type AdminArtist = {
  id: string;
  name: string;
  slug?: string | null;
  stage_name?: string | null;
  status?: ArtistStatus | string | null;
};

type AdminDiscographyRelease = {
  id: string;
  title: string;
  type: string | null;
  release_year: number | null;
  year: number | null;
  date: string | null;
  status: string | null;
  label: string | null;
  country: string | null;
  barcode: string | null;
  catalog_number: string | null;
  disambiguation: string | null;
  release_artist_id: string;
  track_count: number;
};

type ReleaseForm = {
  title: string;
  type: string;
  release_year: string;
  year: string;
  date: string;
  status: string;
  label: string;
  country: string;
  barcode: string;
  catalog_number: string;
  disambiguation: string;
};

type AdminWriteResponse = {
  ok: boolean;
  id?: string;
  error?: string;
};

type ArtistDiscographyResponse = {
  ok: boolean;
  releases?: AdminDiscographyRelease[];
  error?: string;
};

const emptyReleaseForm: ReleaseForm = {
  title: "",
  type: "Album",
  release_year: "",
  year: "",
  date: "",
  status: "Official",
  label: "",
  country: "DO",
  barcode: "",
  catalog_number: "",
  disambiguation: "",
};

const releaseTypeOptions = [
  { value: "Album", label: "Album" },
  { value: "EP", label: "EP" },
  { value: "Single", label: "Single" },
  { value: "Compilation", label: "Compilation" },
  { value: "Live", label: "Live" },
  { value: "Other", label: "Other" },
];

const releaseStatusOptions = [
  { value: "Official", label: "Official" },
  { value: "Promotion", label: "Promotion" },
  { value: "Bootleg", label: "Bootleg" },
  { value: "Pseudo-Release", label: "Pseudo-Release" },
  { value: "Withdrawn", label: "Withdrawn" },
];

function nullable(value: string | null | undefined) {
  const trimmed = (value ?? "").trim();
  return trimmed ? trimmed : null;
}

function yearFromDate(value: string) {
  const year = value.slice(0, 4);
  return /^\d{4}$/.test(year) ? year : "";
}

export default function AdminDiscographyPage() {
  const supabase = useMemo(() => getSupabaseClient(), []);
  const [artists, setArtists] = useState<AdminArtist[]>([]);
  const [selectedArtistId, setSelectedArtistId] = useState("");
  const [search, setSearch] = useState("");
  const [discography, setDiscography] = useState<AdminDiscographyRelease[]>([]);
  const [releaseForm, setReleaseForm] = useState<ReleaseForm>(emptyReleaseForm);
  const [editingReleaseId, setEditingReleaseId] = useState("");
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");

  const selectedArtist = useMemo(
    () => artists.find((artist) => artist.id === selectedArtistId) ?? null,
    [artists, selectedArtistId]
  );

  const filteredArtists = useMemo(() => {
    const query = search.trim().toLowerCase();
    if (!query) return artists;

    return artists.filter((artist) =>
      [artist.name, artist.stage_name, artist.slug, artist.status]
        .filter(Boolean)
        .some((value) => String(value).toLowerCase().includes(query))
    );
  }, [artists, search]);

  const fetchArtists = useCallback(async () => {
    setLoading(true);

    const { data, error } = await supabase
      .from("artists")
      .select("id, name, slug, stage_name, status")
      .order("name", { ascending: true });

    if (error) {
      setStatus(`Error loading artists: ${error.message}`);
    } else {
      setArtists((data ?? []) as AdminArtist[]);
    }

    setLoading(false);
  }, [supabase]);

  const fetchArtistDiscography = useCallback(async (artistId: string) => {
    const response = await fetch(
      `/api/admin/artist-discography?artistId=${encodeURIComponent(artistId)}`
    );
    const result = (await response.json()) as ArtistDiscographyResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error loading artist discography: ${result.error || response.statusText}`);
      setDiscography([]);
      return;
    }

    setDiscography(result.releases ?? []);
  }, []);

  useEffect(() => {
    void fetchArtists();
  }, [fetchArtists]);

  function resetReleaseForm() {
    setReleaseForm({ ...emptyReleaseForm });
    setEditingReleaseId("");
  }

  function handleSelectArtist(id: string) {
    setSelectedArtistId(id);
    resetReleaseForm();
    setDiscography([]);
    setStatus("");

    if (id) {
      void fetchArtistDiscography(id);
    }
  }

  function updateReleaseForm<K extends keyof ReleaseForm>(
    key: K,
    value: ReleaseForm[K]
  ) {
    setReleaseForm((current) => {
      if (key === "date") {
        const releaseYear = yearFromDate(String(value));
        return {
          ...current,
          date: String(value),
          release_year: releaseYear || current.release_year,
          year: releaseYear || current.year,
        };
      }

      if (key === "release_year") {
        return {
          ...current,
          release_year: value,
          year: current.year || value,
        };
      }

      return {
        ...current,
        [key]: value,
      };
    });
  }

  function handleEditRelease(release: AdminDiscographyRelease) {
    setEditingReleaseId(release.id);
    setReleaseForm({
      title: release.title ?? "",
      type: release.type ?? "Album",
      release_year: release.release_year ? String(release.release_year) : "",
      year: release.year ? String(release.year) : "",
      date: release.date ?? "",
      status: release.status ?? "Official",
      label: release.label ?? "",
      country: release.country ?? "DO",
      barcode: release.barcode ?? "",
      catalog_number: release.catalog_number ?? "",
      disambiguation: release.disambiguation ?? "",
    });
  }

  async function handleSaveRelease() {
    if (!selectedArtistId) {
      setStatus("Select an artist before editing discography.");
      return;
    }

    if (!releaseForm.title.trim()) {
      setStatus("Release title is required.");
      return;
    }

    setLoading(true);
    setStatus("");

    const releaseYear = releaseForm.release_year
      ? Number(releaseForm.release_year)
      : null;
    const year = releaseForm.year ? Number(releaseForm.year) : releaseYear;
    const payload = {
      release_artist_id: selectedArtistId,
      title: releaseForm.title.trim(),
      type: nullable(releaseForm.type),
      release_year: releaseYear,
      year,
      date: nullable(releaseForm.date),
      status: nullable(releaseForm.status),
      label: nullable(releaseForm.label),
      country: nullable(releaseForm.country),
      barcode: nullable(releaseForm.barcode),
      catalog_number: nullable(releaseForm.catalog_number),
      disambiguation: nullable(releaseForm.disambiguation),
    };

    const response = await fetch("/api/admin/artist-discography", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        releaseId: editingReleaseId || null,
        releaseData: payload,
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error saving release: ${result.error || response.statusText}`);
    } else {
      setStatus(editingReleaseId ? "Release updated." : "Release added.");
      resetReleaseForm();
      await fetchArtistDiscography(selectedArtistId);
    }

    setLoading(false);
  }

  return (
    <main className="mx-auto max-w-6xl px-5 pb-10 pt-8 font-sans text-(--color-ink) sm:pt-10">
      <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <p className="text-xs font-medium uppercase tracking-[0.22em] text-(--color-wikicrimson)">
              Mangulina Admin
            </p>
            <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-(--color-flagblue) sm:text-4xl">
              Discography Manager
            </h1>
            <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
              Add and update releases attached to artist profiles.
            </p>
          </div>

          <Link
            href="/admin"
            className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-(--color-flagblue) shadow-sm transition hover:border-(--color-wikicrimson) hover:text-(--color-wikicrimson)"
          >
            Admin Portal
          </Link>
        </div>
      </header>

      {status && (
        <div className="mb-6 rounded-lg border border-gray-200 bg-white px-4 py-3 text-sm text-gray-700 shadow-sm">
          {status}
        </div>
      )}

      <div className="grid gap-8 lg:grid-cols-[320px_1fr]">
        <aside className="space-y-5">
          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Select Artist
            </h2>

            <input
              value={search}
              onChange={(event) => setSearch(event.target.value)}
              placeholder="Search artist..."
              className="mb-3 w-full rounded-lg border border-gray-200 px-3 py-2 text-sm outline-none focus:border-(--color-flagblue)"
            />

            <select
              value={selectedArtistId}
              onChange={(event) => handleSelectArtist(event.target.value)}
              className="w-full rounded-lg border border-gray-200 px-3 py-2 text-sm outline-none focus:border-(--color-flagblue)"
            >
              <option value="">-- Select Artist --</option>
              {filteredArtists.map((artist) => (
                <option key={artist.id} value={artist.id}>
                  {artist.name}
                  {artist.status && artist.status !== "published"
                    ? ` - ${artist.status}`
                    : ""}
                </option>
              ))}
            </select>

            {selectedArtist && (
              <div className="mt-4 rounded-lg border border-gray-100 bg-gray-50 px-4 py-3">
                <p className="text-sm font-semibold text-(--color-flagblue)">
                  {selectedArtist.name}
                </p>
                <p className="mt-1 text-xs text-gray-400">
                  {discography.length} releases loaded
                </p>
              </div>
            )}
          </section>

          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Releases
            </h2>

            {!selectedArtistId ? (
              <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-500">
                Select an artist to load releases.
              </p>
            ) : (
              <div className="max-h-[34rem] space-y-2 overflow-y-auto pr-1">
                {discography.length ? (
                  discography.map((release) => (
                    <button
                      key={release.id}
                      type="button"
                      onClick={() => handleEditRelease(release)}
                      className={`w-full rounded-lg border px-3 py-3 text-left transition ${
                        editingReleaseId === release.id
                          ? "border-(--color-flagblue) bg-(--color-flagblue)/5"
                          : "border-gray-200 bg-gray-50 hover:border-(--color-flagblue)"
                      }`}
                    >
                      <p className="line-clamp-2 text-sm font-semibold text-(--color-flagblue)">
                        {release.title}
                      </p>
                      <p className="mt-1 text-xs text-gray-400">
                        {release.release_year ?? release.year ?? "No year"} -{" "}
                        {release.type ?? "Album"} - {release.track_count} tracks
                      </p>
                    </button>
                  ))
                ) : (
                  <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-400">
                    No releases saved for this artist yet.
                  </p>
                )}
              </div>
            )}
          </section>
        </aside>

        <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
          <div className="mb-5 flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                {editingReleaseId ? "Edit Release" : "Add Release"}
              </h2>
              <p className="mt-1 text-xs text-gray-400">
                Release-level metadata. Track editing will be added as the next layer.
              </p>
            </div>

            {editingReleaseId && (
              <button
                type="button"
                onClick={resetReleaseForm}
                className="w-fit text-xs font-semibold text-(--color-wikicrimson)"
              >
                Cancel release edit
              </button>
            )}
          </div>

          {!selectedArtistId ? (
            <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-500">
              Select an artist before editing discography.
            </p>
          ) : (
            <>
              <div className="grid gap-4 md:grid-cols-2">
                <Field label="Release Title">
                  <input
                    value={releaseForm.title}
                    onChange={(event) => updateReleaseForm("title", event.target.value)}
                    className={inputClass}
                  />
                </Field>

                <Field label="Release Type">
                  <select
                    value={releaseForm.type}
                    onChange={(event) => updateReleaseForm("type", event.target.value)}
                    className={inputClass}
                  >
                    {releaseTypeOptions.map((option) => (
                      <option key={option.value} value={option.value}>
                        {option.label}
                      </option>
                    ))}
                  </select>
                </Field>

                <Field label="Release Date">
                  <input
                    type="date"
                    value={releaseForm.date}
                    onChange={(event) => updateReleaseForm("date", event.target.value)}
                    className={inputClass}
                  />
                </Field>

                <Field label="Release Year">
                  <input
                    type="number"
                    value={releaseForm.release_year}
                    onChange={(event) =>
                      updateReleaseForm("release_year", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Sort Year">
                  <input
                    type="number"
                    value={releaseForm.year}
                    onChange={(event) => updateReleaseForm("year", event.target.value)}
                    className={inputClass}
                  />
                </Field>

                <Field label="Release Status">
                  <select
                    value={releaseForm.status}
                    onChange={(event) => updateReleaseForm("status", event.target.value)}
                    className={inputClass}
                  >
                    {releaseStatusOptions.map((option) => (
                      <option key={option.value} value={option.value}>
                        {option.label}
                      </option>
                    ))}
                  </select>
                </Field>

                <Field label="Label">
                  <input
                    value={releaseForm.label}
                    onChange={(event) => updateReleaseForm("label", event.target.value)}
                    className={inputClass}
                  />
                </Field>

                <Field label="Country">
                  <input
                    value={releaseForm.country}
                    onChange={(event) => updateReleaseForm("country", event.target.value)}
                    placeholder="DO"
                    className={inputClass}
                  />
                </Field>

                <Field label="Catalog Number">
                  <input
                    value={releaseForm.catalog_number}
                    onChange={(event) =>
                      updateReleaseForm("catalog_number", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Barcode">
                  <input
                    value={releaseForm.barcode}
                    onChange={(event) => updateReleaseForm("barcode", event.target.value)}
                    className={inputClass}
                  />
                </Field>
              </div>

              <div className="mt-4">
                <Field label="Disambiguation">
                  <input
                    value={releaseForm.disambiguation}
                    onChange={(event) =>
                      updateReleaseForm("disambiguation", event.target.value)
                    }
                    placeholder="Remaster, live edition, alternate release..."
                    className={inputClass}
                  />
                </Field>
              </div>

              <button
                type="button"
                onClick={handleSaveRelease}
                disabled={Boolean(loading)}
                className="mt-5 w-full rounded-lg bg-(--color-flagblue) px-5 py-4 text-sm uppercase tracking-[0.18em] text-white transition disabled:cursor-not-allowed disabled:opacity-40"
              >
                {loading
                  ? "Processing..."
                  : editingReleaseId
                    ? "Update Release"
                    : "Add Release"}
              </button>
            </>
          )}
        </section>
      </div>
    </main>
  );
}

function Field({
  label,
  children,
}: {
  label: string;
  children: React.ReactNode;
}) {
  return (
    <div className="block">
      <span className="mb-1 block text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
        {label}
      </span>
      {children}
    </div>
  );
}

const inputClass =
  "w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm font-normal text-gray-800 outline-none transition focus:border-(--color-flagblue)";
