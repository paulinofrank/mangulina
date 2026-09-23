SELECT id, title, recording_year, disambiguation, slug
FROM public.recordings
WHERE work_id = '646df393-978e-4457-a6c0-43e1b7a82ffd'
ORDER BY recording_year, slug;

SELECT rel.title, coalesce(rel.release_year, rel.year, extract(year from rel.date)::int) release_year,
       t.position, r.slug
FROM public.tracks t
JOIN public.recordings r ON r.id = t.recording_id
JOIN public.releases rel ON rel.id = t.release_id
WHERE r.work_id = '646df393-978e-4457-a6c0-43e1b7a82ffd'
ORDER BY release_year, rel.title, t.position;

SELECT r.slug, count(distinct t.id)::int track_appearances,
       count(distinct i.id)::int isrcs,
       count(distinct l.id)::int platform_links,
       count(distinct c.id)::int credits
FROM public.recordings r
LEFT JOIN public.tracks t ON t.recording_id = r.id
LEFT JOIN public.recording_isrcs i ON i.recording_id = r.id
LEFT JOIN public.recording_platform_links l ON l.recording_id = r.id
LEFT JOIN public.recording_credits c ON c.recording_id = r.id
WHERE r.work_id = '646df393-978e-4457-a6c0-43e1b7a82ffd'
GROUP BY r.id, r.slug
ORDER BY r.recording_year;

SELECT count(*) AS obsolete_redirects
FROM public.recording_redirects
WHERE old_recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);
