"use client";

import Link from "next/link";
import { useMemo, useState } from "react";
import type { FormEvent, ReactNode } from "react";
import { useTranslations } from "next-intl";
import ContributorImage from "@/components/atoms/ContributorImage";
import { getSupabaseClient } from "@/lib/supabase";
import type { Contributor } from "@/types/contributor";

type ContributorForm = {
  name: string;
  slug: string;
  role: string;
  bio: string;
  location: string;
  specialty: string;
  website: string;
  facebook: string;
  instagram: string;
  youtube: string;
  active: boolean;
  display_order: string;
};

type ContributorsResponse = {
  ok: boolean;
  contributors?: Contributor[];
  contributor?: Contributor;
  error?: string;
};

type Props = {
  initialContributors: Contributor[];
  initialError: string | null;
};

const emptyForm: ContributorForm = {
  name: "",
  slug: "",
  role: "",
  bio: "",
  location: "",
  specialty: "",
  website: "",
  facebook: "",
  instagram: "",
  youtube: "",
  active: true,
  display_order: "100",
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

function parseSpecialty(value: string) {
  return value
    .split(",")
    .map((item) => item.trim())
    .filter(Boolean);
}

function nullable(value: string) {
  const trimmed = value.trim();
  return trimmed || null;
}

function sortContributors(contributors: Contributor[]) {
  return contributors.slice().sort(
    (a, b) => a.display_order - b.display_order || a.name.localeCompare(b.name),
  );
}

export default function ContributorsAdminClient({
  initialContributors,
  initialError,
}: Props) {
  const t = useTranslations();
  const [contributors, setContributors] = useState(() => sortContributors(initialContributors));
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [form, setForm] = useState<ContributorForm>(emptyForm);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(initialError ? `${t("admin.errors.updatingContributor")} ${initialError}` : "");
  const [messageType, setMessageType] = useState<"success" | "error" | "info">(
    initialError ? "error" : "info",
  );
  const [imageCacheKeys, setImageCacheKeys] = useState<Record<string, number>>({});

  const selectedContributor = useMemo(
    () => contributors.find((contributor) => contributor.id === selectedId) ?? null,
    [contributors, selectedId],
  );
  const filteredContributors = useMemo(() => {
    const query = search.trim().toLowerCase();
    if (!query) return contributors;

    return contributors.filter((contributor) =>
      [contributor.name, contributor.role, contributor.slug]
        .some((value) => value.toLowerCase().includes(query)),
    );
  }, [contributors, search]);

  function showMessage(text: string, type: "success" | "error" | "info") {
    setMessage(text);
    setMessageType(type);
  }

  function createNew() {
    setSelectedId(null);
    setForm(emptyForm);
    setMessage("");
  }

  function selectContributor(contributor: Contributor) {
    setSelectedId(contributor.id);
    setForm({
      name: contributor.name,
      slug: contributor.slug,
      role: contributor.role,
      bio: contributor.bio ?? "",
      location: contributor.location ?? "",
      specialty: contributor.specialty?.join(", ") ?? "",
      website: contributor.website ?? "",
      facebook: contributor.facebook ?? "",
      instagram: contributor.instagram ?? "",
      youtube: contributor.youtube ?? "",
      active: contributor.active,
      display_order: String(contributor.display_order),
    });
    setMessage("");
  }

  function updateName(name: string) {
    setForm((current) => ({
      ...current,
      name,
      slug: !selectedId && !current.slug.trim() ? slugify(name) : current.slug,
    }));
  }

  async function refreshContributors(preferredId?: string) {
    const response = await fetch("/api/admin/contributors");
    const result = (await response.json()) as ContributorsResponse;

    if (!response.ok || !result.ok) {
      throw new Error(result.error || response.statusText);
    }

    const rows = sortContributors(result.contributors ?? []);
    setContributors(rows);

    if (preferredId) {
      const contributor = rows.find((row) => row.id === preferredId);
      if (contributor) selectContributor(contributor);
    }
  }

  async function saveContributor(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const displayOrder = Number(form.display_order);
    const resolvedSlug = form.slug.trim() || (!selectedId ? slugify(form.name) : "");
    if (!form.name.trim() || !resolvedSlug || !form.role.trim()) {
      showMessage(t("admin.contributors.requiredFieldsError"), "error");
      return;
    }
    if (!form.display_order.trim() || !Number.isFinite(displayOrder)) {
      showMessage(t("admin.contributors.displayOrderError"), "error");
      return;
    }

    setLoading(true);
    showMessage(t("admin.status.savingContributor"), "info");

    try {
      const response = await fetch("/api/admin/contributors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          contributorId: selectedId,
          contributorData: {
            name: form.name.trim(),
            slug: resolvedSlug,
            role: form.role.trim(),
            bio: nullable(form.bio),
            location: nullable(form.location),
            specialty: parseSpecialty(form.specialty),
            website: nullable(form.website),
            facebook: nullable(form.facebook),
            instagram: nullable(form.instagram),
            youtube: nullable(form.youtube),
            active: form.active,
            display_order: displayOrder,
          },
        }),
      });
      const result = (await response.json()) as ContributorsResponse;

      if (!response.ok || !result.ok || !result.contributor) {
        throw new Error(result.error || response.statusText);
      }

      await refreshContributors(result.contributor.id);
      showMessage(t("admin.status.contributorSaved"), "success");
    } catch (error) {
      showMessage(
        `${t("admin.errors.savingContributor").replace("{error}", error instanceof Error ? error.message : "Unknown error")}`,
        "error",
      );
    } finally {
      setLoading(false);
    }
  }

  async function toggleActive(contributor: Contributor) {
    setLoading(true);
    showMessage(`${contributor.active ? t("admin.status.deactivatingContributor") : t("admin.status.activatingContributor")}`, "info");

    try {
      const response = await fetch("/api/admin/contributors", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ contributorId: contributor.id, active: !contributor.active }),
      });
      const result = (await response.json()) as ContributorsResponse;

      if (!response.ok || !result.ok || !result.contributor) {
        throw new Error(result.error || response.statusText);
      }

      await refreshContributors(selectedId ?? undefined);
      showMessage(t("admin.status.contributorToggled").replace("{status}", result.contributor.active ? t("admin.contributors.statusActive") : t("admin.contributors.statusInactive")), "success");
    } catch (error) {
      showMessage(
        `${t("admin.errors.updatingContributor").replace("{error}", error instanceof Error ? error.message : "Unknown error")}`,
        "error",
      );
    } finally {
      setLoading(false);
    }
  }

  async function uploadImage(file: File) {
    if (!selectedId) {
      showMessage(t("admin.contributors.saveBeforeImage"), "error");
      return;
    }

    const isWebp = file.type === "image/webp" || file.name.toLowerCase().endsWith(".webp");
    if (!isWebp) {
      showMessage(t("admin.contributors.webpRequired"), "error");
      return;
    }

    setLoading(true);
    showMessage(t("admin.status.uploadingImage").replace("{id}", selectedId), "info");

    const filePath = `${selectedId}.webp`;
    const webpFile = new File([file], filePath, { type: "image/webp" });
    const { error } = await getSupabaseClient().storage
      .from("contributors-images")
      .upload(filePath, webpFile, {
        upsert: true,
        contentType: "image/webp",
        cacheControl: "3600",
      });

    if (error) {
      showMessage(`${t("admin.errors.uploadingImage").replace("{error}", error.message)}`, "error");
    } else {
      setImageCacheKeys((current) => ({ ...current, [selectedId]: Date.now() }));
      showMessage(t("admin.status.imageUploaded"), "success");
    }
    setLoading(false);
  }

  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-8 font-sans text-gray-900 sm:px-6 sm:pb-12 sm:pt-10">
      <div className="mx-auto max-w-6xl">
        <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">{t("admin.ui.branding")}</p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">{t("admin.contributors.title")}</h1>
              <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">{t("admin.contributors.description")}</p>
            </div>
            <Link href="/admin" className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs uppercase tracking-[0.18em] text-[#002D62] shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126]">{t("admin.navigation.portal")}</Link>
          </div>
        </header>

        {message && (
          <div className={`mb-6 rounded-xl border px-4 py-3 text-sm shadow-sm ${messageType === "error" ? "border-red-200 bg-red-50 text-red-800" : messageType === "success" ? "border-green-200 bg-green-50 text-green-800" : "border-gray-200 bg-white text-gray-700"}`} role="status">
            {message}
          </div>
        )}

        <div className="grid gap-6 lg:grid-cols-[380px_1fr]">
          <aside className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
            <div className="mb-4 flex items-center justify-between gap-3">
              <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">{t("admin.contributors.listHeading")}</h2>
              <button type="button" onClick={createNew} className="rounded-lg border border-gray-200 px-3 py-2 text-xs font-medium uppercase tracking-[0.14em] text-[#002D62] transition hover:border-[#CE1126] hover:text-[#CE1126]">{t("admin.buttons.new")}</button>
            </div>
            <input value={search} onChange={(event) => setSearch(event.target.value)} placeholder={t("admin.contributors.searchPlaceholder")} className={inputClass} />
            <div className="mt-4 max-h-[780px] space-y-2 overflow-y-auto pr-1">
              {filteredContributors.map((contributor) => (
                <div key={contributor.id} className={`rounded-xl border p-3 transition ${selectedId === contributor.id ? "border-[#CE1126]/40 bg-[#CE1126]/5" : "border-gray-100"}`}>
                  <button type="button" onClick={() => selectContributor(contributor)} className="flex w-full items-center gap-3 text-left">
                    <ContributorImage contributorId={contributor.id} alt="" cacheKey={imageCacheKeys[contributor.id]} className="h-14 w-14 shrink-0 rounded-lg object-cover" />
                    <span className="min-w-0 flex-1">
                      <span className="block truncate font-medium text-[#002D62]">{contributor.name}</span>
                      <span className="mt-1 block truncate text-xs text-gray-500">{contributor.role} · {t("admin.contributors.displayOrder").replace("{number}", String(contributor.display_order))}</span>
                      <span className={`mt-1 inline-block text-[10px] font-medium uppercase tracking-[0.12em] ${contributor.active ? "text-green-700" : "text-gray-400"}`}>{contributor.active ? t("admin.contributors.statusActive") : t("admin.contributors.statusInactive")}</span>
                    </span>
                  </button>
                  <div className="mt-3 flex gap-2 border-t border-gray-100 pt-3">
                    <button type="button" onClick={() => selectContributor(contributor)} className="rounded-lg border border-gray-200 px-3 py-1.5 text-xs font-medium text-[#002D62]">{t("admin.buttons.edit")}</button>
                    <button type="button" disabled={loading} onClick={() => void toggleActive(contributor)} className="rounded-lg border border-gray-200 px-3 py-1.5 text-xs font-medium text-[#CE1126] disabled:opacity-50">{contributor.active ? t("admin.buttons.deactivate") : t("admin.buttons.activate")}</button>
                  </div>
                </div>
              ))}
              {!filteredContributors.length && <p className="rounded-xl border border-dashed border-gray-200 px-4 py-6 text-sm text-gray-500">{t("admin.contributors.emptyState")}</p>}
            </div>
          </aside>

          <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
            <div className="mb-5 flex items-center justify-between gap-3">
              <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">{selectedContributor ? t("admin.contributors.editHeading") : t("admin.contributors.createHeading")}</h2>
              {!selectedId && <button type="button" onClick={() => setForm((current) => ({ ...current, slug: slugify(current.name) }))} className="rounded-lg border border-gray-200 px-3 py-2 text-xs font-medium uppercase tracking-[0.14em] text-[#002D62]">{t("admin.buttons.generateSlug")}</button>}
            </div>

            {selectedContributor && (
              <div className="mb-6 flex flex-col gap-4 rounded-xl border border-gray-100 bg-gray-50 p-4 sm:flex-row sm:items-center">
                <ContributorImage contributorId={selectedContributor.id} alt={selectedContributor.name} cacheKey={imageCacheKeys[selectedContributor.id]} className="aspect-square w-32 rounded-xl object-cover" />
                <label className="block flex-1">
                  <span className="mb-2 block text-[10px] font-medium uppercase tracking-[0.18em] text-gray-400">{t("admin.contributors.replaceImage")}</span>
                  <input type="file" accept=".webp,image/webp" disabled={loading} onChange={(event) => { const file = event.target.files?.[0]; if (file) void uploadImage(file); event.target.value = ""; }} className="block w-full text-sm text-gray-600 file:mr-4 file:rounded-lg file:border-0 file:bg-[#002D62] file:px-4 file:py-2 file:text-sm file:text-white disabled:opacity-50" />
                  <span className="mt-2 block text-xs text-gray-500">{t("admin.contributors.webpOnlyHint").replace("{id}", selectedContributor.id)}</span>
                </label>
              </div>
            )}

            <form onSubmit={saveContributor} className="space-y-4">
              <div className="grid gap-4 md:grid-cols-2">
                <Field label={t("form.labels.name")}><input value={form.name} onChange={(event) => updateName(event.target.value)} required className={inputClass} /></Field>
                <Field label={t("form.labels.slug")}><input value={form.slug} onChange={(event) => setForm((current) => ({ ...current, slug: event.target.value }))} required className={inputClass} /></Field>
                <Field label={t("form.labels.role")}><input value={form.role} onChange={(event) => setForm((current) => ({ ...current, role: event.target.value }))} required className={inputClass} /></Field>
                <Field label={t("form.labels.location")}><input value={form.location} onChange={(event) => setForm((current) => ({ ...current, location: event.target.value }))} className={inputClass} /></Field>
              </div>
              <Field label={t("form.labels.bio")}><textarea value={form.bio} onChange={(event) => setForm((current) => ({ ...current, bio: event.target.value }))} className={`${inputClass} min-h-32 resize-y leading-relaxed`} /></Field>
              <Field label={t("form.labels.specialty")}><input value={form.specialty} onChange={(event) => setForm((current) => ({ ...current, specialty: event.target.value }))} placeholder={t("form.placeholders.specialtyExample")} className={inputClass} /></Field>
              <div className="grid gap-4 md:grid-cols-2">
                {(["website", "facebook", "instagram", "youtube"] as const).map((field) => (
                  <Field key={field} label={t(`form.labels.${field}`)}><input type="url" value={form[field]} onChange={(event) => setForm((current) => ({ ...current, [field]: event.target.value }))} className={inputClass} /></Field>
                ))}
              </div>
              <div className="grid gap-4 md:grid-cols-[1fr_auto]">
                <Field label={t("form.labels.displayOrder")}><input type="number" value={form.display_order} onChange={(event) => setForm((current) => ({ ...current, display_order: event.target.value }))} required className={inputClass} /></Field>
                <label className="flex items-end gap-3 rounded-lg border border-gray-100 bg-gray-50 px-4 py-3 text-sm text-gray-700"><input type="checkbox" checked={form.active} onChange={(event) => setForm((current) => ({ ...current, active: event.target.checked }))} className="h-4 w-4" />{t("form.labels.active")}</label>
              </div>
              <div className="flex flex-wrap gap-3 pt-2">
                <button type="submit" disabled={loading} className="rounded-lg bg-[#002D62] px-5 py-3 text-sm font-medium uppercase tracking-[0.16em] text-white disabled:cursor-not-allowed disabled:opacity-50">{t("admin.buttons.saveContributor")}</button>
                <button type="button" onClick={createNew} className="rounded-lg border border-gray-200 bg-white px-5 py-3 text-sm font-medium uppercase tracking-[0.16em] text-[#002D62] transition hover:border-[#CE1126] hover:text-[#CE1126]">{t("admin.buttons.resetForm")}</button>
              </div>
            </form>
          </section>
        </div>
      </div>
    </main>
  );
}

function Field({ label, children }: { label: string; children: ReactNode }) {
  return <label className="block"><span className="mb-1 block text-[10px] font-medium uppercase tracking-[0.18em] text-gray-400">{label}</span>{children}</label>;
}

const inputClass = "w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm text-gray-800 outline-none transition focus:border-[#002D62]";
