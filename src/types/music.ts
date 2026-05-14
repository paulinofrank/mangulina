// src/types/music.ts

export interface Artist {
  id: string; // Changed to string to match Supabase UUIDs
  name: string;
  date_of_birth?: string | null; // Needed for BirthdaySection.tsx
  province?: string | null;      // Matches your DB column
  birth_place?: string | null;
  bio?: string | null;
  image_url?: string | null;
  is_religious?: boolean;        // Used in your Admin form
  facebook?: string | null;
  instagram?: string | null;
  genres?: string[];             // Array for multiple genres
  views?: number | null;         // Kept from your other file
}