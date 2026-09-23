BEGIN;

DO $$
DECLARE
  linked_recordings integer;
  evidence_rows integer;
BEGIN
  SELECT count(*) INTO linked_recordings
  FROM public.recordings
  WHERE work_id = '646df393-978e-4457-a6c0-43e1b7a82ffd';

  IF linked_recordings <> 6 THEN
    RAISE EXCEPTION 'Expected 6 recordings linked to Colegiala, found %', linked_recordings;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM public.works
    WHERE id = '646df393-978e-4457-a6c0-43e1b7a82ffd'
      AND slug = 'colegiala'
      AND language = 'es'
      AND composition_year = 1975
      AND status = 'published'
  ) THEN
    RAISE EXCEPTION 'Colegiala Work publication values are incomplete';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM public.work_credits
    WHERE id = '5a6b8302-cc5a-44c2-ab73-334b76dbdf31'
      AND role = 'composer'
      AND role_id = '2bf885e4-c481-4afe-acff-be876c16f471'
      AND verification_status = 'verified'
  ) THEN
    RAISE EXCEPTION 'Walter León Aguilar composer credit is not verified';
  END IF;

  SELECT count(*) INTO evidence_rows
  FROM public.work_credit_sources
  WHERE work_credit_id = '5a6b8302-cc5a-44c2-ab73-334b76dbdf31'
    AND verification_status = 'verified';

  IF evidence_rows < 2 THEN
    RAISE EXCEPTION 'Expected at least two verified composer sources, found %', evidence_rows;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM public.recording_credits
    WHERE id = 'f70664da-8a10-4c17-9224-9695c85ee0b3'
      AND role = 'lead_performer'
      AND role_id = 'c648475e-7d6a-4f08-9781-3f470b572537'
  ) THEN
    RAISE EXCEPTION 'Alex Bueno lead performer role is not normalized';
  END IF;
END $$;

ROLLBACK;
