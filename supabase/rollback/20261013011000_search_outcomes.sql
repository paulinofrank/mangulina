-- Restore legacy analytics projections first; preserve all new event columns
-- and records for evidence. Application rollback does not require data loss.
BEGIN;
CREATE OR REPLACE VIEW public.searches_with_no_results WITH (security_invoker = true) AS
SELECT lower(trim(query)) query,count(*) search_count,max(searched_at) last_searched_at
FROM public.search_events WHERE results_count=0 AND trim(query)<>''
AND (search_action IS NULL OR search_action='results')
AND (search_outcome IS NULL OR search_outcome='no_match')
GROUP BY lower(trim(query)) ORDER BY count(*) DESC,max(searched_at) DESC;
CREATE OR REPLACE VIEW public.search_events_by_day_last_30_days WITH (security_invoker = true) AS
SELECT date(searched_at) search_date,count(*)::bigint total_searches,
sum(CASE WHEN results_count=0 THEN 1 ELSE 0 END)::bigint zero_result_searches,
NULL::bigint normal_searches,NULL::bigint recovered_searches,NULL::bigint unmatched_searches,
NULL::bigint failed_searches,NULL::bigint degraded_searches,NULL::bigint suggestions_displayed,
NULL::bigint suggestions_selected,NULL::bigint unclassified_searches
FROM public.search_events WHERE searched_at>=now()-interval '30 days'
AND (search_action IS NULL OR search_action='results')
GROUP BY date(searched_at) ORDER BY search_date DESC;
-- Do not drop outcome columns or restore NOT NULL while new nullable events
-- remain. They are additive and harmless to the old application.
-- Retain filters on new event kinds so rollback cannot inflate legacy totals.
COMMIT;
