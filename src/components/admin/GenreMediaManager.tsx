"use client";

import { useCallback, useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { extractYouTubeVideoId } from "@/utils/youtube";

type Media = {
  id: string; title: string; url: string; media_type: string; platform: string;
  external_id: string | null; thumbnail_url: string | null; published_date: string | null;
  youtube_channel_id: string | null; youtube_channel_name: string | null;
  youtube_channel_url: string | null; youtube_channel_avatar_url: string | null;
  youtube_metadata_fetched_at: string | null; is_official: boolean; is_featured: boolean;
  display_order: number; notes: string | null;
};

type Form = Omit<Media, "id" | "display_order" | "is_official" | "is_featured"> & {
  display_order: string; is_official: boolean; is_featured: boolean;
};

const emptyForm: Form = {
  title: "", url: "", media_type: "video", platform: "youtube", external_id: "",
  thumbnail_url: "", published_date: "", youtube_channel_id: "", youtube_channel_name: "",
  youtube_channel_url: "", youtube_channel_avatar_url: "", youtube_metadata_fetched_at: "",
  is_official: false, is_featured: false, display_order: "0", notes: "",
};

const inputClass = "w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm text-gray-800 outline-none focus:border-[#002D62]";
const nullable = (value: string | null) => value?.trim() || null;

export default function GenreMediaManager({ genreId, genreName }: { genreId: string | number; genreName: string }) {
  const t = useTranslations("admin.genres.media");
  const [items, setItems] = useState<Media[]>([]);
  const [form, setForm] = useState<Form>(emptyForm);
  const [editingId, setEditingId] = useState("");
  const [status, setStatus] = useState("");
  const [loading, setLoading] = useState(false);

  const load = useCallback(async () => {
    const response = await fetch(`/api/admin/genre-media?genreId=${encodeURIComponent(String(genreId))}`);
    const result = await response.json();
    if (!response.ok || !result.ok) { setStatus(result.error || response.statusText); return; }
    setItems(result.media ?? []);
  }, [genreId]);

  useEffect(() => {
    // Load the media attached to the newly selected taxonomy record.
    // eslint-disable-next-line react-hooks/set-state-in-effect
    void load();
  }, [load]);
  const update = <K extends keyof Form>(key: K, value: Form[K]) => setForm((current) => ({ ...current, [key]: value }));
  const reset = () => { setForm(emptyForm); setEditingId(""); setStatus(""); };

  const edit = (item: Media) => {
    setEditingId(item.id);
    setForm({
      title: item.title, url: item.url, media_type: item.media_type, platform: item.platform,
      external_id: item.external_id ?? "", thumbnail_url: item.thumbnail_url ?? "",
      published_date: item.published_date ?? "", youtube_channel_id: item.youtube_channel_id ?? "",
      youtube_channel_name: item.youtube_channel_name ?? "", youtube_channel_url: item.youtube_channel_url ?? "",
      youtube_channel_avatar_url: item.youtube_channel_avatar_url ?? "",
      youtube_metadata_fetched_at: item.youtube_metadata_fetched_at ?? "", is_official: item.is_official,
      is_featured: item.is_featured, display_order: String(item.display_order), notes: item.notes ?? "",
    });
  };

  const metadata = async () => {
    const videoId = (form.external_id ?? "").trim() || extractYouTubeVideoId(form.url);
    if (!videoId) { setStatus(t("youtubeRequired")); return; }
    setLoading(true);
    const response = await fetch("/api/admin/youtube-metadata", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ videoId, url: form.url || undefined }) });
    const result = await response.json();
    if (response.ok && result.ok && result.metadata) {
      const m = result.metadata;
      setForm((current) => ({ ...current, external_id: videoId, title: current.title || m.title || "", thumbnail_url: current.thumbnail_url || m.thumbnail_url || "", published_date: m.published_date || current.published_date, youtube_channel_id: m.youtube_channel_id || "", youtube_channel_name: m.youtube_channel_name || "", youtube_channel_url: m.youtube_channel_url || "", youtube_channel_avatar_url: m.youtube_channel_avatar_url || "", youtube_metadata_fetched_at: new Date().toISOString() }));
      setStatus(t("metadataLoaded"));
    } else setStatus(result.error || response.statusText);
    setLoading(false);
  };

  const save = async () => {
    if (!form.title.trim() || !form.url.trim()) { setStatus(t("required")); return; }
    setLoading(true);
    const mediaData = { ...form, genre_id: genreId, external_id: nullable(form.external_id), thumbnail_url: nullable(form.thumbnail_url), published_date: nullable(form.published_date), youtube_channel_id: nullable(form.youtube_channel_id), youtube_channel_name: nullable(form.youtube_channel_name), youtube_channel_url: nullable(form.youtube_channel_url), youtube_channel_avatar_url: nullable(form.youtube_channel_avatar_url), youtube_metadata_fetched_at: nullable(form.youtube_metadata_fetched_at), notes: nullable(form.notes), display_order: Number(form.display_order) || 0 };
    const response = await fetch("/api/admin/genre-media", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ mediaId: editingId || null, mediaData }) });
    const result = await response.json();
    if (!response.ok || !result.ok) setStatus(result.error || response.statusText);
    else { reset(); await load(); setStatus(t("saved")); }
    setLoading(false);
  };

  const remove = async (item: Media) => {
    if (!window.confirm(t("deleteConfirm", { title: item.title }))) return;
    const response = await fetch("/api/admin/genre-media", { method: "DELETE", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ mediaId: item.id, genreId }) });
    const result = await response.json();
    if (!response.ok || !result.ok) setStatus(result.error || response.statusText); else await load();
  };

  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
      <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">{t("heading", { genre: genreName })}</h2>
      {status && <p className="mt-3 text-sm text-gray-600">{status}</p>}
      <div className="mt-5 space-y-2">
        {items.map((item) => <div key={item.id} className="flex items-center justify-between gap-3 rounded-lg border border-gray-100 p-3"><div><p className="text-sm font-medium text-[#002D62]">{item.title}</p><p className="text-xs text-gray-400">{item.platform} · {item.media_type} · {item.display_order}</p></div><div className="flex gap-2"><button type="button" onClick={() => edit(item)} className="text-xs text-[#002D62] underline">{t("edit")}</button><button type="button" onClick={() => void remove(item)} className="text-xs text-[#CE1126] underline">{t("delete")}</button></div></div>)}
      </div>
      <div className="mt-5 grid gap-3 md:grid-cols-2">
        <input className={inputClass} placeholder={t("title")} value={form.title} onChange={(e) => update("title", e.target.value)} />
        <input className={inputClass} placeholder={t("url")} value={form.url} onChange={(e) => { update("url", e.target.value); const id = extractYouTubeVideoId(e.target.value); if (id) update("external_id", id); }} />
        <select className={inputClass} value={form.media_type} onChange={(e) => update("media_type", e.target.value)}><option value="video">Video</option><option value="interview">Interview</option><option value="documentary">Documentary</option><option value="live_performance">Live Performance</option></select>
        <input className={inputClass} placeholder={t("videoId")} value={form.external_id ?? ""} onChange={(e) => update("external_id", e.target.value)} />
        <input type="date" className={inputClass} value={form.published_date ?? ""} onChange={(e) => update("published_date", e.target.value)} />
        <input type="number" className={inputClass} placeholder={t("order")} value={form.display_order} onChange={(e) => update("display_order", e.target.value)} />
        <textarea className={`${inputClass} md:col-span-2`} placeholder={t("notes")} value={form.notes ?? ""} onChange={(e) => update("notes", e.target.value)} />
        <label className="text-sm"><input type="checkbox" checked={form.is_official} onChange={(e) => update("is_official", e.target.checked)} /> {t("official")}</label>
        <label className="text-sm"><input type="checkbox" checked={form.is_featured} onChange={(e) => update("is_featured", e.target.checked)} /> {t("featured")}</label>
      </div>
      <div className="mt-4 flex flex-wrap gap-3"><button type="button" disabled={loading} onClick={() => void metadata()} className="rounded-lg border px-4 py-2 text-sm text-[#002D62]">{t("loadMetadata")}</button><button type="button" disabled={loading} onClick={() => void save()} className="rounded-lg bg-[#002D62] px-4 py-2 text-sm text-white">{editingId ? t("update") : t("add")}</button>{editingId && <button type="button" onClick={reset} className="rounded-lg border px-4 py-2 text-sm">{t("cancel")}</button>}</div>
    </section>
  );
}
