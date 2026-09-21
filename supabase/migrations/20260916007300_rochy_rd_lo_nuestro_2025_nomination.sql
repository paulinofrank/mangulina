BEGIN;

-- Rochy RD: nominación de 2025 a Mejor Canción Dembow (Premio Lo Nuestro) por «Déjenme Rulay» con Donaty.
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'f289c627-bc9e-48c5-8da3-d8fe3e9b0f60', (SELECT id FROM award_categories WHERE award_id = 'f289c627-bc9e-48c5-8da3-d8fe3e9b0f60' AND name = 'Mejor Canción Dembow'), 2025, 'Déjenme Rulay', false, 'Billboard y LOS40 (lista de nominados, 22 ene 2025); ganó «Hay Lupita» de Lomiiel (Diario Libre y Los Angeles Times, 20-21 feb 2025)'
  FROM artists a WHERE a.slug = 'rochy-rd';

COMMIT;
