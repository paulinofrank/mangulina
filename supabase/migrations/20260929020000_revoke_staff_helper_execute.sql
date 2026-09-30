-- Advisor lint 0029: signed-in users could call the staff-role helper
-- functions through /rest/v1/rpc and probe their own (or the editorial)
-- role/capability mapping. Nothing calls them as a signed-in client: no
-- RLS policy references them and no app code invokes them over RPC.
-- approve_editorial_decision (SECURITY DEFINER, runs as owner) still reaches
-- them internally, so it keeps working.
--
-- approve_editorial_decision itself stays executable by authenticated: it is
-- the editors' entry point and authorizes inside via auth.uid() plus the
-- 'decision.approve' capability, so it cannot work under the service role.
--
-- Rollback:
--   GRANT EXECUTE ON FUNCTION public.current_staff_role() TO authenticated;
--   GRANT EXECUTE ON FUNCTION public.has_staff_role(text) TO authenticated;
--   GRANT EXECUTE ON FUNCTION public.has_editorial_capability(text) TO authenticated;
REVOKE EXECUTE ON FUNCTION public.current_staff_role() FROM authenticated;
REVOKE EXECUTE ON FUNCTION public.has_staff_role(text) FROM authenticated;
REVOKE EXECUTE ON FUNCTION public.has_editorial_capability(text) FROM authenticated;
