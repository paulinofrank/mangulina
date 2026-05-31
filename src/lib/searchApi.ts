import { supabase } from "@/lib/supabase";

export type SearchResult = {
  type: "artist" | "song" | "release";
  id: string;
  title: string;
  slug: string | null;
  subtitle: string | null;
  year: number | null;
};

export type GlobalSearchResponse = {
  artists: SearchResult[];
  songs: SearchResult[];
  releases: SearchResult[];
};

export async function globalSearch(query: string): Promise<GlobalSearchResponse> {
  const cleaned = query.trim();

  if (!cleaned) {
    return {
      artists: [],
      songs: [],
      releases: [],
    };
  }

  const { data, error } = await supabase.rpc("global_search", {
    search_text: cleaned,
  });

  if (error) {
    console.error("globalSearch error:", error);
    return {
      artists: [],
      songs: [],
      releases: [],
    };
  }

  return data as GlobalSearchResponse;
}