export function normalizeSearchText(value: string): string {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, " ")
    .trim()
    .replace(/\s+/g, " ");
}

export function rankSearchText(values: Array<string | null | undefined>, query: string): number {
  const normalizedQuery = normalizeSearchText(query);
  if (!normalizedQuery) return 0;

  const normalizedValues = values.map((value) => normalizeSearchText(value ?? "")).filter(Boolean);
  if (normalizedValues.some((value) => value === normalizedQuery)) return 0;
  if (normalizedValues.some((value) => value.startsWith(normalizedQuery))) return 1;
  if (normalizedValues.some((value) => value.split(" ").some((word) => word.startsWith(normalizedQuery)))) return 2;
  if (normalizedValues.some((value) => value.includes(normalizedQuery))) return 3;
  return Number.MAX_SAFE_INTEGER;
}
