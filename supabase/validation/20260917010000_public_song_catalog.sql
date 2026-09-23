-- Read-only checks: every query below must return zero failures.
BEGIN READ ONLY;
SELECT 'duplicate_recording_rows' AS check_name, count(*) AS failures FROM (
 SELECT id FROM public.public_song_recordings GROUP BY id HAVING count(*)>1
) duplicates
UNION ALL
SELECT 'draft_work_exposure', count(*) FROM public.public_song_recordings s JOIN public.works w ON w.id=s.work_id WHERE w.status<>'published'
UNION ALL
SELECT 'unpublished_artist_exposure', count(*) FROM public.public_song_recordings s JOIN public.artists a ON a.id=s.artist_id WHERE a.status<>'published'
UNION ALL
SELECT 'dangling_track_recording', count(*) FROM public.tracks t LEFT JOIN public.recordings r ON r.id=t.recording_id WHERE t.recording_id IS NOT NULL AND r.id IS NULL
UNION ALL
SELECT 'dangling_track_release', count(*) FROM public.tracks t LEFT JOIN public.releases r ON r.id=t.release_id WHERE t.release_id IS NOT NULL AND r.id IS NULL
UNION ALL
SELECT 'duplicate_recording_credit', count(*) FROM (
 SELECT recording_id,coalesce(artist_id,external_contributor_id),coalesce(role_id::text,role)
 FROM public.recording_credits GROUP BY 1,2,3 HAVING count(*)>1
) duplicates
UNION ALL
SELECT 'duplicate_work_credit', count(*) FROM (
 SELECT work_id,coalesce(artist_id,external_contributor_id),coalesce(role_id::text,role)
 FROM public.work_credits GROUP BY 1,2,3 HAVING count(*)>1
) duplicates;

-- Version/platform checks use the current explicit identity relationships only.
WITH samples AS (
 SELECT id FROM public.public_song_recordings WHERE work_id IS NOT NULL
 UNION SELECT DISTINCT recording_id FROM public.recording_platform_links WHERE status='approved_manual'
), contexts AS (
 SELECT id,public.get_public_song_context(id,NULL) AS value FROM samples
), links AS (
 SELECT c.id,l.value AS link FROM contexts c
 CROSS JOIN LATERAL jsonb_array_elements(c.value->'recordings') r
 CROSS JOIN LATERAL jsonb_array_elements(r.value->'platform_links') l
)
SELECT 'platform_link_recording_ownership' AS check_name,count(*) AS failures FROM links l
WHERE NOT EXISTS (SELECT 1 FROM public.recording_platform_links p WHERE p.recording_id=l.id
 AND p.platform=l.link->>'platform' AND p.url=l.link->>'url' AND p.status IN ('approved_manual','approved_auto','approved'));
ROLLBACK;
