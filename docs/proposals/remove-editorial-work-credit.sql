-- PROPOSAL - NOT APPLIED. A human owner must review and apply this file.
-- New service-only RPC; no existing RLS, grants, or role capabilities are changed.
-- Callers: POST /api/admin/editorial-workflows, action credit.remove.
-- Uses existing high-impact credit.dispute and assertion.reject capabilities:
-- owner/admin can withdraw credits; editors cannot gain destructive access.
-- Supersedes rather than deletes: preserves all assertions, sources and identities.
-- Public song context and composition portfolios already exclude superseded credits.
-- Review on a development database first; do not test removal on live records.
BEGIN;
CREATE FUNCTION public.remove_editorial_work_credit(
  actor uuid, key uuid, work_uuid uuid, credit_uuid uuid, reason_value text
) RETURNS jsonb LANGUAGE plpgsql SECURITY DEFINER SET search_path = '' AS $$
DECLARE
  cached jsonb;
  previous_credit jsonb;
  decision_uuid uuid;
  result_value jsonb;
BEGIN
  PERFORM public.require_editorial_capability(actor, 'credit.dispute');
  PERFORM public.require_editorial_capability(actor, 'assertion.reject');
  IF key IS NULL OR work_uuid IS NULL OR credit_uuid IS NULL OR
     reason_value IS NULL OR btrim(reason_value) = '' OR length(btrim(reason_value)) > 2000 THEN
    RAISE EXCEPTION 'Work, credit, idempotency key and removal reason are required';
  END IF;
  PERFORM pg_advisory_xact_lock(hashtextextended(actor::text || key::text, 0));
  cached := public.editorial_idempotent_result(actor, 'work_credit.remove', key);
  IF cached IS NOT NULL THEN
    IF cached->>'work_id' IS DISTINCT FROM work_uuid::text OR
       cached->>'work_credit_id' IS DISTINCT FROM credit_uuid::text THEN
      RAISE EXCEPTION 'Idempotency key belongs to another credit';
    END IF;
    RETURN cached;
  END IF;
  SELECT to_jsonb(c) INTO previous_credit FROM public.work_credits c
    WHERE c.id = credit_uuid AND c.work_id = work_uuid FOR UPDATE;
  IF NOT FOUND THEN RAISE EXCEPTION 'Composition credit not found on this Work'; END IF;
  IF previous_credit->>'verification_status' = 'superseded' THEN
    RAISE EXCEPTION 'Composition credit has already been removed';
  END IF;
  -- Contested or shared attribution requires a separate independent review;
  -- this routine endpoint must not bypass that gate.
  IF previous_credit->>'verification_status' = 'disputed' OR
     EXISTS (SELECT 1 FROM public.editorial_assertions a
       JOIN public.editorial_assertion_work_credits c ON c.assertion_id = a.id
       WHERE c.work_credit_id = credit_uuid AND
         (a.verification_status = 'disputed' OR a.canonical_status = 'disputed')) OR
     (SELECT count(*) FROM public.recordings WHERE work_id = work_uuid) > 1 THEN
    RAISE EXCEPTION 'This contested or shared credit requires independent editorial approval before removal';
  END IF;
  PERFORM set_config('app.governed_credit', 'on', true);
  PERFORM set_config('app.editorial_reason', btrim(reason_value), true);
  UPDATE public.work_credits SET verification_status = 'superseded' WHERE id = credit_uuid;
  UPDATE public.editorial_assertions SET verification_status = 'superseded',
    canonical_status = 'superseded', reviewed_by = actor, reviewed_at = now()
    WHERE id IN (SELECT assertion_id FROM public.editorial_assertion_work_credits
                 WHERE work_credit_id = credit_uuid);
  INSERT INTO public.editorial_decisions(decision_type, status, reason,
    requested_by, decided_by, previous_canonical_state, resulting_canonical_state, decided_at)
    VALUES ('remove_work_credit', 'executed', btrim(reason_value), actor, actor,
      previous_credit, jsonb_build_object('work_credit_id', credit_uuid,
      'work_id', work_uuid, 'verification_status', 'superseded'), now())
    RETURNING id INTO decision_uuid;
  INSERT INTO public.editorial_decision_assertions(decision_id, assertion_id, relationship)
    SELECT decision_uuid, assertion_id, 'superseded'
    FROM public.editorial_assertion_work_credits WHERE work_credit_id = credit_uuid;
  INSERT INTO public.editorial_audit_events(event_type, actor_type, actor_user_id,
    decision_id, table_name, row_id, before_state, after_state, reason)
    VALUES ('work_credit.removed', 'human_editor', actor, decision_uuid, 'work_credits',
      credit_uuid, previous_credit, jsonb_build_object('verification_status', 'superseded'),
      btrim(reason_value));
  PERFORM set_config('app.governed_credit', 'off', true);
  result_value := jsonb_build_object('work_credit_id', credit_uuid, 'work_id', work_uuid,
    'decision_id', decision_uuid, 'status', 'superseded');
  INSERT INTO public.editorial_idempotency_keys VALUES
    (actor, 'work_credit.remove', key, result_value, now());
  RETURN result_value;
END;
$$;
REVOKE ALL ON FUNCTION public.remove_editorial_work_credit(uuid,uuid,uuid,uuid,text) FROM PUBLIC,anon,authenticated;
GRANT EXECUTE ON FUNCTION public.remove_editorial_work_credit(uuid,uuid,uuid,uuid,text) TO service_role;
COMMIT;

-- Rollback installation (human only):
-- DROP FUNCTION public.remove_editorial_work_credit(uuid,uuid,uuid,uuid,text);
-- This does not undo editorial removals. Restore only after reviewing the recorded
-- previous_canonical_state and assertion history through a separate approved action.
-- Verification after application: inspect pg_proc/proacl for service-only execution;
-- use development fixtures to verify denied editors, wrong work, blank reason,
-- concurrent/repeated removal, preserved evidence, rollback on audit failure,
-- and disappearance from public song context and the contributor portfolio.
