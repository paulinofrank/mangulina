"use client";

import Link from "next/link";
import { useCallback, useEffect, useMemo, useState } from "react";
import type { FormEvent } from "react";
import { useTranslations } from "next-intl";

type GenreRow = {
  id: string | number;
  name: string;
  description: string | null;
  slug: string;
  display_order: number | null;
  is_home_featured: boolean | null;
};

type SubgenreRow = {
  id: string | number;
  genre_id: string | number;
  name: string;
  description: string | null;
};

type GenreForm = {
  name: string;
  slug: string;
  description: string;
  display_order: string;
  is_home_featured: boolean;
};

type SubgenreForm = {
  name: string;
  description: string;
};

type AdminGenresResponse = {
  ok: boolean;
  genres?: GenreRow[];
  error?: string;
};

type AdminSubgenresResponse = {
  ok: boolean;
  subgenres?: SubgenreRow[];
  error?: string;
};

type AdminWriteResponse = {
  ok: boolean;
  id?: string | number;
  error?: string;
};

const emptyGenreForm: GenreForm = {
  name: "",
  slug: "",
  description: "",
  display_order: "",
  is_home_featured: false,
};

const emptySubgenreForm: SubgenreForm = {
  name: "",
  description: "",
};

function slugify(value: string) {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

function nullable(value: string) {
  const trimmed = value.trim();
  return trimmed ? trimmed : null;
}

function sortGenres(genres: GenreRow[]) {
  return genres.slice().sort((a, b) => {
    const orderA = a.display_order ?? Number.MAX_SAFE_INTEGER;
    const orderB = b.display_order ?? Number.MAX_SAFE_INTEGER;

    return orderA - orderB || a.name.localeCompare(b.name);
  });
}

export default function AdminGenresPage() {
  const t = useTranslations();
  const [genres, setGenres] = useState<GenreRow[]>([]);
  const [subgenres, setSubgenres] = useState<SubgenreRow[]>([]);
  const [subgenreForms, setSubgenreForms] = useState<Record<string, SubgenreForm>>({});
  const [selectedGenreId, setSelectedGenreId] = useState<string | number | null>(null);
  const [genreForm, setGenreForm] = useState<GenreForm>(emptyGenreForm);
  const [newSubgenreForm, setNewSubgenreForm] = useState<SubgenreForm>(emptySubgenreForm);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState(t("admin.status.loadingGenres"));

  const selectedGenre = useMemo(
    () => genres.find((genre) => String(genre.id) === String(selectedGenreId)) ?? null,
    [genres, selectedGenreId],
  );

  const filteredGenres = useMemo(() => {
    const query = search.trim().toLowerCase();

    if (!query) return genres;

    return genres.filter((genre) =>
      [genre.name, genre.slug, genre.description]
        .filter(Boolean)
        .some((value) => String(value).toLowerCase().includes(query)),
    );
  }, [genres, search]);

  const loadGenres = useCallback(async () => {
    setLoading(true);
    setStatus(t("admin.status.loadingGenres"));

    const response = await fetch("/api/admin/genres");
    const result = (await response.json()) as AdminGenresResponse;

    if (!response.ok || !result.ok) {
      setStatus(`${t("admin.errors.loadingGenres").replace("{error}", result.error || response.statusText)}`);
      setLoading(false);
      return;
    }

    setGenres(sortGenres(result.genres ?? []));
    setStatus("");
    setLoading(false);
  }, [t]);

  const loadSubgenres = useCallback(
    async (genreId: string | number | null) => {
      if (!genreId) {
        setSubgenres([]);
        setSubgenreForms({});
        return;
      }

      setStatus("Loading subgenres...");

      const response = await fetch(
        `/api/admin/subgenres?genreId=${encodeURIComponent(String(genreId))}`,
      );
      const result = (await response.json()) as AdminSubgenresResponse;

      if (!response.ok || !result.ok) {
        setStatus(`${t("admin.errors.loadingSubgenres").replace("{error}", result.error || response.statusText)}`);
        return;
      }

      const rows = result.subgenres ?? [];

      setSubgenres(rows);
      setSubgenreForms(
        Object.fromEntries(
          rows.map((subgenre) => [
            String(subgenre.id),
            {
              name: subgenre.name ?? "",
              description: subgenre.description ?? "",
            },
          ]),
        ),
      );
      setStatus("");
    },
    [t],
  );

  useEffect(() => {
    void loadGenres();
  }, [loadGenres]);

  useEffect(() => {
    void loadSubgenres(selectedGenreId);
  }, [loadSubgenres, selectedGenreId]);

  function resetGenreForm() {
    setSelectedGenreId(null);
    setGenreForm(emptyGenreForm);
    setSubgenres([]);
    setSubgenreForms({});
    setNewSubgenreForm(emptySubgenreForm);
    setStatus("");
  }

  function selectGenre(genre: GenreRow) {
    setSelectedGenreId(genre.id);
    setGenreForm({
      name: genre.name ?? "",
      slug: genre.slug ?? "",
      description: genre.description ?? "",
      display_order: genre.display_order == null ? "" : String(genre.display_order),
      is_home_featured: Boolean(genre.is_home_featured),
    });
    setNewSubgenreForm(emptySubgenreForm);
    setStatus("");
  }

  function updateGenreName(name: string) {
    setGenreForm((current) => ({
      ...current,
      name,
      slug: !selectedGenreId && !current.slug.trim() ? slugify(name) : current.slug,
    }));
  }

  async function saveGenre(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!genreForm.name.trim()) {
      setStatus(t("admin.genres.nameRequired"));
      return;
    }

    const payload = {
      name: genreForm.name.trim(),
      slug: genreForm.slug.trim() || slugify(genreForm.name),
      description: nullable(genreForm.description),
      display_order: genreForm.display_order.trim()
        ? Number(genreForm.display_order)
        : null,
      is_home_featured: genreForm.is_home_featured,
    };

    setLoading(true);
    setStatus(t("admin.status.savingGenre"));

    const response = await fetch("/api/admin/genres", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        genreId: selectedGenreId,
        genreData: payload,
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`${t("admin.errors.savingGenre").replace("{error}", result.error || response.statusText)}`);
      setLoading(false);
      return;
    }

    const savedId = result.id ?? selectedGenreId;

    await loadGenres();
    setSelectedGenreId(savedId ?? null);
    setStatus(t("admin.status.genreSaved"));
    setLoading(false);
  }

  async function saveSubgenre(subgenre: SubgenreRow) {
    const form = subgenreForms[String(subgenre.id)];

    if (!form?.name.trim()) {
      setStatus(t("admin.genres.subgenreNameRequired"));
      return;
    }

    setLoading(true);
    setStatus(t("admin.status.savingSubgenre"));

    const response = await fetch("/api/admin/subgenres", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        subgenreId: subgenre.id,
        subgenreData: {
        name: form.name.trim(),
        description: nullable(form.description),
        },
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`${t("admin.errors.savingSubgenre").replace("{error}", result.error || response.statusText)}`);
      setLoading(false);
      return;
    }

    await loadSubgenres(selectedGenreId);
    setStatus(t("admin.status.subgenreSaved"));
    setLoading(false);
  }

  async function addSubgenre(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!selectedGenreId) {
      setStatus(t("admin.genres.selectGenreFirst"));
      return;
    }

    if (!newSubgenreForm.name.trim()) {
      setStatus(t("admin.genres.subgenreNameRequired"));
      return;
    }

    setLoading(true);
    setStatus("Adding subgenre...");

    const response = await fetch("/api/admin/subgenres", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        subgenreId: null,
        subgenreData: {
        genre_id: selectedGenreId,
        name: newSubgenreForm.name.trim(),
        description: nullable(newSubgenreForm.description),
        },
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`${t("admin.errors.addingSubgenre").replace("{error}", result.error || response.statusText)}`);
      setLoading(false);
      return;
    }

    setNewSubgenreForm(emptySubgenreForm);
    await loadSubgenres(selectedGenreId);
    setStatus(t("admin.status.subgenreSaved"));
    setLoading(false);
  }

  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-8 font-sans text-gray-900 sm:px-6 sm:pb-12 sm:pt-10">
      <div className="mx-auto max-w-6xl">
        <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
                {t("admin.ui.branding")}
              </p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
                {t("admin.genres.title")}
              </h1>
              <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
                {t("admin.genres.description")}
              </p>
            </div>

            <Link
              href="/admin"
              className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-[#002D62] shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126]"
            >
              {t("admin.navigation.portal")}
            </Link>
          </div>
        </header>

        {status && (
          <div className="mb-6 rounded-xl border border-gray-200 bg-white px-4 py-3 text-sm text-gray-700 shadow-sm">
            {status}
          </div>
        )}

        <div className="grid gap-6 lg:grid-cols-[340px_1fr]">
          <aside className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
            <div className="mb-4 flex items-center justify-between gap-3">
              <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                {t("admin.genres.listHeading")}
              </h2>
              <button
                type="button"
                onClick={resetGenreForm}
                className="rounded-lg border border-gray-200 bg-white px-3 py-2 text-xs font-medium uppercase tracking-[0.14em] text-[#002D62] transition hover:border-[#CE1126] hover:text-[#CE1126]"
              >
                {t("admin.buttons.new")}
              </button>
            </div>

            <input
              value={search}
              onChange={(event) => setSearch(event.target.value)}
              placeholder={t("admin.genres.searchPlaceholder")}
              className={inputClass}
            />

            <div className="mt-4 max-h-170 space-y-2 overflow-y-auto pr-1">
              {filteredGenres.map((genre) => (
                <button
                  key={genre.id}
                  type="button"
                  onClick={() => selectGenre(genre)}
                  className={`w-full rounded-xl border px-4 py-3 text-left transition ${
                    String(selectedGenreId) === String(genre.id)
                      ? "border-[#CE1126]/40 bg-[#CE1126]/5"
                      : "border-gray-100 bg-white hover:border-[#002D62]/20"
                  }`}
                >
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <p className="font-medium text-[#002D62]">{genre.name}</p>
                      <p className="mt-1 text-xs text-gray-500">{genre.slug}</p>
                    </div>
                    {genre.is_home_featured && (
                      <span className="rounded-full bg-[#CE1126]/10 px-2 py-1 text-[10px] font-medium uppercase tracking-[0.12em] text-[#CE1126]">
                        {t("admin.genres.homeFeatured")}
                      </span>
                    )}
                  </div>
                  <p className="mt-2 text-xs text-gray-500">
                    {t("admin.genres.displayOrder").replace("{order}", String(genre.display_order ?? "None"))}
                  </p>
                </button>
              ))}

              {!filteredGenres.length && (
                <p className="rounded-xl border border-dashed border-gray-200 px-4 py-6 text-center text-sm text-gray-500">
                  {t("admin.genres.noGenres")}
                </p>
              )}
            </div>
          </aside>

          <div className="space-y-6">
            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <div className="mb-5 flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
                <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                  {selectedGenre ? t("admin.genres.editHeading") : t("admin.genres.createHeading")}
                </h2>
                <button
                  type="button"
                  onClick={() =>
                    setGenreForm((current) => ({
                      ...current,
                      slug: slugify(current.name),
                    }))
                  }
                  className="w-fit rounded-lg border border-gray-200 bg-white px-3 py-2 text-xs font-medium uppercase tracking-[0.14em] text-[#002D62] transition hover:border-[#CE1126] hover:text-[#CE1126]"
                >
                  {t("admin.buttons.generateSlug")}
                </button>
              </div>

              <form onSubmit={saveGenre} className="space-y-4">
                <div className="grid gap-4 md:grid-cols-2">
                  <Field label={t("form.labels.genreName")}>
                    <input
                      value={genreForm.name}
                      onChange={(event) => updateGenreName(event.target.value)}
                      className={inputClass}
                      required
                    />
                  </Field>

                  <Field label={t("form.labels.slug")}>
                    <input
                      value={genreForm.slug}
                      onChange={(event) =>
                        setGenreForm((current) => ({
                          ...current,
                          slug: event.target.value,
                        }))
                      }
                      className={inputClass}
                    />
                  </Field>
                </div>

                <Field label={t("form.labels.description")}>
                  <textarea
                    value={genreForm.description}
                    onChange={(event) =>
                      setGenreForm((current) => ({
                        ...current,
                        description: event.target.value,
                      }))
                    }
                    className={`${inputClass} min-h-32 resize-y leading-relaxed`}
                  />
                </Field>

                <div className="grid gap-4 md:grid-cols-[1fr_auto]">
                  <Field label={t("form.labels.displayOrder")}>
                    <input
                      type="number"
                      value={genreForm.display_order}
                      onChange={(event) =>
                        setGenreForm((current) => ({
                          ...current,
                          display_order: event.target.value,
                        }))
                      }
                      className={inputClass}
                    />
                  </Field>

                  <label className="flex items-end gap-3 rounded-lg border border-gray-100 bg-gray-50 px-4 py-3 text-sm text-gray-700">
                    <input
                      type="checkbox"
                      checked={genreForm.is_home_featured}
                      onChange={(event) =>
                        setGenreForm((current) => ({
                          ...current,
                          is_home_featured: event.target.checked,
                        }))
                      }
                      className="h-4 w-4"
                    />
                    {t("form.labels.homeFeatured")}
                  </label>
                </div>

                <div className="flex flex-wrap gap-3">
                  <button
                    type="submit"
                    disabled={loading}
                    className="rounded-lg bg-[#002D62] px-5 py-3 text-sm font-medium uppercase tracking-[0.16em] text-white transition disabled:cursor-not-allowed disabled:opacity-50"
                  >
                    {t("admin.buttons.saveGenre")}
                  </button>
                  <button
                    type="button"
                    onClick={resetGenreForm}
                    className="rounded-lg border border-gray-200 bg-white px-5 py-3 text-sm font-medium uppercase tracking-[0.16em] text-[#002D62] transition hover:border-[#CE1126] hover:text-[#CE1126]"
                  >
                    {t("admin.buttons.resetForm")}
                  </button>
                </div>
              </form>
            </section>

            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <h2 className="mb-5 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                {t("admin.genres.subgenresHeading")}
              </h2>

              {!selectedGenreId ? (
                <p className="rounded-xl border border-dashed border-gray-200 px-4 py-6 text-sm text-gray-500">
                  {t("admin.genres.selectGenreFirst")}
                </p>
              ) : (
                <div className="space-y-5">
                  <div className="space-y-3">
                    {subgenres.map((subgenre) => {
                      const form = subgenreForms[String(subgenre.id)] ?? emptySubgenreForm;

                      return (
                        <div
                          key={subgenre.id}
                          className="rounded-xl border border-gray-100 bg-gray-50 p-4"
                        >
                          <div className="grid gap-3 md:grid-cols-[220px_1fr_auto] md:items-end">
                            <Field label={t("form.labels.name")}>
                              <input
                                value={form.name}
                                onChange={(event) =>
                                  setSubgenreForms((current) => ({
                                    ...current,
                                    [String(subgenre.id)]: {
                                      ...form,
                                      name: event.target.value,
                                    },
                                  }))
                                }
                                className={inputClass}
                              />
                            </Field>

                            <Field label={t("form.labels.description")}>
                              <input
                                value={form.description}
                                onChange={(event) =>
                                  setSubgenreForms((current) => ({
                                    ...current,
                                    [String(subgenre.id)]: {
                                      ...form,
                                      description: event.target.value,
                                    },
                                  }))
                                }
                                className={inputClass}
                              />
                            </Field>

                            <button
                              type="button"
                              disabled={loading}
                              onClick={() => void saveSubgenre(subgenre)}
                              className="rounded-lg bg-[#002D62] px-4 py-2 text-sm font-medium text-white transition disabled:cursor-not-allowed disabled:opacity-50"
                            >
                              {t("admin.buttons.save")}
                            </button>
                          </div>
                        </div>
                      );
                    })}

                    {!subgenres.length && (
                      <p className="rounded-xl border border-dashed border-gray-200 px-4 py-6 text-sm text-gray-500">
                        {t("admin.genres.noSubgenres")}
                      </p>
                    )}
                  </div>

                  <form
                    onSubmit={addSubgenre}
                    className="rounded-xl border border-[#002D62]/10 bg-[#002D62]/5 p-4"
                  >
                    <h3 className="mb-3 text-xs font-medium uppercase tracking-[0.18em] text-[#002D62]">
                      {t("admin.genres.addSubgenreHeading")}
                    </h3>
                    <div className="grid gap-3 md:grid-cols-[220px_1fr_auto] md:items-end">
                      <Field label={t("form.labels.name")}>
                        <input
                          value={newSubgenreForm.name}
                          onChange={(event) =>
                            setNewSubgenreForm((current) => ({
                              ...current,
                              name: event.target.value,
                            }))
                          }
                          className={inputClass}
                        />
                      </Field>

                      <Field label={t("form.labels.description")}>
                        <input
                          value={newSubgenreForm.description}
                          onChange={(event) =>
                            setNewSubgenreForm((current) => ({
                              ...current,
                              description: event.target.value,
                            }))
                          }
                          className={inputClass}
                        />
                      </Field>

                      <button
                        type="submit"
                        disabled={loading}
                        className="rounded-lg bg-[#CE1126] px-4 py-2 text-sm font-medium text-white transition disabled:cursor-not-allowed disabled:opacity-50"
                      >
                        {t("admin.buttons.add")}
                      </button>
                    </div>
                  </form>
                </div>
              )}
            </section>
          </div>
        </div>
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
    <label className="block">
      <span className="mb-1 block text-[10px] font-medium uppercase tracking-[0.18em] text-gray-400">
        {label}
      </span>
      {children}
    </label>
  );
}

const inputClass =
  "w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm text-gray-800 outline-none transition focus:border-[#002D62]";
