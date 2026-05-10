// src/types/Artist.ts

export type Artist = {
  id: string | number;
  name: string;
  origin_region?: string | null;
  image_url?: string | null;
  genre?: string | null;
  views?: number | null;
};
