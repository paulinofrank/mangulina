BEGIN;

DELETE FROM public.work_credit_sources
WHERE work_credit_id = '5a6b8302-cc5a-44c2-ab73-334b76dbdf31'
  AND source_reference IN (
    'https://www.qobuz.com/co-es/album/los-grandes-de-alex-bueno-alex-bueno-orquesta-liberacion/ylmzqajymoc9a',
    'https://www.shazam.com/track/59619591/colegiala'
  );

UPDATE public.recording_credits
SET role_id = NULL
WHERE id = 'f70664da-8a10-4c17-9224-9695c85ee0b3'
  AND role_id = 'c648475e-7d6a-4f08-9781-3f470b572537';

SELECT set_config('app.governed_credit', 'on', true);

UPDATE public.work_credits
SET sequence = NULL,
    verification_status = 'unverified',
    updated_at = now()
WHERE id = '5a6b8302-cc5a-44c2-ab73-334b76dbdf31';

SELECT set_config('app.governed_credit', 'off', true);

UPDATE public.works
SET slug = NULL,
    language = NULL,
    composition_year = NULL,
    status = 'draft',
    updated_at = now()
WHERE id = '646df393-978e-4457-a6c0-43e1b7a82ffd';

NOTIFY pgrst, 'reload schema';
COMMIT;
