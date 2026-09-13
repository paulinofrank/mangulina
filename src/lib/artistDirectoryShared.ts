import type { Artist } from "@/types/music";

export const ARTIST_DIRECTORY_ITEMS_PER_PAGE = 24;

// The thirty-one provinces plus the Distrito Nacional. This is the whole set of
// values that name a real place; anything else in the province column is
// bookkeeping.
export const DOMINICAN_PROVINCES = new Set([
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
]);

// The province column also carries sentinels so the directory can group artists
// who have no Dominican province: those born outside the country, and those
// whose province is simply unrecorded. They are bookkeeping, not place names.
// Bookkeeping values that occupy the province column without naming a place.
// "Nacido en el Exterior" is the live one; the three English forms are kept so
// that a row imported or restored from before the Spanish normalisation is
// still recognised rather than printed.
export const PROVINCE_SENTINELS = new Set([
  "Nacido en el Exterior",
  "Born Abroad",
  "No Province",
  "X - Born Outside",
]);

// Printing an origin used to work by rejecting the sentinels it knew about,
// which meant any value the import had not been seen to produce printed itself.
// "X - Born Outside" reached a published profile that way. The test is now the
// other way round: a province is printed only when it is one of the thirty-two,
// so a stray value is silently dropped rather than shown to a reader.
export function formatOrigin(
  birthPlace: string | null | undefined,
  province: string | null | undefined,
) {
  const realProvince = province && DOMINICAN_PROVINCES.has(province) ? province : null;

  // Several provinces share a name with their capital, and 102 published rows
  // record both — "Barahona, Barahona", "Santiago, Santiago". Printing the
  // pair reads like an error rather than a place, so the province is dropped
  // when it only repeats the town.
  if (realProvince && birthPlace && birthPlace.trim() === realProvince) {
    return realProvince;
  }

  return [birthPlace, realProvince].filter(Boolean).join(", ") || null;
}

export const ARTIST_LIST_SELECT = [
  "id",
  "slug",
  "name",
  "status",
  "primary_role",
  "occupations",
  "primary_genre",
  "stage_name",
  "date_of_birth",
  "province",
  "birth_place",
  "facebook",
  "instagram",
  "genres",
  "artist_tags",
  "has_image",
  "image_updated_at",
  "views",
  "death_year",
  "type",
].join(",");

export type ArtistDirectoryInitialData = {
  artists: Artist[];
  totalCount: number;
  cacheKey: string;
};
