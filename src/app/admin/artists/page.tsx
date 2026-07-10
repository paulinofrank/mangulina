// src/app/admin/page.tsx
"use client";

import Image from "next/image";
import Link from "next/link";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useTranslations } from "next-intl";
import type { FormEvent } from "react";
import { getSupabaseClient } from "@/lib/supabase";
import {
  artistRelationshipTypeLabels,
  formatArtistRelationshipType,
  formatRelationshipYears,
  type ArtistRelationship,
  type ArtistRelationshipType,
} from "@/lib/artistRelationships";
import type { Artist } from "@/types/music";
import { getArtistImageUrlIfAvailable } from "@/utils/getArtistImageUrl";
import { extractYouTubeVideoId } from "@/utils/youtube";
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
  bio_en?: string | null;
  bio_es?: string | null;
  gender?: string | null;
  disambiguation?: string | null;
  ended?: boolean | null;
  wikidata_id?: string | null;
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
  bio_en: string;
  bio_es: string;
  ended: boolean;
};

type LocalizedBioField = "bio_en" | "bio_es";

type AdminArtistMedia = {
  id: string;
  artist_id: string;
  media_type: string;
  title: string;
  url: string;
  platform: string;
  external_id: string | null;
  thumbnail_url: string | null;
  published_date: string | null;
  youtube_channel_id: string | null;
  youtube_channel_name: string | null;
  youtube_channel_url: string | null;
  youtube_channel_avatar_url: string | null;
  youtube_metadata_fetched_at: string | null;
  is_official: boolean;
  is_featured: boolean;
  display_order: number;
  notes: string | null;
};

type ArtistMediaForm = {
  media_type: string;
  title: string;
  url: string;
  platform: string;
  external_id: string;
  thumbnail_url: string;
  published_date: string;
  youtube_channel_id: string;
  youtube_channel_name: string;
  youtube_channel_url: string;
  youtube_channel_avatar_url: string;
  youtube_metadata_fetched_at: string;
  is_official: boolean;
  is_featured: boolean;
  display_order: string;
  notes: string;
};

type AdminWriteResponse = {
  ok: boolean;
  id?: string;
  artistId?: string;
  error?: string;
};

type ArtistMediaListResponse = {
  ok: boolean;
  media?: AdminArtistMedia[];
  error?: string;
};

type YouTubeMetadata = {
  title: string | null;
  thumbnail_url: string | null;
  published_date: string | null;
  youtube_channel_id: string | null;
  youtube_channel_name: string | null;
  youtube_channel_url: string | null;
  youtube_channel_avatar_url: string | null;
};

type YouTubeMetadataResponse = {
  ok: boolean;
  metadata?: YouTubeMetadata;
  error?: string;
};

type ArtistRelationshipForm = {
  target_artist_id: string;
  relationship_type: ArtistRelationshipType;
  start_year: string;
  end_year: string;
  notes: string;
};

type ArtistRelationshipListResponse = {
  ok: boolean;
  outgoing?: ArtistRelationship[];
  incoming?: ArtistRelationship[];
  error?: string;
};

type GenreCatalogRow = {
  id: string | number;
  name: string;
  slug?: string | null;
  display_order?: number | null;
};

type SubgenreCatalogRow = {
  id: string | number;
  genre_id: string | number;
  name: string;
};

type AdminGenresResponse = {
  ok: boolean;
  genres?: GenreCatalogRow[];
  error?: string;
};

type AdminSubgenresResponse = {
  ok: boolean;
  subgenres?: SubgenreCatalogRow[];
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

type MusicalGenreOption = {
  value: string;
  label: string;
  searchValues: string[];
};

type PrimaryGenreOption = {
  value: string;
  label: string;
};

const emptyMediaForm: ArtistMediaForm = {
  media_type: "interview",
  title: "",
  url: "",
  platform: "youtube",
  external_id: "",
  thumbnail_url: "",
  published_date: "",
  youtube_channel_id: "",
  youtube_channel_name: "",
  youtube_channel_url: "",
  youtube_channel_avatar_url: "",
  youtube_metadata_fetched_at: "",
  is_official: false,
  is_featured: false,
  display_order: "0",
  notes: "",
};

const emptyRelationshipForm: ArtistRelationshipForm = {
  target_artist_id: "",
  relationship_type: "member_of",
  start_year: "",
  end_year: "",
  notes: "",
};

const mediaTypeOptions = [
  { value: "interview", label: "Interview" },
  { value: "video", label: "Video" },
  { value: "live_performance", label: "Live Performance" },
  { value: "tv_performance", label: "TV Performance" },
  { value: "documentary", label: "Documentary" },
  { value: "behind_the_scenes", label: "Behind the Scenes" },
  { value: "short_clip", label: "Short Clip" },
  { value: "audio", label: "Audio" },
  { value: "podcast", label: "Podcast" },
  { value: "other", label: "Other" },
];

const platformOptions = [
  { value: "youtube", label: "YouTube" },
  { value: "facebook", label: "Facebook" },
  { value: "instagram", label: "Instagram" },
  { value: "tiktok", label: "TikTok" },
  { value: "vimeo", label: "Vimeo" },
  { value: "spotify", label: "Spotify" },
  { value: "apple_podcasts", label: "Apple Podcasts" },
  { value: "website", label: "Website" },
  { value: "archive", label: "Archive" },
  { value: "other", label: "Other" },
];

const artistTypeOptions = [
  { value: "", label: "-- Select Artist Type --" },
  { value: "person", label: "Person" },
  { value: "duo", label: "Duo" },
  { value: "group", label: "Group" },
  { value: "orchestra", label: "Orchestra" },
  { value: "choir", label: "Choir" },
  { value: "other", label: "Other" },
];

const relationshipTypeOptions = [
  { value: "member_of", label: "Member" },
  { value: "founder_of", label: "Founder" },
  { value: "leader_of", label: "Leader" },
] satisfies { value: ArtistRelationshipType; label: string }[];

const primaryRoleOptions = [
  { value: "", label: "-- Select Primary Role --" },
  { value: "singer", label: "Singer" },
  { value: "musician", label: "Musician" },
  { value: "composer", label: "Composer" },
  { value: "songwriter", label: "Songwriter" },
  { value: "producer", label: "Producer" },
  { value: "arranger", label: "Arranger" },
  { value: "bandleader", label: "Bandleader" },
  { value: "orchestra", label: "Orchestra" },
  { value: "dj", label: "DJ" },
  { value: "rapper", label: "Rapper" },
  { value: "instrumentalist", label: "Instrumentalist" },
  { value: "other", label: "Other" },
];

const instrumentOptions = [
  "accordion",
  "bass",
  "bongos",
  "congas",
  "drums",
  "guitar",
  "guira",
  "keyboard",
  "maracas",
  "piano",
  "saxophone",
  "tambora",
  "trombone",
  "trumpet",
  "violin",
  "voice",
];

const religiousTagOptions = ["christian", "secular"];
const careerStageTagOptions = ["legend", "emerging"];
const genderOptions = ["male", "female", "other", "group"];

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
  bio_en: "",
  bio_es: "",
  ended: false,
};

const provinceOptions = [
  "X - Born Outside",
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

function toggleCsvValue(value: string, option: string) {
  const items = parseCsv(value);
  const normalized = option.toLowerCase();
  const exists = items.some((item) => item.toLowerCase() === normalized);
  const nextItems = exists
    ? items.filter((item) => item.toLowerCase() !== normalized)
    : [...items, option];

  return nextItems.join(", ");
}

function toggleExclusiveCsvValue(
  value: string,
  options: string[],
  selectedOption: string
) {
  const items = parseCsv(value);
  const isSelected = items.some(
    (item) => item.toLowerCase() === selectedOption.toLowerCase()
  );
  const optionSet = new Set(options.map((option) => option.toLowerCase()));
  const remainingItems = items.filter(
    (item) => !optionSet.has(item.toLowerCase())
  );

  return isSelected ? remainingItems.join(", ") : [...remainingItems, selectedOption].join(", ");
}

function nullable(value: string | null | undefined) {
  const trimmed = (value ?? "").trim();
  return trimmed ? trimmed : null;
}

function slugify(value: string) {
  return value
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/&/g, " and ")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .replace(/-{2,}/g, "-");
}

function yearFromDate(value: string) {
  const year = value.slice(0, 4);
  return /^\d{4}$/.test(year) ? year : "";
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

function buildPrimaryGenreOptions(genres: GenreCatalogRow[]): PrimaryGenreOption[] {
  return [
    { value: "", label: "-- Select Primary Genre --" },
    ...genres
      .map((genre) => ({
        value: genre.slug || genre.name,
        label: genre.name,
      }))
      .filter((option) => option.value && option.label)
      .sort((a, b) => a.label.localeCompare(b.label)),
  ];
}

function buildMusicalGenreOptions(subgenres: SubgenreCatalogRow[]): MusicalGenreOption[] {
  const options = new Map<string, MusicalGenreOption>();

  for (const subgenre of subgenres) {
    if (!subgenre.name) continue;

    const value = subgenre.name;
    const key = value.toLowerCase();

    options.set(key, {
      value,
      label: subgenre.name,
      searchValues: [value, subgenre.name].map((item) => item.toLowerCase()),
    });
  }

  return Array.from(options.values()).sort((a, b) => a.label.localeCompare(b.label));
}

function isMusicalGenreSelected(selectedValues: string[], option: MusicalGenreOption) {
  return selectedValues.some((item) => {
    const normalized = item.toLowerCase();
    return option.searchValues.includes(normalized);
  });
}

function detectMediaPlatform(url: string) {
  const normalized = url.toLowerCase();

  if (normalized.includes("youtube.com") || normalized.includes("youtu.be")) {
    return "youtube";
  }

  if (normalized.includes("facebook.com") || normalized.includes("fb.watch")) {
    return "facebook";
  }

  if (normalized.includes("instagram.com")) return "instagram";
  if (normalized.includes("tiktok.com")) return "tiktok";
  if (normalized.includes("vimeo.com")) return "vimeo";
  if (normalized.includes("spotify.com")) return "spotify";
  if (normalized.includes("podcasts.apple.com")) return "apple_podcasts";
  if (normalized.includes("archive.org")) return "archive";

  return "other";
}

export default function AdminDashboard() {
  const t = useTranslations();
  const supabase = getSupabaseClient();

  const [mounted, setMounted] = useState(false);
  const [artists, setArtists] = useState<AdminArtist[]>([]);
  const [selectedArtistId, setSelectedArtistId] = useState("");
  const [search, setSearch] = useState("");
  const [artistPickerOpen, setArtistPickerOpen] = useState(false);
  const [form, setForm] = useState<ArtistForm>(emptyForm);
  const [primaryGenreOptions, setPrimaryGenreOptions] = useState<PrimaryGenreOption[]>([
    { value: "", label: "-- Select Primary Genre --" },
  ]);
  const [musicalGenreOptions, setMusicalGenreOptions] = useState<MusicalGenreOption[]>([]);
  const [artistMedia, setArtistMedia] = useState<AdminArtistMedia[]>([]);
  const [mediaForm, setMediaForm] = useState<ArtistMediaForm>(emptyMediaForm);
  const [editingMediaId, setEditingMediaId] = useState("");
  const [outgoingRelationships, setOutgoingRelationships] = useState<ArtistRelationship[]>([]);
  const [incomingRelationships, setIncomingRelationships] = useState<ArtistRelationship[]>([]);
  const [relationshipForm, setRelationshipForm] = useState<ArtistRelationshipForm>(emptyRelationshipForm);
  const [editingRelationshipId, setEditingRelationshipId] = useState("");
  const [relationshipArtistSearch, setRelationshipArtistSearch] = useState("");
  const [relationshipArtistPickerOpen, setRelationshipArtistPickerOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");
  const [previewImageUrl, setPreviewImageUrl] = useState<string | null>(null);
  const bioTextareaRefs = useRef<Record<LocalizedBioField, HTMLTextAreaElement | null>>({
    bio_en: null,
    bio_es: null,
  });

  const selectedArtist = useMemo(
    () => artists.find((artist) => artist.id === selectedArtistId) || null,
    [artists, selectedArtistId]
  );

  const selectedArtistImageUrl = previewImageUrl || getArtistImageUrlIfAvailable(selectedArtist) || null;

  const mediaYouTubeVideoId =
    mediaForm.platform === "youtube"
      ? mediaForm.external_id.trim() || extractYouTubeVideoId(mediaForm.url)
      : "";
  const canAutofillYouTubeMetadata = Boolean(
    mediaForm.platform === "youtube" && mediaYouTubeVideoId && !loading
  );

  const filteredArtists = useMemo(() => {
    const query = search.trim().toLowerCase();

    if (!query) return artists;

    return artists.filter((artist) =>
      [
        artist.name,
        artist.stage_name,
        artist.sort_name,
        artist.slug,
        artist.province,
        artist.status,
      ]
        .filter(Boolean)
        .some((value) => String(value).toLowerCase().includes(query))
    );
  }, [artists, search]);

  const selectedRelationshipArtist = useMemo(
    () => artists.find((artist) => artist.id === relationshipForm.target_artist_id) || null,
    [artists, relationshipForm.target_artist_id]
  );

  const filteredRelationshipArtists = useMemo(() => {
    const query = relationshipArtistSearch.trim().toLowerCase();

    return artists
      .filter((artist) => artist.id !== selectedArtistId)
      .filter((artist) => {
        if (!query) return true;

        return [
          artist.name,
          artist.stage_name,
          artist.sort_name,
          artist.slug,
          artist.type,
        ]
          .filter(Boolean)
          .some((value) => String(value).toLowerCase().includes(query));
      })
      .slice(0, 40);
  }, [artists, relationshipArtistSearch, selectedArtistId]);

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

    setLoading(false);
  }, [supabase]);

  const fetchGenreCatalog = useCallback(async () => {
    const [genresResponse, subgenresResponse] = await Promise.all([
      fetch("/api/admin/genres"),
      fetch("/api/admin/subgenres?all=1"),
    ]);
    const genresResult = await readAdminJson<AdminGenresResponse>(
      genresResponse,
      "Genres endpoint did not return JSON"
    );
    const subgenresResult = await readAdminJson<AdminSubgenresResponse>(
      subgenresResponse,
      "Subgenres endpoint did not return JSON"
    );

    if (!genresResponse.ok || !genresResult.ok) {
      setStatus(`Error loading genres: ${genresResult.error || genresResponse.statusText}`);
      return;
    }

    if (!subgenresResponse.ok || !subgenresResult.ok) {
      setStatus(`Error loading subgenres: ${subgenresResult.error || subgenresResponse.statusText}`);
      return;
    }

    setPrimaryGenreOptions(buildPrimaryGenreOptions(genresResult.genres ?? []));
    setMusicalGenreOptions(buildMusicalGenreOptions(subgenresResult.subgenres ?? []));
  }, []);

  const fetchArtistMedia = useCallback(
    async (artistId: string) => {
      const response = await fetch(
        `/api/admin/artist-media?artistId=${encodeURIComponent(artistId)}`
      );
      const result = (await response.json()) as ArtistMediaListResponse;

      if (!response.ok || !result.ok) {
        setStatus(`Error loading artist media: ${result.error || response.statusText}`);
        setArtistMedia([]);
        return;
      }

      setArtistMedia(result.media ?? []);
    },
    []
  );

  const fetchArtistRelationships = useCallback(
    async (artistId: string) => {
      const response = await fetch(
        `/api/admin/artist-relationships?artistId=${encodeURIComponent(artistId)}`
      );
      const result = (await response.json()) as ArtistRelationshipListResponse;

      if (!response.ok || !result.ok) {
        setStatus(`Error loading artist relationships: ${result.error || response.statusText}`);
        setOutgoingRelationships([]);
        setIncomingRelationships([]);
        return;
      }

      setOutgoingRelationships(result.outgoing ?? []);
      setIncomingRelationships(result.incoming ?? []);
    },
    []
  );

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (!mounted) return;

    void fetchData();
    void fetchGenreCatalog();
  }, [fetchData, fetchGenreCatalog, mounted]);

  useEffect(() => {
    return () => {
      if (previewImageUrl?.startsWith("blob:")) {
        URL.revokeObjectURL(previewImageUrl);
      }
    };
  }, [previewImageUrl]);

  function updateForm<K extends keyof ArtistForm>(key: K, value: ArtistForm[K]) {
    setForm((current) => ({
      ...current,
      [key]: value,
    }));
  }

  function updateArtistName(value: string) {
    setForm((current) => ({
      ...current,
      name: value,
      slug:
        selectedArtistId ||
        (current.slug.trim() && current.slug !== slugify(current.name))
          ? current.slug
          : slugify(value),
    }));
  }

  function updateDateWithYear(
    dateKey: "date_of_birth" | "date_of_death",
    yearKey: "birth_year" | "death_year",
    value: string
  ) {
    const nextYear = yearFromDate(value);

    setForm((current) => ({
      ...current,
      [dateKey]: value,
      [yearKey]: nextYear || current[yearKey],
    }));
  }

  function updateMediaForm<K extends keyof ArtistMediaForm>(
    key: K,
    value: ArtistMediaForm[K]
  ) {
    setMediaForm((current) => {
      if (key !== "url" || typeof value !== "string") {
        return {
          ...current,
          [key]: value,
        };
      }

      const platform = detectMediaPlatform(value);
      const externalId = platform === "youtube" ? extractYouTubeVideoId(value) : "";

      return {
        ...current,
        url: value,
        platform,
        external_id: externalId || current.external_id,
      };
    });
  }

  function updateRelationshipForm<K extends keyof ArtistRelationshipForm>(
    key: K,
    value: ArtistRelationshipForm[K]
  ) {
    setRelationshipForm((current) => ({
      ...current,
      [key]: value,
    }));
  }

  function resetMediaForm() {
    setMediaForm({ ...emptyMediaForm });
    setEditingMediaId("");
  }

  function resetRelationshipForm() {
    setRelationshipForm({ ...emptyRelationshipForm });
    setEditingRelationshipId("");
    setRelationshipArtistSearch("");
    setRelationshipArtistPickerOpen(false);
  }

  function resetForm() {
    setSelectedArtistId("");
    setSearch("");
    setArtistPickerOpen(false);
    setForm({ ...emptyForm });
    setArtistMedia([]);
    setOutgoingRelationships([]);
    setIncomingRelationships([]);
    resetMediaForm();
    resetRelationshipForm();
    setStatus("");
  }

  function focusBioSelection(field: LocalizedBioField, start: number, end: number) {
    window.setTimeout(() => {
      bioTextareaRefs.current[field]?.focus();
      bioTextareaRefs.current[field]?.setSelectionRange(start, end);
    }, 0);
  }

  function wrapBioSelection(
    field: LocalizedBioField,
    prefix: string,
    suffix = prefix,
    placeholder = "text"
  ) {
    const textarea = bioTextareaRefs.current[field];
    const value = form[field] ?? "";
    const start = textarea?.selectionStart ?? value.length;
    const end = textarea?.selectionEnd ?? value.length;
    const selectedText = value.slice(start, end) || placeholder;
    const nextBio = `${value.slice(0, start)}${prefix}${selectedText}${suffix}${value.slice(end)}`;
    const nextStart = start + prefix.length;
    const nextEnd = nextStart + selectedText.length;

    updateForm(field, nextBio);
    focusBioSelection(field, nextStart, nextEnd);
  }

  function formatBioLines(
    field: LocalizedBioField,
    prefix: string,
    placeholder = "New line"
  ) {
    const textarea = bioTextareaRefs.current[field];
    const value = form[field] ?? "";
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

    updateForm(field, nextBio);
    focusBioSelection(field, start, start + formattedText.length);
  }

  function insertBioLink(field: LocalizedBioField) {
    const href = window.prompt("Paste the full URL for this link:");

    if (!href?.trim()) return;

    wrapBioSelection(field, "[", `](${href.trim()})`, "link text");
  }

  function handleSelectArtistForEdit(id: string) {
    const artist = artists.find((item) => item.id === id);

    if (!artist) {
      resetForm();
      return;
    }

    setSelectedArtistId(artist.id);
    setSearch(artist.name ?? "");
    setArtistPickerOpen(false);
    setPreviewImageUrl(null);
    resetMediaForm();
    resetRelationshipForm();
    void fetchArtistMedia(artist.id);
    void fetchArtistRelationships(artist.id);

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
      bio_en: artist.bio_en ?? "",
      bio_es: artist.bio_es ?? "",
      ended: Boolean(artist.ended),
    });

    setStatus("");
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
        cacheControl: "0",
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

    const imageUpdatedAt = new Date().toISOString();

    const { data: updatedArtist, error: artistUpdateError } = await supabase
      .from("artists")
      .update({ has_image: true, image_updated_at: imageUpdatedAt })
      .eq("id", selectedArtistId)
      .select("id, has_image, image_updated_at")
      .single();

    if (artistUpdateError) {
      console.error("Error marking artist image as available:", artistUpdateError);
      setStatus(
        `Artist image uploaded as ${filePath}, but database metadata was not updated: ${artistUpdateError.message}`
      );
      setLoading(false);
      return;
    }

    if (!updatedArtist || updatedArtist.has_image !== true || !updatedArtist.image_updated_at) {
      console.error("Artist update verification failed:", { updatedArtist });
      setStatus(
        `Artist image uploaded as ${filePath}, but database metadata verification failed.`
      );
      setLoading(false);
      return;
    }

    setArtists((current) =>
      current.map((artist) =>
        artist.id === selectedArtistId
          ? {
              ...artist,
              has_image: updatedArtist.has_image,
              image_updated_at: updatedArtist.image_updated_at,
            }
          : artist,
      ),
    );

    let freshnessWarning = "";
    const selectedArtistSlug = selectedArtist?.slug?.trim();

    if (selectedArtistSlug) {
      try {
        const revalidateResponse = await fetch("/api/admin/revalidate-artist-profile", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ slug: selectedArtistSlug }),
        });

        const contentType = revalidateResponse.headers.get("content-type");
        if (!contentType?.includes("application/json")) {
          const body = await revalidateResponse.text();
          throw new Error(
            `Expected JSON from revalidate endpoint, received ${contentType ?? "unknown content type"}: ${body.slice(0, 200)}`,
          );
        }

        const revalidateResult = (await revalidateResponse.json()) as AdminWriteResponse;

        if (!revalidateResponse.ok || !revalidateResult.ok) {
          freshnessWarning = ` Profile revalidation failed: ${revalidateResult.error || revalidateResponse.statusText}`;
        }
      } catch (error) {
        freshnessWarning = ` Profile revalidation failed: ${error instanceof Error ? error.message : "Unknown error"}`;
      }
    } else {
      freshnessWarning = " Profile revalidation skipped because the artist slug is missing.";
    }

    setStatus(`Artist image uploaded successfully as ${filePath}.${freshnessWarning}`);
    setPreviewImageUrl((currentUrl) => {
      if (currentUrl?.startsWith("blob:")) {
        URL.revokeObjectURL(currentUrl);
      }

      return URL.createObjectURL(file);
    });
    await fetchData();

    setLoading(false);
  }

  function handleEditArtistMedia(item: AdminArtistMedia) {
    setEditingMediaId(item.id);
    setMediaForm({
      media_type: item.media_type ?? "interview",
      title: item.title ?? "",
      url: item.url ?? "",
      platform: item.platform ?? "other",
      external_id: item.external_id ?? "",
      thumbnail_url: item.thumbnail_url ?? "",
      published_date: item.published_date ?? "",
      youtube_channel_id: item.youtube_channel_id ?? "",
      youtube_channel_name: item.youtube_channel_name ?? "",
      youtube_channel_url: item.youtube_channel_url ?? "",
      youtube_channel_avatar_url: item.youtube_channel_avatar_url ?? "",
      youtube_metadata_fetched_at: item.youtube_metadata_fetched_at ?? "",
      is_official: Boolean(item.is_official),
      is_featured: Boolean(item.is_featured),
      display_order: String(item.display_order ?? 0),
      notes: item.notes ?? "",
    });
  }

  async function handleAutofillYouTubeMetadata() {
    const videoId = mediaYouTubeVideoId;

    if (!videoId && !mediaForm.url.trim()) {
      setStatus("Paste a YouTube URL or enter a YouTube video ID first.");
      return;
    }

    setLoading(true);
    setStatus("Loading YouTube metadata...");

    try {
      const response = await fetch("/api/admin/youtube-metadata", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          videoId: videoId || undefined,
          url: mediaForm.url.trim() || undefined,
        }),
      });
      const result = (await response.json()) as YouTubeMetadataResponse;

      if (!response.ok || !result.ok || !result.metadata) {
        setStatus(
          `Could not load YouTube metadata: ${result.error || response.statusText}`
        );
        return;
      }

      const metadata = result.metadata;
      setMediaForm((current) => ({
        ...current,
        title: current.title.trim() || metadata.title || current.title,
        thumbnail_url:
          current.thumbnail_url.trim() ||
          metadata.thumbnail_url ||
          current.thumbnail_url,
        published_date: metadata.published_date || current.published_date,
        youtube_channel_id:
          metadata.youtube_channel_id || current.youtube_channel_id,
        youtube_channel_name:
          metadata.youtube_channel_name || current.youtube_channel_name,
        youtube_channel_url:
          metadata.youtube_channel_url || current.youtube_channel_url,
        youtube_channel_avatar_url:
          metadata.youtube_channel_avatar_url ||
          current.youtube_channel_avatar_url,
        youtube_metadata_fetched_at: new Date().toISOString(),
      }));
      setStatus("YouTube metadata loaded.");
    } catch (error) {
      setStatus(
        `Could not load YouTube metadata: ${
          error instanceof Error ? error.message : "Unknown error"
        }`
      );
    } finally {
      setLoading(false);
    }
  }

  async function handleSaveArtistMedia() {
    if (!selectedArtistId) {
      setStatus("Select and save an artist before adding media.");
      return;
    }

    if (!mediaForm.title.trim() || !mediaForm.url.trim()) {
      setStatus("Media title and URL are required.");
      return;
    }

    setLoading(true);
    setStatus("");

    const payload = {
      artist_id: selectedArtistId,
      media_type: mediaForm.media_type || "interview",
      title: mediaForm.title.trim(),
      url: mediaForm.url.trim(),
      platform: mediaForm.platform || detectMediaPlatform(mediaForm.url),
      external_id: nullable(mediaForm.external_id),
      thumbnail_url: nullable(mediaForm.thumbnail_url),
      published_date: nullable(mediaForm.published_date),
      youtube_channel_id: nullable(mediaForm.youtube_channel_id),
      youtube_channel_name: nullable(mediaForm.youtube_channel_name),
      youtube_channel_url: nullable(mediaForm.youtube_channel_url),
      youtube_channel_avatar_url: nullable(mediaForm.youtube_channel_avatar_url),
      youtube_metadata_fetched_at: nullable(mediaForm.youtube_metadata_fetched_at),
      is_official: mediaForm.is_official,
      is_featured: mediaForm.is_featured,
      display_order: mediaForm.display_order
        ? Number(mediaForm.display_order)
        : 0,
      notes: nullable(mediaForm.notes),
      updated_at: new Date().toISOString(),
    };

    const response = await fetch("/api/admin/artist-media", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        mediaId: editingMediaId || null,
        mediaData: payload,
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error saving artist media: ${result.error || response.statusText}`);
    } else {
      setStatus(editingMediaId ? "Artist media updated." : "Artist media added.");
      resetMediaForm();
      await fetchArtistMedia(selectedArtistId);
    }

    setLoading(false);
  }

  async function handleDeleteArtistMedia(item: AdminArtistMedia) {
    if (!selectedArtistId) return;

    const confirmed = window.confirm(`Delete this media link?\n\n${item.title}`);
    if (!confirmed) return;

    setLoading(true);
    setStatus("");

    const response = await fetch("/api/admin/artist-media", {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        mediaId: item.id,
        artistId: selectedArtistId,
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error deleting artist media: ${result.error || response.statusText}`);
    } else {
      setStatus("Artist media deleted.");
      if (editingMediaId === item.id) resetMediaForm();
      await fetchArtistMedia(selectedArtistId);
    }

    setLoading(false);
  }

  function handleSelectRelationshipArtist(artist: AdminArtist) {
    updateRelationshipForm("target_artist_id", artist.id);
    setRelationshipArtistSearch(artist.name ?? "");
    setRelationshipArtistPickerOpen(false);
  }

  function handleEditRelationship(item: ArtistRelationship) {
    setEditingRelationshipId(item.id);
    setRelationshipForm({
      target_artist_id: item.target_artist_id,
      relationship_type: item.relationship_type,
      start_year: item.start_year ? String(item.start_year) : "",
      end_year: item.end_year ? String(item.end_year) : "",
      notes: item.notes ?? "",
    });
    setRelationshipArtistSearch(item.target_artist?.name ?? "");
    setRelationshipArtistPickerOpen(false);
  }

  async function handleSaveRelationship() {
    if (!selectedArtistId) {
      setStatus("Select and save an artist before adding groups or projects.");
      return;
    }

    if (!relationshipForm.target_artist_id) {
      setStatus("Choose a related artist, group, duo, or orchestra.");
      return;
    }

    if (relationshipForm.target_artist_id === selectedArtistId) {
      setStatus("An artist cannot be related to itself.");
      return;
    }

    setLoading(true);
    setStatus("");

    const payload = {
      source_artist_id: selectedArtistId,
      target_artist_id: relationshipForm.target_artist_id,
      relationship_type: relationshipForm.relationship_type,
      start_year: relationshipForm.start_year ? Number(relationshipForm.start_year) : null,
      end_year: relationshipForm.end_year ? Number(relationshipForm.end_year) : null,
      notes: nullable(relationshipForm.notes),
    };

    const response = await fetch("/api/admin/artist-relationships", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        relationshipId: editingRelationshipId || null,
        relationshipData: payload,
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error saving artist relationship: ${result.error || response.statusText}`);
    } else {
      setStatus(editingRelationshipId ? "Artist relationship updated." : "Artist relationship added.");
      resetRelationshipForm();
      await fetchArtistRelationships(selectedArtistId);
    }

    setLoading(false);
  }

  async function handleDeleteRelationship(item: ArtistRelationship) {
    if (!selectedArtistId) return;

    const relatedName = item.target_artist?.name ?? "this relationship";
    const confirmed = window.confirm(`Delete this artist relationship?\n\n${relatedName}`);
    if (!confirmed) return;

    setLoading(true);
    setStatus("");

    const response = await fetch("/api/admin/artist-relationships", {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        relationshipId: item.id,
        artistId: selectedArtistId,
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error deleting artist relationship: ${result.error || response.statusText}`);
    } else {
      setStatus("Artist relationship deleted.");
      if (editingRelationshipId === item.id) resetRelationshipForm();
      await fetchArtistRelationships(selectedArtistId);
    }

    setLoading(false);
  }

  async function handleSaveArtist(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    setLoading(true);
    setStatus("");

    const resolvedSlug = form.slug.trim() || slugify(form.name);

    const artistData = {
      name: form.name.trim(),
      sort_name: nullable(form.sort_name),
      slug: nullable(resolvedSlug),
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

      bio_en: nullable(form.bio_en),
      bio_es: nullable(form.bio_es),
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

    const wasEditing = Boolean(selectedArtistId);

    if (!response.ok || !result.ok) {
      setStatus(`Error saving artist: ${result.error || response.statusText}`);
    } else {
      const successMessage = wasEditing
        ? "Artist profile updated. Ready for a new artist."
        : "New artist created. Ready for another profile.";

      await fetchData();
      resetForm();
      setStatus(successMessage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    }

    setLoading(false);
  }

  async function handleDeleteArtist() {
    if (!selectedArtistId || !selectedArtist) return;

    const confirmed = window.confirm(
      `Permanently delete this artist?\n\n${selectedArtist.name}\n\nThis will also delete associated releases, recordings, credits, media, links, lyrics, and other cascaded data. This cannot be undone.`
    );

    if (!confirmed) return;

    setLoading(true);
    setStatus("");

    const response = await fetch("/api/admin/artists", {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        artistId: selectedArtistId,
      }),
    });
    const result = (await response.json()) as AdminWriteResponse;

    if (!response.ok || !result.ok) {
      setStatus(`Error deleting artist: ${result.error || response.statusText}`);
    } else {
      setStatus(`Artist deleted: ${selectedArtist.name}`);
      resetForm();
      await fetchData();
    }

    setLoading(false);
  }

  if (!mounted) {
    return null;
  }

  return (
    <div className="mx-auto max-w-6xl px-5 pb-10 pt-8 font-sans text-(--color-ink) sm:pt-10">
      <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <p className="text-xs font-medium uppercase tracking-[0.22em] text-(--color-wikicrimson)">
              Mangulina Admin
            </p>
            <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-(--color-flagblue) sm:text-4xl">
              Artist Profile Editor
            </h1>

            <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
              Create, review, update, and safely remove curated artist profiles
              from Mangulina.
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

      <div className="grid gap-8 lg:grid-cols-[320px_1fr]">
        <aside className="space-y-5">
          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <h2 className="mb-4 text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Select Artist
            </h2>

            <div className="relative">
              <input
                value={search ?? ""}
                onChange={(event) => {
                  setSearch(event.target.value);
                  setArtistPickerOpen(true);
                }}
                onFocus={() => setArtistPickerOpen(true)}
                onBlur={() => {
                  window.setTimeout(() => setArtistPickerOpen(false), 120);
                }}
                placeholder="Search or select artist..."
                className="w-full rounded-lg border border-gray-200 px-3 py-2 pr-9 text-sm outline-none focus:border-(--color-flagblue)"
                role="combobox"
                aria-expanded={artistPickerOpen}
                aria-controls="admin-artist-picker-results"
              />

              <button
                type="button"
                onClick={() => setArtistPickerOpen((open) => !open)}
                className="absolute right-2 top-1/2 flex h-7 w-7 -translate-y-1/2 items-center justify-center rounded-md text-gray-400 transition hover:bg-gray-100 hover:text-(--color-flagblue)"
                aria-label="Toggle artist list"
              >
                <svg
                  aria-hidden="true"
                  viewBox="0 0 20 20"
                  className="h-4 w-4"
                  fill="currentColor"
                >
                  <path
                    fillRule="evenodd"
                    d="M5.23 7.21a.75.75 0 0 1 1.06.02L10 11.17l3.71-3.94a.75.75 0 1 1 1.08 1.04l-4.25 4.5a.75.75 0 0 1-1.08 0l-4.25-4.5a.75.75 0 0 1 .02-1.06Z"
                    clipRule="evenodd"
                  />
                </svg>
              </button>

              {artistPickerOpen && (
                <div
                  id="admin-artist-picker-results"
                  className="absolute left-0 right-0 top-[calc(100%+0.35rem)] z-30 max-h-72 overflow-y-auto rounded-lg border border-gray-200 bg-white shadow-lg"
                >
                  <button
                    type="button"
                    onMouseDown={(event) => event.preventDefault()}
                    onClick={resetForm}
                    className="block w-full border-b border-gray-100 px-3 py-2 text-left text-sm font-medium text-(--color-flagblue) transition hover:bg-(--color-flagblue)/5"
                  >
                    Create New Artist
                  </button>

                  {filteredArtists.length ? (
                    filteredArtists.map((artist) => (
                      <button
                        key={artist.id}
                        type="button"
                        onMouseDown={(event) => event.preventDefault()}
                        onClick={() => handleSelectArtistForEdit(artist.id)}
                        className={`block w-full border-b border-gray-100 px-3 py-2 text-left text-sm transition last:border-none hover:bg-(--color-flagblue)/5 ${
                          selectedArtistId === artist.id
                            ? "bg-(--color-flagblue)/8 text-(--color-flagblue)"
                            : "text-gray-700"
                        }`}
                      >
                        <span className="block truncate font-medium">{artist.name}</span>
                        {artist.status && artist.status !== "published" && (
                          <span className="mt-0.5 block text-[10px] uppercase tracking-[0.14em] text-gray-400">
                            {artist.status}
                          </span>
                        )}
                      </button>
                    ))
                  ) : (
                    <p className="px-3 py-2 text-sm text-gray-400">
                      No artists found.
                    </p>
                  )}
                </div>
              )}
            </div>

            {selectedArtist && (
              <div className="mt-5">
                <div className="relative aspect-square w-full overflow-hidden rounded-xl bg-gray-100">
                  {selectedArtistImageUrl ? (
                    selectedArtistImageUrl.startsWith("blob:") ? (
                      <img
                        src={selectedArtistImageUrl}
                        alt={selectedArtist.name}
                        className="h-full w-full object-cover"
                      />
                    ) : (
                      <Image
                        src={selectedArtistImageUrl}
                        alt={selectedArtist.name}
                        fill
                        className="object-cover"
                        sizes="320px"
                        unoptimized
                      />
                    )
                  ) : (
                    <div className="flex h-full w-full items-center justify-center text-gray-400 text-sm">
                      No image
                    </div>
                  )}
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

          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <div className="mb-4 flex items-start justify-between gap-3">
              <div>
                <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                  Artist Media / Interviews
                  {selectedArtistId ? ` (${artistMedia.length})` : ""}
                </h2>
                <p className="mt-1 text-xs text-gray-400">
                  Interviews, performances, and other artist media.
                </p>
              </div>

              {editingMediaId && (
                <button
                  type="button"
                  onClick={resetMediaForm}
                  className="shrink-0 text-xs font-semibold text-(--color-wikicrimson)"
                >
                  Cancel
                </button>
              )}
            </div>

            {!selectedArtistId ? (
              <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-500">
                Select an artist before adding media links.
              </p>
            ) : (
              <div className="space-y-4">
                <div className="space-y-2">
                  {artistMedia.length ? (
                    artistMedia.map((item) => (
                      <div
                        key={item.id}
                        className="rounded-lg border border-gray-200 bg-gray-50 px-3 py-3"
                      >
                        <p className="line-clamp-2 text-sm font-semibold leading-snug text-(--color-flagblue)">
                          {item.title}
                        </p>
                        <p className="mt-1 text-xs text-gray-400">
                          {item.platform} - {item.media_type} - order {item.display_order}
                        </p>
                        {(item.youtube_channel_name || item.published_date) && (
                          <p className="mt-1 text-xs text-gray-500">
                            {[item.youtube_channel_name, item.published_date]
                              .filter(Boolean)
                              .join(" - ")}
                          </p>
                        )}
                        {item.notes && (
                          <p className="mt-1 line-clamp-2 text-xs text-gray-500">
                            {item.notes}
                          </p>
                        )}

                        <div className="mt-3 flex items-center gap-2">
                          <button
                            type="button"
                            onClick={() => handleEditArtistMedia(item)}
                            className="rounded-md border border-gray-200 bg-white px-3 py-2 text-xs text-(--color-flagblue) transition hover:border-(--color-flagblue)"
                          >
                            Edit
                          </button>

                          <button
                            type="button"
                            onClick={() => void handleDeleteArtistMedia(item)}
                            className="rounded-md border border-red-100 bg-white px-3 py-2 text-xs text-(--color-wikicrimson) transition hover:border-(--color-wikicrimson)"
                          >
                            Delete
                          </button>
                        </div>
                      </div>
                    ))
                  ) : (
                    <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-400">
                      No media links saved for this artist yet.
                    </p>
                  )}
                </div>

                <div className="space-y-3 border-t border-gray-100 pt-4">
                  <p className="text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
                    {editingMediaId ? "Edit Media Link" : "Add Media Link"}
                  </p>

                  <Field label="Media Title">
                    <input
                      value={mediaForm.title ?? ""}
                      onChange={(event) => updateMediaForm("title", event.target.value)}
                      placeholder="Original video or interview title"
                      className={inputClass}
                    />
                  </Field>

                  <Field label="URL">
                    <input
                      value={mediaForm.url ?? ""}
                      onChange={(event) => updateMediaForm("url", event.target.value)}
                      placeholder="https://www.youtube.com/watch?v=..."
                      className={inputClass}
                    />
                  </Field>

                  <Field label="Media Type">
                    <select
                      value={mediaForm.media_type ?? "interview"}
                      onChange={(event) => updateMediaForm("media_type", event.target.value)}
                      className={inputClass}
                    >
                      {mediaTypeOptions.map((option) => (
                        <option key={option.value} value={option.value}>
                          {option.label}
                        </option>
                      ))}
                    </select>
                  </Field>

                  <Field label="Platform">
                    <select
                      value={mediaForm.platform ?? "other"}
                      onChange={(event) => updateMediaForm("platform", event.target.value)}
                      className={inputClass}
                    >
                      {platformOptions.map((option) => (
                        <option key={option.value} value={option.value}>
                          {option.label}
                        </option>
                      ))}
                    </select>
                  </Field>

                  <Field label="External ID">
                    <input
                      value={mediaForm.external_id ?? ""}
                      onChange={(event) => updateMediaForm("external_id", event.target.value)}
                      placeholder="YouTube video ID, Facebook post ID..."
                      className={inputClass}
                    />
                  </Field>

                  <button
                    type="button"
                    onClick={() => void handleAutofillYouTubeMetadata()}
                    disabled={!canAutofillYouTubeMetadata}
                    className="w-full rounded-lg border border-(--color-flagblue)/20 bg-white px-4 py-2.5 text-xs font-medium uppercase tracking-[0.16em] text-(--color-flagblue) transition hover:border-(--color-flagblue) disabled:cursor-not-allowed disabled:opacity-40"
                  >
                    Auto-fill from YouTube
                  </button>

                  <Field label="Thumbnail URL">
                    <input
                      value={mediaForm.thumbnail_url ?? ""}
                      onChange={(event) => updateMediaForm("thumbnail_url", event.target.value)}
                      placeholder="Optional custom thumbnail"
                      className={inputClass}
                    />
                  </Field>

                  <Field label="YouTube Channel ID">
                    <input
                      value={mediaForm.youtube_channel_id ?? ""}
                      onChange={(event) =>
                        updateMediaForm("youtube_channel_id", event.target.value)
                      }
                      placeholder="YouTube channel ID"
                      className={inputClass}
                    />
                  </Field>

                  <Field label="YouTube Channel Name">
                    <input
                      value={mediaForm.youtube_channel_name ?? ""}
                      onChange={(event) =>
                        updateMediaForm("youtube_channel_name", event.target.value)
                      }
                      placeholder="Channel name"
                      className={inputClass}
                    />
                  </Field>

                  <Field label="YouTube Channel URL">
                    <input
                      value={mediaForm.youtube_channel_url ?? ""}
                      onChange={(event) =>
                        updateMediaForm("youtube_channel_url", event.target.value)
                      }
                      placeholder="https://www.youtube.com/channel/..."
                      className={inputClass}
                    />
                  </Field>

                  <Field label="YouTube Channel Logo URL">
                    <input
                      value={mediaForm.youtube_channel_avatar_url ?? ""}
                      onChange={(event) =>
                        updateMediaForm(
                          "youtube_channel_avatar_url",
                          event.target.value
                        )
                      }
                      placeholder="Channel avatar/logo URL"
                      className={inputClass}
                    />
                  </Field>

                  <div className="grid grid-cols-2 gap-3">
                    <Field label="Published Date">
                      <input
                        type="date"
                        value={mediaForm.published_date ?? ""}
                        onChange={(event) =>
                          updateMediaForm("published_date", event.target.value)
                        }
                        className={inputClass}
                      />
                    </Field>

                    <Field label="Display Order">
                      <input
                        type="number"
                        value={mediaForm.display_order ?? "0"}
                        onChange={(event) =>
                          updateMediaForm("display_order", event.target.value)
                        }
                        className={inputClass}
                      />
                    </Field>
                  </div>

                  <Field label="Notes">
                    <textarea
                      value={mediaForm.notes ?? ""}
                      onChange={(event) => updateMediaForm("notes", event.target.value)}
                      className={`${inputClass} min-h-24 resize-y`}
                      placeholder="Channel name, context, source note..."
                    />
                  </Field>

                  <div className="flex flex-wrap gap-3 rounded-lg border border-gray-200 bg-gray-50 px-4 py-3">
                    <label className="flex items-center gap-2 text-sm text-gray-700">
                      <input
                        type="checkbox"
                        checked={Boolean(mediaForm.is_official)}
                        onChange={(event) =>
                          updateMediaForm("is_official", event.target.checked)
                        }
                        className="h-4 w-4"
                      />
                      Official
                    </label>

                    <label className="flex items-center gap-2 text-sm text-gray-700">
                      <input
                        type="checkbox"
                        checked={Boolean(mediaForm.is_featured)}
                        onChange={(event) =>
                          updateMediaForm("is_featured", event.target.checked)
                        }
                        className="h-4 w-4"
                      />
                      Featured
                    </label>
                  </div>

                  <button
                    type="button"
                    onClick={handleSaveArtistMedia}
                    disabled={Boolean(loading)}
                    className="w-full rounded-lg bg-(--color-flagblue) px-5 py-3 text-xs uppercase tracking-[0.18em] text-white transition disabled:cursor-not-allowed disabled:opacity-40"
                  >
                    {editingMediaId ? "Update Media Link" : "Add Media Link"}
                  </button>
                </div>
              </div>
            )}
          </section>
        </aside>

        <main className="flex flex-col gap-6">
          <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm">
            <div className="mb-6 flex items-center justify-between gap-4">
              <h2 className="text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
                {selectedArtistId ? t("admin.forms.editArtistProfile") : t("admin.forms.createNewArtist")}
              </h2>

              <button
                type="button"
                onClick={resetForm}
                className="rounded-lg border border-(--color-wikicrimson)/25 bg-white px-4 py-2 text-xs font-medium uppercase tracking-[0.16em] text-(--color-wikicrimson) shadow-sm transition hover:border-(--color-wikicrimson) hover:bg-(--color-wikicrimson) hover:text-white"
              >
                {t("admin.buttons.newArtist")}
              </button>
            </div>

            <form onSubmit={handleSaveArtist} className="space-y-6">
              <div className="grid gap-4 md:grid-cols-2">
                <Field label={t("admin.labels.artistName")}>
                  <input
                    value={form.name ?? ""}
                    onChange={(event) => updateArtistName(event.target.value)}
                    required
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.sortName")}>
                  <input
                    value={form.sort_name ?? ""}
                    onChange={(event) =>
                      updateForm("sort_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.slug")}>
                  <input
                    value={form.slug ?? ""}
                    onChange={(event) => updateForm("slug", event.target.value)}
                    placeholder="Auto-created from artist name"
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.stageName")}>
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
                <Field label={t("admin.labels.firstName")}>
                  <input
                    value={form.first_name ?? ""}
                    onChange={(event) =>
                      updateForm("first_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.middleName")}>
                  <input
                    value={form.middle_name ?? ""}
                    onChange={(event) =>
                      updateForm("middle_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.lastName")}>
                  <input
                    value={form.last_name ?? ""}
                    onChange={(event) =>
                      updateForm("last_name", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.secondLastName")}>
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
                <Field label={t("admin.labels.dateOfBirth")}>
                  <input
                    type="date"
                    value={form.date_of_birth ?? ""}
                    onChange={(event) =>
                      updateDateWithYear(
                        "date_of_birth",
                        "birth_year",
                        event.target.value
                      )
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.birthYear")}>
                  <input
                    type="number"
                    value={form.birth_year ?? ""}
                    onChange={(event) =>
                      updateForm("birth_year", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.dateOfDeath")}>
                  <input
                    type="date"
                    value={form.date_of_death ?? ""}
                    onChange={(event) =>
                      updateDateWithYear(
                        "date_of_death",
                        "death_year",
                        event.target.value
                      )
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.deathYear")}>
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

              <div>
                <Field label={t("admin.labels.gender")}>
                  <div className="rounded-lg border border-gray-200 bg-white px-3 py-3">
                    <div className="flex flex-wrap items-center gap-x-4 gap-y-2">
                      {genderOptions.map((gender) => {
                        const selected = form.gender === gender;

                        return (
                          <label
                            key={gender}
                            className="flex items-center gap-2 text-sm capitalize text-gray-700"
                          >
                            <input
                              type="checkbox"
                              checked={selected}
                              onChange={() =>
                                updateForm("gender", selected ? "" : gender)
                              }
                              className="h-4 w-4"
                            />
                            {gender}
                          </label>
                        );
                      })}
                    </div>

                    <div className="mt-3 border-t border-gray-100 pt-3">
                      <label className="flex items-center gap-2 text-sm text-gray-700">
                        <input
                          type="checkbox"
                          checked={Boolean(form.ended)}
                          onChange={(event) =>
                            updateForm("ended", event.target.checked)
                          }
                          className="h-4 w-4"
                        />
                        Ended / No longer active
                      </label>
                      <p className="mt-1 max-w-2xl pl-6 text-xs leading-relaxed text-gray-400">
                        Use this for duos, groups, orchestras, choirs, or projects that are no longer active. For people, use death date/year instead.
                      </p>
                    </div>
                  </div>
                </Field>
              </div>

              <div className="grid gap-4 md:grid-cols-2">
                <Field label={t("admin.labels.placeOfBirth")}>
                  <input
                    value={form.birth_place ?? ""}
                    onChange={(event) =>
                      updateForm("birth_place", event.target.value)
                    }
                    className={inputClass}
                  />
                </Field>

                <Field label={t("admin.labels.province")}>
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
                <Field label={t("admin.labels.artistType")}>
                  <select
                    value={form.type ?? ""}
                    onChange={(event) => updateForm("type", event.target.value)}
                    className={inputClass}
                  >
                    {artistTypeOptions.map((option) => (
                      <option key={option.value || "empty-artist-type"} value={option.value}>
                        {option.label}
                      </option>
                    ))}
                  </select>
                </Field>

                <Field label={t("admin.labels.primaryRole")}>
                  <select
                    value={form.primary_role ?? ""}
                    onChange={(event) =>
                      updateForm("primary_role", event.target.value)
                    }
                    className={inputClass}
                  >
                    {primaryRoleOptions.map((option) => (
                      <option key={option.value || "empty-primary-role"} value={option.value}>
                        {option.label}
                      </option>
                    ))}
                  </select>
                </Field>

                <Field label={t("admin.labels.primaryGenre")}>
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

                <Field label={t("admin.labels.profileStatus")}>
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

              <Field label={t("admin.labels.otherRoles")}>
                <input
                  value={form.occupations ?? ""}
                  onChange={(event) =>
                    updateForm("occupations", event.target.value)
                  }
                  placeholder="singer, composer, producer"
                  className={inputClass}
                />
              </Field>

              <div className="grid gap-4 md:grid-cols-2">
                <Field label={t("admin.labels.musicalGenres")}>
                  <div className="grid gap-2 rounded-lg border border-gray-200 bg-white p-3 sm:grid-cols-2">
                    {musicalGenreOptions.length ? (
                      musicalGenreOptions.map((option) => {
                        const selected = isMusicalGenreSelected(
                          parseCsv(form.genres),
                          option
                        );

                        return (
                          <label
                            key={option.value}
                            className="flex items-center gap-2 text-sm text-gray-700"
                          >
                            <input
                              type="checkbox"
                              checked={selected}
                              onChange={() =>
                                updateForm(
                                  "genres",
                                  toggleCsvValue(form.genres, option.value)
                                )
                              }
                              className="h-4 w-4"
                            />
                            {option.label}
                          </label>
                        );
                      })
                    ) : (
                      <p className="text-sm text-gray-400">
                        Loading subgenres...
                      </p>
                    )}
                  </div>
                </Field>

                <Field label={t("admin.labels.instruments")}>
                  <div className="grid gap-2 rounded-lg border border-gray-200 bg-white p-3 sm:grid-cols-2">
                    {instrumentOptions.map((instrument) => {
                      const selected = parseCsv(form.instruments).some(
                        (item) => item.toLowerCase() === instrument.toLowerCase()
                      );

                      return (
                        <label
                          key={instrument}
                          className="flex items-center gap-2 text-sm capitalize text-gray-700"
                        >
                          <input
                            type="checkbox"
                            checked={selected}
                            onChange={() =>
                              updateForm(
                                "instruments",
                                toggleCsvValue(form.instruments, instrument)
                              )
                            }
                            className="h-4 w-4"
                          />
                          {instrument}
                        </label>
                      );
                    })}
                  </div>
                </Field>
              </div>

              <Field label={t("admin.labels.aliases")}>
                <input
                  value={form.aliases ?? ""}
                  onChange={(event) => updateForm("aliases", event.target.value)}
                  placeholder="El Mayimbe, El Caballo Mayor"
                  className={inputClass}
                />
              </Field>

              <Field label={t("admin.labels.disambiguation")}>
                <input
                  value={form.disambiguation ?? ""}
                  onChange={(event) =>
                    updateForm("disambiguation", event.target.value)
                  }
                  placeholder="Dominican merengue singer, not the composer..."
                  className={inputClass}
                />
              </Field>

              <Field label={t("admin.labels.artistTags")}>
                <div className="flex flex-wrap items-stretch gap-2 rounded-lg border border-gray-200 bg-white p-3">
                    {religiousTagOptions.map((tag) => {
                      const selected = parseCsv(form.artist_tags).some(
                        (item) => item.toLowerCase() === tag.toLowerCase()
                      );

                      return (
                        <button
                          key={tag}
                          type="button"
                          aria-pressed={selected}
                          onClick={() =>
                            updateForm(
                              "artist_tags",
                              toggleExclusiveCsvValue(
                                form.artist_tags,
                                religiousTagOptions,
                                tag
                              )
                            )
                          }
                          className={`rounded-lg border px-3 py-2 text-sm capitalize transition ${
                            selected
                              ? "border-(--color-flagblue) bg-(--color-flagblue) text-white"
                              : "border-gray-200 bg-white text-gray-700 hover:border-(--color-flagblue)"
                          } flex min-w-24 flex-1 items-center justify-center text-center`}
                        >
                          {tag}
                        </button>
                      );
                    })}

                    <span
                      aria-hidden="true"
                      className="mx-1 h-8 w-px bg-linear-to-b from-transparent via-gray-300 to-transparent"
                    />

                    {careerStageTagOptions.map((tag) => {
                      const selected = parseCsv(form.artist_tags).some(
                        (item) => item.toLowerCase() === tag.toLowerCase()
                      );

                      return (
                        <button
                          key={tag}
                          type="button"
                          aria-pressed={selected}
                          onClick={() =>
                            updateForm(
                              "artist_tags",
                              toggleExclusiveCsvValue(
                                form.artist_tags,
                                careerStageTagOptions,
                                tag
                              )
                            )
                          }
                          className={`rounded-lg border px-3 py-2 text-sm capitalize transition ${
                            selected
                              ? "border-(--color-flagblue) bg-(--color-flagblue) text-white"
                              : "border-gray-200 bg-white text-gray-700 hover:border-(--color-flagblue)"
                          } flex min-w-24 flex-1 items-center justify-center text-center`}
                        >
                          {tag}
                        </button>
                      );
                    })}
                </div>
              </Field>

              <div className="grid gap-4 md:grid-cols-2">
                <Field label={t("admin.labels.officialWebsite")}>
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

              {(["bio_en", "bio_es"] as const).map((field) => (
                <Field
                  key={field}
                  label={field === "bio_en" ? "English Bio" : "Spanish Bio"}
                >
                  <div className="overflow-hidden rounded-lg border border-gray-200 bg-white focus-within:border-(--color-flagblue)">
                    <div className="flex flex-wrap gap-2 border-b border-gray-100 bg-gray-50 px-3 py-2">
                      <button
                        type="button"
                        onClick={() => wrapBioSelection(field, "**", "**", "bold text")}
                        className={toolbarButtonClass}
                      >
                        B
                      </button>

                      <button
                        type="button"
                        onClick={() => wrapBioSelection(field, "*", "*", "italic text")}
                        className={`${toolbarButtonClass} italic`}
                      >
                        I
                      </button>

                      <button
                        type="button"
                        onClick={() => formatBioLines(field, "## ", "Section title")}
                        className={toolbarButtonClass}
                      >
                        H
                      </button>

                      <button
                        type="button"
                        onClick={() => formatBioLines(field, "- ", "List item")}
                        className={toolbarButtonClass}
                      >
                        List
                      </button>

                      <button
                        type="button"
                        onClick={() => formatBioLines(field, "> ", "Quoted text")}
                        className={toolbarButtonClass}
                      >
                        Quote
                      </button>

                      <button
                        type="button"
                        onClick={() => insertBioLink(field)}
                        className={toolbarButtonClass}
                      >
                        Link
                      </button>
                    </div>

                    <textarea
                      ref={(element) => {
                        bioTextareaRefs.current[field] = element;
                      }}
                      value={form[field] ?? ""}
                      onChange={(event) => updateForm(field, event.target.value)}
                      className="min-h-55 w-full resize-y bg-white px-3 py-3 text-sm font-normal leading-relaxed text-gray-800 outline-none"
                    />
                  </div>

                  <div className="mt-3 rounded-lg border border-gray-100 bg-gray-50 px-4 py-3">
                    <p className="mb-2 text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
                      Preview
                    </p>

                    {form[field].trim() ? (
                      <BioText bio={form[field]} />
                    ) : (
                      <p className="text-sm text-gray-400">
                        Biography preview will appear here.
                      </p>
                    )}
                  </div>
                </Field>
              ))}

              <button
                type="submit"
                disabled={Boolean(loading)}
                className="w-full rounded-lg bg-(--color-flagblue) px-5 py-4 text-sm uppercase tracking-[0.18em] text-white transition disabled:cursor-not-allowed disabled:opacity-40"
              >
                {loading
                  ? t("admin.buttons.processing")
                  : selectedArtistId
                    ? t("admin.buttons.updateArtistProfile")
                    : t("admin.buttons.createArtist")}
              </button>
            </form>

            {selectedArtistId && selectedArtist && (
              <div className="mt-5 rounded-xl border border-red-100 bg-red-50/70 p-4">
                <p className="text-[10px] font-normal uppercase tracking-[0.18em] text-red-700">
                  Danger Zone
                </p>
                <p className="mt-2 text-sm leading-relaxed text-red-900">
                  Permanently delete {selectedArtist.name} and all associated
                  cascaded data after verification.
                </p>
                <button
                  type="button"
                  onClick={handleDeleteArtist}
                  disabled={Boolean(loading)}
                  className="mt-4 w-full rounded-lg border border-red-300 bg-white px-5 py-3 text-sm uppercase tracking-[0.18em] text-red-700 transition hover:bg-red-700 hover:text-white disabled:cursor-not-allowed disabled:opacity-40"
                >
                  Delete Artist Permanently
                </button>
              </div>
            )}
          </section>

          <details className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm" open>
            <summary className="cursor-pointer text-xs font-normal uppercase tracking-[0.2em] text-(--color-wikicrimson)">
              Groups & Projects
              {selectedArtistId ? ` (${outgoingRelationships.length})` : ""}
            </summary>

            <div className="mt-5 space-y-5">
              {!selectedArtistId ? (
                <p className="rounded-lg border border-dashed border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-500">
                  Select and save an artist before adding groups or projects.
                </p>
              ) : (
                <>
                  <div className="overflow-x-auto rounded-lg border border-gray-100">
                    <table className="min-w-full divide-y divide-gray-100 text-sm">
                      <thead className="bg-gray-50 text-left text-[10px] uppercase tracking-[0.16em] text-gray-400">
                        <tr>
                          <th className="px-3 py-2 font-normal">Artist</th>
                          <th className="px-3 py-2 font-normal">Relationship</th>
                          <th className="px-3 py-2 font-normal">From</th>
                          <th className="px-3 py-2 font-normal">To</th>
                          <th className="px-3 py-2 font-normal">Notes</th>
                          <th className="px-3 py-2 text-right font-normal">Actions</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-gray-100">
                        {outgoingRelationships.length ? (
                          outgoingRelationships.map((item) => (
                            <tr key={item.id} className="align-top">
                              <td className="px-3 py-3 text-(--color-flagblue)">
                                {item.target_artist?.name ?? "Unknown artist"}
                              </td>
                              <td className="px-3 py-3 text-gray-700">
                                {formatArtistRelationshipType(item.relationship_type)}
                              </td>
                              <td className="px-3 py-3 text-gray-500">
                                {item.start_year ?? "-"}
                              </td>
                              <td className="px-3 py-3 text-gray-500">
                                {item.end_year ?? "-"}
                              </td>
                              <td className="max-w-52 px-3 py-3 text-gray-500">
                                <span className="line-clamp-2">{item.notes || "-"}</span>
                              </td>
                              <td className="px-3 py-3">
                                <div className="flex justify-end gap-2">
                                  <button
                                    type="button"
                                    onClick={() => handleEditRelationship(item)}
                                    className="rounded-md border border-gray-200 bg-white px-3 py-1.5 text-xs text-(--color-flagblue) transition hover:border-(--color-flagblue)"
                                  >
                                    Edit
                                  </button>
                                  <button
                                    type="button"
                                    onClick={() => void handleDeleteRelationship(item)}
                                    className="rounded-md border border-red-100 bg-white px-3 py-1.5 text-xs text-(--color-wikicrimson) transition hover:border-(--color-wikicrimson)"
                                  >
                                    Delete
                                  </button>
                                </div>
                              </td>
                            </tr>
                          ))
                        ) : (
                          <tr>
                            <td colSpan={6} className="px-3 py-4 text-sm text-gray-400">
                              No groups or projects saved for this artist yet.
                            </td>
                          </tr>
                        )}
                      </tbody>
                    </table>
                  </div>

                  <div className="rounded-lg border border-gray-100 bg-gray-50 p-4">
                    <div className="mb-4 flex items-center justify-between gap-3">
                      <p className="text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
                        {editingRelationshipId ? "Edit Relationship" : "Add Relationship"}
                      </p>

                      {editingRelationshipId && (
                        <button
                          type="button"
                          onClick={resetRelationshipForm}
                          className="text-xs font-semibold text-(--color-wikicrimson)"
                        >
                          Cancel
                        </button>
                      )}
                    </div>

                    <div className="grid gap-4 md:grid-cols-2">
                      <Field label="Related Artist">
                        <div className="relative">
                          <input
                            value={
                              relationshipArtistSearch ||
                              selectedRelationshipArtist?.name ||
                              ""
                            }
                            onChange={(event) => {
                              setRelationshipArtistSearch(event.target.value);
                              updateRelationshipForm("target_artist_id", "");
                              setRelationshipArtistPickerOpen(true);
                            }}
                            onFocus={() => setRelationshipArtistPickerOpen(true)}
                            onBlur={() => {
                              window.setTimeout(
                                () => setRelationshipArtistPickerOpen(false),
                                120
                              );
                            }}
                            placeholder="Search group, duo, orchestra..."
                            className={inputClass}
                            role="combobox"
                            aria-expanded={relationshipArtistPickerOpen}
                            aria-controls="relationship-artist-picker-results"
                          />

                          {relationshipArtistPickerOpen && (
                            <div
                              id="relationship-artist-picker-results"
                              className="absolute left-0 right-0 top-[calc(100%+0.35rem)] z-30 max-h-64 overflow-y-auto rounded-lg border border-gray-200 bg-white shadow-lg"
                            >
                              {filteredRelationshipArtists.length ? (
                                filteredRelationshipArtists.map((artist) => (
                                  <button
                                    key={artist.id}
                                    type="button"
                                    onMouseDown={(event) => event.preventDefault()}
                                    onClick={() => handleSelectRelationshipArtist(artist)}
                                    className="block w-full border-b border-gray-100 px-3 py-2 text-left text-sm text-gray-700 transition last:border-none hover:bg-(--color-flagblue)/5"
                                  >
                                    <span className="block truncate font-medium">
                                      {artist.name}
                                    </span>
                                    <span className="mt-0.5 block text-[10px] uppercase tracking-[0.14em] text-gray-400">
                                      {artist.type || "artist"}
                                    </span>
                                  </button>
                                ))
                              ) : (
                                <p className="px-3 py-2 text-sm text-gray-400">
                                  No artists found.
                                </p>
                              )}
                            </div>
                          )}
                        </div>
                      </Field>

                      <Field label="Relationship Type">
                        <select
                          value={relationshipForm.relationship_type}
                          onChange={(event) =>
                            updateRelationshipForm(
                              "relationship_type",
                              event.target.value as ArtistRelationshipType
                            )
                          }
                          className={inputClass}
                        >
                          {relationshipTypeOptions.map((option) => (
                            <option key={option.value} value={option.value}>
                              {option.label}
                            </option>
                          ))}
                        </select>
                      </Field>

                      <Field label="Start Year">
                        <input
                          type="number"
                          value={relationshipForm.start_year}
                          onChange={(event) =>
                            updateRelationshipForm("start_year", event.target.value)
                          }
                          className={inputClass}
                        />
                      </Field>

                      <Field label="End Year">
                        <input
                          type="number"
                          value={relationshipForm.end_year}
                          onChange={(event) =>
                            updateRelationshipForm("end_year", event.target.value)
                          }
                          className={inputClass}
                        />
                      </Field>
                    </div>

                    <div className="mt-4">
                      <Field label="Notes">
                        <textarea
                          value={relationshipForm.notes}
                          onChange={(event) =>
                            updateRelationshipForm("notes", event.target.value)
                          }
                          className={`${inputClass} min-h-20 resize-y`}
                          placeholder="Optional context for this group or project."
                        />
                      </Field>
                    </div>

                    <button
                      type="button"
                      onClick={() => void handleSaveRelationship()}
                      disabled={Boolean(loading)}
                      className="mt-4 w-full rounded-lg bg-(--color-flagblue) px-5 py-3 text-xs uppercase tracking-[0.18em] text-white transition disabled:cursor-not-allowed disabled:opacity-40"
                    >
                      {editingRelationshipId ? "Update Relationship" : "Add Relationship"}
                    </button>
                  </div>

                  {incomingRelationships.length > 0 && (
                    <div className="rounded-lg border border-gray-100 bg-white p-4">
                      <h3 className="text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
                        Members
                      </h3>
                      <div className="mt-3 grid gap-2 sm:grid-cols-2">
                        {incomingRelationships.map((item) => {
                          const years = formatRelationshipYears(
                            item.start_year,
                            item.end_year
                          );

                          return (
                            <div
                              key={item.id}
                              className="rounded-lg border border-gray-100 bg-gray-50 px-3 py-2"
                            >
                              <p className="truncate text-sm font-medium text-(--color-flagblue)">
                                {item.source_artist?.name ?? "Unknown artist"}
                              </p>
                              <p className="mt-0.5 text-xs text-gray-500">
                                {[
                                  formatArtistRelationshipType(item.relationship_type),
                                  years,
                                ]
                                  .filter(Boolean)
                                  .join(", ")}
                              </p>
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  )}
                </>
              )}
            </div>
          </details>

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
