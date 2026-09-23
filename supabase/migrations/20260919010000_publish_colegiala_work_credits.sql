BEGIN;

-- Publish the already-curated Colegiala Work and attach the evidence that
-- supports its existing composer credit. No Recording identity or Work link
-- is changed by this migration.
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM public.works
    WHERE id = '646df393-978e-4457-a6c0-43e1b7a82ffd'
      AND preferred_title = 'Colegiala'
  ) THEN
    RAISE EXCEPTION 'Expected Colegiala Work was not found';
  END IF;

  IF EXISTS (
    SELECT 1 FROM public.works
    WHERE slug = 'colegiala'
      AND id <> '646df393-978e-4457-a6c0-43e1b7a82ffd'
  ) THEN
    RAISE EXCEPTION 'The Work slug colegiala is already in use';
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM public.work_credits wc
    JOIN public.external_contributors ec ON ec.id = wc.external_contributor_id
    WHERE wc.id = '5a6b8302-cc5a-44c2-ab73-334b76dbdf31'
      AND wc.work_id = '646df393-978e-4457-a6c0-43e1b7a82ffd'
      AND wc.role = 'composer'
      AND ec.preferred_name = 'Walter León Aguilar'
  ) THEN
    RAISE EXCEPTION 'Expected Walter León Aguilar composer credit was not found';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM public.recordings
    WHERE id = '698e33d6-115d-4801-8acf-73376269492f'
      AND work_id = '646df393-978e-4457-a6c0-43e1b7a82ffd'
  ) THEN
    RAISE EXCEPTION 'Expected Alex Bueno recording is not linked to the Colegiala Work';
  END IF;
END $$;

UPDATE public.works
SET slug = 'colegiala',
    language = 'es',
    composition_year = 1975,
    status = 'published',
    updated_at = now()
WHERE id = '646df393-978e-4457-a6c0-43e1b7a82ffd';

SELECT set_config('app.governed_credit', 'on', true);

UPDATE public.work_credits
SET role_id = '2bf885e4-c481-4afe-acff-be876c16f471',
    sequence = 1,
    verification_status = 'verified',
    updated_at = now()
WHERE id = '5a6b8302-cc5a-44c2-ab73-334b76dbdf31';

UPDATE public.recording_credits
SET role_id = 'c648475e-7d6a-4f08-9781-3f470b572537'
WHERE id = 'f70664da-8a10-4c17-9224-9695c85ee0b3'
  AND role = 'lead_performer'
  AND role_id IS NULL;

INSERT INTO public.work_credit_sources (
  work_credit_id, source_type, source_name, source_reference,
  assertion_status, verification_status, notes, metadata,
  observed_at, verified_at
)
SELECT
  '5a6b8302-cc5a-44c2-ab73-334b76dbdf31',
  'digital_music_service',
  'Qobuz',
  'https://www.qobuz.com/co-es/album/los-grandes-de-alex-bueno-alex-bueno-orquesta-liberacion/ylmzqajymoc9a',
  'supports',
  'verified',
  'Qobuz credits Walter León as composer of Colegiala and Alex Bueno and Orquesta Liberación as main artists.',
  jsonb_build_object('track_title', 'Colegiala', 'credit', 'Walter León — Composer'),
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.work_credit_sources
  WHERE work_credit_id = '5a6b8302-cc5a-44c2-ab73-334b76dbdf31'
    AND source_reference = 'https://www.qobuz.com/co-es/album/los-grandes-de-alex-bueno-alex-bueno-orquesta-liberacion/ylmzqajymoc9a'
);

INSERT INTO public.work_credit_sources (
  work_credit_id, source_type, source_name, source_reference,
  assertion_status, verification_status, notes, metadata,
  observed_at, verified_at
)
SELECT
  '5a6b8302-cc5a-44c2-ab73-334b76dbdf31',
  'digital_music_service',
  'Shazam',
  'https://www.shazam.com/track/59619591/colegiala',
  'supports',
  'verified',
  'Shazam credits Walter Leon as composer, Alex Bueno on lead vocals, and Alex Bueno y Su Orquesta as performer.',
  jsonb_build_object('track_title', 'Colegiala', 'credits', jsonb_build_array('Walter Leon — Composer', 'Alex Bueno — Lead Vocals', 'Alex Bueno y Su Orquesta — Performer')),
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.work_credit_sources
  WHERE work_credit_id = '5a6b8302-cc5a-44c2-ab73-334b76dbdf31'
    AND source_reference = 'https://www.shazam.com/track/59619591/colegiala'
);

SELECT set_config('app.governed_credit', 'off', true);

NOTIFY pgrst, 'reload schema';
COMMIT;
