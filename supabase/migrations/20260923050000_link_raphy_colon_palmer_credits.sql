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
  'f742ae2c-8372-43ce-9030-e02043a5ba95',
  '45d09b50-cac4-4a8b-8faf-28a0d07f75ff'
);
