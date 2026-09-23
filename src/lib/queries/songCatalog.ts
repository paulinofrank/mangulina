import { cache } from "react";
import { supabase } from "@/lib/supabase";
import type { RawCredit } from "@/lib/queries/songs";
import type { SongPlatformLink } from "@/lib/platformLinks";
import { uniqueRecordings } from "@/lib/songIdentity";

export type RepertoireRecording = {
  id: string;
  slug: string | null;
  title: string;
  work_id: string | null;
  work_slug: string | null;
  work_title: string | null;
  artist_id: string | null;
  artist_name: string | null;
  artist_slug: string | null;
  year: number | null;
  recording_year: number | null;
  duration: number | null;
  isrcs: string[] | null;
  cover_release_id: string | null;
  has_cover_image: boolean;
};

export type SongContext = {
  work: { id: string; slug: string | null; title: string; language: string | null;
    composition_year: number | null; publication_year: number | null } | null;
  work_credits: RawCredit[];
  recordings: (RepertoireRecording & {
    version: { performance_kind: string | null; derivation_kind: string | null;
      language_code: string | null; performance_context: string | null;
      performance_date: string | null; performance_date_precision: string | null } | null;
    credits: RawCredit[];
    identifiers: { isrc: string; verification_status: string }[];
    platform_links: SongPlatformLink[];
    appearances: { track_id: string; release_id: string; title: string; slug: string | null;
      year: number | null; type: string | null; country: string | null; group_title: string | null;
      disc: number | null; position: number | null; title_override: string | null }[];
  })[];
};

export type SongDirectory = { total: number; entries: {
  identity: string; title: string; slug: string; year: number | null;
  cover_release_id: string | null; has_cover_image: boolean;
}[] };

export async function getArtistSongDiscography(artistId: string): Promise<RepertoireRecording[]> {
  const { data, error } = await supabase.rpc("get_artist_song_discography", { artist_uuid: artistId });
  if (error) throw new Error(`Unable to load artist repertoire: ${error.message}`);
  return uniqueRecordings((data ?? []) as RepertoireRecording[]);
}

export async function getSongDirectory(page: number, search: string): Promise<SongDirectory> {
  const { data, error } = await supabase.rpc("get_public_song_directory", { page_number: page, search_text: search });
  if (error) throw new Error(`Unable to load Songs: ${error.message}`);
  return data as SongDirectory;
}

export const getSongContext = cache(async (kind: "recording" | "work", key: string): Promise<SongContext | null> => {
  const { data, error } = await supabase.rpc("get_public_song_context", kind === "recording"
    ? { recording_uuid: key } : { work_key: key });
  if (error) throw new Error(`Unable to load Song context: ${error.message}`);
  return data as SongContext | null;
});

export function creditItems(credits: RawCredit[]) {
  return credits.map((credit) => ({
    role: credit.role ?? "", name: credit.display_name,
    slug: credit.identity_type === "artist" ? credit.artist_slug : null,
    externalContributorId: credit.identity_type === "external_contributor" ? credit.identity_id : null,
    country: credit.country,
    roleFamily: credit.role_family,
    creditDetail: credit.credit_detail,
    instruments: credit.instruments,
  }));
}
