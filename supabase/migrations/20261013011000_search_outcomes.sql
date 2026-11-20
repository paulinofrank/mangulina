-- Additive, no historical backfill and no changes to privileges/RLS.
BEGIN;
ALTER TABLE public.search_events
  ADD COLUMN search_outcome text CHECK(search_outcome IN ('normal','recovered','no_match','error','degraded')),
  ADD COLUMN search_action text CHECK(search_action IN ('results','suggestion_displayed','suggestion_selected')),
  ADD COLUMN search_version text,
  ADD COLUMN suggestion_text text;
ALTER TABLE public.search_events ALTER COLUMN results_count DROP NOT NULL;
CREATE OR REPLACE VIEW public.searches_with_no_results WITH (security_invoker = true) AS
SELECT lower(trim(query)) query,count(*) search_count,max(searched_at) last_searched_at
FROM public.search_events
WHERE results_count=0 AND trim(query)<>''
  AND (search_action IS NULL OR search_action='results')
  AND (search_outcome IS NULL OR search_outcome='no_match')
GROUP BY lower(trim(query)) ORDER BY count(*) DESC,max(searched_at) DESC;
CREATE OR REPLACE VIEW public.search_events_by_day_last_30_days WITH (security_invoker = true) AS
SELECT date(searched_at) search_date,
  count(*) FILTER(WHERE search_action IS NULL OR search_action='results')::bigint total_searches,
  count(*) FILTER(WHERE results_count=0 AND (search_outcome IS NULL OR search_outcome='no_match') AND (search_action IS NULL OR search_action='results'))::bigint zero_result_searches,
  count(*) FILTER(WHERE search_action='results' AND search_outcome='normal')::bigint normal_searches,
  count(*) FILTER(WHERE search_action='results' AND search_outcome='recovered')::bigint recovered_searches,
  count(*) FILTER(WHERE search_action='results' AND search_outcome='no_match')::bigint unmatched_searches,
  count(*) FILTER(WHERE search_action='results' AND search_outcome='error')::bigint failed_searches,
  count(*) FILTER(WHERE search_action='results' AND search_outcome='degraded')::bigint degraded_searches,
  count(*) FILTER(WHERE search_action='suggestion_displayed')::bigint suggestions_displayed,
  count(*) FILTER(WHERE search_action='suggestion_selected')::bigint suggestions_selected,
  count(*) FILTER(WHERE search_outcome IS NULL AND (search_action IS NULL OR search_action='results'))::bigint unclassified_searches
FROM public.search_events WHERE searched_at>=now()-interval '30 days'
GROUP BY date(searched_at) ORDER BY search_date DESC;
COMMIT;
