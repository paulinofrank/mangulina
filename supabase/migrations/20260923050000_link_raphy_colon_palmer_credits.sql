-- Promote Raphy Colón's Palmer Hernández credits from external text to the
-- published Mangulina performer, linking existing recordings where present.
UPDATE public.credited_works
SET performer_artist_id = 'a69ae2ce-2571-4816-b367-f78e63fcac62',
    recording_id = CASE search_normalize(title)
      WHEN 'con el' THEN 'a612eba3-cc7c-479c-8b12-b0b5c3ffe21c'::uuid
      WHEN 'ungete' THEN '2c93b942-faa8-4ba0-aee2-5291d5ff87bc'::uuid
      ELSE recording_id
    END,
    updated_at = now()
WHERE id IN (
  '78622cf4-813a-4c2e-b05a-cc365c4065c9',
  '09c0d076-216d-477a-9538-fb566c42d07a',
  '02e0760a-a9fb-4ba4-9b1f-98fdfc0c0182',
  'e3b7ce9a-5d0b-4e6a-8b80-16f2ce0a7f81'
);
