BEGIN;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM public.recordings
    WHERE id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
      AND title = 'Colegiala'
  ) THEN
    RAISE EXCEPTION 'Colegiala canonical recording is missing';
  END IF;

  IF (SELECT count(*) FROM public.recordings WHERE id IN (
    '698e33d6-115d-4801-8acf-73376269492f',
    'ed8a0861-8328-488f-bfd5-652a69f148d9'
  )) <> 2 THEN
    RAISE EXCEPTION 'Expected Colegiala duplicate recordings are missing';
  END IF;
END $$;

-- The MusicBrainz import dated one uncatalogued release instance to 1984.
-- The identified original pressing is Karen KLP-89 (1985), so normalize the
-- duplicate release instance that otherwise overrides the public song year.
UPDATE public.releases
SET release_year = 1985,
    year = 1985,
    date = DATE '1985-01-01',
    metadata = coalesce(metadata, '{}'::jsonb)
      || jsonb_build_object(
        'editorial_date_override', '1985',
        'editorial_date_basis', 'Karen KLP-89 original pressing'
      )
WHERE id = 'e78f16ed-683b-499f-8621-bf740d87f4f1';

UPDATE public.release_groups
SET release_year = 1985
WHERE id = '4dc82373-62d2-43d5-b6de-c0a7c5003afd';

-- Preserve every release appearance on the surviving original recording.
UPDATE public.tracks
SET recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
WHERE recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);

-- Preserve normalized ISRC evidence. ISRC remains evidence rather than identity.
UPDATE public.recording_isrcs
SET recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
WHERE recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);

-- Keep existing canonical credits and remove duplicate semantic credits first.
UPDATE public.editorial_assertion_recording_credits assertion_credit
SET recording_credit_id = canonical_credit.id
FROM public.recording_credits old_credit
JOIN public.recording_credits canonical_credit
  ON canonical_credit.recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
 AND canonical_credit.role = old_credit.role
 AND canonical_credit.artist_id IS NOT DISTINCT FROM old_credit.artist_id
 AND canonical_credit.external_contributor_id IS NOT DISTINCT FROM old_credit.external_contributor_id
WHERE assertion_credit.recording_credit_id = old_credit.id
  AND old_credit.recording_id IN (
    '698e33d6-115d-4801-8acf-73376269492f',
    'ed8a0861-8328-488f-bfd5-652a69f148d9'
  );

DELETE FROM public.recording_credits old_credit
WHERE old_credit.recording_id IN (
    '698e33d6-115d-4801-8acf-73376269492f',
    'ed8a0861-8328-488f-bfd5-652a69f148d9'
  )
  AND EXISTS (
    SELECT 1
    FROM public.recording_credits canonical_credit
    WHERE canonical_credit.recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
      AND canonical_credit.role = old_credit.role
      AND canonical_credit.artist_id IS NOT DISTINCT FROM old_credit.artist_id
      AND canonical_credit.external_contributor_id IS NOT DISTINCT FROM old_credit.external_contributor_id
  );

UPDATE public.recording_credits
SET recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
WHERE recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);

-- Prefer the canonical platform row where one already exists. Move missing
-- services from the best-supported 1985/1992 identity, then discard redundant
-- provider links from the purported 2004 duplicate.
DELETE FROM public.recording_platform_links old_link
WHERE old_link.recording_id IN (
    '698e33d6-115d-4801-8acf-73376269492f',
    'ed8a0861-8328-488f-bfd5-652a69f148d9'
  )
  AND EXISTS (
    SELECT 1
    FROM public.recording_platform_links canonical_link
    WHERE canonical_link.recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
      AND canonical_link.platform = old_link.platform
      AND canonical_link.link_type = old_link.link_type
  );

UPDATE public.recording_platform_links
SET recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
WHERE recording_id = '698e33d6-115d-4801-8acf-73376269492f';

DELETE FROM public.recording_platform_links old_link
WHERE old_link.recording_id = 'ed8a0861-8328-488f-bfd5-652a69f148d9'
  AND EXISTS (
    SELECT 1
    FROM public.recording_platform_links canonical_link
    WHERE canonical_link.recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
      AND canonical_link.platform = old_link.platform
      AND canonical_link.link_type = old_link.link_type
  );

UPDATE public.recording_platform_links
SET recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
WHERE recording_id = 'ed8a0861-8328-488f-bfd5-652a69f148d9';

-- Preserve historical views while respecting the session/day deduplication key.
DELETE FROM public.recording_view_events old_view
WHERE old_view.recording_id IN (
    '698e33d6-115d-4801-8acf-73376269492f',
    'ed8a0861-8328-488f-bfd5-652a69f148d9'
  )
  AND old_view.session_id IS NOT NULL
  AND EXISTS (
    SELECT 1
    FROM public.recording_view_events canonical_view
    WHERE canonical_view.recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
      AND canonical_view.session_id = old_view.session_id
      AND canonical_view.view_day = old_view.view_day
  );

UPDATE public.recording_view_events
SET recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
WHERE recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);

UPDATE public.editorial_assertion_recording_work_targets
SET recording_id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd'
WHERE recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);

DELETE FROM public.recording_slug_redirects
WHERE old_recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
)
OR canonical_recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);

DELETE FROM public.recording_redirects
WHERE old_recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
)
OR canonical_recording_id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);

-- Free the requested canonical slug before assigning it to the original.
UPDATE public.recordings
SET slug = 'colegiala-bachata-pending'
WHERE id = '0fea06fb-180e-404b-a6cd-aa8351ae188d';

UPDATE public.recordings
SET slug = 'colegiala-alex-bueno',
    recording_year = 1985,
    duration = 291640,
    disambiguation = 'Original',
    release_id = 'b8d7126a-6277-4b5c-939e-8398bc51460f',
    isrcs = ARRAY['USJ3V1497149','USJ3V1498118','USJ3V1841803','US3Z40407609','US3Z41500153']::text[],
    views = (
      SELECT coalesce(sum(coalesce(source.views, 0)), 0)
      FROM public.recordings source
      WHERE source.id IN (
        'a313df5d-479b-4f7e-b980-87d5d6abfedd',
        '698e33d6-115d-4801-8acf-73376269492f',
        'ed8a0861-8328-488f-bfd5-652a69f148d9'
      )
    ),
    metadata = (coalesce(metadata, '{}'::jsonb)
      || jsonb_build_object(
        'first-release-date', '1985',
        'identity_review', 'Consolidated duplicate catalog identities into the documented 1985 original on 2026-09-22.'
      ))
      - 'isrcs'
WHERE id = 'a313df5d-479b-4f7e-b980-87d5d6abfedd';

UPDATE public.recordings
SET slug = 'colegiala-bachata',
    recording_year = 2001,
    disambiguation = 'Bachata',
    metadata = coalesce(metadata, '{}'::jsonb)
      || jsonb_build_object('first-release-date', '2001-01-01')
WHERE id = '0fea06fb-180e-404b-a6cd-aa8351ae188d';

UPDATE public.recordings
SET recording_year = 2018,
    disambiguation = 'Gabriel Pagán version',
    metadata = coalesce(metadata, '{}'::jsonb)
      || jsonb_build_object('first-release-date', '2018-10-15')
WHERE id = '6531cb3f-74da-42a6-a2e5-3eda3682deef';

UPDATE public.recordings
SET slug = 'colegiala-sinfonico',
    recording_year = 2024,
    disambiguation = 'Sinfónico',
    metadata = coalesce(metadata, '{}'::jsonb)
      || jsonb_build_object('first-release-date', '2024-11-22')
WHERE id = '220cbbd4-f2c3-480e-8161-df3a9b69ae50';

DELETE FROM public.recordings
WHERE id IN (
  '698e33d6-115d-4801-8acf-73376269492f',
  'ed8a0861-8328-488f-bfd5-652a69f148d9'
);

UPDATE public.editorial_decisions
SET status = 'reversed', decided_at = coalesce(decided_at, now()),
    internal_notes = concat_ws(E'\n', internal_notes, 'Superseded by physical consolidation migration 20260922012000.')
WHERE id = '3330644f-2ebf-4d4b-82b0-43e88e0b5531';

INSERT INTO public.editorial_decisions (
  id, decision_type, status, reason, previous_canonical_state,
  resulting_canonical_state, public_notes, metadata, decided_at
) VALUES (
  '34bb5fd5-e1ee-4c1b-95fc-58d0ae853a71',
  'merge_recording_identity',
  'executed',
  'Normalize Colegiala into four documented Recording identities and consolidate compilation/provider duplicates into the 1985 original.',
  jsonb_build_object('recording_count', 6, 'redirect_count', 2),
  jsonb_build_object(
    'recording_count', 4,
    'slugs', jsonb_build_array('colegiala-alex-bueno','colegiala-bachata','colegiala-gabriel-pagan','colegiala-sinfonico')
  ),
  'Colegiala now has four Recording identities: the 1985 original, 2001 bachata version, 2018 Gabriel Pagán version, and 2024 symphonic version.',
  jsonb_build_object('requested_by', 'catalog owner', 'applied_on', '2026-09-22'),
  now()
) ON CONFLICT (id) DO NOTHING;

DO $$
BEGIN
  IF (SELECT count(*) FROM public.recordings WHERE work_id = '646df393-978e-4457-a6c0-43e1b7a82ffd') <> 4 THEN
    RAISE EXCEPTION 'Colegiala normalization did not produce exactly four recordings';
  END IF;

  IF EXISTS (
    SELECT 1 FROM public.recording_redirects
    WHERE old_recording_id IN (
      '698e33d6-115d-4801-8acf-73376269492f',
      'ed8a0861-8328-488f-bfd5-652a69f148d9'
    )
  ) THEN
    RAISE EXCEPTION 'Obsolete Colegiala redirects remain';
  END IF;
END $$;

NOTIFY pgrst, 'reload schema';
COMMIT;
