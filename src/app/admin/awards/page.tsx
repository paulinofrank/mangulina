"use client";

import Link from "next/link";
import { useCallback, useEffect, useMemo, useState } from "react";
import type { FormEvent } from "react";
import { getSupabaseClient } from "@/lib/supabase";

type AdminTab = "awards" | "categories" | "artist-awards";

type AwardRow = {
  id: string;
  name: string;
  organization: string | null;
  country: string | null;
  description: string | null;
  created_at?: string | null;
  updated_at?: string | null;
};

type AwardCategoryRow = {
  id: string;
  award_id: string;
  name: string;
  description: string | null;
  created_at?: string | null;
  updated_at?: string | null;
};

type ArtistRow = {
  id: string;
  name: string;
  slug: string | null;
  status: string | null;
};

type AwardRelation = {
  id: string;
  name: string;
  organization: string | null;
  country: string | null;
};

type AwardCategoryRelation = {
  id: string;
  name: string;
};

type ArtistAwardRow = {
  id: string;
  artist_id: string;
  award_id: string;
  category_id: string | null;
  year: number | null;
  work: string | null;
  won: boolean;
  source: string | null;
  awards?: AwardRelation | AwardRelation[] | null;
  award_categories?: AwardCategoryRelation | AwardCategoryRelation[] | null;
};

type AwardForm = {
  name: string;
  organization: string;
  country: string;
  description: string;
};

type CategoryForm = {
  award_id: string;
  name: string;
  description: string;
};

type ArtistAwardForm = {
  artist_id: string;
  award_id: string;
  category_id: string;
  year: string;
  work: string;
  won: boolean;
  source: string;
};

const emptyAwardForm: AwardForm = {
  name: "",
  organization: "",
  country: "",
  description: "",
};

const emptyCategoryForm: CategoryForm = {
  award_id: "",
  name: "",
  description: "",
};

const emptyArtistAwardForm: ArtistAwardForm = {
  artist_id: "",
  award_id: "",
  category_id: "",
  year: "",
  work: "",
  won: true,
  source: "",
};

function nullable(value: string | null | undefined) {
  const trimmed = (value ?? "").trim();
  return trimmed ? trimmed : null;
}

function firstRelation<T>(value: T | T[] | null | undefined) {
  if (Array.isArray(value)) return value[0] ?? null;
  return value ?? null;
}

export default function AdminAwardsPage() {
  const supabase = getSupabaseClient();

  const [activeTab, setActiveTab] = useState<AdminTab>("awards");
  const [awards, setAwards] = useState<AwardRow[]>([]);
  const [allCategories, setAllCategories] = useState<AwardCategoryRow[]>([]);
  const [categories, setCategories] = useState<AwardCategoryRow[]>([]);
  const [artists, setArtists] = useState<ArtistRow[]>([]);
  const [artistAwards, setArtistAwards] = useState<ArtistAwardRow[]>([]);

  const [selectedAwardId, setSelectedAwardId] = useState("");
  const [selectedCategoryId, setSelectedCategoryId] = useState("");
  const [selectedCategoryAwardId, setSelectedCategoryAwardId] = useState("");
  const [selectedArtistAwardId, setSelectedArtistAwardId] = useState("");
  const [selectedArtistId, setSelectedArtistId] = useState("");

  const [awardForm, setAwardForm] = useState<AwardForm>(emptyAwardForm);
  const [categoryForm, setCategoryForm] = useState<CategoryForm>(emptyCategoryForm);
  const [artistAwardForm, setArtistAwardForm] =
    useState<ArtistAwardForm>(emptyArtistAwardForm);

  const [awardSearch, setAwardSearch] = useState("");
  const [artistSearch, setArtistSearch] = useState("");
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("Loading awards...");

  const filteredAwards = useMemo(() => {
    const query = awardSearch.trim().toLowerCase();

    if (!query) return awards;

    return awards.filter((award) =>
      [award.name, award.organization, award.country, award.description]
        .filter(Boolean)
        .some((value) => String(value).toLowerCase().includes(query)),
    );
  }, [awards, awardSearch]);

  const filteredArtists = useMemo(() => {
    const query = artistSearch.trim().toLowerCase();

    if (!query) return artists.slice(0, 120);

    return artists
      .filter((artist) =>
        [artist.name, artist.slug, artist.status]
          .filter(Boolean)
          .some((value) => String(value).toLowerCase().includes(query)),
      )
      .slice(0, 120);
  }, [artists, artistSearch]);

  const artistAwardCategories = useMemo(
    () =>
      allCategories.filter(
        (category) => category.award_id === artistAwardForm.award_id,
      ),
    [allCategories, artistAwardForm.award_id],
  );

  const loadAwards = useCallback(async () => {
    setLoading(true);
    setStatus("Loading awards...");

    const { data, error } = await supabase
      .from("awards")
      .select("id,name,organization,country,description,created_at,updated_at")
      .order("name", { ascending: true });

    if (error) {
      setStatus(`Error loading awards: ${error.message}`);
      setLoading(false);
      return;
    }

    setAwards((data ?? []) as AwardRow[]);
    setStatus("");
    setLoading(false);
  }, [supabase]);

  const loadAllCategories = useCallback(async () => {
    const { data, error } = await supabase
      .from("award_categories")
      .select("id,award_id,name,description,created_at,updated_at")
      .order("name", { ascending: true });

    if (error) {
      setStatus(`Error loading categories: ${error.message}`);
      return;
    }

    setAllCategories((data ?? []) as AwardCategoryRow[]);
  }, [supabase]);

  const loadArtists = useCallback(async () => {
    const { data, error } = await supabase
      .from("artists")
      .select("id,name,slug,status")
      .order("name", { ascending: true });

    if (error) {
      setStatus(`Error loading artists: ${error.message}`);
      return;
    }

    setArtists((data ?? []) as ArtistRow[]);
  }, [supabase]);

  const loadCategoriesForAward = useCallback(
    async (awardId: string) => {
      if (!awardId) {
        setCategories([]);
        return;
      }

      setStatus("Loading categories...");

      const { data, error } = await supabase
        .from("award_categories")
        .select("id,award_id,name,description,created_at,updated_at")
        .eq("award_id", awardId)
        .order("name", { ascending: true });

      if (error) {
        setStatus(`Error loading categories: ${error.message}`);
        return;
      }

      setCategories((data ?? []) as AwardCategoryRow[]);
      setStatus("");
    },
    [supabase],
  );

  const loadArtistAwards = useCallback(
    async (artistId: string) => {
      if (!artistId) {
        setArtistAwards([]);
        return;
      }

      setStatus("Loading artist awards...");

      const { data, error } = await supabase
        .from("artist_awards")
        .select(
          `
          id,
          artist_id,
          award_id,
          category_id,
          year,
          work,
          won,
          source,
          awards (
            id,
            name,
            organization,
            country
          ),
          award_categories (
            id,
            name
          )
        `,
        )
        .eq("artist_id", artistId)
        .order("year", { ascending: false, nullsFirst: false });

      if (error) {
        setStatus(`Error loading artist awards: ${error.message}`);
        return;
      }

      setArtistAwards((data ?? []) as ArtistAwardRow[]);
      setStatus("");
    },
    [supabase],
  );

  useEffect(() => {
    void loadAwards();
    void loadAllCategories();
    void loadArtists();
  }, [loadAllCategories, loadArtists, loadAwards]);

  useEffect(() => {
    void loadCategoriesForAward(selectedCategoryAwardId);
  }, [loadCategoriesForAward, selectedCategoryAwardId]);

  useEffect(() => {
    void loadArtistAwards(selectedArtistId);
  }, [loadArtistAwards, selectedArtistId]);

  function resetAwardForm() {
    setSelectedAwardId("");
    setAwardForm(emptyAwardForm);
    setStatus("");
  }

  function selectAward(award: AwardRow) {
    setSelectedAwardId(award.id);
    setAwardForm({
      name: award.name ?? "",
      organization: award.organization ?? "",
      country: award.country ?? "",
      description: award.description ?? "",
    });
    setStatus("");
  }

  async function saveAward(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!awardForm.name.trim()) {
      setStatus("Award name is required.");
      return;
    }

    setLoading(true);
    setStatus("Saving award...");

    const payload = {
      name: awardForm.name.trim(),
      organization: nullable(awardForm.organization),
      country: nullable(awardForm.country),
      description: nullable(awardForm.description),
    };

    const response = selectedAwardId
      ? await supabase
          .from("awards")
          .update(payload)
          .eq("id", selectedAwardId)
          .select("id")
          .maybeSingle()
      : await supabase.from("awards").insert([payload]).select("id").maybeSingle();

    if (response.error) {
      setStatus(`Error saving award: ${response.error.message}`);
      setLoading(false);
      return;
    }

    await loadAwards();
    setSelectedAwardId(response.data?.id ?? selectedAwardId);
    setStatus("Award saved.");
    setLoading(false);
  }

  function resetCategoryForm() {
    setSelectedCategoryId("");
    setCategoryForm({
      ...emptyCategoryForm,
      award_id: selectedCategoryAwardId,
    });
    setStatus("");
  }

  function selectCategory(category: AwardCategoryRow) {
    setSelectedCategoryId(category.id);
    setSelectedCategoryAwardId(category.award_id);
    setCategoryForm({
      award_id: category.award_id,
      name: category.name ?? "",
      description: category.description ?? "",
    });
    setStatus("");
  }

  async function saveCategory(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!categoryForm.award_id) {
      setStatus("Award is required for a category.");
      return;
    }

    if (!categoryForm.name.trim()) {
      setStatus("Category name is required.");
      return;
    }

    setLoading(true);
    setStatus("Saving category...");

    const payload = {
      award_id: categoryForm.award_id,
      name: categoryForm.name.trim(),
      description: nullable(categoryForm.description),
    };

    const response = selectedCategoryId
      ? await supabase
          .from("award_categories")
          .update(payload)
          .eq("id", selectedCategoryId)
          .select("id")
          .maybeSingle()
      : await supabase
          .from("award_categories")
          .insert([payload])
          .select("id")
          .maybeSingle();

    if (response.error) {
      setStatus(`Error saving category: ${response.error.message}`);
      setLoading(false);
      return;
    }

    setSelectedCategoryAwardId(categoryForm.award_id);
    await loadCategoriesForAward(categoryForm.award_id);
    await loadAllCategories();
    setSelectedCategoryId(response.data?.id ?? selectedCategoryId);
    setStatus("Category saved.");
    setLoading(false);
  }

  function updateArtistSelection(artistId: string) {
    setSelectedArtistId(artistId);
    setArtistAwardForm((current) => ({
      ...current,
      artist_id: artistId,
    }));
    setSelectedArtistAwardId("");
  }

  function resetArtistAwardForm() {
    setSelectedArtistAwardId("");
    setArtistAwardForm({
      ...emptyArtistAwardForm,
      artist_id: selectedArtistId,
    });
    setStatus("");
  }

  function selectArtistAward(artistAward: ArtistAwardRow) {
    setSelectedArtistAwardId(artistAward.id);
    setSelectedArtistId(artistAward.artist_id);
    setArtistAwardForm({
      artist_id: artistAward.artist_id,
      award_id: artistAward.award_id,
      category_id: artistAward.category_id ?? "",
      year: artistAward.year == null ? "" : String(artistAward.year),
      work: artistAward.work ?? "",
      won: Boolean(artistAward.won),
      source: artistAward.source ?? "",
    });
    setActiveTab("artist-awards");
    setStatus("");
  }

  async function saveArtistAward(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!artistAwardForm.artist_id) {
      setStatus("Artist is required.");
      return;
    }

    if (!artistAwardForm.award_id) {
      setStatus("Award is required.");
      return;
    }

    setLoading(true);
    setStatus("Saving artist award...");

    const payload = {
      artist_id: artistAwardForm.artist_id,
      award_id: artistAwardForm.award_id,
      category_id: artistAwardForm.category_id || null,
      year: artistAwardForm.year ? Number(artistAwardForm.year) : null,
      work: nullable(artistAwardForm.work),
      won: artistAwardForm.won,
      source: nullable(artistAwardForm.source),
    };

    const response = selectedArtistAwardId
      ? await supabase
          .from("artist_awards")
          .update(payload)
          .eq("id", selectedArtistAwardId)
          .select("id")
          .maybeSingle()
      : await supabase
          .from("artist_awards")
          .insert([payload])
          .select("id")
          .maybeSingle();

    if (response.error) {
      setStatus(`Error saving artist award: ${response.error.message}`);
      setLoading(false);
      return;
    }

    await loadArtistAwards(artistAwardForm.artist_id);
    setSelectedArtistId(artistAwardForm.artist_id);
    setSelectedArtistAwardId(response.data?.id ?? selectedArtistAwardId);
    setStatus("Artist award saved.");
    setLoading(false);
  }

  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-8 font-sans text-gray-900 sm:px-6 sm:pb-12 sm:pt-10">
      <div className="mx-auto max-w-6xl">
        <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
                Mangulina Admin
              </p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
                Awards Manager
              </h1>
              <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
                Manage awards, categories, and artist awards/nominations.
              </p>
            </div>

            <Link
              href="/admin"
              className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-[#002D62] shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126]"
            >
              Admin Portal
            </Link>
          </div>
        </header>

        <div className="mb-6 flex flex-wrap gap-2">
          {[
            { id: "awards", label: "Awards" },
            { id: "categories", label: "Categories" },
            { id: "artist-awards", label: "Artist Awards" },
          ].map((tab) => (
            <button
              key={tab.id}
              type="button"
              onClick={() => setActiveTab(tab.id as AdminTab)}
              className={`rounded-lg border px-4 py-2 text-xs font-medium uppercase tracking-[0.16em] transition ${
                activeTab === tab.id
                  ? "border-[#CE1126]/40 bg-[#CE1126]/10 text-[#CE1126]"
                  : "border-gray-200 bg-white text-[#002D62] hover:border-[#CE1126]/40 hover:text-[#CE1126]"
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>

        {status && (
          <div className="mb-6 rounded-xl border border-gray-200 bg-white px-4 py-3 text-sm text-gray-700 shadow-sm">
            {status}
          </div>
        )}

        {activeTab === "awards" && (
          <div className="grid gap-6 lg:grid-cols-[360px_1fr]">
            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <div className="mb-4 flex items-center justify-between gap-3">
                <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                  Awards
                </h2>
                <button
                  type="button"
                  onClick={resetAwardForm}
                  className={secondaryButtonClass}
                >
                  New
                </button>
              </div>

              <input
                value={awardSearch}
                onChange={(event) => setAwardSearch(event.target.value)}
                placeholder="Search awards..."
                className={inputClass}
              />

              <div className="mt-4 max-h-[680px] space-y-2 overflow-y-auto pr-1">
                {filteredAwards.map((award) => (
                  <button
                    key={award.id}
                    type="button"
                    onClick={() => selectAward(award)}
                    className={`w-full rounded-xl border px-4 py-3 text-left transition ${
                      selectedAwardId === award.id
                        ? "border-[#CE1126]/40 bg-[#CE1126]/5"
                        : "border-gray-100 bg-white hover:border-[#002D62]/20"
                    }`}
                  >
                    <p className="font-medium text-[#002D62]">{award.name}</p>
                    <p className="mt-1 text-xs text-gray-500">
                      {[award.organization, award.country].filter(Boolean).join(" · ") ||
                        "No organization"}
                    </p>
                  </button>
                ))}
              </div>
            </section>

            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <h2 className="mb-5 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                {selectedAwardId ? "Edit Award" : "Create Award"}
              </h2>

              <form onSubmit={saveAward} className="space-y-4">
                <Field label="Award Name">
                  <input
                    value={awardForm.name}
                    onChange={(event) =>
                      setAwardForm((current) => ({
                        ...current,
                        name: event.target.value,
                      }))
                    }
                    className={inputClass}
                    required
                  />
                </Field>

                <div className="grid gap-4 md:grid-cols-2">
                  <Field label="Organization">
                    <input
                      value={awardForm.organization}
                      onChange={(event) =>
                        setAwardForm((current) => ({
                          ...current,
                          organization: event.target.value,
                        }))
                      }
                      className={inputClass}
                    />
                  </Field>

                  <Field label="Country">
                    <input
                      value={awardForm.country}
                      onChange={(event) =>
                        setAwardForm((current) => ({
                          ...current,
                          country: event.target.value,
                        }))
                      }
                      className={inputClass}
                    />
                  </Field>
                </div>

                <Field label="Description">
                  <textarea
                    value={awardForm.description}
                    onChange={(event) =>
                      setAwardForm((current) => ({
                        ...current,
                        description: event.target.value,
                      }))
                    }
                    className={`${inputClass} min-h-32 resize-y leading-relaxed`}
                  />
                </Field>

                <div className="flex flex-wrap gap-3">
                  <button type="submit" disabled={loading} className={primaryButtonClass}>
                    Save Award
                  </button>
                  <button type="button" onClick={resetAwardForm} className={secondaryButtonClass}>
                    Reset / Create New Award
                  </button>
                </div>
              </form>
            </section>
          </div>
        )}

        {activeTab === "categories" && (
          <div className="grid gap-6 lg:grid-cols-[360px_1fr]">
            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <h2 className="mb-4 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                Award Categories
              </h2>

              <Field label="Award">
                <select
                  value={selectedCategoryAwardId}
                  onChange={(event) => {
                    const awardId = event.target.value;
                    setSelectedCategoryAwardId(awardId);
                    setCategoryForm((current) => ({
                      ...current,
                      award_id: awardId,
                    }));
                    setSelectedCategoryId("");
                  }}
                  className={inputClass}
                >
                  <option value="">-- Select Award --</option>
                  {awards.map((award) => (
                    <option key={award.id} value={award.id}>
                      {award.name}
                    </option>
                  ))}
                </select>
              </Field>

              <div className="mt-4 space-y-2">
                {categories.map((category) => (
                  <button
                    key={category.id}
                    type="button"
                    onClick={() => selectCategory(category)}
                    className={`w-full rounded-xl border px-4 py-3 text-left transition ${
                      selectedCategoryId === category.id
                        ? "border-[#CE1126]/40 bg-[#CE1126]/5"
                        : "border-gray-100 bg-white hover:border-[#002D62]/20"
                    }`}
                  >
                    <p className="font-medium text-[#002D62]">{category.name}</p>
                    {category.description && (
                      <p className="mt-1 text-xs text-gray-500">{category.description}</p>
                    )}
                  </button>
                ))}

                {selectedCategoryAwardId && categories.length === 0 && (
                  <p className="rounded-xl border border-dashed border-gray-200 px-4 py-6 text-sm text-gray-500">
                    No categories for this award yet.
                  </p>
                )}
              </div>
            </section>

            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <div className="mb-5 flex items-center justify-between gap-3">
                <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                  {selectedCategoryId ? "Edit Category" : "Create Category"}
                </h2>
                <button type="button" onClick={resetCategoryForm} className={secondaryButtonClass}>
                  New
                </button>
              </div>

              <form onSubmit={saveCategory} className="space-y-4">
                <Field label="Award">
                  <select
                    value={categoryForm.award_id}
                    onChange={(event) =>
                      setCategoryForm((current) => ({
                        ...current,
                        award_id: event.target.value,
                      }))
                    }
                    className={inputClass}
                    required
                  >
                    <option value="">-- Select Award --</option>
                    {awards.map((award) => (
                      <option key={award.id} value={award.id}>
                        {award.name}
                      </option>
                    ))}
                  </select>
                </Field>

                <Field label="Category Name">
                  <input
                    value={categoryForm.name}
                    onChange={(event) =>
                      setCategoryForm((current) => ({
                        ...current,
                        name: event.target.value,
                      }))
                    }
                    className={inputClass}
                    required
                  />
                </Field>

                <Field label="Description">
                  <textarea
                    value={categoryForm.description}
                    onChange={(event) =>
                      setCategoryForm((current) => ({
                        ...current,
                        description: event.target.value,
                      }))
                    }
                    className={`${inputClass} min-h-32 resize-y leading-relaxed`}
                  />
                </Field>

                <div className="flex flex-wrap gap-3">
                  <button type="submit" disabled={loading} className={primaryButtonClass}>
                    Save Category
                  </button>
                  <button type="button" onClick={resetCategoryForm} className={secondaryButtonClass}>
                    Reset / Create New Category
                  </button>
                </div>
              </form>
            </section>
          </div>
        )}

        {activeTab === "artist-awards" && (
          <div className="grid gap-6 lg:grid-cols-[360px_1fr]">
            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <h2 className="mb-4 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                Select Artist
              </h2>

              <input
                value={artistSearch}
                onChange={(event) => setArtistSearch(event.target.value)}
                placeholder="Search artists..."
                className={inputClass}
              />

              <select
                value={selectedArtistId}
                onChange={(event) => updateArtistSelection(event.target.value)}
                className={`${inputClass} mt-3`}
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

              <div className="mt-5 space-y-2">
                <h3 className="text-xs font-medium uppercase tracking-[0.18em] text-[#002D62]">
                  Existing Awards
                </h3>

                {artistAwards.map((artistAward) => {
                  const award = firstRelation(artistAward.awards);
                  const category = firstRelation(artistAward.award_categories);

                  return (
                    <button
                      key={artistAward.id}
                      type="button"
                      onClick={() => selectArtistAward(artistAward)}
                      className={`w-full rounded-xl border px-4 py-3 text-left transition ${
                        selectedArtistAwardId === artistAward.id
                          ? "border-[#CE1126]/40 bg-[#CE1126]/5"
                          : "border-gray-100 bg-white hover:border-[#002D62]/20"
                      }`}
                    >
                      <div className="flex items-start justify-between gap-3">
                        <p className="font-medium text-[#002D62]">
                          {artistAward.year ?? "No year"} · {award?.name ?? "Award"}
                        </p>
                        <span className="rounded-full bg-gray-100 px-2 py-1 text-[10px] uppercase tracking-[0.12em] text-gray-600">
                          {artistAward.won ? "Won" : "Nominated"}
                        </span>
                      </div>
                      <p className="mt-1 text-xs text-gray-500">
                        {[category?.name, artistAward.work].filter(Boolean).join(" · ") ||
                          "No category/work"}
                      </p>
                    </button>
                  );
                })}

                {selectedArtistId && artistAwards.length === 0 && (
                  <p className="rounded-xl border border-dashed border-gray-200 px-4 py-6 text-sm text-gray-500">
                    No awards recorded for this artist yet.
                  </p>
                )}
              </div>
            </section>

            <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
              <div className="mb-5 flex items-center justify-between gap-3">
                <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
                  {selectedArtistAwardId ? "Edit Artist Award" : "Add Artist Award"}
                </h2>
                <button type="button" onClick={resetArtistAwardForm} className={secondaryButtonClass}>
                  New
                </button>
              </div>

              <form onSubmit={saveArtistAward} className="space-y-4">
                <Field label="Artist">
                  <select
                    value={artistAwardForm.artist_id}
                    onChange={(event) => updateArtistSelection(event.target.value)}
                    className={inputClass}
                    required
                  >
                    <option value="">-- Select Artist --</option>
                    {filteredArtists.map((artist) => (
                      <option key={artist.id} value={artist.id}>
                        {artist.name}
                      </option>
                    ))}
                  </select>
                </Field>

                <div className="grid gap-4 md:grid-cols-2">
                  <Field label="Award">
                    <select
                      value={artistAwardForm.award_id}
                      onChange={(event) =>
                        setArtistAwardForm((current) => ({
                          ...current,
                          award_id: event.target.value,
                          category_id: "",
                        }))
                      }
                      className={inputClass}
                      required
                    >
                      <option value="">-- Select Award --</option>
                      {awards.map((award) => (
                        <option key={award.id} value={award.id}>
                          {award.name}
                        </option>
                      ))}
                    </select>
                  </Field>

                  <Field label="Category">
                    <select
                      value={artistAwardForm.category_id}
                      onChange={(event) =>
                        setArtistAwardForm((current) => ({
                          ...current,
                          category_id: event.target.value,
                        }))
                      }
                      className={inputClass}
                    >
                      <option value="">-- No Category --</option>
                      {artistAwardCategories.map((category) => (
                        <option key={category.id} value={category.id}>
                          {category.name}
                        </option>
                      ))}
                    </select>
                  </Field>
                </div>

                <div className="grid gap-4 md:grid-cols-[1fr_1fr_auto]">
                  <Field label="Year">
                    <input
                      type="number"
                      value={artistAwardForm.year}
                      onChange={(event) =>
                        setArtistAwardForm((current) => ({
                          ...current,
                          year: event.target.value,
                        }))
                      }
                      className={inputClass}
                    />
                  </Field>

                  <Field label="Work">
                    <input
                      value={artistAwardForm.work}
                      onChange={(event) =>
                        setArtistAwardForm((current) => ({
                          ...current,
                          work: event.target.value,
                        }))
                      }
                      className={inputClass}
                    />
                  </Field>

                  <label className="flex items-end gap-3 rounded-lg border border-gray-100 bg-gray-50 px-4 py-3 text-sm text-gray-700">
                    <input
                      type="checkbox"
                      checked={artistAwardForm.won}
                      onChange={(event) =>
                        setArtistAwardForm((current) => ({
                          ...current,
                          won: event.target.checked,
                        }))
                      }
                      className="h-4 w-4"
                    />
                    Won
                  </label>
                </div>

                <Field label="Source">
                  <input
                    value={artistAwardForm.source}
                    onChange={(event) =>
                      setArtistAwardForm((current) => ({
                        ...current,
                        source: event.target.value,
                      }))
                    }
                    className={inputClass}
                  />
                </Field>

                <div className="flex flex-wrap gap-3">
                  <button type="submit" disabled={loading} className={primaryButtonClass}>
                    Save Artist Award
                  </button>
                  <button
                    type="button"
                    onClick={resetArtistAwardForm}
                    className={secondaryButtonClass}
                  >
                    Reset / Create New
                  </button>
                </div>
              </form>
            </section>
          </div>
        )}
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

const primaryButtonClass =
  "rounded-lg bg-[#002D62] px-5 py-3 text-sm font-medium uppercase tracking-[0.16em] text-white transition disabled:cursor-not-allowed disabled:opacity-50";

const secondaryButtonClass =
  "rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-medium uppercase tracking-[0.14em] text-[#002D62] transition hover:border-[#CE1126] hover:text-[#CE1126]";
