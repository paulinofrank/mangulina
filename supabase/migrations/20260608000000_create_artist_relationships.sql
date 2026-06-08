CREATE TABLE IF NOT EXISTS public.artist_relationships (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    source_artist_id uuid NOT NULL REFERENCES public.artists(id) ON DELETE CASCADE,
    target_artist_id uuid NOT NULL REFERENCES public.artists(id) ON DELETE CASCADE,
    relationship_type text NOT NULL,
    start_year integer,
    end_year integer,
    notes text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT artist_relationships_no_self_reference
        CHECK (source_artist_id <> target_artist_id),
    CONSTRAINT artist_relationships_unique
        UNIQUE (source_artist_id, target_artist_id, relationship_type),
    CONSTRAINT artist_relationships_type_check
        CHECK (relationship_type IN ('member_of', 'founder_of', 'leader_of'))
);

CREATE INDEX IF NOT EXISTS idx_artist_relationships_source
ON public.artist_relationships(source_artist_id);

CREATE INDEX IF NOT EXISTS idx_artist_relationships_target
ON public.artist_relationships(target_artist_id);

CREATE INDEX IF NOT EXISTS idx_artist_relationships_type
ON public.artist_relationships(relationship_type);
