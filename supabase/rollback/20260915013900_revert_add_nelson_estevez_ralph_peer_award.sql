BEGIN;

-- Revierte 20260915013900_add_nelson_estevez_ralph_peer_award.sql.
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Songwriters Hall of Fame' AND cat.name = 'Ralph S. Peer Publishers Award'
   AND w.year = 2025 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'nelson-estevez');

COMMIT;
