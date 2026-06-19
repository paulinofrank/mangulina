CREATE TABLE IF NOT EXISTS public.page_view_events (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    path text NOT NULL,
    page_type text,
    entity_id uuid,
    entity_slug text,
    referrer text,
    source text,
    user_agent text,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS page_view_events_created_at_idx
ON public.page_view_events(created_at DESC);

CREATE INDEX IF NOT EXISTS page_view_events_path_idx
ON public.page_view_events(path);

CREATE INDEX IF NOT EXISTS page_view_events_page_type_idx
ON public.page_view_events(page_type);

CREATE INDEX IF NOT EXISTS page_view_events_entity_id_idx
ON public.page_view_events(entity_id);

ALTER TABLE public.page_view_events ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON public.page_view_events FROM anon, authenticated;
GRANT SELECT, INSERT ON public.page_view_events TO service_role;

NOTIFY pgrst, 'reload schema';
