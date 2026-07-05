"use client";

import Link from "next/link";
import { useCallback, useEffect, useMemo, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import {
  AdminField,
  AdminGenrePicker,
  AdminSearchPicker,
  AdminStatusMessage,
  adminButtonClass,
  adminInputClass,
  type PickerOption,
} from "@/components/admin/CatalogAdminControls";

type AdminRecording = {
  id: string;
  title: string;
  slug: string | null;
  artist_id: string | null;
  artist_name?: string | null;
  release_id: string | null;
  release_title?: string | null;
  recording_year: number | null;
  youtube_id: string | null;
  duration: number | null;
  recording_context: string | null;
  genre_id: number | null;
  subgenre_id: number | null;
  isrcs: string[] | null;
  disambiguation: string | null;
  metadata: unknown;
  views: number | null;
  mbid: string | null;
  work_id: string | null;
  ai_confidence: number | null;
  ai_reason: string | null;
  classified_at: string | null;
};

type AdminArtist = {
  id: string;
  name: string;
};

type PlatformLink = {
  id: string;
  platform: string | null;
  label: string | null;
  url: string | null;
  status: string | null;
  confidence: number | null;
  source: string | null;
  checked_at: string | null;
};

type TrackUsage = {
  id: string;
  release_id: string | null;
  release_title?: string | null;
  disc_number: number | null;
  track_number: number | null;
  position: number | null;
};

type RecordingForm = {
  title: string;
  slug: string;
  artist_id: string;
  artist_name: string;
  release_id: string;
  release_title: string;
  recording_year: string;
  youtube_id: string;
  duration: string;
  recording_context: string;
  genre_id: string;
  subgenre_id: string;
  isrcs: string;
  disambiguation: string;
  metadata: string;
  mbid: string;
  work_id: string;
};

const emptyForm: RecordingForm = {
  title: "",
  slug: "",
  artist_id: "",
  artist_name: "",
  release_id: "",
  release_title: "",
  recording_year: "",
  youtube_id: "",
  duration: "",
  recording_context: "secular",
  genre_id: "",
  subgenre_id: "",
  isrcs: "",
  disambiguation: "",
  metadata: "",
  mbid: "",
  work_id: "",
};

const contextOptions = ["secular", "christian", "soundtrack", "children", "patriotic"];

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
  if (seconds == null) return "";
  const minutes = Math.floor(seconds / 60);
  const remaining = seconds % 60;
  return `${minutes}:${String(remaining).padStart(2, "0")}`;
}

function formatMetadata(value: unknown) {
  if (!value) return "";
  return JSON.stringify(value, null, 2);
}

function parseIsrcs(value: string) {
  return value
    .split(",")
    .map((item) => item.trim().toUpperCase())
    .filter(Boolean);
}

export default function AdminCatalogRecordingsPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const initialArtistId = searchParams.get("artistId") ?? "";
  const [selectedArtist, setSelectedArtist] = useState<AdminArtist | null>(null);
  const [artistRecordings, setArtistRecordings] = useState<AdminRecording[]>([]);
  const [searchAllRecordings, setSearchAllRecordings] = useState(false);
  const [selectedRecordingId, setSelectedRecordingId] = useState("");
  const [selectedRecording, setSelectedRecording] = useState<AdminRecording | null>(null);
  const [form, setForm] = useState<RecordingForm>(emptyForm);
  const [platformLinks, setPlatformLinks] = useState<PlatformLink[]>([]);
  const [trackUsage, setTrackUsage] = useState<TrackUsage[]>([]);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");

  const selectedRecordingLabel = useMemo(
    () => selectedRecording?.title ?? form.title,
    [form.title, selectedRecording],
  );

  const scopedRecordingParams = !searchAllRecordings && selectedArtist ? { artistId: selectedArtist.id } : undefined;

  function recordingFormForArtist(artist: AdminArtist | null): RecordingForm {
    return {
      ...emptyForm,
      artist_id: artist?.id ?? "",
      artist_name: artist?.name ?? "",
    };
  }

  const loadArtistRecordings = useCallback(async (artistId: string) => {
    const response = await fetch(`/api/admin/recordings?artistId=${encodeURIComponent(artistId)}&limit=50`);
    const result = await response.json();
    if (!response.ok || !result.ok) {
      setStatus(`Error loading artist recordings: ${result.error || response.statusText}`);
      setArtistRecordings([]);
      return;
    }
    setArtistRecordings(result.recordings ?? []);
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
      setSelectedRecordingId("");
      setSelectedRecording(null);
      setPlatformLinks([]);
      setTrackUsage([]);
      setForm(recordingFormForArtist(artist));
    }
    await loadArtistRecordings(artist.id);
  }, [loadArtistRecordings]);

  useEffect(() => {
    if (initialArtistId) void loadArtist(initialArtistId, { resetWorkflow: true });
  }, [initialArtistId, loadArtist]);

  function selectPageArtist(option: PickerOption) {
    const artist = { id: option.id, name: option.name ?? "" };
    setSelectedArtist(artist);
    setArtistRecordings([]);
    setSelectedRecordingId("");
    setSelectedRecording(null);
    setPlatformLinks([]);
    setTrackUsage([]);
    setForm(recordingFormForArtist(artist));
    router.replace(`/admin/catalog/recordings?artistId=${encodeURIComponent(option.id)}`);
    void loadArtistRecordings(option.id);
  }

  function clearPageArtist() {
    setSelectedArtist(null);
    setArtistRecordings([]);
    setSelectedRecordingId("");
    setSelectedRecording(null);
    setPlatformLinks([]);
    setTrackUsage([]);
    setForm(recordingFormForArtist(null));
    router.replace("/admin/catalog/recordings");
    setStatus("Global mode is active. Select an artist first, or use global mode intentionally.");
  }

  function updateForm<K extends keyof RecordingForm>(key: K, value: RecordingForm[K]) {
    setForm((current) => ({ ...current, [key]: value }));
  }

  async function loadRecording(recordingId: string) {
    const response = await fetch(`/api/admin/recordings?id=${encodeURIComponent(recordingId)}`);
    const result = await response.json();
    if (!response.ok || !result.ok || !result.recordings?.[0]) {
      setStatus(`Error loading recording: ${result.error || response.statusText}`);
      return;
    }

    const recording = result.recordings[0] as AdminRecording;
    setSelectedRecordingId(recording.id);
    setSelectedRecording(recording);
    setForm({
      title: recording.title ?? "",
      slug: recording.slug ?? "",
      artist_id: recording.artist_id ?? "",
      artist_name: recording.artist_name ?? "",
      release_id: recording.release_id ?? "",
      release_title: recording.release_title ?? "",
      recording_year: recording.recording_year ? String(recording.recording_year) : "",
      youtube_id: recording.youtube_id ?? "",
      duration: formatDuration(recording.duration),
      recording_context: recording.recording_context ?? "secular",
      genre_id: recording.genre_id ? String(recording.genre_id) : "",
      subgenre_id: recording.subgenre_id ? String(recording.subgenre_id) : "",
      isrcs: (recording.isrcs ?? []).join(", "),
      disambiguation: recording.disambiguation ?? "",
      metadata: formatMetadata(recording.metadata),
      mbid: recording.mbid ?? "",
      work_id: recording.work_id ?? "",
    });
    setPlatformLinks(result.platform_links ?? []);
    setTrackUsage(result.track_usage ?? []);
    setStatus("");
  }

  function resetRecording() {
    setSelectedRecordingId("");
    setSelectedRecording(null);
    setForm(recordingFormForArtist(selectedArtist));
    setPlatformLinks([]);
    setTrackUsage([]);
    setStatus("");
  }

  function handleCreateNewRecording() {
    if (!selectedArtist) {
      setStatus("Select an artist first, or use global mode intentionally.");
      return;
    }
    resetRecording();
  }

  async function saveRecording() {
    if (!form.title.trim()) {
      setStatus("Recording title is required.");
      return;
    }

    if (!form.artist_id.trim()) {
      const confirmed = window.confirm(
        "This recording has no artist. Continue intentionally without an artist?",
      );
      if (!confirmed) return;
    }

    const duration = secondsFromDuration(form.duration);
    if (Number.isNaN(duration)) {
      setStatus("Duration must be seconds or mm:ss.");
      return;
    }

    setLoading(true);
    setStatus("");

    const response = await fetch("/api/admin/recordings", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        recordingId: selectedRecordingId || null,
        recordingData: {
          title: form.title,
          slug: nullable(form.slug),
          artist_id: nullable(form.artist_id),
          artist_name: nullable(form.artist_name),
          release_id: nullable(form.release_id),
          release_title: nullable(form.release_title),
          recording_year: form.recording_year ? Number(form.recording_year) : null,
          youtube_id: nullable(form.youtube_id),
          duration,
          recording_context: nullable(form.recording_context),
          genre_id: form.genre_id ? Number(form.genre_id) : null,
          subgenre_id: form.subgenre_id ? Number(form.subgenre_id) : null,
          isrcs: parseIsrcs(form.isrcs),
          disambiguation: nullable(form.disambiguation),
          metadata: nullable(form.metadata),
          mbid: nullable(form.mbid),
          work_id: nullable(form.work_id),
        },
      }),
    });
    const result = await response.json();

    if (!response.ok || !result.ok) {
      setStatus(`Error saving recording: ${result.error || response.statusText}`);
    } else {
      setStatus(selectedRecordingId ? "Recording updated." : "Recording created.");
      await loadRecording(result.id);
      if (selectedArtist) await loadArtistRecordings(selectedArtist.id);
    }

    setLoading(false);
  }

  async function deleteRecording() {
    if (!selectedRecordingId || !selectedRecording) return;
    if (!window.confirm(`Delete this recording?\n\n${selectedRecording.title}`)) return;

    setLoading(true);
    const response = await fetch("/api/admin/recordings", {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ recordingId: selectedRecordingId }),
    });
    const result = await response.json();

    if (!response.ok || !result.ok) {
      setStatus(`Delete blocked: ${result.error || response.statusText}`);
    } else {
      resetRecording();
      setStatus("Recording deleted.");
    }
    setLoading(false);
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
              Recordings / Songs
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
                href={`/admin/catalog/releases?artistId=${encodeURIComponent(selectedArtist.id)}`}
                className="mt-3 inline-flex text-sm font-medium text-(--color-flagblue)"
              >
                Manage this artist's releases
              </Link>
              </>
            ) : (
              <p className="mt-3 text-sm text-gray-500">
                Select an artist to scope recording lists and new-recording defaults.
              </p>
            )}
          </section>

          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Search / Select Recording
            </h2>
            {selectedArtist && (
              <label className="mb-3 flex items-center gap-2 text-sm text-gray-600">
                <input
                  type="checkbox"
                  checked={searchAllRecordings}
                  onChange={(event) => setSearchAllRecordings(event.target.checked)}
                  className="h-4 w-4"
                />
                Search all recordings
              </label>
            )}
            <AdminSearchPicker
              label="Recording"
              value={selectedRecordingId}
              displayValue={selectedRecordingLabel}
              placeholder={
                selectedArtist && !searchAllRecordings
                  ? `Search ${selectedArtist.name} recordings...`
                  : "Search all recordings..."
              }
              endpoint="/api/admin/recordings"
              extraParams={scopedRecordingParams}
              resultKey="recordings"
              onSelect={(option) => void loadRecording(option.id)}
              onClear={resetRecording}
            />
            <button type="button" onClick={handleCreateNewRecording} className="mt-4 w-full rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs uppercase tracking-[0.18em] text-(--color-flagblue)">
              {selectedArtist ? `Create New Recording for ${selectedArtist.name}` : "Create New Recording"}
            </button>
          </section>

          {selectedArtist && (
            <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
              <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                Artist Recordings
              </h2>
              <div className="max-h-96 space-y-2 overflow-y-auto pr-1">
                {artistRecordings.length ? (
                  artistRecordings.map((recording) => (
                    <button
                      key={recording.id}
                      type="button"
                      onClick={() => void loadRecording(recording.id)}
                      className={`w-full rounded-lg border px-3 py-3 text-left transition ${
                        selectedRecordingId === recording.id
                          ? "border-(--color-flagblue) bg-(--color-flagblue)/5"
                          : "border-gray-200 bg-gray-50 hover:border-(--color-flagblue)"
                      }`}
                    >
                      <p className="line-clamp-2 text-sm font-semibold text-(--color-flagblue)">
                        {recording.title}
                      </p>
                      <p className="mt-1 text-xs text-gray-500">
                        {[
                          recording.artist_name,
                          recording.recording_year,
                          recording.release_title,
                          recording.youtube_id,
                        ]
                          .filter(Boolean)
                          .join(" · ")}
                      </p>
                    </button>
                  ))
                ) : (
                  <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-400">
                    No recordings found for this artist yet.
                  </p>
                )}
              </div>
            </section>
          )}

          {selectedRecording && (
            <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
              <p className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                Selected Recording
              </p>
              <h2 className="mt-2 text-lg font-semibold text-(--color-flagblue)">{selectedRecording.title}</h2>
              <p className="mt-2 text-sm text-gray-500">
                {selectedRecording.artist_name || "Unknown artist"} · {selectedRecording.recording_year ?? "No year"}
              </p>
              <p className="mt-2 text-xs text-gray-400">
                Views: {selectedRecording.views ?? 0} · Track rows: {trackUsage.length}
              </p>
            </section>
          )}
        </aside>

        <div className="space-y-6">
          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <div className="mb-5 flex items-center justify-between gap-3">
              <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                Recording Form
              </h2>
              <p className="text-xs text-gray-400">Views: {selectedRecording?.views ?? "read-only"}</p>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <AdminField label="Title"><input value={form.title} onChange={(event) => updateForm("title", event.target.value)} className={adminInputClass} /></AdminField>
              <AdminField label="Slug"><input value={form.slug} onChange={(event) => updateForm("slug", event.target.value)} placeholder="Auto-created if empty" className={adminInputClass} /></AdminField>
              <div>
                <AdminSearchPicker
                  label="Primary Performer"
                  value={form.artist_id}
                  displayValue={form.artist_name}
                  placeholder="Search artist..."
                  endpoint="/api/admin/artists"
                  resultKey="artists"
                  onSelect={(option: PickerOption) => {
                    updateForm("artist_id", option.id);
                    updateForm("artist_name", option.name ?? "");
                  }}
                  onClear={() => {
                    updateForm("artist_id", "");
                    updateForm("artist_name", "");
                  }}
                />
                <p className="mt-1 text-xs text-gray-500">
                  This artist is saved as the legacy recording artist and as the primary performer in recording_credits.
                </p>
              </div>
              <AdminSearchPicker
                label="Release"
                value={form.release_id}
                displayValue={form.release_title}
                placeholder="Search release..."
                endpoint="/api/admin/releases"
                resultKey="releases"
                onSelect={(option: PickerOption) => {
                  updateForm("release_id", option.id);
                  updateForm("release_title", option.title ?? "");
                }}
                onClear={() => {
                  updateForm("release_id", "");
                  updateForm("release_title", "");
                }}
              />
              <AdminField label="Recording Year"><input type="number" value={form.recording_year} onChange={(event) => updateForm("recording_year", event.target.value)} className={adminInputClass} /></AdminField>
              <AdminField label="YouTube ID / URL"><input value={form.youtube_id} onChange={(event) => updateForm("youtube_id", event.target.value)} className={adminInputClass} /></AdminField>
              <AdminField label="Duration"><input value={form.duration} onChange={(event) => updateForm("duration", event.target.value)} placeholder="215 or 3:35" className={adminInputClass} /></AdminField>
              <AdminField label="Recording Context">
                <select value={form.recording_context} onChange={(event) => updateForm("recording_context", event.target.value)} className={adminInputClass}>
                  {contextOptions.map((context) => <option key={context} value={context}>{context}</option>)}
                </select>
              </AdminField>
            </div>

            <div className="mt-4">
              <AdminGenrePicker
                genreId={form.genre_id}
                subgenreId={form.subgenre_id}
                onGenreChange={(value) => updateForm("genre_id", value)}
                onSubgenreChange={(value) => updateForm("subgenre_id", value)}
              />
            </div>

            <div className="mt-4 grid gap-4 md:grid-cols-2">
              <AdminField label="ISRCs"><input value={form.isrcs} onChange={(event) => updateForm("isrcs", event.target.value)} placeholder="USRC17607839, ..." className={adminInputClass} /></AdminField>
              <AdminField label="Disambiguation"><input value={form.disambiguation} onChange={(event) => updateForm("disambiguation", event.target.value)} className={adminInputClass} /></AdminField>
              <AdminField label="Recording ID"><input value={selectedRecording?.id ?? ""} readOnly className={`${adminInputClass} bg-gray-50 cursor-not-allowed`} /></AdminField>
              <AdminField label="Work ID"><input value={form.work_id} onChange={(event) => updateForm("work_id", event.target.value)} className={adminInputClass} /></AdminField>
            </div>

            <div className="mt-4">
              <AdminField label="Metadata JSON">
                <textarea value={form.metadata} onChange={(event) => updateForm("metadata", event.target.value)} className={`${adminInputClass} min-h-28 font-mono`} />
              </AdminField>
            </div>

            {(selectedRecording?.ai_confidence != null || selectedRecording?.ai_reason || selectedRecording?.classified_at) && (
              <div className="mt-4 rounded-lg border border-gray-100 bg-gray-50 p-4 text-sm text-gray-600">
                <p className="text-[10px] uppercase tracking-[0.18em] text-gray-400">AI Classification Read-only</p>
                <p className="mt-2">Confidence: {selectedRecording.ai_confidence ?? "-"}</p>
                <p>Reason: {selectedRecording.ai_reason ?? "-"}</p>
                <p>Classified at: {selectedRecording.classified_at ?? "-"}</p>
              </div>
            )}

            <button type="button" onClick={saveRecording} disabled={loading} className={`mt-5 w-full ${adminButtonClass}`}>
              {selectedRecordingId ? "Update Recording" : "Create Recording"}
            </button>
          </section>

          {selectedRecordingId && (
            <>
              <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
                <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">Platform Links Summary</h2>
                <div className="mt-4 space-y-2">
                  {platformLinks.length ? platformLinks.map((link) => (
                    <div key={link.id} className="rounded-lg border border-gray-100 bg-gray-50 px-3 py-2 text-sm">
                      <p className="font-medium text-(--color-flagblue)">{link.platform || "platform"} · {link.label || "No label"}</p>
                      <p className="truncate text-xs text-gray-500">{link.url}</p>
                      <p className="mt-1 text-xs text-gray-400">Status: {link.status ?? "-"} · Confidence: {link.confidence ?? "-"} · Source: {link.source ?? "-"} · Checked: {link.checked_at ?? "-"}</p>
                    </div>
                  )) : <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-400">No platform links saved for this recording.</p>}
                </div>
                <Link href="/admin/platform-links" className="mt-4 inline-flex text-sm font-medium text-(--color-flagblue)">Open Platform Links Admin</Link>
              </section>

              <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
                <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">Release / Track Usage</h2>
                <div className="mt-4 space-y-2">
                  {trackUsage.length ? trackUsage.map((track) => (
                    <div key={track.id} className="rounded-lg border border-gray-100 bg-gray-50 px-3 py-2 text-sm">
                      <p className="font-medium text-(--color-flagblue)">{track.release_title ?? track.release_id ?? "Unknown release"}</p>
                      <p className="text-xs text-gray-500">Disc {track.disc_number ?? 1} · Track {track.track_number ?? "-"} · Position {track.position ?? "-"}</p>
                    </div>
                  )) : <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-400">No tracklist usage found.</p>}
                </div>
              </section>

              <section className="rounded-xl border border-red-100 bg-red-50/70 p-5">
                <p className="text-[10px] uppercase tracking-[0.18em] text-red-700">Danger Zone</p>
                <p className="mt-2 text-sm text-red-900">
                  Deletion is blocked if tracks, platform links, credits, lyrics, notes, media, relationships, or analytics reference this recording.
                </p>
                <button type="button" onClick={deleteRecording} disabled={loading} className="mt-4 w-full rounded-lg border border-red-300 bg-white px-5 py-3 text-sm uppercase tracking-[0.18em] text-red-700 transition hover:bg-red-700 hover:text-white disabled:opacity-40">
                  Delete Recording
                </button>
              </section>
            </>
          )}
        </div>
      </div>
    </main>
  );
}
