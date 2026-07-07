"use client";

import Link from "next/link";
import { useCallback, useEffect, useState } from "react";
import { useRouter } from "next/navigation";

import {
  AdminField,
  AdminSearchPicker,
  AdminStatusMessage,
  adminButtonClass,
  adminInputClass,
  type PickerOption,
} from "@/components/admin/CatalogAdminControls";

type AdminArtist = {
  id: string;
  name: string;
};

type CreativeWork = {
  id: string;
  title: string;
  performer_text: string | null;
  release_title: string | null;
  release_year: number | null;
  roles: string[];
};

type CreativeWorkForm = {
  title: string;
  performer_text: string;
  release_title: string;
  release_year: string;
  roles: string;
};

const emptyForm: CreativeWorkForm = {
  title: "",
  performer_text: "",
  release_title: "",
  release_year: "",
  roles: "",
};

function formFromWork(work: CreativeWork): CreativeWorkForm {
  return {
    title: work.title ?? "",
    performer_text: work.performer_text ?? "",
    release_title: work.release_title ?? "",
    release_year: work.release_year ? String(work.release_year) : "",
    roles: work.roles.join(", "),
  };
}

function displayYear(year: number | null) {
  return year == null ? "Unknown" : String(year);
}

export default function CreativeWorksAdminPage({ initialArtistId = "" }: { initialArtistId?: string }) {
  const router = useRouter();
  const [selectedArtist, setSelectedArtist] = useState<AdminArtist | null>(null);
  const [works, setWorks] = useState<CreativeWork[]>([]);
  const [selectedWorkId, setSelectedWorkId] = useState("");
  const [form, setForm] = useState<CreativeWorkForm>(emptyForm);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");

  const selectedWork = works.find((work) => work.id === selectedWorkId) ?? null;

  const loadWorks = useCallback(async (artistId: string) => {
    const response = await fetch(`/api/admin/creative-works?artistId=${encodeURIComponent(artistId)}`);
    const result = await response.json();
    if (!response.ok || !result.ok) {
      setWorks([]);
      setStatus(`Error loading creative works: ${result.error || response.statusText}`);
      return;
    }

    setWorks((result.works ?? []) as CreativeWork[]);
  }, []);

  const loadArtist = useCallback(async (artistId: string) => {
    const response = await fetch(`/api/admin/artists?id=${encodeURIComponent(artistId)}`);
    const result = await response.json();
    if (!response.ok || !result.ok || !result.artists?.[0]) {
      setStatus(`Error loading artist: ${result.error || response.statusText}`);
      return;
    }

    const artist = result.artists[0] as AdminArtist;
    setSelectedArtist(artist);
    setSelectedWorkId("");
    setForm(emptyForm);
    await loadWorks(artist.id);
  }, [loadWorks]);

  useEffect(() => {
    if (initialArtistId) void loadArtist(initialArtistId);
  }, [initialArtistId, loadArtist]);

  function selectArtist(option: PickerOption) {
    const artist = { id: option.id, name: option.name ?? "" };
    setSelectedArtist(artist);
    setSelectedWorkId("");
    setForm(emptyForm);
    setStatus("");
    router.replace(`/admin/artists/${encodeURIComponent(option.id)}/creative-works`);
    void loadWorks(option.id);
  }

  function clearArtist() {
    setSelectedArtist(null);
    setWorks([]);
    setSelectedWorkId("");
    setForm(emptyForm);
    router.replace("/admin/artists/creative-works");
    setStatus("Select an artist to manage Creative Works.");
  }

  function updateForm<K extends keyof CreativeWorkForm>(key: K, value: CreativeWorkForm[K]) {
    setForm((current) => ({ ...current, [key]: value }));
  }

  function startNewWork() {
    setSelectedWorkId("");
    setForm(emptyForm);
    setStatus(selectedArtist ? `Adding a new Creative Work for ${selectedArtist.name}.` : "Select an artist first.");
  }

  function editWork(work: CreativeWork) {
    setSelectedWorkId(work.id);
    setForm(formFromWork(work));
    setStatus(`Editing ${work.title}.`);
  }

  async function saveWork(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!selectedArtist) {
      setStatus("Select an artist before saving.");
      return;
    }

    setLoading(true);
    setStatus("");

    const response = await fetch("/api/admin/creative-works", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        artistId: selectedArtist.id,
        workId: selectedWorkId || null,
        workData: form,
      }),
    });
    const result = await response.json();
    setLoading(false);

    if (!response.ok || !result.ok) {
      setStatus(`Error saving creative work: ${result.error || response.statusText}`);
      return;
    }

    setStatus(selectedWorkId ? "Creative Work updated." : "Creative Work saved.");
    setSelectedWorkId("");
    setForm(emptyForm);
    await loadWorks(selectedArtist.id);
  }

  async function deleteCredit(work: CreativeWork) {
    if (!selectedArtist) return;
    const confirmed = window.confirm(`Remove ${selectedArtist.name}'s Creative Works credit for "${work.title}"?`);
    if (!confirmed) return;

    setLoading(true);
    const response = await fetch("/api/admin/creative-works", {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ artistId: selectedArtist.id, workId: work.id }),
    });
    const result = await response.json();
    setLoading(false);

    if (!response.ok || !result.ok) {
      setStatus(`Error deleting credit: ${result.error || response.statusText}`);
      return;
    }

    if (selectedWorkId === work.id) {
      setSelectedWorkId("");
      setForm(emptyForm);
    }
    setStatus("Artist credit removed.");
    await loadWorks(selectedArtist.id);
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
              Creative Works
            </h1>
            <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
              Maintain Works & Credits portfolios independently from Discography, recordings, and release artists.
            </p>
          </div>

          <div className="flex flex-wrap gap-2">
            <Link
              href="/admin/artists"
              className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-(--color-flagblue) shadow-sm transition hover:border-(--color-wikicrimson) hover:text-(--color-wikicrimson)"
            >
              Artists
            </Link>
            <Link
              href="/admin"
              className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-(--color-flagblue) shadow-sm transition hover:border-(--color-wikicrimson) hover:text-(--color-wikicrimson)"
            >
              Admin Portal
            </Link>
          </div>
        </div>
      </header>

      <AdminStatusMessage message={status} />

      <div className="grid gap-6 lg:grid-cols-[380px_minmax(0,1fr)]">
        <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
          <p className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
            {selectedWork ? "Edit Work" : "Add Work"}
          </p>
          <h2 className="mt-1 text-xl font-semibold text-(--color-flagblue)">
            {selectedWork?.title ?? "Creative Work Details"}
          </h2>

          <div className="mt-5">
            <AdminSearchPicker
              label="Artist"
              value={selectedArtist?.id ?? ""}
              displayValue={selectedArtist?.name ?? ""}
              placeholder="Search artist..."
              endpoint="/api/admin/artists"
              resultKey="artists"
              onSelect={selectArtist}
              onClear={clearArtist}
            />
            {selectedArtist && (
              <p className="mt-3 text-sm text-gray-500">
                Managing Works & Credits for{" "}
                <span className="font-medium text-(--color-flagblue)">{selectedArtist.name}</span>.
              </p>
            )}
          </div>

          <form className="mt-5 space-y-4" onSubmit={(event) => void saveWork(event)}>
            <AdminField label="Title">
              <input
                value={form.title}
                onChange={(event) => updateForm("title", event.target.value)}
                className={adminInputClass}
                placeholder="Gasolina"
                required
              />
            </AdminField>

            <AdminField label="Performer">
              <input
                value={form.performer_text}
                onChange={(event) => updateForm("performer_text", event.target.value)}
                className={adminInputClass}
                placeholder="Daddy Yankee"
              />
            </AdminField>

            <AdminField label="Release / Album">
              <input
                value={form.release_title}
                onChange={(event) => updateForm("release_title", event.target.value)}
                className={adminInputClass}
                placeholder="Barrio Fino"
              />
            </AdminField>

            <AdminField label="Year">
              <input
                value={form.release_year}
                onChange={(event) => updateForm("release_year", event.target.value)}
                className={adminInputClass}
                inputMode="numeric"
                placeholder="2004"
              />
            </AdminField>

            <AdminField label="Roles">
              <textarea
                value={form.roles}
                onChange={(event) => updateForm("roles", event.target.value)}
                className={`${adminInputClass} min-h-24 resize-y`}
                placeholder="Producer, Composer, Mix Engineer"
                required
              />
            </AdminField>

            <div className="flex flex-wrap gap-3 pt-2">
              <button type="submit" className={adminButtonClass} disabled={!selectedArtist || loading}>
                {loading ? "Saving..." : selectedWork ? "Update Creative Work" : "Add Creative Work"}
              </button>
              <button
                type="button"
                onClick={startNewWork}
                className="rounded-lg border border-gray-200 bg-white px-5 py-3 text-xs uppercase tracking-[0.18em] text-(--color-flagblue) transition hover:border-(--color-wikicrimson) hover:text-(--color-wikicrimson)"
              >
                {selectedWork ? "Cancel Edit" : "Reset"}
              </button>
              {selectedWork && (
                <button
                  type="button"
                  onClick={() => void deleteCredit(selectedWork)}
                  className="rounded-lg border border-(--color-wikicrimson)/30 bg-white px-5 py-3 text-xs uppercase tracking-[0.18em] text-(--color-wikicrimson) transition hover:border-(--color-wikicrimson) hover:bg-(--color-wikicrimson) hover:text-white disabled:cursor-not-allowed disabled:opacity-40"
                  disabled={loading}
                >
                  Delete
                </button>
              )}
            </div>
          </form>
        </section>

        <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
          <div className="mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div>
              <p className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                Artist Portfolio
              </p>
              <h2 className="mt-1 text-xl font-semibold text-(--color-flagblue)">
                {works.length} Creative {works.length === 1 ? "Work" : "Works"}
              </h2>
            </div>
            <button
              type="button"
              onClick={startNewWork}
              className={adminButtonClass}
              disabled={!selectedArtist || loading}
            >
              Add Work
            </button>
          </div>

          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-100 text-left text-sm">
              <thead>
                <tr className="text-[10px] uppercase tracking-[0.18em] text-gray-400">
                  <th className="py-2 pr-4 font-normal">Year</th>
                  <th className="py-2 pr-4 font-normal">Title</th>
                  <th className="py-2 pr-4 font-normal">Performer</th>
                  <th className="py-2 pr-4 font-normal">Roles</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {works.map((work) => {
                  const isSelected = selectedWorkId === work.id;
                  return (
                  <tr
                    key={work.id}
                    onClick={() => editWork(work)}
                    className={`cursor-pointer transition hover:bg-(--color-flagblue)/5 ${
                      isSelected ? "bg-(--color-flagblue)/10 ring-1 ring-inset ring-(--color-flagblue)/20" : ""
                    }`}
                    aria-selected={isSelected}
                  >
                    <td className="whitespace-nowrap py-3 pr-4 text-gray-500">{displayYear(work.release_year)}</td>
                    <td className="min-w-40 py-3 pr-4 font-medium text-gray-800">{work.title}</td>
                    <td className="min-w-36 py-3 pr-4 text-gray-600">{work.performer_text || "Unknown"}</td>
                    <td className="min-w-48 py-3 pr-4 text-gray-600">{work.roles.join(", ")}</td>
                  </tr>
                  );
                })}
                {!works.length && (
                  <tr>
                    <td colSpan={4} className="py-8 text-center text-sm text-gray-400">
                      {selectedArtist ? "No Creative Works found for this artist." : "Select an artist to load Creative Works."}
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </section>

      </div>
    </main>
  );
}
