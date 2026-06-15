const INVALID_PROVINCES = new Set(["unknown", "no province", "born abroad"]);

export function provinceToSlug(province: string) {
  return province
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

export function isValidProvinceName(
  province: string | null | undefined,
): province is string {
  const normalized = province?.trim().toLowerCase();
  return Boolean(normalized && !INVALID_PROVINCES.has(normalized));
}
