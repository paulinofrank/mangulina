BEGIN;

-- Añade a Nelson Estévez el Ralph S. Peer Publishers Award 2025 (J&N Publishing),
-- compartido con Juan Hidalgo.
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2025, 'A J&N Publishing (con Juan Hidalgo), entregado por la presidenta Marti Cuevas', true, 'Billboard (27 ago 2025); Yahoo/Yahoo Entertainment (17 oct 2025); LaMezcla.com (28 ago 2025); Nevarez PR (9 oct 2025)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'nelson-estevez' AND a.name = 'Latin Songwriters Hall of Fame' AND cat.name = 'Ralph S. Peer Publishers Award'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2025);

COMMIT;
