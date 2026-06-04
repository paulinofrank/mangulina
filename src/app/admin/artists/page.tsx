// src/app/admin/page.tsx
"use client";

import Image from "next/image";
import Link from "next/link";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import type { FormEvent } from "react";
import { getSupabaseClient } from "@/lib/supabase";
import type { Artist } from "@/types/music";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";
import BioText from "@/components/molecules/BioText";

type ArtistStatus =
  | "draft"
  | "published"
  | "hidden"
  | "needs_review"
  | "duplicate";

type AdminArtist = Artist & {
  sort_name?: string | null;
  slug?: string | null;
  type?: string | null;
  primary_role?: string | null;
  primary_genre?: string | null;
  status?: ArtistStatus | string | null;
  first_name?: string | null;
  middle_name?: string | null;
  last_name?: string | null;
  second_last_name?: string | null;
  stage_name?: string | null;
  date_of_birth?: string | null;
  birth_year?: number | null;
  date_of_death?: string | null;
  death_year?: number | null;
  birth_place?: string | null;
  province?: string | null;
  website?: string | null;
  facebook?: string | null;
  instagram?: string | null;
  youtube?: string | null;
  occupations?: string[] | Record<string, unknown> | null;
  instruments?: string[] | null;
  genres?: string[] | null;
  artist_tags?: string[] | null;
  aliases?: string[] | null;
  bio?: string | null;
  gender?: string | null;
  disambiguation?: string | null;
  ended?: boolean | null;
  wikidata_id?: string | null;
};

type FeaturedArtistRow = {
  artist_id?: string | null;
};

type ArtistForm = {
  name: string;
  sort_name: string;
  slug: string;
  stage_name: string;
  first_name: string;
  middle_name: string;
  last_name: string;
  second_last_name: string;
  date_of_birth: string;
  birth_year: string;
  date_of_death: string;
  death_year: string;
  birth_place: string;
  province: string;
  type: string;
  primary_role: string;
  primary_genre: string;
  status: ArtistStatus;
  occupations: string;
  instruments: string;
  genres: string;
  artist_tags: string;
  aliases: string;
  website: string;
  facebook: string;
  instagram: string;
  youtube: string;
  gender: string;
  disambiguation: string;
  wikidata_id: string;
  bio: string;
  ended: boolean;
};

type AdminWriteResponse = {
  ok: boolean;
  id?: string;
  artistId?: string;
  error?: string;
};

const emptyForm: ArtistForm = {
  name: "",
  sort_name: "",
  slug: "",
  stage_name: "",
  first_name: "",
  middle_name: "",
  last_name: "",
  second_last_name: "",
  date_of_birth: "",
  birth_year: "",
  date_of_death: "",
  death_year: "",
  birth_place: "",
  province: "",
  type: "",
  primary_role: "",
  primary_genre: "",
  status: "published",
  occupations: "",
  instruments: "",
  genres: "",
  artist_tags: "",
  aliases: "",
  website: "",
  facebook: "",
  instagram: "",
  youtube: "",
  gender: "",
  disambiguation: "",
  wikidata_id: "",
  bio: "",
  ended: false,
};

const primaryGenreOptions = [
  { value: "", label: "-- Select Primary Genre --" },
  { value: "merengue", label: "Merengue" },
  { value: "bachata", label: "Bachata" },
  { value: "salsa", label: "Salsa" },
  { value: "urban", label: "Urban / Urbano" },
  { value: "dembow", label: "Dembow" },
  { value: "reggaeton", label: "Reggaeton" },
  { value: "rap", label: "Rap" },
  { value: "hip-hop", label: "Hip-Hop" },
  { value: "trap", label: "Trap" },
  { value: "ballads", label: "Ballads / Balada" },
  { value: "bolero", label: "Bolero" },
  { value: "pop", label: "Pop" },
  { value: "rock", label: "Rock" },
  { value: "instrumental", label: "Instrumental" },
  { value: "classical", label: "Classical / Clásica" },
  { value: "jazz", label: "Jazz" },
  { value: "folklore", label: "Folklore" },
  { value: "fusion", label: "Fusion" },
  { value: "electronic", label: "Electronic" },
  { value: "other", label: "Other Genre" },
];

const provinceOptions = [
  "Azua",
  "Bahoruco",
  "Barahona",
  "Dajabón",
  "Distrito Nacional",
  "Duarte",
  "El Seibo",
  "Elías Piña",
  "Espaillat",
  "Hato Mayor",
  "Hermanas Mirabal",
  "Independencia",
  "La Altagracia",
  "La Romana",
  "La Vega",
  "María Trinidad Sánchez",
  "Monseñor Nouel",
  "Monte Cristi",
  "Monte Plata",
  "Pedernales",
  "Peravia",
  "Puerto Plata",
  "Samaná",
  "San Cristóbal",
  "San José de Ocoa",
  "San Juan",
  "San Pedro de Macorís",
  "Sánchez Ramírez",
  "Santiago",
  "Santiago Rodríguez",
  "Santo Domingo",
  "Valverde",
];

function parseCsv(value: string | null | undefined) {
  if (!value) return [];

  return value
    .split(",")
    .map((item) => item.trim())
    .filter(Boolean);
}

function toCsv(value: string[] | Record<string, unknown> | null | undefined) {
  if (!value) return "";

  if (Array.isArray(value)) {
    return value.filter(Boolean).join(", ");
  }

  return Object.keys(value).filter(Boolean).join(", ");
}

function nullable(value: string | null | undefined) {
  const trimmed = (value ?? "").trim();
  return trimmed ? trimmed : null;
}

function normalizeStatus(value: string | null | undefined): ArtistStatus {
  if (
    value === "draft" ||
    value === "published" ||
    value === "hidden" ||
    value === "needs_review" ||
    value === "duplicate"
  ) {
    return value;
  }

  return "published";
}

export default function AdminDashboard() {
  const supabase = getSupabaseClient();

  const [mounted, setMounted] = useState(false);
  const [artists, setArtists] = useState<AdminArtist[]>([]);
  const [featuredId, setFeaturedId] = useState("");
  const [selectedArtistId, setSelectedArtistId] = useState("");
  const [search, setSearch] = useState("");
  const [form, setForm] = useState<ArtistForm>(emptyForm);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");
  const [imageVersion, setImageVersion] = useState(0);
  const bioTextareaRef = useRef<HTMLTextAreaElement>(null);

  const selectedArtist = useMemo(
    () => artists.find((artist) => artist.id === selectedArtistId) || null,
    [artists, selectedArtistId]
  );

  const selectedArtistImageUrl = selectedArtist
    ? `${getArtistImageUrl(selectedArtist.id)}?v=${imageVersion}`
    : "";

  const filteredArtists = useMemo(() => {
    const query = search.trim().toLowerCase();

    if (!query) return artists;

    return artists.filter((artist) =>
      [
        artist.name,
        artist.stage_name,
        artist.slug,
        artist.province,
        artist.status,
      ]
        .filter(Boolean)
        .some((value) => String(value).toLowerCase().includes(query))
    );
  }, [artists, search]);

  const fetchData = useCallback(async () => {
    setLoading(true);

    const { data: artistsData, error: artistsError } = await supabase
      .from("artists")
      .select("*")
      .order("name", { ascending: true });

    if (artistsError) {
      console.error("Error fetching artists:", artistsError);
      setStatus(`Error loading artists: ${artistsError.message}`);
    }

    if (artistsData) {
      setArtists(artistsData as AdminArtist[]);
    }

    const { data: featuredData, error: featuredError } = await supabase
      .from("featured_artist")
      .select("artist_id")
      .maybeSingle();

    if (featuredError) {
      console.error("Error fetching featured artist:", featuredError);
    }

    const featuredRow = featuredData as FeaturedArtistRow | null;

    if (featuredRow?.artist_id) {
      setFeaturedId(String(featuredRow.artist_id));
    }

    setLoading(false);
  }, [supabase]);

  useEffect(() => {
    setMounted(true);
    setImageVersion(Date.now());
  }, []);

  useEffect(() => {
    if (!mounted) return;

    void fetchData();
  }, [fetchData, mounted]);

  function updateForm<K extends keyof ArtistForm>(key: K, value: ArtistForm[K]) {
    setForm((current) => ({
      ...current,
      [key]: value,
    }));
  }

  function resetForm() {
    setSelectedArtistId("");
    setForm({ ...emptyForm });
    setStatus("");
  }

  function focusBioSelection(start: number, end: number) {
    window.setTimeout(() => {
      bioTextareaRef.current?.focus();
      bioTextareaRef.current?.setSelectionRange(start, end);
    }, 0);
  }

  function wrapBioSelection(prefix: string, suffix = prefix, placeholder = "text") {
    const textarea = bioTextareaRef.current;
    const value = form.bio ?? "";
    const start = textarea?.selectionStart ?? value.length;
    const end = textarea?.selectionEnd ?? value.length;
    const selectedText = value.slice(start, end) || placeholder;
    const nextBio = `${value.slice(0, start)}${prefix}${selectedText}${suffix}${value.slice(end)}`;
    const nextStart = start + prefix.length;
    const nextEnd = nextStart + selectedText.length;

    updateForm("bio", nextBio);
    focusBioSelection(nextStart, nextEnd);
  }

  function formatBioLines(prefix: string, placeholder = "New line") {
    const textarea = bioTextareaRef.current;
    const value = form.bio ?? "";
    const start = textarea?.selectionStart ?? value.length;
    const end = textarea?.selectionEnd ?? value.length;
    const selectedText = value.slice(start, end) || placeholder;
    const formattedText = selectedText
      .split("\n")
      .map((line) => {
        const trimmed = line.trim();
        return trimmed ? `${prefix}${trimmed}` : line;
      })
      .join("\n");
    const nextBio = `${value.slice(0, start)}${formattedText}${value.slice(end)}`;

    updateForm("bio", nextBio);
    focusBioSelection(start, start + formattedText.length);
  }

  function insertBioLink() {
    const href = window.prompt("Paste the full URL for this link:");

    if (!href?.trim()) return;

    wrapBioSelection("[", `](${href.trim()})`, "link text");
  }

  function handleSelectArtistForEdit(id: string) {
    const artist = artists.find((item) => item.id === id);

    if (!artist) {
      resetForm();
      return;
    }

    setSelectedArtistId(artist.id);
    setImageVersion(Date.now());

    setForm({
      name: artist.name ?? "",
      sort_name: artist.sort_name ?? "",
      slug: artist.slug ?? "",
      stage_name: artist.stage_name ?? "",
      first_name: artist.first_name ?? "",
      middle_name: artist.middle_name ?? "",
      last_name: artist.last_name ?? "",
      second_last_name: artist.second_last_name ?? "",
      date_of_birth: artist.date_of_birth ?? "",
      birth_year: artist.birth_year ? String(artist.birth_year) : "",
      date_of_death: artist.date_of_death ?? "",
      death_year: artist.death_year ? String(artist.death_year) : "",
      birth_place: artist.birth_place ?? "",
      province: artist.province ?? "",
      type: artist.type ?? "",
      primary_role: artist.primary_role ?? "",
      primary_genre: artist.primary_genre ?? "",
      status: normalizeStatus(artist.status),
      occupations: toCsv(artist.occupations),
      instruments: toCsv(artist.instruments),
      genres: toCsv(artist.genres),
      artist_tags: toCsv(artist.artist_tags),
      aliases: toCsv(artist.aliases),
      website: artist.website ?? "",
      facebook: artist.facebook ?? "",
      instagram: artist.instagram ?? "",
      youtube: artist.youtube ?? "",
      gender: artist.gender ?? "",
      disambiguation: artist.disambiguation ?? "",
      wikidata_id: artist.wikidata_id ?? "",
      bio: artist.bio ?? "",
      ended: Boolean(artist.ended),
    });

    setStatus("");
  }

async function updateFeatured() {
    if (!featuredId) return;

    setLoading(true);
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

    setLoading(false);
  }

  async function handleUploadArtistImage(file: File) {
    if (!selectedArtistId) {
      setStatus("Select an artist before uploading an image.");
      return;
    }

    const isWebp =
      file.type === "image/webp" || file.name.toLowerCase().endsWith(".webp");

    if (!isWebp) {
      setStatus("Please upload a .webp image file.");
      return;
    }

    setLoading(true);
    setStatus(`Uploading image as ${selectedArtistId}.webp...`);

    const filePath = `${selectedArtistId}.webp`;

    const webpFile = new File([file], filePath, {
      type: "image/webp",
    });

    const { data, error } = await supabase.storage
      .from("artists-images")
      .upload(filePath, webpFile, {
        upsert: true,
        contentType: "image/webp",
        cacheControl: "3600",
      });

    if (error) {
      console.error("Image upload error:", error);

      setStatus(
        `Error uploading image: ${error.message}. Path attempted: artists-images/${filePath}`
      );

      setLoading(false);
      return;
    }

    console.log("Image upload success:", data);

    setStatus(`Artist image uploaded successfully as ${filePath}.`);
    setImageVersion(Date.now());

    await fetchData();

    setLoading(false);
  }

  async function handleSaveArtist(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    setLoading(true);
    setStatus("");

    const artistData = {
      name: form.name.trim(),
      sort_name: nullable(form.sort_name),
      slug: nullable(form.slug),
      stage_name: nullable(form.stage_name),

      first_name: nullable(form.first_name),
      middle_name: nullable(form.middle_name),
      last_name: nullable(form.last_name),
      second_last_name: nullable(form.second_last_name),

      date_of_birth: nullable(form.date_of_birth),
      birth_year: form.birth_year ? Number(form.birth_year) : null,
      date_of_death: nullable(form.date_of_death),
      death_year: form.death_year ? Number(form.death_year) : null,

      birth_place: nullable(form.birth_place),
      province: nullable(form.province),

      type: nullable(form.type),
      primary_role: nullable(form.primary_role),
      primary_genre: nullable(form.primary_genre),
      status: form.status || "published",

      occupations: parseCsv(form.occupations),
      instruments: parseCsv(form.instruments),
      genres: parseCsv(form.genres),
      artist_tags: parseCsv(form.artist_tags),
      aliases: parseCsv(form.aliases),

      website: nullable(form.website),
      facebook: nullable(form.facebook),
      instagram: nullable(form.instagram),
      youtube: nullable(form.youtube),

      gender: nullable(form.gender),
      disambiguation: nullable(form.disambiguation),
      wikidata_id: nullable(form.wikidata_id),

      bio: nullable(form.bio),
      ended: form.ended,
    };

    const response = await fetch("/api/admin/artists", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        artistId: selectedArtistId || null,
        artistData,
      }),
    });

    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error saving artist: ${result.error || response.statusText}`);
    } else {
      setStatus(
        selectedArtistId ? "Artist profile updated." : "New artist created."
      );

      await fetchData();

      if (!selectedArtistId) {
        resetForm();
      }
    }

    setLoading(false);
  }

  if (!mounted) {
    return null;
  }

  return (
    <div className="mx-auto max-w-6xl px-5 pb-10 pt-24 font-sans text-(--color-ink)">
      <header className="mb-10 border-b border-gray-200 pb-6">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <h1 className="text-3xl font-normal tracking-tight text-(--color-flagblue) sm:text-4xl">
              MANGULINA
              <span className="text-(--color-wikicrimson)">™</span> ADMIN
            </h1>

            <p className="mt-2 text-sm text-gray-500">
              Artist profile editor and homepage spotlight control.
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

      <section className="mb-8 rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
        <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
          Homepage Spotlight
        </h2>

        <div className="grid gap-3 sm:grid-cols-[1fr_auto]">
          <select
            value={featuredId ?? ""}
            onChange={(event) => setFeaturedId(event.target.value)}
            className="rounded-lg border border-gray-200 px-3 py-2 text-sm outline-none focus:border-(--color-flagblue)"
          >
            <option value="">-- Select Featured Artist --</option>

            {artists.map((artist) => (
              <option key={artist.id} value={artist.id}>
                {artist.name}
                {artist.status && artist.status !== "published"
                  ? ` — ${artist.status}`
                  : ""}
              </option>
            ))}
          </select>

          <button
            type="button"
            onClick={updateFeatured}
            disabled={Boolean(loading || !featuredId)}
            className="rounded-lg bg-(--color-flagblue) px-5 py-2 text-sm text-white transition disabled:cursor-not-allowed disabled:opacity-40"
          >
            Update Spotlight
          </button>
        </div>
      </section>

      <div className="grid gap-8 lg:grid-cols-[320px_1fr]">
        <aside className="space-y-5">
          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Select Artist
            </h2>

            <input
              value={search ?? ""}
              onChange={(event) => setSearch(event.target.value)}
              placeholder="Search artist..."
              className="mb-3 w-full rounded-lg border border-gray-200 px-3 py-2 text-sm outline-none focus:border-(--color-flagblue)"
            />

            <select
              value={selectedArtistId ?? ""}
              onChange={(event) => handleSelectArtistForEdit(event.target.value)}
              className="w-full rounded-lg border border-gray-200 px-3 py-2 text-sm outline-none focus:border-(--color-flagblue)"
            >
              <option value="">-- Create New Artist --</option>

              {filteredArtists.map((artist) => (
                <option key={artist.id} value={artist.id}>
                  {artist.name}
                  {artist.status && artist.status !== "published"
                    ? ` — ${artist.status}`
                    : ""}
                </option>
              ))}
            </select>

            {selectedArtist && (
              <div className="mt-5">
                <div className="relative aspect-square w-full overflow-hidden rounded-xl bg-gray-100">
                  <Image
                    src={selectedArtistImageUrl}
                    alt={selectedArtist.name}
                    fill
                    className="object-cover"
                    sizes="320px"
                  />
                </div>

                <div className="mt-3 flex flex-wrap items-center gap-2">
                  <p className="text-sm text-gray-600">{selectedArtist.name}</p>

                  <span className="rounded-full bg-gray-100 px-2.5 py-1 text-[10px] uppercase tracking-[0.14em] text-gray-500">
                    {normalizeStatus(selectedArtist.status)}
                  </span>
                </div>

                <label className="mt-4 block">
                  <span className="mb-1 block text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
                    Upload Artist Image
                  </span>

                  <input
                    type="file"
                    accept=".webp,image/webp"
                    disabled={Boolean(!selectedArtistId || loading)}
                    onChange={(event) => {
                      const file = event.target.files?.[0];

                      if (file) {
                        void handleUploadArtistImage(file);
                      }

                      event.target.value = "";
                    }}
                    className="block w-full text-sm text-gray-600 file:mr-4 file:rounded-lg file:border-0 file:bg-(--color-flagblue) file:px-4 file:py-2 file:text-sm file:text-white disabled:opacity-40"
                  />

                  <p className="mt-2 text-xs text-gray-400">
                    Uploads as {selectedArtist.id}.webp
                  </p>
                </label>
              </div>
            )}
          </section>
        </aside>

        <main>
          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <div className="mb-6 flex items-center justify-between gap-4">
              <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                {selectedArtistId ? "Edit Artist Profile" : "Create New Artist"}
              </h2>

              {selectedArtistId && (
                <button
                  type="button"
                  onClick={resetForm}
                  className="text-sm text-(--color-wikicrimson)"
                >
                  Cancel edit
                </button>
              )}
            </div>

            <form onSubmit={handleSaveArtist} className="space-y-6">
              <div className="grid gap-4 md:grid-cols-2">
                <Field label="Artist Name">
                  <input
                    value={form.name ?? ""}
                    onChange={(event) => updateForm("name", event.target.value)}
                    required
                    className={inputClass}
                  />
                </Field>

                <Field label="Sort Name">
                  <input
                    value={form.sort_name ?? ""}
                    onChange={(event) =>
                      updateForm("sort_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Slug">
                  <input
                    value={form.slug ?? ""}
                    onChange={(event) => updateForm("slug", event.target.value)}
                    required
                    className={inputClass}
                  />
                </Field>

                <Field label="Stage Name">
                  <input
                    value={form.stage_name ?? ""}
                    onChange={(event) =>
                      updateForm("stage_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>
              </div>

              <div className="grid gap-4 md:grid-cols-4">
                <Field label="First Name">
                  <input
                    value={form.first_name ?? ""}
                    onChange={(event) =>
                      updateForm("first_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Middle Name">
                  <input
                    value={form.middle_name ?? ""}
                    onChange={(event) =>
                      updateForm("middle_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Last Name">
                  <input
                    value={form.last_name ?? ""}
                    onChange={(event) =>
                      updateForm("last_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Second Last Name">
                  <input
                    value={form.second_last_name ?? ""}
                    onChange={(event) =>
                      updateForm("second_last_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>
              </div>

              <div className="grid gap-4 md:grid-cols-4">
                <Field label="Date of Birth">
                  <input
                    type="date"
                    value={form.date_of_birth ?? ""}
                    onChange={(event) =>
                      updateForm("date_of_birth", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Birth Year">
                  <input
                    type="number"
                    value={form.birth_year ?? ""}
                    onChange={(event) =>
                      updateForm("birth_year", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Date of Death">
                  <input
                    type="date"
                    value={form.date_of_death ?? ""}
                    onChange={(event) =>
                      updateForm("date_of_death", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Death Year">
                  <input
                    type="number"
                    value={form.death_year ?? ""}
                    onChange={(event) =>
                      updateForm("death_year", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>
              </div>

              <div className="grid gap-4 md:grid-cols-2">
                <Field label="Place of Birth">
                  <input
                    value={form.birth_place ?? ""}
                    onChange={(event) =>
                      updateForm("birth_place", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Province">
                  <select
                    value={form.province ?? ""}
                    onChange={(event) =>
                      updateForm("province", event.target.value)
                    }
                    className={inputClass}
                  >
                    <option value="">-- Select Province --</option>
                    {provinceOptions.map((province) => (
                      <option key={province} value={province}>
                        {province}
                      </option>
                    ))}
                  </select>
                </Field>
              </div>

              <div className="grid gap-4 md:grid-cols-4">
                <Field label="Artist Type">
                  <input
                    value={form.type ?? ""}
                    onChange={(event) => updateForm("type", event.target.value)}
                    placeholder="solo_artist, group, orchestra..."
                    className={inputClass}
                  />
                </Field>

                <Field label="Primary Role">
                  <input
                    value={form.primary_role ?? ""}
                    onChange={(event) =>
                      updateForm("primary_role", event.target.value)
                    }
                    placeholder="singer, composer, musician..."
                    className={inputClass}
                  />
                </Field>

                <Field label="Primary Genre">
                  <select
                    value={form.primary_genre ?? ""}
                    onChange={(event) =>
                      updateForm("primary_genre", event.target.value)
                    }
                    className={inputClass}
                  >
                    {primaryGenreOptions.map((option) => (
                      <option
                        key={option.value || "empty-primary-genre"}
                        value={option.value}
                      >
                        {option.label}
                      </option>
                    ))}
                  </select>
                </Field>

                <Field label="Profile Status">
                  <select
                    value={form.status ?? "published"}
                    onChange={(event) =>
                      updateForm(
                        "status",
                        normalizeStatus(event.target.value)
                      )
                    }
                    className={inputClass}
                  >
                    <option value="published">Published</option>
                    <option value="draft">Draft</option>
                    <option value="hidden">Hidden</option>
                    <option value="needs_review">Needs Review</option>
                    <option value="duplicate">Duplicate</option>
                  </select>
                </Field>
              </div>

              <Field label="Other Roles / Occupations">
                <input
                  value={form.occupations ?? ""}
                  onChange={(event) =>
                    updateForm("occupations", event.target.value)
                  }
                  placeholder="singer, composer, producer"
                  className={inputClass}
                />
              </Field>

              <Field label="Instruments">
                <input
                  value={form.instruments ?? ""}
                  onChange={(event) =>
                    updateForm("instruments", event.target.value)
                  }
                  placeholder="piano, guitar, güira, tambora"
                  className={inputClass}
                />
              </Field>

              <Field label="Musical Genres">
                <input
                  value={form.genres ?? ""}
                  onChange={(event) => updateForm("genres", event.target.value)}
                  placeholder="merengue, bachata, salsa"
                  className={inputClass}
                />
              </Field>

              <Field label="Artist Tags">
                <input
                  value={form.artist_tags ?? ""}
                  onChange={(event) =>
                    updateForm("artist_tags", event.target.value)
                  }
                  placeholder="christian, religious, classic-merengue, 1980s"
                  className={inputClass}
                />
              </Field>

              <Field label="Aliases">
                <input
                  value={form.aliases ?? ""}
                  onChange={(event) => updateForm("aliases", event.target.value)}
                  placeholder="El Mayimbe, El Caballo Mayor"
                  className={inputClass}
                />
              </Field>

              <div className="grid gap-4 md:grid-cols-2">
                <Field label="Official Website">
                  <input
                    value={form.website ?? ""}
                    onChange={(event) =>
                      updateForm("website", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="YouTube">
                  <input
                    value={form.youtube ?? ""}
                    onChange={(event) =>
                      updateForm("youtube", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Facebook">
                  <input
                    value={form.facebook ?? ""}
                    onChange={(event) =>
                      updateForm("facebook", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label="Instagram">
                  <input
                    value={form.instagram ?? ""}
                    onChange={(event) =>
                      updateForm("instagram", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>
              </div>

              <div className="grid gap-4 md:grid-cols-3">
                <Field label="Gender">
                  <input
                    value={form.gender ?? ""}
                    onChange={(event) => updateForm("gender", event.target.value)}
                    placeholder="male, female, group"
                    className={inputClass}
                  />
                </Field>

                <Field label="Wikidata ID">
                  <input
                    value={form.wikidata_id ?? ""}
                    onChange={(event) =>
                      updateForm("wikidata_id", event.target.value)
                    }
                    placeholder="Q123456"
                    className={inputClass}
                  />
                </Field>

                <label className="flex items-end gap-3 text-sm text-gray-700">
                  <input
                    type="checkbox"
                    checked={Boolean(form.ended)}
                    onChange={(event) =>
                      updateForm("ended", event.target.checked)
                    }
                    className="mb-3 h-4 w-4"
                  />
                  Ended / Inactive
                </label>
              </div>

              <Field label="Disambiguation">
                <input
                  value={form.disambiguation ?? ""}
                  onChange={(event) =>
                    updateForm("disambiguation", event.target.value)
                  }
                  placeholder="Dominican merengue singer, not the composer..."
                  className={inputClass}
                />
              </Field>

              <Field label="Biography">
                <div className="overflow-hidden rounded-lg border border-gray-200 bg-white focus-within:border-(--color-flagblue)">
                  <div className="flex flex-wrap gap-2 border-b border-gray-100 bg-gray-50 px-3 py-2">
                    <button
                      type="button"
                      onClick={() => wrapBioSelection("**", "**", "bold text")}
                      className={toolbarButtonClass}
                    >
                      B
                    </button>

                    <button
                      type="button"
                      onClick={() => wrapBioSelection("*", "*", "italic text")}
                      className={`${toolbarButtonClass} italic`}
                    >
                      I
                    </button>

                    <button
                      type="button"
                      onClick={() => formatBioLines("## ", "Section title")}
                      className={toolbarButtonClass}
                    >
                      H
                    </button>

                    <button
                      type="button"
                      onClick={() => formatBioLines("- ", "List item")}
                      className={toolbarButtonClass}
                    >
                      List
                    </button>

                    <button
                      type="button"
                      onClick={() => formatBioLines("> ", "Quoted text")}
                      className={toolbarButtonClass}
                    >
                      Quote
                    </button>

                    <button
                      type="button"
                      onClick={insertBioLink}
                      className={toolbarButtonClass}
                    >
                      Link
                    </button>
                  </div>

                  <textarea
                    ref={bioTextareaRef}
                    value={form.bio ?? ""}
                    onChange={(event) => updateForm("bio", event.target.value)}
                    className="min-h-55 w-full resize-y bg-white px-3 py-3 text-sm font-normal leading-relaxed text-gray-800 outline-none"
                  />
                </div>

                <div className="mt-3 rounded-lg border border-gray-100 bg-gray-50 px-4 py-3">
                  <p className="mb-2 text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
                    Preview
                  </p>

                  {form.bio.trim() ? (
                    <BioText bio={form.bio} />
                  ) : (
                    <p className="text-sm text-gray-400">
                      Biography preview will appear here.
                    </p>
                  )}
                </div>
              </Field>

              <button
                type="submit"
                disabled={Boolean(loading)}
                className="w-full rounded-lg bg-(--color-flagblue) px-5 py-4 text-sm uppercase tracking-[0.18em] text-white transition disabled:cursor-not-allowed disabled:opacity-40"
              >
                {loading
                  ? "Processing..."
                  : selectedArtistId
                    ? "Update Artist Profile"
                    : "Create Artist"}
              </button>
            </form>
          </section>
        </main>
      </div>
    </div>
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

const toolbarButtonClass =
  "rounded-md border border-gray-200 bg-white px-2.5 py-1 text-xs font-normal text-gray-700 transition hover:border-(--color-flagblue) hover:text-(--color-flagblue)";
