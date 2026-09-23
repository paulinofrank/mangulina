BEGIN;
DO $$ DECLARE n integer; BEGIN
 SELECT count(*) INTO n FROM public.recording_credits WHERE recording_id='a313df5d-479b-4f7e-b980-87d5d6abfedd' AND role='backing_vocalist';
 IF n<>2 THEN RAISE EXCEPTION 'Expected two backing vocalists, found %',n; END IF;
 SELECT count(*) INTO n FROM public.recording_credits WHERE recording_id='a313df5d-479b-4f7e-b980-87d5d6abfedd' AND role='arranger';
 IF n<>1 THEN RAISE EXCEPTION 'Expected Manuel Tejada as sole arranger, found % arranger rows',n; END IF;
 IF NOT EXISTS(SELECT 1 FROM public.recording_credits WHERE recording_id='a313df5d-479b-4f7e-b980-87d5d6abfedd' AND artist_id='6c3e0d74-23b7-4d80-969f-9d5319ee5127' AND role='lead_performer') THEN RAISE EXCEPTION 'Alex Bueno lead performer credit missing'; END IF;
 SELECT count(*) INTO n FROM public.release_credits WHERE release_id='b8d7126a-6277-4b5c-939e-8398bc51460f' AND verification_status='verified';
 IF n<>5 THEN RAISE EXCEPTION 'Expected five verified release credits, found %',n; END IF;
 IF NOT EXISTS(SELECT 1 FROM public.releases WHERE id='b8d7126a-6277-4b5c-939e-8398bc51460f' AND label='Karen Records' AND catalog_number='KLP-89' AND metadata->>'recorded_at'='EMCA Studio') THEN RAISE EXCEPTION 'Karen release metadata incomplete'; END IF;
END $$;
ROLLBACK;
