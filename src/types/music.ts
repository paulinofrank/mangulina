// src/types/music.ts

export interface Artist {
  id: string; // Changed to string to match Supabase UUIDs
  slug: string;
  name: string;
  type?: string | null;
  status?: "draft" | "published" | "hidden" | "needs_review" | "duplicate";
  primary_role?: string | null;
  occupations?: string[] | Record<string, unknown> | null;
  instruments?: string[] | Record<string, unknown> | null;
  /** Alternate billing / search name when different from `name` */
  stage_name?: string | null;
  date_of_birth?: string | null; // Needed for BirthdaySection.tsx
  province?: string | null;      // Matches your DB column
  birth_place?: string | null;
  biography?: string | null;
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

export type OntologyStatus =
  | "draft"
  | "published"
  | "hidden"
  | "needs_review"
  | "duplicate"
  | "archived";

export type AssertionVerificationStatus =
  | "unverified"
  | "verified"
  | "disputed"
  | "superseded";

export interface MusicalWork {
  id: string;
  preferred_title: string;
  slug: string | null;
  language: string | null;
  composition_year: number | null;
  publication_year: number | null;
  status: OntologyStatus;
  editorial_notes: string | null;
  metadata: Record<string, unknown>;
  created_at: string;
  updated_at: string;
}

export interface WorkCredit {
  id: string;
  work_id: string;
  artist_id: string;
  role: string;
  credited_as: string | null;
  credit_detail: string | null;
  sequence: number | null;
  verification_status: AssertionVerificationStatus;
  notes: string | null;
  metadata: Record<string, unknown>;
  created_at: string;
  updated_at: string;
}

export interface RecordingIsrc {
  id: string;
  recording_id: string;
  isrc: string;
  verification_status: AssertionVerificationStatus;
  first_observed_at: string | null;
  last_verified_at: string | null;
  notes: string | null;
  metadata: Record<string, unknown>;
  created_at: string;
  updated_at: string;
}
