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

  const { data: artistData, error: artistError } = await supabase
    .from("artists")
    .select("id, slug, name, province, birth_year")
    .eq("status", "published")
    .ilike("name", `%${cleaned}%`)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(10);

  if (artistError) {
    console.error("globalSearch artists error:", artistError);
  }

  const { data, error } = await supabase.rpc("global_search", {
    search_text: cleaned,
  });

  if (error) {
    console.error("globalSearch error:", error);
    return {
      artists: ((artistData ?? []) as any[]).map((artist) => ({
        type: "artist",
        id: artist.id,
        title: artist.name,
        slug: artist.slug,
        subtitle: artist.province,
        year: artist.birth_year,
      })),
      songs: [],
      releases: [],
    };
  }

  const results = data as GlobalSearchResponse;

  return {
    ...results,
    artists: ((artistData ?? []) as any[]).map((artist) => ({
      type: "artist",
      id: artist.id,
      title: artist.name,
      slug: artist.slug,
      subtitle: artist.province,
      year: artist.birth_year,
    })),
  };
}
