// src/types/music.ts

export interface Artist {
  id: string; // Changed to string to match Supabase UUIDs
  slug: string;
  name: string;
  primary_role?: string | null;
  /** Alternate billing / search name when different from `name` */
  stage_name?: string | null;
  date_of_birth?: string | null; // Needed for BirthdaySection.tsx
  province?: string | null;      // Matches your DB column
  birth_place?: string | null;
  bio?: string | null;
  is_religious?: boolean;        // Used in your Admin form
  facebook?: string | null;
  instagram?: string | null;
  genres?: string[];             // Array for multiple genres
  views?: number | null;         // Kept from your other file
death_year?: number | null;
}
