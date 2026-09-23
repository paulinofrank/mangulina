BEGIN;
DROP FUNCTION IF EXISTS public.get_public_recording_credit_details(uuid);
NOTIFY pgrst, 'reload schema';
COMMIT;
