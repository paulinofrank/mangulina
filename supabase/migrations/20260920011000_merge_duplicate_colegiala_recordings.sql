BEGIN;

DO $$ BEGIN
 IF NOT EXISTS(SELECT 1 FROM public.recordings WHERE id='a313df5d-479b-4f7e-b980-87d5d6abfedd' AND slug='colegiala-alex-bueno-3') THEN RAISE EXCEPTION 'Canonical Colegiala recording missing'; END IF;
 IF NOT EXISTS(SELECT 1 FROM public.recordings WHERE id='698e33d6-115d-4801-8acf-73376269492f') OR NOT EXISTS(SELECT 1 FROM public.recordings WHERE id='ed8a0861-8328-488f-bfd5-652a69f148d9') THEN RAISE EXCEPTION 'Duplicate Colegiala recordings missing'; END IF;
END $$;

INSERT INTO public.editorial_decisions(id,decision_type,status,reason,previous_canonical_state,resulting_canonical_state,public_notes,metadata,decided_at)
VALUES('3330644f-2ebf-4d4b-82b0-43e88e0b5531','merge_recording_identity','executed',
 'Consolidate provider-created Colegiala duplicates. ISRC assignment is evidence, not Recording identity; the rows resolve to the same commercial audio and have no documented performance distinction.',
 jsonb_build_object('recording_ids',jsonb_build_array('a313df5d-479b-4f7e-b980-87d5d6abfedd','698e33d6-115d-4801-8acf-73376269492f','ed8a0861-8328-488f-bfd5-652a69f148d9')),
 jsonb_build_object('canonical_recording_id','a313df5d-479b-4f7e-b980-87d5d6abfedd'),
 'The original, compilation, and purported 2004 merengue rows represent one Colegiala recording. The bachata version remains separate.',
 jsonb_build_object('evidence','same commercial platform recording; no distinct performance evidence'),now())
ON CONFLICT(id) DO NOTHING;

INSERT INTO public.recording_redirects(old_recording_id,canonical_recording_id,decision_id,reason)
VALUES
 ('698e33d6-115d-4801-8acf-73376269492f','a313df5d-479b-4f7e-b980-87d5d6abfedd','3330644f-2ebf-4d4b-82b0-43e88e0b5531','Duplicate provider Recording identity'),
 ('ed8a0861-8328-488f-bfd5-652a69f148d9','a313df5d-479b-4f7e-b980-87d5d6abfedd','3330644f-2ebf-4d4b-82b0-43e88e0b5531','Duplicate provider Recording identity')
ON CONFLICT(old_recording_id) DO UPDATE SET canonical_recording_id=excluded.canonical_recording_id,decision_id=excluded.decision_id,reason=excluded.reason;

INSERT INTO public.recording_slug_redirects(old_recording_id,old_slug,canonical_recording_id,reason)
VALUES
 ('698e33d6-115d-4801-8acf-73376269492f','colegiala-alex-bueno-2','a313df5d-479b-4f7e-b980-87d5d6abfedd','Duplicate Recording consolidated into the original'),
 ('ed8a0861-8328-488f-bfd5-652a69f148d9','colegiala-alex-bueno-4','a313df5d-479b-4f7e-b980-87d5d6abfedd','Duplicate Recording consolidated into the original')
ON CONFLICT(old_recording_id,canonical_recording_id) DO UPDATE SET old_slug=excluded.old_slug,reason=excluded.reason;

UPDATE public.recordings SET recording_year=1984,genre_id='1',disambiguation=NULL,
 metadata=coalesce(metadata,'{}'::jsonb)||jsonb_build_object('identity_review','Merged duplicate provider rows on 2026-09-20; ISRCs retained as evidence, not identity keys.')
WHERE id='a313df5d-479b-4f7e-b980-87d5d6abfedd';

CREATE OR REPLACE VIEW public.public_song_recordings WITH (security_invoker = true) AS
SELECT r.id, r.slug, r.title, w.id AS work_id, w.slug AS work_slug,
       w.preferred_title AS work_title, owner.id AS artist_id, owner.name AS artist_name,
       owner.slug AS artist_slug, r.duration, r.recording_year, r.isrcs,
       coalesce(first_release.release_year, r.recording_year) AS year,
       coalesce(first_release.id, representative.id) AS cover_release_id,
       coalesce(first_release.has_cover_image, representative.has_cover_image, false) AS has_cover_image
FROM public.recordings r
LEFT JOIN public.releases representative ON representative.id = r.release_id
LEFT JOIN public.artists owner ON owner.id = coalesce(r.artist_id, representative.release_artist_id)
LEFT JOIN public.works w ON w.id = r.work_id AND w.status = 'published'
LEFT JOIN LATERAL (
  SELECT rel.id, coalesce(rel.release_year, rel.year, extract(year FROM rel.date)::integer) AS release_year, rel.has_cover_image
  FROM public.tracks t JOIN public.releases rel ON rel.id=t.release_id LEFT JOIN public.artists a ON a.id=rel.release_artist_id
  WHERE t.recording_id=r.id AND (rel.release_artist_id IS NULL OR a.status='published')
  ORDER BY coalesce(rel.release_year,rel.year,extract(year FROM rel.date)::integer) NULLS LAST,rel.date NULLS LAST,rel.id LIMIT 1
) first_release ON true
WHERE (coalesce(r.artist_id,representative.release_artist_id) IS NULL OR owner.status='published')
AND NOT EXISTS(SELECT 1 FROM public.recording_redirects redirect WHERE redirect.old_recording_id=r.id);

NOTIFY pgrst,'reload schema';
COMMIT;
