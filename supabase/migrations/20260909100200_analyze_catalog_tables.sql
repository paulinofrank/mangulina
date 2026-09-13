-- Fix: the four largest catalogue tables had never been analyzed.
--
-- pg_stat_user_tables showed n_live_tup = 0 with last_analyze,
-- last_autoanalyze and last_autovacuum all NULL for recordings (17029 rows),
-- tracks (22698), releases (3163) and release_artists (3163). The planner was
-- costing every query against them as if they were empty, which reliably
-- picks nested loops and sequential scans where an index scan belongs.
--
-- artists is not in this list: it autoanalyzed normally, because editorial
-- work writes to it constantly. The catalogue tables take no writes between
-- ingest runs, so nothing ever triggered autoanalyze after the statistics
-- were last reset.
--
-- This is also why the Supabase dashboard reported 0 rows for most of the
-- catalogue: stale estimates, not missing data.

ANALYZE public.recordings;
ANALYZE public.releases;
ANALYZE public.tracks;
ANALYZE public.release_artists;

-- DOWN: not applicable. Collecting statistics has no inverse.
