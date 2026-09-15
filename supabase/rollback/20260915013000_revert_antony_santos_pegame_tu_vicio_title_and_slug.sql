BEGIN;

-- Revierte 20260915013000_fix_antony_santos_pegame_tu_vicio_title_and_slug.sql

UPDATE recordings
   SET title = 'Págame tu vicio',
       slug = 'pagame-tu-vicio-antony-santos',
       metadata = jsonb_set(metadata, '{title}', '"Págame tu vicio"'),
       updated_at = now()
 WHERE id = '04b5b553-ea3f-47d5-b865-17b9a8717324';

UPDATE tracks
   SET metadata = jsonb_set(
         jsonb_set(metadata, '{track,title}', '"Págame tu vicio"'),
         '{recording,title}',
         '"Págame tu vicio"'
       ),
       updated_at = now()
 WHERE id = 'de03953e-a920-4495-adbb-2f5070c613de';

COMMIT;
