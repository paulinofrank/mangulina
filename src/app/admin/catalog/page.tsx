"use client";

import Link from "next/link";
import { useState } from "react";
import {
  AdminSearchPicker,
  AdminStatusMessage,
  type PickerOption,
} from "@/components/admin/CatalogAdminControls";

const catalogTools = [
  {
    href: "/admin/catalog/releases",
    title: "Releases / Albums",
    description:
      "Create and edit albums, singles, EPs, compilations, release metadata, artist links, labels, and tracklists.",
    button: "Manage Releases",
  },
  {
    href: "/admin/catalog/recordings",
    title: "Recordings / Songs",
    description:
      "Create and edit songs, artists, YouTube IDs, genres, context, ISRCs, duration, and release links.",
    button: "Manage Recordings",
  },
];

export default function AdminCatalogPage() {
  const [artistId, setArtistId] = useState("");
  const [artistName, setArtistName] = useState("");
  const [status, setStatus] = useState("");

  function toolHref(href: string) {
    return artistId ? `${href}?artistId=${encodeURIComponent(artistId)}` : href;
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
              Catalog Admin
            </h1>
            <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
              Start with an artist so similarly named releases and recordings are edited in the right context.
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

      <AdminStatusMessage message={status} />

      <section className="mb-6 rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
        <p className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
          Select Artist First
        </p>
        <AdminSearchPicker
          label="Artist"
          value={artistId}
          displayValue={artistName}
          placeholder="Search artist..."
          endpoint="/api/admin/artists"
          resultKey="artists"
          onSelect={(option: PickerOption) => {
            setArtistId(option.id);
            setArtistName(option.name ?? "");
            setStatus("");
          }}
          onClear={() => {
            setArtistId("");
            setArtistName("");
            setStatus("Global catalog actions are available, but artist selection is recommended.");
          }}
        />
        {artistId ? (
          <p className="mt-3 text-sm text-gray-500">
            Managing catalog data for <span className="font-medium text-(--color-flagblue)">{artistName}</span>.
          </p>
        ) : (
          <p className="mt-3 text-sm text-gray-500">
            Select an artist to scope release and recording work. Use the cards without an artist only for advanced global cleanup.
          </p>
        )}
      </section>

      <section className="grid gap-4 md:grid-cols-2">
        {catalogTools.map((tool) => (
          <Link
            key={tool.href}
            href={toolHref(tool.href)}
            className="group rounded-xl border border-black/5 bg-white p-6 shadow-sm transition hover:-translate-y-0.5 hover:border-(--color-wikicrimson)/30 hover:shadow-md"
          >
            <p className="text-xs font-medium uppercase tracking-[0.18em] text-(--color-wikicrimson)">
              {artistId ? artistName : "Advanced Global Catalog"}
            </p>
            <h2 className="mt-2 text-xl font-semibold text-(--color-flagblue)">
              {tool.title}
            </h2>
            <p className="mt-3 text-sm leading-relaxed text-gray-600">
              {tool.description}
            </p>
            <p className="mt-5 inline-flex text-sm font-medium text-(--color-flagblue) transition group-hover:text-(--color-wikicrimson)">
              {tool.button}
            </p>
          </Link>
        ))}
      </section>
    </main>
  );
}

