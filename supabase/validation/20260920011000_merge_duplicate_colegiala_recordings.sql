BEGIN;
DO $$ DECLARE n integer; BEGIN
 SELECT count(*) INTO n FROM public.public_song_recordings WHERE work_id='646df393-978e-4457-a6c0-43e1b7a82ffd';
 IF n<>4 THEN RAISE EXCEPTION 'Expected four public Colegiala recordings after consolidation, found %',n; END IF;
 SELECT count(*) INTO n FROM public.tracks WHERE recording_id IN ('698e33d6-115d-4801-8acf-73376269492f','ed8a0861-8328-488f-bfd5-652a69f148d9');
 IF n<>9 THEN RAISE EXCEPTION 'Non-destructive redirect must preserve nine duplicate-row release appearances, found %',n; END IF;
 SELECT count(*) INTO n FROM public.recording_redirects WHERE old_recording_id IN ('698e33d6-115d-4801-8acf-73376269492f','ed8a0861-8328-488f-bfd5-652a69f148d9') AND canonical_recording_id='a313df5d-479b-4f7e-b980-87d5d6abfedd';
 IF n<>2 THEN RAISE EXCEPTION 'Expected two redirects, found %',n; END IF;
 IF NOT EXISTS(SELECT 1 FROM public.public_song_recordings WHERE id='0fea06fb-180e-404b-a6cd-aa8351ae188d') THEN RAISE EXCEPTION 'Bachata Recording must remain public'; END IF;
END $$;
ROLLBACK;
