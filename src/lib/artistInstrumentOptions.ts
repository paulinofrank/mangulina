import { getSupabaseClient } from "@/lib/supabase";

const PAGE_SIZE = 1000;

type ArtistInstrumentRow = {
  instruments: string[] | Record<string, unknown> | null;
};

function formatInstrumentLabel(value: string) {
  return value
    .split(/\s+/)
    .map((word) => word.charAt(0).toLocaleUpperCase() + word.slice(1))
    .join(" ");
}

export async function getArtistInstrumentOptions(baseRole: string) {
  const supabase = getSupabaseClient();
  const instruments = new Map<string, string>();

  for (let from = 0; ; from += PAGE_SIZE) {
    const { data, error } = await supabase
      .from("artists")
      .select("instruments")
      .eq("status", "published")
      .or(`primary_role.eq.${baseRole},occupations.cs.${JSON.stringify([baseRole])}`)
      .range(from, from + PAGE_SIZE - 1);

    if (error) {
      console.error("Unable to load artist instrument options:", error);
      return [];
    }

    const page = (data ?? []) as ArtistInstrumentRow[];
    for (const artist of page) {
      const values = Array.isArray(artist.instruments)
        ? artist.instruments
        : artist.instruments
          ? Object.keys(artist.instruments)
          : [];

      for (const value of values) {
        const label = String(value).trim();
        const normalized = label.toLocaleLowerCase();
        if (!label || instruments.has(normalized)) continue;
        instruments.set(normalized, label);
      }
    }

    if (page.length < PAGE_SIZE) break;
  }

  return [...instruments.entries()]
    .sort((left, right) => left[1].localeCompare(right[1]))
    .map(([value, label]) => ({ value, label: formatInstrumentLabel(label) }));
}
