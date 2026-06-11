export type Contributor = {
  id: string;
  name: string;
  slug: string;
  role: string;
  bio: string | null;
  location: string | null;
  specialty: string[] | null;
  website: string | null;
  facebook: string | null;
  instagram: string | null;
  youtube: string | null;
  active: boolean;
  display_order: number;
  created_at: string;
};
