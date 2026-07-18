"use client";

import Link from "next/link";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import type { FormEvent } from "react";
import { useTranslations } from "next-intl";
import BioText from "@/components/molecules/BioText";
import GenreMediaManager from "@/components/admin/GenreMediaManager";

type GenreRow = {
  id: string | number;
  name: string;
  description: string | null;
  history_en: string | null;
  history_es: string | null;
  slug: string;
  display_order: number | null;
  is_home_featured: boolean | null;
};

type SubgenreRow = {
  id: string | number;
  genre_id: string | number;
  name: string;
  description: string | null;
  history_en: string | null;
  history_es: string | null;
};

type GenreForm = {
  name: string;
  slug: string;
  description: string;
  history_en: string;
  history_es: string;
  display_order: string;
  is_home_featured: boolean;
};

type SubgenreForm = {
  name: string;
  description: string;
  history_en: string;
  history_es: string;
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

async function readAdminJson<T extends { ok?: boolean; error?: string }>(
  response: Response,
  fallbackMessage: string
): Promise<T> {
  const contentType = response.headers.get("content-type") ?? "";

  if (contentType.includes("application/json")) {
    return (await response.json()) as T;
  }

  return {
    ok: false,
    error: `${fallbackMessage} (${response.status} ${response.statusText})`,
  } as T;
}

const emptyGenreForm: GenreForm = {
  name: "",
  slug: "",
  description: "",
  history_en: "",
  history_es: "",
  display_order: "",
  is_home_featured: false,
};

const emptySubgenreForm: SubgenreForm = {
  name: "",
  description: "",
  history_en: "",
  history_es: "",
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
  const [selectedSubgenreId, setSelectedSubgenreId] = useState<string | number | null>(null);
  const [genreForm, setGenreForm] = useState<GenreForm>(emptyGenreForm);
  const [newSubgenreForm, setNewSubgenreForm] = useState<SubgenreForm>(emptySubgenreForm);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState(t("admin.status.loadingGenres"));

  const selectedGenre = useMemo(
    () => genres.find((genre) => String(genre.id) === String(selectedGenreId)) ?? null,
    [genres, selectedGenreId],
  );

  const selectedSubgenre = useMemo(
    () => subgenres.find((subgenre) => String(subgenre.id) === String(selectedSubgenreId)) ?? null,
    [selectedSubgenreId, subgenres],
  );
  const selectedSubgenreForm = selectedSubgenre
    ? subgenreForms[String(selectedSubgenre.id)] ?? emptySubgenreForm
    : null;

  const loadGenres = useCallback(async () => {
    setLoading(true);
    setStatus(t("admin.status.loadingGenres"));

    const response = await fetch("/api/admin/genres");
    const result = (await response.json()) as AdminGenresResponse;

    if (!response.ok || !result.ok) {
      setStatus(t("admin.errors.loadingGenres", { error: result.error || response.statusText }));
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
        setSelectedSubgenreId(null);
        return;
      }

      setStatus("Loading subgenres...");

      const response = await fetch(
        `/api/admin/subgenres?genreId=${encodeURIComponent(String(genreId))}`,
      );
      const result = await readAdminJson<AdminSubgenresResponse>(
        response,
        "Subgenres endpoint did not return JSON"
      );

      if (!response.ok || !result.ok) {
        setStatus(t("admin.errors.loadingSubgenres", { error: result.error || response.statusText }));
        return;
      }

      const rows = result.subgenres ?? [];

      setSubgenres(rows);
      setSelectedSubgenreId((current) =>
        rows.some((subgenre) => String(subgenre.id) === String(current)) ? current : null,
      );
      setSubgenreForms(
        Object.fromEntries(
          rows.map((subgenre) => [
            String(subgenre.id),
            {
              name: subgenre.name ?? "",
              description: subgenre.description ?? "",
              history_en: subgenre.history_en ?? "",
              history_es: subgenre.history_es ?? "",
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
    setSelectedSubgenreId(null);
    setGenreForm(emptyGenreForm);
    setSubgenres([]);
    setSubgenreForms({});
    setNewSubgenreForm(emptySubgenreForm);
    setStatus("");
  }

  function selectGenre(genre: GenreRow) {
    setSelectedGenreId(genre.id);
    setSelectedSubgenreId(null);
    setGenreForm({
      name: genre.name ?? "",
      slug: genre.slug ?? "",
      description: genre.description ?? "",
      history_en: genre.history_en ?? "",
      history_es: genre.history_es ?? "",
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
      history_en: nullable(genreForm.history_en),
      history_es: nullable(genreForm.history_es),
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
      setStatus(t("admin.errors.savingGenre", { error: result.error || response.statusText }));
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
          history_en: nullable(form.history_en),
          history_es: nullable(form.history_es),
        },
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(t("admin.errors.savingSubgenre", { error: result.error || response.statusText }));
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
          history_en: null,
          history_es: null,
        },
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(t("admin.errors.addingSubgenre", { error: result.error || response.statusText }));
      setLoading(false);
      return;
    }

    setNewSubgenreForm(emptySubgenreForm);
    await loadSubgenres(selectedGenreId);
    setSelectedSubgenreId(result.id ?? null);
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

            <div className="space-y-4">
              <Field label={t("admin.genres.selectGenreLabel")}>
                <select
                  value={selectedGenreId ?? ""}
                  onChange={(event) => {
                    const genre = genres.find(
                      (item) => String(item.id) === event.target.value,
                    );
                    if (genre) selectGenre(genre);
                    else resetGenreForm();
                  }}
                  className={inputClass}
                >
                  <option value="">{t("admin.genres.selectGenreOption")}</option>
                  {genres.map((genre) => (
                    <option key={genre.id} value={genre.id}>
                      {genre.name}
                    </option>
                  ))}
                </select>
              </Field>

              <Field label={t("admin.genres.selectSubgenreLabel")}>
                <select
                  value={selectedSubgenreId ?? ""}
                  onChange={(event) => {
                    if (!selectedGenreId) return;
                    setSelectedSubgenreId(event.target.value || null);
                  }}
                  className={inputClass}
                >
                  <option value="">{t("admin.genres.selectSubgenreOption")}</option>
                  {subgenres.map((subgenre) => (
                    <option key={subgenre.id} value={subgenre.id}>
                      {subgenre.name}
                    </option>
                  ))}
                </select>
              </Field>
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

              <form id="genre-form" onSubmit={saveGenre} className="space-y-4">
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
                    {selectedSubgenre ? (
                      <div className="rounded-xl border border-gray-100 bg-gray-50 p-4">
                        <div className="grid gap-3 md:grid-cols-[220px_1fr_auto] md:items-end">
                          <Field label={t("form.labels.name")}>
                            <input
                              value={
                                subgenreForms[String(selectedSubgenre.id)]?.name ?? ""
                              }
                              onChange={(event) =>
                                setSubgenreForms((current) => ({
                                  ...current,
                                  [String(selectedSubgenre.id)]: {
                                    ...(current[String(selectedSubgenre.id)] ?? emptySubgenreForm),
                                    name: event.target.value,
                                  },
                                }))
                              }
                              className={inputClass}
                            />
                          </Field>

                          <Field label={t("form.labels.description")}>
                            <input
                              value={
                                subgenreForms[String(selectedSubgenre.id)]?.description ?? ""
                              }
                              onChange={(event) =>
                                setSubgenreForms((current) => ({
                                  ...current,
                                  [String(selectedSubgenre.id)]: {
                                    ...(current[String(selectedSubgenre.id)] ?? emptySubgenreForm),
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
                            onClick={() => void saveSubgenre(selectedSubgenre)}
                            className="rounded-lg bg-[#002D62] px-4 py-2 text-sm font-medium text-white transition disabled:cursor-not-allowed disabled:opacity-50"
                          >
                            {t("admin.buttons.save")}
                          </button>
                        </div>
                      </div>
                    ) : subgenres.length ? (
                      <p className="rounded-xl border border-dashed border-gray-200 px-4 py-6 text-sm text-gray-500">
                        {t("admin.genres.selectSubgenreToEdit")}
                      </p>
                    ) : (
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

            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <h2 className="mb-5 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                {t("admin.genres.historyHeading")}
              </h2>

              {!selectedGenreId ? (
                <p className="rounded-xl border border-dashed border-gray-200 px-4 py-6 text-sm text-gray-500">
                  {t("admin.genres.selectGenreForHistory")}
                </p>
              ) : (
                <div className="space-y-6">
                  <RichTextEditor
                    label={t("admin.genres.historyEnglish")}
                    value={selectedSubgenreForm?.history_en ?? genreForm.history_en}
                    onChange={(history_en) => {
                      if (selectedSubgenre) {
                        setSubgenreForms((current) => ({
                          ...current,
                          [String(selectedSubgenre.id)]: {
                            ...(current[String(selectedSubgenre.id)] ?? emptySubgenreForm),
                            history_en,
                          },
                        }));
                      } else setGenreForm((current) => ({ ...current, history_en }));
                    }}
                    previewLabel={t("admin.genres.historyPreview")}
                  />
                  <RichTextEditor
                    label={t("admin.genres.historySpanish")}
                    value={selectedSubgenreForm?.history_es ?? genreForm.history_es}
                    onChange={(history_es) => {
                      if (selectedSubgenre) {
                        setSubgenreForms((current) => ({
                          ...current,
                          [String(selectedSubgenre.id)]: {
                            ...(current[String(selectedSubgenre.id)] ?? emptySubgenreForm),
                            history_es,
                          },
                        }));
                      } else setGenreForm((current) => ({ ...current, history_es }));
                    }}
                    previewLabel={t("admin.genres.historyPreview")}
                  />
                  <button
                    type="button"
                    disabled={loading}
                    onClick={() => {
                      if (selectedSubgenre) void saveSubgenre(selectedSubgenre);
                      else (document.getElementById("genre-form") as HTMLFormElement | null)?.requestSubmit();
                    }}
                    className="rounded-lg bg-[#002D62] px-5 py-3 text-sm font-medium uppercase tracking-[0.16em] text-white transition disabled:cursor-not-allowed disabled:opacity-50"
                  >
                    {t("admin.genres.saveHistory")}
                  </button>
                </div>
              )}
            </section>

            {(selectedSubgenre ?? selectedGenre) && (
              <GenreMediaManager
                key={String(selectedSubgenre?.id ?? selectedGenre?.id)}
                genreId={selectedSubgenre?.id ?? selectedGenre!.id}
                genreName={selectedSubgenre?.name ?? selectedGenre!.name}
              />
            )}
          </div>
        </div>
      </div>
    </main>
  );
}

function RichTextEditor({
  label,
  value,
  onChange,
  previewLabel,
}: {
  label: string;
  value: string;
  onChange: (value: string) => void;
  previewLabel: string;
}) {
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  const wrapSelection = (prefix: string, suffix = "", placeholder = "Text") => {
    const textarea = textareaRef.current;
    if (!textarea) return;
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const selected = value.slice(start, end) || placeholder;
    const next = `${value.slice(0, start)}${prefix}${selected}${suffix}${value.slice(end)}`;
    onChange(next);
    requestAnimationFrame(() => {
      textarea.focus();
      textarea.setSelectionRange(start + prefix.length, start + prefix.length + selected.length);
    });
  };

  const formatLines = (prefix: string, placeholder: string) => {
    const textarea = textareaRef.current;
    if (!textarea) return;
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const selected = value.slice(start, end) || placeholder;
    const formatted = selected
      .split("\n")
      .map((line) => `${prefix}${line}`)
      .join("\n");
    onChange(`${value.slice(0, start)}${formatted}${value.slice(end)}`);
  };

  return (
    <div className="overflow-hidden rounded-xl border border-gray-200">
      <div className="border-b border-gray-200 bg-gray-50 px-4 py-3">
        <p className="text-xs font-semibold uppercase tracking-[0.16em] text-[#002D62]">{label}</p>
        <div className="mt-3 flex flex-wrap gap-2">
          <EditorButton label="H2" onClick={() => formatLines("## ", "Section title")} />
          <EditorButton label="Bold" onClick={() => wrapSelection("**", "**")} />
          <EditorButton label="Italic" onClick={() => wrapSelection("*", "*")} />
          <EditorButton label="List" onClick={() => formatLines("- ", "List item")} />
          <EditorButton label="Quote" onClick={() => formatLines("> ", "Quoted text")} />
          <EditorButton
            label="Link"
            onClick={() => wrapSelection("[", "](https://example.com)", "Link text")}
          />
        </div>
      </div>
      <textarea
        ref={textareaRef}
        value={value}
        onChange={(event) => onChange(event.target.value)}
        className="min-h-64 w-full resize-y px-4 py-3 text-sm leading-relaxed text-gray-800 outline-none"
      />
      <div className="border-t border-gray-200 bg-gray-50 px-4 py-4">
        <p className="mb-3 text-[10px] font-medium uppercase tracking-[0.18em] text-gray-400">
          {previewLabel}
        </p>
        {value.trim() ? <BioText bio={value} /> : <p className="text-sm text-gray-400">—</p>}
      </div>
    </div>
  );
}

function EditorButton({ label, onClick }: { label: string; onClick: () => void }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="rounded-md border border-gray-200 bg-white px-3 py-1.5 text-xs font-medium text-[#002D62] transition hover:border-[#002D62]/30 hover:bg-[#002D62]/5"
    >
      {label}
    </button>
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
