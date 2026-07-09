// src/types/music.ts

export interface Artist {
  id: string; // Changed to string to match Supabase UUIDs
  slug: string;
  name: string;
  status?: "draft" | "published" | "hidden" | "needs_review" | "duplicate";
  primary_role?: string | null;
  occupations?: string[] | Record<string, unknown> | null;
  instruments?: string[] | Record<string, unknown> | null;
  /** Alternate billing / search name when different from `name` */
  stage_name?: string | null;
  date_of_birth?: string | null; // Needed for BirthdaySection.tsx
  province?: string | null;      // Matches your DB column
  birth_place?: string | null;
  bio?: string | null;
  bio_en?: string | null;
  bio_es?: string | null;
  is_religious?: boolean;        // Used in your Admin form
  facebook?: string | null;
  instagram?: string | null;
  genres?: string[] | null;      // Musical genres/styles only
  artist_tags?: string[] | null; // Editorial/category tags
  has_image?: boolean | null;
  image_updated_at?: string | null;
  views?: number | null;         // Kept from your other file
death_year?: number | null;
}
