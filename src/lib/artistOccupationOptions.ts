import { getSupabaseClient } from "@/lib/supabase";

const PAGE_SIZE = 1000;

type ArtistOccupationRow = {
  occupations: string[] | Record<string, unknown> | null;
};

function formatOccupationLabel(value: string) {
  return value
    .split(/\s+/)
    .map((word) => word.charAt(0).toLocaleUpperCase() + word.slice(1))
    .join(" ");
}

export async function getArtistOccupationOptions(baseRole: string) {
  const supabase = getSupabaseClient();
  const occupations = new Map<string, string>();

  for (let from = 0; ; from += PAGE_SIZE) {
    const { data, error } = await supabase
      .from("artists")
      .select("occupations")
      .eq("status", "published")
      .or(`primary_role.eq.${baseRole},occupations.cs.${JSON.stringify([baseRole])}`)
      .range(from, from + PAGE_SIZE - 1);

    if (error) {
      console.error("Unable to load artist occupation options:", error);
      return [];
    }

    const page = (data ?? []) as ArtistOccupationRow[];
    for (const artist of page) {
      const values = Array.isArray(artist.occupations)
        ? artist.occupations
        : artist.occupations
          ? Object.keys(artist.occupations)
          : [];

      for (const value of values) {
        const label = String(value).trim();
        const normalized = label.toLocaleLowerCase();
        if (!label || normalized === baseRole.toLocaleLowerCase()) continue;
        if (!occupations.has(normalized)) occupations.set(normalized, label);
      }
    }

    if (page.length < PAGE_SIZE) break;
  }

  return [...occupations.entries()]
    .sort((left, right) => left[1].localeCompare(right[1]))
    .map(([value, label]) => ({ value, label: formatOccupationLabel(label) }));
}
