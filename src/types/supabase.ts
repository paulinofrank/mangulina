export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json }
  | Json[];

export interface Database {
  public: {
    Tables: {
      artists: {
        Row: {
          id: string;
          name: string;
          sort_name: string | null;
          type: string | null;
          bio: string | null;
          image_url: string | null;
          birth_year: number | null;
          death_year: number | null;
          origin_region: string | null;
          created_at: string | null;
          views: number;
        };
        Insert: Partial<Database["public"]["Tables"]["artists"]["Row"]>;
        Update: Partial<Database["public"]["Tables"]["artists"]["Row"]>;
      };

      wikidata_raw: {
        Row: {
          artist_id: string;
          wikidata_id: string;
          raw_json: Json;
          updated_at: string | null;
        };
        Insert: {
          artist_id: string;
          wikidata_id: string;
          raw_json: Json;
          updated_at?: string | null;
        };
        Update: Partial<Database["public"]["Tables"]["wikidata_raw"]["Insert"]>;
      };
    };
  };
}
