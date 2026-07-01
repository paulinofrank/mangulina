import type { Artist } from "@/types/music";

export const ARTIST_DIRECTORY_ITEMS_PER_PAGE = 24;

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
  "bio",
  "facebook",
  "instagram",
  "genres",
  "artist_tags",
  "views",
  "death_year",
].join(",");

export type ArtistDirectoryInitialData = {
  artists: Artist[];
  totalCount: number;
  cacheKey: string;
};
