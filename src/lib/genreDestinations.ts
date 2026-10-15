export type PublicGenreRow = {
  id: number;
  name: string;
  slug: string | null;
  parent_id: number | null;
  level: number;
};

export type GenreDestination = { name: string; slug: string; href: string; parentName?: string };

export function buildGenreDestinations(rows: readonly PublicGenreRow[]): GenreDestination[] {
  const parents = new Map(rows.filter((row) => row.level === 0 && row.parent_id === null && row.slug)
    .map((row) => [row.id, row]));
  return rows.flatMap((row) => {
    if (!row.slug) return [];
    if (parents.has(row.id)) return [{ name: row.name, slug: row.slug, href: `/genres/${row.slug}` }];
    const parent = row.parent_id === null ? undefined : parents.get(row.parent_id);
    if (row.level !== 1 || !parent) return [];
    return [{ name: row.name, slug: row.slug, parentName: parent.name,
      href: `/genres/${parent.slug}?${new URLSearchParams({ subgenre: row.slug })}` }];
  });
}

function normalize(value: string) {
  return value.trim().normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase();
}

export function resolveGenreDestination(
  label: string, destinations: readonly GenreDestination[], parentLabel?: string | null,
): string | null {
  const key = normalize(label);
  const matches = destinations.filter((item) => normalize(item.name) === key || normalize(item.slug) === key);
  const scoped = parentLabel ? matches.filter((item) => item.parentName && normalize(item.parentName) === normalize(parentLabel)) : [];
  const hrefs = new Set((scoped.length ? scoped : matches).map((item) => item.href));
  // Unmapped or ambiguous labels remain visible without inventing a destination.
  return hrefs.size === 1 ? [...hrefs][0] : null;
}
