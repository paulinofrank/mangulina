"use client";

import Link from "next/link";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import type { FormEvent } from "react";
import { useTranslations } from "next-intl";

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------
type PlatformLinkRow = {
  id: string;
  recording_id: string;
  platform: string;
  url: string;
  label: string | null;
  link_type: string;
  is_official: boolean;
  status: string;
  display_order: number;
  created_at: string | null;
  updated_at: string | null;
  confidence: number | null;
  source: string | null;
  external_id: string | null;
  title_found: string | null;
  artist_found: string | null;
  checked_at: string | null;
  // Hydrated server-side
  recording_title: string;
  artist_name: string;
  recording_year: number | null;
  duration_sec: number | null;
};

type PlatformLinkForm = {
  url: string;
  label: string;
  link_type: string;
  is_official: boolean;
  status: string;
  display_order: string;
  confidence: string;
  title_found: string;
  artist_found: string;
  external_id: string;
};

type ManualLinkForm = {
  recording_id: string;
  platform: string;
  url: string;
  label: string;
  link_type: string;
  is_official: boolean;
  display_order: string;
};

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------
const PLATFORMS = [
  "youtube",
  "spotify",
  "apple_music",
  "deezer",
  "amazon_music",
  "tidal",
  "pandora",
  "audiomack",
  "boomplay",
  "youtube_music",
  "soundcloud",
  "bandcamp",
];

const STATUSES = [
  "needs_review",
  "pending",
  "approved_auto",
  "approved_manual",
  "rejected",
  "all",
];

const STATUS_COLORS: Record<string, string> = {
  approved_auto:   "bg-emerald-50 text-emerald-700 border-emerald-200",
  approved_manual: "bg-blue-50 text-blue-700 border-blue-200",
  needs_review:    "bg-amber-50 text-amber-700 border-amber-200",
  pending:         "bg-gray-50 text-gray-600 border-gray-200",
  rejected:        "bg-red-50 text-red-700 border-red-200",
};

const EMPTY_MANUAL: ManualLinkForm = {
  recording_id: "",
  platform: "deezer",
  url: "",
  label: "",
  link_type: "stream",
  is_official: true,
  display_order: "0",
};

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
function nullable(v: string | null | undefined): string | null {
  const s = (v ?? "").trim();
  return s || null;
}

function toLinkForm(row: PlatformLinkRow): PlatformLinkForm {
  return {
    url:          row.url ?? "",
    label:        row.label ?? "",
    link_type:    row.link_type ?? "stream",
    is_official:  Boolean(row.is_official),
    status:       row.status ?? "needs_review",
    display_order: String(row.display_order ?? 0),
    confidence:   row.confidence == null ? "" : String(row.confidence),
    title_found:  row.title_found ?? "",
    artist_found: row.artist_found ?? "",
    external_id:  row.external_id ?? "",
  };
}

function formatDate(v: string | null): string {
  if (!v) return "—";
  return new Date(v).toLocaleString("en-US", {
    month: "short", day: "numeric", year: "numeric",
    hour: "numeric", minute: "2-digit",
  });
}

function formatConfidence(v: number | null): string {
  if (v == null) return "—";
  return (v * 100).toFixed(1) + "%";
}

function formatDuration(sec: number | null): string {
  if (!sec) return "—";
  const m = Math.floor(sec / 60);
  const s = sec % 60;
  return `${m}:${String(s).padStart(2, "0")}`;
}

// ---------------------------------------------------------------------------
// API helpers
// ---------------------------------------------------------------------------
async function apiFetch(path: string, opts?: RequestInit) {
  const resp = await fetch(path, opts);
  const json = await resp.json();
  if (!resp.ok || !json.ok) throw new Error(json.error ?? `HTTP ${resp.status}`);
  return json;
}

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------
export default function AdminPlatformLinksPage() {
  const t = useTranslations();
  const [rows, setRows]         = useState<PlatformLinkRow[]>([]);
  const [forms, setForms]       = useState<Record<string, PlatformLinkForm>>({});
  const [platform, setPlatform] = useState("deezer");
  const [statusFilter, setStatusFilter] = useState("needs_review");
  const [minConfidence, setMinConfidence] = useState("");
  const [search, setSearch]     = useState("");
  const [limit, setLimit]       = useState("50");
  const [loading, setLoading]   = useState(false);
  const [msg, setMsg]           = useState<{ text: string; kind: "info" | "ok" | "err" } | null>(null);

  // Manual add
  const [recSearch, setRecSearch]         = useState("");
  const [recOptions, setRecOptions]       = useState<{ id: string; title: string; artist_name: string; recording_year: number | null }[]>([]);
  const [manualForm, setManualForm]       = useState<ManualLinkForm>(EMPTY_MANUAL);
  const [recSearchLoading, setRecSearchLoading] = useState(false);

  // Expanded rows (show edit form)
  const [expanded, setExpanded] = useState<Set<string>>(new Set());

  const abortRef = useRef<AbortController | null>(null);

  // ── Filtered view ─────────────────────────────────────────────────────────
  const filteredRows = useMemo(() => {
    const q = search.trim().toLowerCase();
    if (!q) return rows;
    return rows.filter((r) =>
      [r.recording_title, r.artist_name, r.title_found, r.artist_found, r.url, r.external_id]
        .filter(Boolean)
        .some((v) => String(v).toLowerCase().includes(q))
    );
  }, [rows, search]);

  // ── Load ──────────────────────────────────────────────────────────────────
  const loadLinks = useCallback(async () => {
    if (abortRef.current) abortRef.current.abort();
    abortRef.current = new AbortController();

    setLoading(true);
    setMsg({ text: t("admin.status.loadingLinks"), kind: "info" });

    try {
      const params = new URLSearchParams({
        platform,
        status: statusFilter,
        limit,
        ...(minConfidence.trim() ? { minConfidence: minConfidence.trim() } : {}),
      });
      const json = await apiFetch(`/api/admin/platform-links?${params}`, {
        signal: abortRef.current.signal,
      });
      const loaded: PlatformLinkRow[] = json.rows ?? [];
      setRows(loaded);
      setForms(Object.fromEntries(loaded.map((r) => [r.id, toLinkForm(r)])));
      setExpanded(new Set());

      if (loaded.length === 0) {
        setMsg({
          text: t("admin.platformLinks.suggestAllStatuses").replace("{platform}", platform).replace("{status}", statusFilter),
          kind: "info",
        });
      } else {
        setMsg({ text: t("admin.platformLinks.linksLoaded").replace("{count}", String(loaded.length)), kind: "ok" });
      }
    } catch (err) {
      if ((err as Error).name === "AbortError") return;
      const msg = err instanceof Error ? err.message : String(err);
      console.error("[platform-links] load error:", msg);
      setMsg({ text: `${t("admin.errors.loadingLinks").replace("{error}", msg)}`, kind: "err" });
    } finally {
      setLoading(false);
    }
  }, [platform, statusFilter, minConfidence, limit, t]);

  useEffect(() => { void loadLinks(); }, [loadLinks]);

  // ── Update (approve / reject / mark / save) ───────────────────────────────
  async function updateLink(
    id: string,
    updates: Record<string, unknown>,
    successMsg: string,
  ) {
    setLoading(true);
    setMsg({ text: t("admin.status.updating"), kind: "info" });
    try {
      await apiFetch("/api/admin/platform-links", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id, updates }),
      });
      // Update local state so the row reflects the change immediately
      setRows((prev) =>
        prev.map((r) => (r.id === id ? { ...r, ...updates } as PlatformLinkRow : r))
      );
      setMsg({ text: successMsg, kind: "ok" });
    } catch (err) {
      const m = err instanceof Error ? err.message : String(err);
      console.error("[platform-links] update error:", m);
      setMsg({ text: `${t("admin.errors.updatingLink").replace("{error}", m)}`, kind: "err" });
    } finally {
      setLoading(false);
    }
  }

  async function saveEdits(id: string) {
    const form = forms[id];
    if (!form) return;
    await updateLink(
      id,
      {
        url:           form.url.trim(),
        label:         nullable(form.label),
        link_type:     form.link_type.trim() || "stream",
        is_official:   form.is_official,
        status:        form.status,
        display_order: Number(form.display_order) || 0,
        confidence:    form.confidence.trim() ? Number(form.confidence) : null,
        title_found:   nullable(form.title_found),
        artist_found:  nullable(form.artist_found),
        external_id:   nullable(form.external_id),
        checked_at:    new Date().toISOString(),
      },
      t("admin.status.linkUpdated"),
    );
  }

  // ── Recording search (for manual add) ─────────────────────────────────────
  async function searchRecordings() {
    const q = recSearch.trim();
    if (!q) { setRecOptions([]); return; }
    setRecSearchLoading(true);
    try {
      // Use the anon client just for title search — recordings table is likely readable
      const resp = await fetch(
        `/api/admin/platform-links/recording-search?q=${encodeURIComponent(q)}`
      );
      const json = await resp.json();
      setRecOptions(json.recordings ?? []);
    } catch {
      setRecOptions([]);
    } finally {
      setRecSearchLoading(false);
    }
  }

  // ── Manual add ────────────────────────────────────────────────────────────
  async function addManualLink(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!manualForm.recording_id) { setMsg({ text: t("form.placeholders.selectRecording"), kind: "err" }); return; }
    if (!manualForm.url.trim())   { setMsg({ text: t("form.labels.urlRequired"),           kind: "err" }); return; }
    setLoading(true);
    setMsg({ text: t("admin.status.addingLink"), kind: "info" });
    try {
      await apiFetch("/api/admin/platform-links", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          recording_id:  manualForm.recording_id,
          platform:      manualForm.platform,
          url:           manualForm.url.trim(),
          label:         nullable(manualForm.label),
          link_type:     manualForm.link_type.trim() || "stream",
          is_official:   manualForm.is_official,
          status:        "approved_manual",
          display_order: Number(manualForm.display_order) || 0,
        }),
      });
      setManualForm(EMPTY_MANUAL);
      setRecSearch("");
      setRecOptions([]);
      await loadLinks();
      setMsg({ text: t("admin.status.linkAdded"), kind: "ok" });
    } catch (err) {
      const m = err instanceof Error ? err.message : String(err);
      setMsg({ text: `${t("admin.errors.addingLink").replace("{error}", m)}`, kind: "err" });
    } finally {
      setLoading(false);
    }
  }

  // ── Toggle expanded ───────────────────────────────────────────────────────
  function toggleExpanded(id: string) {
    setExpanded((prev) => {
      const next = new Set(prev);
      next.has(id) ? next.delete(id) : next.add(id);
      return next;
    });
  }

  // ── Render ────────────────────────────────────────────────────────────────
  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-12 pt-8 font-sans text-gray-900 sm:px-6 sm:pt-10">
      <div className="mx-auto max-w-6xl">

        {/* ── Header ──────────────────────────────────────────────────────── */}
        <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
                {t("admin.ui.branding")}
              </p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
                {t("admin.platformLinks.title")}
              </h1>
              <p className="mt-3 max-w-2xl text-sm leading-relaxed text-gray-500">
                {t("admin.platformLinks.description")}
              </p>
            </div>
            <Link
              href="/admin"
              className="inline-flex w-fit shrink-0 items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-medium uppercase tracking-[0.18em] text-[#002D62] shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126]"
            >
              {t("admin.navigation.portal")}
            </Link>
          </div>
        </header>

        {/* ── Status message ──────────────────────────────────────────────── */}
        {msg && (
          <div
            className={`mb-5 rounded-xl border px-4 py-3 text-sm shadow-sm ${
              msg.kind === "err"  ? "border-red-200 bg-red-50 text-red-700" :
              msg.kind === "ok"   ? "border-emerald-200 bg-emerald-50 text-emerald-700" :
              "border-gray-200 bg-white text-gray-600"
            }`}
          >
            {msg.text}
          </div>
        )}

        {/* ── Filters ─────────────────────────────────────────────────────── */}
        <section className="mb-6 rounded-xl border border-black/5 bg-white p-5 shadow-sm">
          <h2 className="mb-4 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
            {t("admin.platformLinks.filtersHeading")}
          </h2>
          <div className="grid gap-4 sm:grid-cols-2 md:grid-cols-5">
            <Field label={t("form.labels.platform")}>
              <select value={platform} onChange={(e) => setPlatform(e.target.value)} className={inputCls}>
                {PLATFORMS.map((p) => <option key={p} value={p}>{p}</option>)}
              </select>
            </Field>
            <Field label={t("form.labels.status")}>
              <select value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)} className={inputCls}>
                {STATUSES.map((s) => <option key={s} value={s}>{s}</option>)}
              </select>
            </Field>
            <Field label={t("form.labels.minConfidence")}>
              <input
                type="number" step="0.01" min="0" max="1"
                value={minConfidence}
                onChange={(e) => setMinConfidence(e.target.value)}
                placeholder="e.g. 0.85"
                className={inputCls}
              />
            </Field>
            <Field label={t("form.labels.limit")}>
              <select value={limit} onChange={(e) => setLimit(e.target.value)} className={inputCls}>
                {["25","50","100","200"].map((n) => <option key={n} value={n}>{n}</option>)}
              </select>
            </Field>
            <div className="flex items-end">
              <button
                type="button" onClick={() => void loadLinks()} disabled={loading}
                className={primaryBtn}
              >
                {loading ? t("admin.status.loading") : t("admin.buttons.refresh")}
              </button>
            </div>
          </div>
          <div className="mt-4">
            <Field label={t("form.labels.searchRows")}>
              <input
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                placeholder={t("admin.platformLinks.searchPlaceholder")}
                className={inputCls}
              />
            </Field>
          </div>
        </section>

        {/* ── Results list ────────────────────────────────────────────────── */}
        <section className="mb-8 space-y-4">
          {filteredRows.length === 0 && !loading && (
            <div className="rounded-xl border border-dashed border-gray-200 bg-white px-4 py-10 text-center">
              <p className="text-sm text-gray-500">
                {t("admin.platformLinks.noLinksFound").replace("{platform}", platform).replace("{status}", statusFilter)}
              </p>
              {statusFilter !== "all" && (
                <button
                  type="button"
                  onClick={() => setStatusFilter("all")}
                  className="mt-3 text-sm font-medium text-[#002D62] underline-offset-2 hover:underline"
                >
                  {t("admin.buttons.showAllStatuses")}
                </button>
              )}
            </div>
          )}

          {filteredRows.map((row) => {
            const form       = forms[row.id] ?? toLinkForm(row);
            const isExpanded = expanded.has(row.id);
            const statusCls  = STATUS_COLORS[row.status] ?? "bg-gray-50 text-gray-600 border-gray-200";
            const confBadge  = row.confidence != null
              ? row.confidence >= 0.95 ? "text-emerald-700"
              : row.confidence >= 0.80 ? "text-amber-700"
              : "text-red-700"
              : "text-gray-400";

            return (
              <article
                key={row.id}
                className="rounded-xl border border-black/5 bg-white shadow-sm"
              >
                {/* ── Card header ─────────────────────────────────────── */}
                <div className="flex flex-col gap-3 p-5 sm:flex-row sm:items-start sm:justify-between">
                  <div className="min-w-0 flex-1">
                    <div className="flex flex-wrap items-center gap-2">
                      <span className={`inline-flex items-center rounded-full border px-2.5 py-0.5 text-[10px] font-semibold uppercase tracking-[0.14em] ${statusCls}`}>
                        {row.status}
                      </span>
                      <span className="text-[10px] uppercase tracking-[0.14em] text-gray-400">
                        {row.platform} · {row.link_type}
                      </span>
                      {row.confidence != null && (
                        <span className={`text-xs font-semibold tabular-nums ${confBadge}`}>
                          {formatConfidence(row.confidence)}
                        </span>
                      )}
                    </div>
                    <h2 className="mt-2 truncate text-lg font-semibold text-[#002D62]">
                      {row.recording_title}
                    </h2>
                    <p className="mt-0.5 text-sm text-gray-500">
                      {row.artist_name}
                      {row.recording_year ? <span className="ml-1 text-gray-400">· {row.recording_year}</span> : null}
                      {row.duration_sec   ? <span className="ml-1 text-gray-400">· {formatDuration(row.duration_sec)}</span> : null}
                    </p>
                  </div>

                  {/* Action buttons */}
                  <div className="flex flex-wrap items-start gap-2 sm:shrink-0">
                    <a
                      href={row.url} target="_blank" rel="noopener noreferrer"
                      className={secondaryBtn}
                    >
                      {t("admin.buttons.openLink")}
                    </a>
                    {row.status !== "approved_manual" && (
                      <button
                        type="button"
                        onClick={() => void updateLink(row.id, { status: "approved_manual", is_official: true, checked_at: new Date().toISOString() }, t("admin.status.linkApproved"))}
                        disabled={loading}
                        className={primaryBtn}
                      >
                        {t("admin.buttons.approve")}
                      </button>
                    )}
                    {row.status !== "rejected" && (
                      <button
                        type="button"
                        onClick={() => void updateLink(row.id, { status: "rejected", checked_at: new Date().toISOString() }, t("admin.status.linkRejected"))}
                        disabled={loading}
                        className={dangerBtn}
                      >
                        {t("admin.buttons.reject")}
                      </button>
                    )}
                    {row.status !== "needs_review" && (
                      <button
                        type="button"
                        onClick={() => void updateLink(row.id, { status: "needs_review", checked_at: new Date().toISOString() }, t("admin.status.markedForReview"))}
                        disabled={loading}
                        className={secondaryBtn}
                      >
                        {t("admin.buttons.needsReview")}
                      </button>
                    )}
                    <button
                      type="button"
                      onClick={() => toggleExpanded(row.id)}
                      className={secondaryBtn}
                    >
                      {isExpanded ? t("admin.buttons.collapse") : t("admin.buttons.edit")}
                    </button>
                  </div>
                </div>

                {/* ── Audit metadata strip ─────────────────────────────── */}
                <div className="grid grid-cols-2 gap-2 border-t border-gray-50 px-5 py-3 md:grid-cols-4">
                  <Meta label={t("admin.platformLinks.titleFound")}  value={row.title_found  ?? "—"} />
                  <Meta label={t("admin.platformLinks.artistFound")} value={row.artist_found ?? "—"} />
                  <Meta label={t("admin.platformLinks.externalId")}  value={row.external_id  ?? "—"} />
                  <Meta label={t("admin.platformLinks.source")}       value={row.source       ?? "—"} />
                  <Meta label={t("admin.platformLinks.checked")}      value={formatDate(row.checked_at)} />
                  <Meta label={t("admin.platformLinks.created")}      value={formatDate(row.created_at)} />
                  <Meta label={t("admin.platformLinks.url")} value={row.url} truncate />
                </div>

                {/* ── Edit form (collapsed by default) ────────────────── */}
                {isExpanded && (
                  <div className="border-t border-gray-100 p-5">
                    <p className="mb-3 text-xs font-medium uppercase tracking-[0.18em] text-gray-400">
                      {t("admin.platformLinks.editFieldsHeading")}
                    </p>
                    <div className="grid gap-4 md:grid-cols-3">
                      <Field label={t("form.labels.url")}>
                        <input value={form.url} onChange={(e) => patchForm(row.id, form, "url", e.target.value)} className={inputCls} />
                      </Field>
                      <Field label={t("form.labels.label")}>
                        <input value={form.label} onChange={(e) => patchForm(row.id, form, "label", e.target.value)} className={inputCls} />
                      </Field>
                      <Field label={t("form.labels.linkType")}>
                        <input value={form.link_type} onChange={(e) => patchForm(row.id, form, "link_type", e.target.value)} className={inputCls} />
                      </Field>
                      <Field label={t("form.labels.status")}>
                        <select value={form.status} onChange={(e) => patchForm(row.id, form, "status", e.target.value)} className={inputCls}>
                          {STATUSES.filter((s) => s !== "all").map((s) => <option key={s} value={s}>{s}</option>)}
                        </select>
                      </Field>
                      <Field label={t("form.labels.confidence")}>
                        <input type="number" step="0.001" min="0" max="1" value={form.confidence} onChange={(e) => patchForm(row.id, form, "confidence", e.target.value)} className={inputCls} />
                      </Field>
                      <Field label={t("form.labels.displayOrder")}>
                        <input type="number" value={form.display_order} onChange={(e) => patchForm(row.id, form, "display_order", e.target.value)} className={inputCls} />
                      </Field>
                      <Field label={t("admin.platformLinks.titleFound")}>
                        <input value={form.title_found} onChange={(e) => patchForm(row.id, form, "title_found", e.target.value)} className={inputCls} />
                      </Field>
                      <Field label={t("admin.platformLinks.artistFound")}>
                        <input value={form.artist_found} onChange={(e) => patchForm(row.id, form, "artist_found", e.target.value)} className={inputCls} />
                      </Field>
                      <Field label={t("admin.platformLinks.externalId")}>
                        <input value={form.external_id} onChange={(e) => patchForm(row.id, form, "external_id", e.target.value)} className={inputCls} />
                      </Field>
                    </div>
                    <label className="mt-3 flex items-center gap-2 text-sm text-gray-600">
                      <input
                        type="checkbox" checked={form.is_official}
                        onChange={(e) => patchForm(row.id, form, "is_official", e.target.checked)}
                        className="h-4 w-4 rounded"
                      />
                      {t("form.labels.officialLink")}
                    </label>
                    <button
                      type="button"
                      onClick={() => void saveEdits(row.id)}
                      disabled={loading}
                      className={`${primaryBtn} mt-4`}
                    >
                      {t("admin.buttons.saveEdits")}
                    </button>
                  </div>
                )}
              </article>
            );
          })}
        </section>

        {/* ── Manual Add ──────────────────────────────────────────────────── */}
        <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
          <h2 className="mb-4 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
            {t("admin.platformLinks.addManualHeading")}
          </h2>
          <form onSubmit={addManualLink} className="space-y-4">
            <div className="grid gap-4 md:grid-cols-[1fr_auto]">
              <Field label={t("form.labels.searchRecording")}>
                <input
                  value={recSearch}
                  onChange={(e) => setRecSearch(e.target.value)}
                  onKeyDown={(e) => { if (e.key === "Enter") { e.preventDefault(); void searchRecordings(); } }}
                  placeholder={t("form.placeholders.recordingTitle")}
                  className={inputCls}
                />
              </Field>
              <div className="flex items-end">
                <button type="button" onClick={() => void searchRecordings()} disabled={recSearchLoading} className={secondaryBtn}>
                  {recSearchLoading ? "…" : t("admin.buttons.search")}
                </button>
              </div>
            </div>

            {recOptions.length > 0 && (
              <Field label={t("form.labels.selectRecording")}>
                <select
                  value={manualForm.recording_id}
                  onChange={(e) => setManualForm((f) => ({ ...f, recording_id: e.target.value }))}
                  className={inputCls}
                >
                  <option value="">{t("form.placeholders.select")}</option>
                  {recOptions.map((r) => (
                    <option key={r.id} value={r.id}>
                      {r.title} · {r.artist_name}{r.recording_year ? ` (${r.recording_year})` : ""}
                    </option>
                  ))}
                </select>
              </Field>
            )}

            <div className="grid gap-4 md:grid-cols-3">
              <Field label={t("form.labels.platform")}>
                <select value={manualForm.platform} onChange={(e) => setManualForm((f) => ({ ...f, platform: e.target.value }))} className={inputCls}>
                  {PLATFORMS.map((p) => <option key={p} value={p}>{p}</option>)}
                </select>
              </Field>
              <Field label={t("form.labels.linkType")}>
                <input value={manualForm.link_type} onChange={(e) => setManualForm((f) => ({ ...f, link_type: e.target.value }))} className={inputCls} />
              </Field>
              <Field label={t("form.labels.displayOrder")}>
                <input type="number" value={manualForm.display_order} onChange={(e) => setManualForm((f) => ({ ...f, display_order: e.target.value }))} className={inputCls} />
              </Field>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <Field label={t("form.labels.urlRequired")}>
                <input value={manualForm.url} onChange={(e) => setManualForm((f) => ({ ...f, url: e.target.value }))} placeholder={t("form.placeholders.url")} className={inputCls} />
              </Field>
              <Field label={t("form.labels.label")}>
                <input value={manualForm.label} onChange={(e) => setManualForm((f) => ({ ...f, label: e.target.value }))} placeholder={t("form.placeholders.labelExample")} className={inputCls} />
              </Field>
            </div>

            <label className="flex items-center gap-2 text-sm text-gray-600">
              <input type="checkbox" checked={manualForm.is_official} onChange={(e) => setManualForm((f) => ({ ...f, is_official: e.target.checked }))} className="h-4 w-4 rounded" />
              {t("form.labels.officialLink")}
            </label>

            <button type="submit" disabled={loading} className={primaryBtn}>
              {t("admin.buttons.addAsApprovedLink")}
            </button>
          </form>
        </section>

      </div>
    </main>
  );

  function patchForm(
    id: string,
    form: PlatformLinkForm,
    field: keyof PlatformLinkForm,
    value: string | boolean,
  ) {
    setForms((prev) => ({ ...prev, [id]: { ...form, [field]: value } }));
  }
}

// ---------------------------------------------------------------------------
// Sub-components
// ---------------------------------------------------------------------------
function Field({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <label className="block">
      <span className="mb-1 block text-[10px] font-medium uppercase tracking-[0.18em] text-gray-400">
        {label}
      </span>
      {children}
    </label>
  );
}

function Meta({ label, value, truncate }: { label: string; value: string; truncate?: boolean }) {
  return (
    <div className="rounded-lg border border-gray-100 bg-gray-50/60 px-3 py-2">
      <dt className="text-[9px] font-semibold uppercase tracking-[0.16em] text-gray-400">{label}</dt>
      <dd className={`mt-0.5 text-xs text-gray-700 ${truncate ? "truncate" : "break-words"}`} title={truncate ? value : undefined}>
        {value}
      </dd>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Style constants
// ---------------------------------------------------------------------------
const inputCls =
  "w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm text-gray-800 outline-none transition focus:border-[#002D62] focus:ring-1 focus:ring-[#002D62]/20";

const primaryBtn =
  "rounded-lg bg-[#002D62] px-4 py-2 text-xs font-semibold uppercase tracking-[0.14em] text-white transition hover:bg-[#002D62]/90 disabled:cursor-not-allowed disabled:opacity-50";

const secondaryBtn =
  "rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-semibold uppercase tracking-[0.14em] text-[#002D62] transition hover:border-[#CE1126] hover:text-[#CE1126] disabled:opacity-50";

const dangerBtn =
  "rounded-lg bg-[#CE1126] px-4 py-2 text-xs font-semibold uppercase tracking-[0.14em] text-white transition hover:bg-[#CE1126]/90 disabled:cursor-not-allowed disabled:opacity-50";
