// home.ts  (Type)
import type { Artist } from "@/types/music";

export type TopArtist = {
  id: string;
  slug: string;
  name: string;
  province: string | null;
  views: number;
};

export type TrendingSong = {
  id: string;
  slug: string | null;
  title: string;
  views: number;
  release: {
    id: string;
  } | null;
  recording_credits: {
    artist: {
      id: string | null;
      name: string;
    } | null;
  }[];
};

export type ArtistSummary = {
  id: string;
  slug: string;
  name: string;
  status?: Artist["status"];
  province: string | null;
  views: number;
};

export type RegionCount = {
  province: string;
  count: number;
};
