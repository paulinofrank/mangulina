"use client";

import Link from "next/link";
import { useCallback, useEffect, useMemo, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import {
  AdminField,
  AdminSearchPicker,
  AdminStatusMessage,
  adminButtonClass,
  adminInputClass,
  type PickerOption,
} from "@/components/admin/CatalogAdminControls";

type AdminRelease = {
  id: string;
  title: string;
  slug: string | null;
  type: string | null;
  release_year: number | null;
  year: number | null;
  date: string | null;
  release_artist_id: string | null;
  release_artist_name?: string | null;
  label: string | null;
  label_id: string | null;
  country: string | null;
  status: string | null;
  packaging: string | null;
  barcode: string | null;
  catalog_number: string | null;
  disambiguation: string | null;
  metadata: unknown;
  views: number | null;
  mbid: string | null;
  track_count?: number;
};

type AdminArtist = {
  id: string;
  name: string;
};

type AdminTrack = {
  id: string;
  release_id: string;
  recording_id: string;
  disc_number: number | null;
  track_number: number | null;
  position: number | null;
  title_override: string | null;
  length: number | null;
  metadata: unknown;
  recording_title?: string | null;
  recording_artist_name?: string | null;
};

type ReleaseForm = {
  title: string;
  slug: string;
  type: string;
  release_year: string;
  year: string;
  date: string;
  release_artist_id: string;
  release_artist_name: string;
  label: string;
  label_id: string;
  country: string;
  status: string;
  packaging: string;
  barcode: string;
  catalog_number: string;
  disambiguation: string;
  metadata: string;
  mbid: string;
};

type TrackForm = {
  recording_id: string;
  recording_title: string;
  disc_number: string;
  track_number: string;
  position: string;
  title_override: string;
  length: string;
  metadata: string;
};

const emptyReleaseForm: ReleaseForm = {
  title: "",
  slug: "",
  type: "album",
  release_year: "",
  year: "",
  date: "",
  release_artist_id: "",
  release_artist_name: "",
  label: "",
  label_id: "",
  country: "",
  status: "",
  packaging: "",
  barcode: "",
  catalog_number: "",
  disambiguation: "",
  metadata: "",
  mbid: "",
};

const emptyTrackForm: TrackForm = {
  recording_id: "",
  recording_title: "",
  disc_number: "1",
  track_number: "",
  position: "",
  title_override: "",
  length: "",
  metadata: "",
};

const releaseTypeOptions = ["album", "single", "ep", "compilation", "live", "other"];

function nullable(value: string) {
  const trimmed = value.trim();
  return trimmed ? trimmed : null;
}

function secondsFromDuration(value: string) {
  const trimmed = value.trim();
  if (!trimmed) return null;
  if (/^\d+$/.test(trimmed)) return Number(trimmed);
  const match = trimmed.match(/^(\d+):([0-5]\d)$/);
  return match ? Number(match[1]) * 60 + Number(match[2]) : Number.NaN;
}

function formatDuration(seconds: number | null | undefined) {
  if (seconds == null) return "-";
  const minutes = Math.floor(seconds / 60);
  const remaining = seconds % 60;
  return `${minutes}:${String(remaining).padStart(2, "0")}`;
}

function formatMetadata(value: unknown) {
  if (!value) return "";
  return JSON.stringify(value, null, 2);
}

export default function AdminCatalogReleasesPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const initialArtistId = searchParams.get("artistId") ?? "";
  const [selectedArtist, setSelectedArtist] = useState<AdminArtist | null>(null);
  const [artistReleases, setArtistReleases] = useState<AdminRelease[]>([]);
  const [searchAllReleases, setSearchAllReleases] = useState(false);
  const [searchAllTrackRecordings, setSearchAllTrackRecordings] = useState(false);
  const [selectedReleaseId, setSelectedReleaseId] = useState("");
  const [selectedRelease, setSelectedRelease] = useState<AdminRelease | null>(null);
  const [releaseForm, setReleaseForm] = useState<ReleaseForm>(emptyReleaseForm);
  const [tracks, setTracks] = useState<AdminTrack[]>([]);
  const [trackForm, setTrackForm] = useState<TrackForm>(emptyTrackForm);
  const [editingTrackId, setEditingTrackId] = useState("");
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");

  const selectedReleaseLabel = useMemo(
    () => selectedRelease?.title ?? releaseForm.title,
    [releaseForm.title, selectedRelease],
  );

  const scopedReleaseParams = !searchAllReleases && selectedArtist ? { artistId: selectedArtist.id } : undefined;
  const scopedTrackRecordingParams =
    !searchAllTrackRecordings && releaseForm.release_artist_id
      ? { artistId: releaseForm.release_artist_id }
      : undefined;

  function releaseFormForArtist(artist: AdminArtist | null): ReleaseForm {
    return {
      ...emptyReleaseForm,
      release_artist_id: artist?.id ?? "",
      release_artist_name: artist?.name ?? "",
    };
  }

  const loadArtistReleases = useCallback(async (artistId: string) => {
    const response = await fetch(`/api/admin/releases?artistId=${encodeURIComponent(artistId)}&limit=50`);
    const result = await response.json();
    if (!response.ok || !result.ok) {
      setStatus(`Error loading artist releases: ${result.error || response.statusText}`);
      setArtistReleases([]);
      return;
    }
    setArtistReleases(result.releases ?? []);
  }, []);

  const loadArtist = useCallback(async (artistId: string, options: { resetWorkflow?: boolean } = {}) => {
    const response = await fetch(`/api/admin/artists?id=${encodeURIComponent(artistId)}`);
    const result = await response.json();
    if (!response.ok || !result.ok || !result.artists?.[0]) {
      setStatus(`Error loading artist context: ${result.error || response.statusText}`);
      return;
    }
    const artist = result.artists[0] as AdminArtist;
    setSelectedArtist(artist);
    if (options.resetWorkflow) {
      setSelectedReleaseId("");
      setSelectedRelease(null);
      setTracks([]);
      resetTrackForm();
      setReleaseForm(releaseFormForArtist(artist));
    }
    await loadArtistReleases(artist.id);
  }, [loadArtistReleases]);

  useEffect(() => {
    if (initialArtistId) void loadArtist(initialArtistId, { resetWorkflow: true });
  }, [initialArtistId, loadArtist]);

  function selectPageArtist(option: PickerOption) {
    const artist = { id: option.id, name: option.name ?? "" };
    setSelectedArtist(artist);
    setArtistReleases([]);
    setSelectedReleaseId("");
    setSelectedRelease(null);
    setTracks([]);
    resetTrackForm();
    setReleaseForm(releaseFormForArtist(artist));
    router.replace(`/admin/catalog/releases?artistId=${encodeURIComponent(option.id)}`);
    void loadArtistReleases(option.id);
  }

  function clearPageArtist() {
    setSelectedArtist(null);
    setArtistReleases([]);
    setSelectedReleaseId("");
    setSelectedRelease(null);
    setTracks([]);
    resetTrackForm();
    setReleaseForm(releaseFormForArtist(null));
    router.replace("/admin/catalog/releases");
    setStatus("Global mode is active. Select an artist first, or use global mode intentionally.");
  }

  function updateReleaseForm<K extends keyof ReleaseForm>(key: K, value: ReleaseForm[K]) {
    setReleaseForm((current) => {
      if (key === "date") {
        const year = value.slice(0, 4);
        return {
          ...current,
          date: value,
          release_year: current.release_year || (/^\d{4}$/.test(year) ? year : ""),
        };
      }
      if (key === "release_year") {
        return { ...current, release_year: value, year: current.year || value };
      }
      return { ...current, [key]: value };
    });
  }

  function updateTrackForm<K extends keyof TrackForm>(key: K, value: TrackForm[K]) {
    setTrackForm((current) => ({ ...current, [key]: value }));
  }

  const loadTracks = useCallback(async (releaseId: string) => {
    const response = await fetch(`/api/admin/tracks?releaseId=${encodeURIComponent(releaseId)}`);
    const result = await response.json();
    if (!response.ok || !result.ok) {
      setStatus(`Error loading tracks: ${result.error || response.statusText}`);
      setTracks([]);
      return;
    }
    setTracks(result.tracks ?? []);
  }, []);

  async function loadRelease(releaseId: string) {
    const response = await fetch(`/api/admin/releases?id=${encodeURIComponent(releaseId)}`);
    const result = await response.json();
    if (!response.ok || !result.ok || !result.releases?.[0]) {
      setStatus(`Error loading release: ${result.error || response.statusText}`);
      return;
    }

    const release = result.releases[0] as AdminRelease;
    setSelectedReleaseId(release.id);
    setSelectedRelease(release);
    setReleaseForm({
      title: release.title ?? "",
      slug: release.slug ?? "",
      type: release.type ?? "",
      release_year: release.release_year ? String(release.release_year) : "",
      year: release.year ? String(release.year) : "",
      date: release.date ?? "",
      release_artist_id: release.release_artist_id ?? "",
      release_artist_name: release.release_artist_name ?? "",
      label: release.label ?? "",
      label_id: release.label_id ?? "",
      country: release.country ?? "",
      status: release.status ?? "",
      packaging: release.packaging ?? "",
      barcode: release.barcode ?? "",
      catalog_number: release.catalog_number ?? "",
      disambiguation: release.disambiguation ?? "",
      metadata: formatMetadata(release.metadata),
      mbid: release.mbid ?? "",
    });
    setStatus("");
    await loadTracks(release.id);
  }

  function resetRelease() {
    setSelectedReleaseId("");
    setSelectedRelease(null);
    setReleaseForm(releaseFormForArtist(selectedArtist));
    setTracks([]);
    resetTrackForm();
    setStatus("");
  }

  function handleCreateNewRelease() {
    if (!selectedArtist) {
      setStatus("Select an artist first, or use global mode intentionally.");
      return;
    }
    resetRelease();
  }

  function resetTrackForm() {
    setTrackForm({ ...emptyTrackForm });
    setEditingTrackId("");
  }

  async function saveRelease() {
    if (!releaseForm.title.trim()) {
      setStatus("Release title is required.");
      return;
    }

    if (!releaseForm.release_artist_id.trim()) {
      const confirmed = window.confirm(
        "This release has no release artist. Continue intentionally without an artist?",
      );
      if (!confirmed) return;
    }

    setLoading(true);
    setStatus("");

    const payload = {
      title: releaseForm.title,
      slug: nullable(releaseForm.slug),
      type: nullable(releaseForm.type),
      release_year: releaseForm.release_year ? Number(releaseForm.release_year) : null,
      year: releaseForm.year ? Number(releaseForm.year) : null,
      date: nullable(releaseForm.date),
      release_artist_id: nullable(releaseForm.release_artist_id),
      release_artist_name: nullable(releaseForm.release_artist_name),
      label: nullable(releaseForm.label),
      label_id: nullable(releaseForm.label_id),
      country: nullable(releaseForm.country),
      status: nullable(releaseForm.status),
      packaging: nullable(releaseForm.packaging),
      barcode: nullable(releaseForm.barcode),
      catalog_number: nullable(releaseForm.catalog_number),
      disambiguation: nullable(releaseForm.disambiguation),
      metadata: nullable(releaseForm.metadata),
      mbid: nullable(releaseForm.mbid),
    };

    const response = await fetch("/api/admin/releases", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ releaseId: selectedReleaseId || null, releaseData: payload }),
    });
    const result = await response.json();

    if (!response.ok || !result.ok) {
      setStatus(`Error saving release: ${result.error || response.statusText}`);
    } else {
      setStatus(selectedReleaseId ? "Release updated." : "Release created.");
      await loadRelease(result.id);
      if (selectedArtist) await loadArtistReleases(selectedArtist.id);
    }

    setLoading(false);
  }

  async function saveTrack() {
    if (!selectedReleaseId || !trackForm.recording_id) {
      setStatus("Choose a release and recording before saving a track.");
      return;
    }

    const length = secondsFromDuration(trackForm.length);
    if (Number.isNaN(length)) {
      setStatus("Track length must be seconds or mm:ss.");
      return;
    }

    setLoading(true);
    setStatus("");

    const response = await fetch("/api/admin/tracks", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        trackId: editingTrackId || null,
        trackData: {
          release_id: selectedReleaseId,
          recording_id: trackForm.recording_id,
          disc_number: trackForm.disc_number ? Number(trackForm.disc_number) : 1,
          track_number: trackForm.track_number ? Number(trackForm.track_number) : null,
          position: trackForm.position ? Number(trackForm.position) : null,
          title_override: nullable(trackForm.title_override),
          length,
          metadata: nullable(trackForm.metadata),
        },
      }),
    });
    const result = await response.json();

    if (!response.ok || !result.ok) {
      setStatus(`Error saving track: ${result.error || response.statusText}`);
    } else {
      setStatus(editingTrackId ? "Track updated." : "Track added.");
      resetTrackForm();
      await loadTracks(selectedReleaseId);
    }

    setLoading(false);
  }

  async function deleteTrack(track: AdminTrack) {
    if (!window.confirm(`Remove this track row?\n\n${track.recording_title ?? track.recording_id}`)) return;

    const response = await fetch("/api/admin/tracks", {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ trackId: track.id }),
    });
    const result = await response.json();

    if (!response.ok || !result.ok) {
      setStatus(`Error removing track: ${result.error || response.statusText}`);
    } else {
      setStatus("Track row removed. Recording was not deleted.");
      await loadTracks(selectedReleaseId);
    }
  }

  async function deleteRelease() {
    if (!selectedReleaseId || !selectedRelease) return;
    if (!window.confirm(`Delete this release?\n\n${selectedRelease.title}`)) return;

    setLoading(true);
    const response = await fetch("/api/admin/releases", {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ releaseId: selectedReleaseId }),
    });
    const result = await response.json();

    if (!response.ok || !result.ok) {
      setStatus(`Delete blocked: ${result.error || response.statusText}`);
    } else {
      resetRelease();
      setStatus("Release deleted.");
    }
    setLoading(false);
  }

  function editTrack(track: AdminTrack) {
    setEditingTrackId(track.id);
    setTrackForm({
      recording_id: track.recording_id,
      recording_title: track.recording_title ?? "",
      disc_number: String(track.disc_number ?? 1),
      track_number: track.track_number ? String(track.track_number) : "",
      position: track.position ? String(track.position) : "",
      title_override: track.title_override ?? "",
      length: track.length ? formatDuration(track.length) : "",
      metadata: formatMetadata(track.metadata),
    });
  }

  return (
    <main className="mx-auto max-w-6xl px-5 pb-10 pt-8 font-sans text-(--color-ink) sm:pt-10">
      <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <p className="text-xs font-medium uppercase tracking-[0.22em] text-(--color-wikicrimson)">
              Catalog Admin
            </p>
            <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-(--color-flagblue) sm:text-4xl">
              Releases / Albums
            </h1>
          </div>
          <Link href="/admin/catalog" className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-(--color-flagblue) shadow-sm transition hover:border-(--color-wikicrimson) hover:text-(--color-wikicrimson)">
            Catalog
          </Link>
        </div>
      </header>

      <AdminStatusMessage message={status} />

      <div className="grid gap-8 lg:grid-cols-[320px_1fr]">
        <aside className="space-y-5">
          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <p className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Page Artist
            </p>
            <AdminSearchPicker
              label="Artist Selector"
              value={selectedArtist?.id ?? ""}
              displayValue={selectedArtist?.name ?? ""}
              placeholder="Search artist..."
              endpoint="/api/admin/artists"
              resultKey="artists"
              onSelect={selectPageArtist}
              onClear={clearPageArtist}
            />
            {selectedArtist ? (
              <>
              <h2 className="mt-2 text-lg font-semibold text-(--color-flagblue)">
                {selectedArtist.name}
              </h2>
              <Link
                href={`/admin/catalog/recordings?artistId=${encodeURIComponent(selectedArtist.id)}`}
                className="mt-3 inline-flex text-sm font-medium text-(--color-flagblue)"
              >
                Manage this artist's recordings
              </Link>
              </>
            ) : (
              <p className="mt-3 text-sm text-gray-500">
                Select an artist to scope release lists and new-release defaults.
              </p>
            )}
          </section>

          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Search / Select Release
            </h2>
            {selectedArtist && (
              <label className="mb-3 flex items-center gap-2 text-sm text-gray-600">
                <input
                  type="checkbox"
                  checked={searchAllReleases}
                  onChange={(event) => setSearchAllReleases(event.target.checked)}
                  className="h-4 w-4"
                />
                Search all releases
              </label>
            )}
            <AdminSearchPicker
              label="Release"
              value={selectedReleaseId}
              displayValue={selectedReleaseLabel}
              placeholder={
                selectedArtist && !searchAllReleases
                  ? `Search ${selectedArtist.name} releases...`
                  : "Search all releases..."
              }
              endpoint="/api/admin/releases"
              extraParams={scopedReleaseParams}
              resultKey="releases"
              onSelect={(option) => void loadRelease(option.id)}
              onClear={resetRelease}
            />
            <button type="button" onClick={handleCreateNewRelease} className="mt-4 w-full rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs uppercase tracking-[0.18em] text-(--color-flagblue)">
              {selectedArtist ? `Create New Release for ${selectedArtist.name}` : "Create New Release"}
            </button>
          </section>

          {selectedArtist && (
            <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
              <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                Artist Releases
              </h2>
              <div className="max-h-96 space-y-2 overflow-y-auto pr-1">
                {artistReleases.length ? (
                  artistReleases.map((release) => (
                    <button
                      key={release.id}
                      type="button"
                      onClick={() => void loadRelease(release.id)}
                      className={`w-full rounded-lg border px-3 py-3 text-left transition ${
                        selectedReleaseId === release.id
                          ? "border-(--color-flagblue) bg-(--color-flagblue)/5"
                          : "border-gray-200 bg-gray-50 hover:border-(--color-flagblue)"
                      }`}
                    >
                      <p className="line-clamp-2 text-sm font-semibold text-(--color-flagblue)">
                        {release.title}
                      </p>
                      <p className="mt-1 text-xs text-gray-500">
                        {[
                          release.release_artist_name,
                          release.release_year ?? release.year,
                          release.type,
                          release.catalog_number || release.barcode,
                        ]
                          .filter(Boolean)
                          .join(" · ")}
                      </p>
                    </button>
                  ))
                ) : (
                  <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-400">
                    No releases found for this artist yet.
                  </p>
                )}
              </div>
            </section>
          )}

          {selectedRelease && (
            <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
              <p className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                Selected Release
              </p>
              <h2 className="mt-2 text-lg font-semibold text-(--color-flagblue)">{selectedRelease.title}</h2>
              <p className="mt-2 text-sm text-gray-500">
                {selectedRelease.release_artist_name || "Unknown artist"} · {selectedRelease.release_year ?? selectedRelease.year ?? "No year"}
              </p>
              <p className="mt-2 text-xs text-gray-400">
                Views: {selectedRelease.views ?? 0} · Tracks: {tracks.length}
              </p>
            </section>
          )}
        </aside>

        <div className="space-y-6">
          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <div className="mb-5 flex items-center justify-between gap-3">
              <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                Release Form
              </h2>
              <p className="text-xs text-gray-400">Views: {selectedRelease?.views ?? "read-only"}</p>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <AdminField label="Title">
                <input value={releaseForm.title} onChange={(event) => updateReleaseForm("title", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Slug">
                <input value={releaseForm.slug} onChange={(event) => updateReleaseForm("slug", event.target.value)} placeholder="Auto-created if empty" className={adminInputClass} />
              </AdminField>
              <AdminField label="Type">
                <select value={releaseForm.type} onChange={(event) => updateReleaseForm("type", event.target.value)} className={adminInputClass}>
                  <option value="">-- Preserve / Select Type --</option>
                  {releaseTypeOptions.map((type) => <option key={type} value={type}>{type}</option>)}
                </select>
              </AdminField>
              <AdminSearchPicker
                label="Release Artist"
                value={releaseForm.release_artist_id}
                displayValue={releaseForm.release_artist_name}
                placeholder="Search artist..."
                endpoint="/api/admin/artists"
                resultKey="artists"
                onSelect={(option: PickerOption) => {
                  updateReleaseForm("release_artist_id", option.id);
                  updateReleaseForm("release_artist_name", option.name ?? "");
                }}
                onClear={() => {
                  updateReleaseForm("release_artist_id", "");
                  updateReleaseForm("release_artist_name", "");
                }}
              />
              <AdminField label="Release Year">
                <input type="number" value={releaseForm.release_year} onChange={(event) => updateReleaseForm("release_year", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Year">
                <input type="number" value={releaseForm.year} onChange={(event) => updateReleaseForm("year", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Date">
                <input type="date" value={releaseForm.date} onChange={(event) => updateReleaseForm("date", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Label">
                <input value={releaseForm.label} onChange={(event) => updateReleaseForm("label", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Country">
                <input value={releaseForm.country} onChange={(event) => updateReleaseForm("country", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Status">
                <input value={releaseForm.status} onChange={(event) => updateReleaseForm("status", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Packaging">
                <input value={releaseForm.packaging} onChange={(event) => updateReleaseForm("packaging", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Barcode">
                <input value={releaseForm.barcode} onChange={(event) => updateReleaseForm("barcode", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Catalog Number">
                <input value={releaseForm.catalog_number} onChange={(event) => updateReleaseForm("catalog_number", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="MBID">
                <input value={releaseForm.mbid} onChange={(event) => updateReleaseForm("mbid", event.target.value)} className={adminInputClass} />
              </AdminField>
            </div>

            <div className="mt-4 space-y-4">
              <AdminField label="Disambiguation">
                <input value={releaseForm.disambiguation} onChange={(event) => updateReleaseForm("disambiguation", event.target.value)} className={adminInputClass} />
              </AdminField>
              <AdminField label="Metadata JSON">
                <textarea value={releaseForm.metadata} onChange={(event) => updateReleaseForm("metadata", event.target.value)} className={`${adminInputClass} min-h-28 font-mono`} />
              </AdminField>
            </div>

            <button type="button" onClick={saveRelease} disabled={loading} className={`mt-5 w-full ${adminButtonClass}`}>
              {selectedReleaseId ? "Update Release" : "Create Release"}
            </button>
          </section>

          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Tracklist Manager
            </h2>
            {!selectedReleaseId ? (
              <p className="mt-4 rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-500">
                Save or select a release before editing tracks.
              </p>
            ) : (
              <div className="mt-4 space-y-5">
                <div className="overflow-x-auto rounded-lg border border-gray-100">
                  <table className="min-w-full divide-y divide-gray-100 text-sm">
                    <thead className="bg-gray-50 text-left text-[10px] uppercase tracking-[0.16em] text-gray-400">
                      <tr>
                        <th className="px-3 py-2">Disc</th>
                        <th className="px-3 py-2">Track</th>
                        <th className="px-3 py-2">Position</th>
                        <th className="px-3 py-2">Recording</th>
                        <th className="px-3 py-2">Override</th>
                        <th className="px-3 py-2">Length</th>
                        <th className="px-3 py-2 text-right">Actions</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-100">
                      {tracks.length ? tracks.map((track) => (
                        <tr key={track.id}>
                          <td className="px-3 py-3">{track.disc_number ?? 1}</td>
                          <td className="px-3 py-3">{track.track_number ?? "-"}</td>
                          <td className="px-3 py-3">{track.position ?? "-"}</td>
                          <td className="px-3 py-3">
                            <p className="font-medium text-(--color-flagblue)">{track.recording_title ?? "Unknown recording"}</p>
                            <p className="text-xs text-gray-400">{track.recording_artist_name ?? ""}</p>
                          </td>
                          <td className="px-3 py-3 text-gray-500">{track.title_override || "-"}</td>
                          <td className="px-3 py-3 text-gray-500">{formatDuration(track.length)}</td>
                          <td className="px-3 py-3">
                            <div className="flex justify-end gap-2">
                              <button type="button" onClick={() => editTrack(track)} className="rounded-md border border-gray-200 px-3 py-1.5 text-xs text-(--color-flagblue)">Edit</button>
                              <button type="button" onClick={() => void deleteTrack(track)} className="rounded-md border border-red-100 px-3 py-1.5 text-xs text-(--color-wikicrimson)">Remove</button>
                            </div>
                          </td>
                        </tr>
                      )) : (
                        <tr><td colSpan={7} className="px-3 py-4 text-gray-400">No tracks saved for this release.</td></tr>
                      )}
                    </tbody>
                  </table>
                </div>

                <div className="rounded-lg border border-gray-100 bg-gray-50 p-4">
                  <div className="mb-4 flex items-center justify-between gap-3">
                    <p className="text-[10px] uppercase tracking-[0.18em] text-gray-400">{editingTrackId ? "Edit Track" : "Add Track"}</p>
                    {editingTrackId && <button type="button" onClick={resetTrackForm} className="text-xs font-semibold text-(--color-wikicrimson)">Cancel</button>}
                  </div>
                  <div className="grid gap-4 md:grid-cols-2">
                    <AdminSearchPicker
                      label="Recording"
                      value={trackForm.recording_id}
                      displayValue={trackForm.recording_title}
                      placeholder={
                        releaseForm.release_artist_name && !searchAllTrackRecordings
                          ? `Search ${releaseForm.release_artist_name} recordings...`
                          : "Search all recordings..."
                      }
                      endpoint="/api/admin/recordings"
                      extraParams={scopedTrackRecordingParams}
                      resultKey="recordings"
                      onSelect={(option) => {
                        updateTrackForm("recording_id", option.id);
                        updateTrackForm("recording_title", option.title ?? "");
                      }}
                      onClear={() => {
                        updateTrackForm("recording_id", "");
                        updateTrackForm("recording_title", "");
                      }}
                    />
                    <label className="flex items-center gap-2 self-end text-sm text-gray-600">
                      <input
                        type="checkbox"
                        checked={searchAllTrackRecordings}
                        onChange={(event) => setSearchAllTrackRecordings(event.target.checked)}
                        className="h-4 w-4"
                      />
                      Search all recordings
                    </label>
                    <AdminField label="Disc Number"><input type="number" min={1} value={trackForm.disc_number} onChange={(event) => updateTrackForm("disc_number", event.target.value)} className={adminInputClass} /></AdminField>
                    <AdminField label="Track Number"><input type="number" value={trackForm.track_number} onChange={(event) => updateTrackForm("track_number", event.target.value)} className={adminInputClass} /></AdminField>
                    <AdminField label="Position"><input type="number" value={trackForm.position} onChange={(event) => updateTrackForm("position", event.target.value)} className={adminInputClass} /></AdminField>
                    <AdminField label="Title Override"><input value={trackForm.title_override} onChange={(event) => updateTrackForm("title_override", event.target.value)} className={adminInputClass} /></AdminField>
                    <AdminField label="Length"><input value={trackForm.length} onChange={(event) => updateTrackForm("length", event.target.value)} placeholder="215 or 3:35" className={adminInputClass} /></AdminField>
                  </div>
                  <div className="mt-4">
                    <AdminField label="Metadata JSON"><textarea value={trackForm.metadata} onChange={(event) => updateTrackForm("metadata", event.target.value)} className={`${adminInputClass} min-h-20 font-mono`} /></AdminField>
                  </div>
                  <button type="button" onClick={saveTrack} disabled={loading} className={`mt-4 w-full ${adminButtonClass}`}>
                    {editingTrackId ? "Update Track" : "Add Track"}
                  </button>
                </div>
              </div>
            )}
          </section>

          {selectedReleaseId && selectedRelease && (
            <section className="rounded-xl border border-red-100 bg-red-50/70 p-5">
              <p className="text-[10px] uppercase tracking-[0.18em] text-red-700">Danger Zone</p>
              <p className="mt-2 text-sm text-red-900">
                Deletion is blocked if tracks, recordings, credits, or analytics reference this release.
              </p>
              <button type="button" onClick={deleteRelease} disabled={loading} className="mt-4 w-full rounded-lg border border-red-300 bg-white px-5 py-3 text-sm uppercase tracking-[0.18em] text-red-700 transition hover:bg-red-700 hover:text-white disabled:opacity-40">
                Delete Release
              </button>
            </section>
          )}
        </div>
      </div>
    </main>
  );
}
