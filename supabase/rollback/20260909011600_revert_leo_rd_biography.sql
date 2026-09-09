BEGIN;

-- Revierte 20260909011600_rewrite_leo_rd_biography.sql
--
-- Aviso: el estado anterior incluye last_name "Castillo", que tres fuentes
-- independientes contradicen. Restaurarlo vuelve a publicar el apellido
-- equivocado.

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'leo-rd' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leo-rd')
   AND document_type = 'artist_biography';

UPDATE artists SET
  last_name     = 'Castillo',
  middle_name   = 'Felipe',
  date_of_birth = NULL,
  birth_year    = NULL,
  birth_place   = 'Santo Domingo',
  bio_es        = NULL,
  bio_en        = 'Leo RD is a Dominican dembow and urban artist connected to Santo Domingo whose work reflects the current vitality of the Dominican urban music scene. Operating within a genre that has established itself as one of the most energetic and original sounds to emerge from the Caribbean in recent years, Leo RD brings the raw energy and street-level perspective that define dembow at its most authentic. His music draws on the dense rhythmic production and assertive vocal style characteristic of Dominican urban music, and his recordings have found audiences among fans of the genre both domestically and in the broader Latin urban market. Leo RD represents the continuing flow of new talent from Santo Domingo''s urban music ecosystem — a scene that has demonstrated a remarkable capacity to generate fresh voices who push the genre''s boundaries while remaining true to its core aesthetic.'
WHERE slug = 'leo-rd';

COMMIT;
