import { getSupabaseClient } from "@/lib/supabase";
import { isValidProvinceName, provinceToSlug } from "@/lib/provinceSlug";

const PAGE_SIZE = 1000;

export type PublishedProvince = {
  name: string;
  slug: string;
  count: number;
};

export async function getPublishedProvinces(): Promise<PublishedProvince[]> {
  const supabase = getSupabaseClient();
  const counts = new Map<string, number>();

  for (let from = 0; ; from += PAGE_SIZE) {
    const { data, error } = await supabase
      .from("artists")
      .select("province")
      .eq("status", "published")
      .not("province", "is", null)
      .range(from, from + PAGE_SIZE - 1);

    if (error) {
      console.error("Unable to load published provinces:", error);
      return [];
    }

    const page = (data ?? []) as Array<{ province: string | null }>;
    for (const row of page) {
      const province = row.province?.trim();
      if (!isValidProvinceName(province)) continue;
      counts.set(province!, (counts.get(province!) ?? 0) + 1);
    }

    if (page.length < PAGE_SIZE) break;
  }

  return [...counts.entries()]
    .map(([name, count]) => ({ name, slug: provinceToSlug(name), count }))
    .filter((province) => province.slug)
    .sort((a, b) => a.name.localeCompare(b.name));
}

export async function getPublishedProvinceBySlug(slug: string) {
  const provinces = await getPublishedProvinces();
  return provinces.find((province) => province.slug === slug) ?? null;
}
