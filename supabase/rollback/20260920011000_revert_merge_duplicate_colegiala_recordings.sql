BEGIN;
DELETE FROM public.recording_slug_redirects WHERE old_recording_id IN ('698e33d6-115d-4801-8acf-73376269492f','ed8a0861-8328-488f-bfd5-652a69f148d9');
DELETE FROM public.recording_redirects WHERE old_recording_id IN ('698e33d6-115d-4801-8acf-73376269492f','ed8a0861-8328-488f-bfd5-652a69f148d9');
DELETE FROM public.editorial_decisions WHERE id='3330644f-2ebf-4d4b-82b0-43e88e0b5531';
UPDATE public.recordings SET recording_year=NULL,genre_id='2',metadata=metadata-'identity_review' WHERE id='a313df5d-479b-4f7e-b980-87d5d6abfedd';
NOTIFY pgrst,'reload schema';
COMMIT;
