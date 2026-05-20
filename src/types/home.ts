// home.ts  (Type)

export type TopArtist = {
  id: string;
  name: string;
  image_url: string | null;
  province: string | null;
  views: number;
};

export type TrendingSong = {
  id: string;
  title: string;
  views: number;
  release: {
    id: string;
  } | null;
  recording_credits: {
    artist: {
      name: string;
      image_url: string | null;
    } | null;
  }[];
};

export type RegionCount = {
  name: string;
  count: number;
};
