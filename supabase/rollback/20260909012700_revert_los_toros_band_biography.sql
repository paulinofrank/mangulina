BEGIN;

-- Revierte 20260909012700_rewrite_los_toros_band_biography.sql
--
-- Aviso: el estado anterior sitúa la fundación en Bonao, que dos fuentes y el
-- propio canal del grupo contradicen.

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'los-toros-band' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-toros-band')
   AND document_type = 'artist_biography';

UPDATE artists SET
  birth_year  = NULL,
  birth_place = 'Bonao',
  province    = 'Monseñor Nouel',
  bio_es      = NULL,
  bio_en      = 'Los Toros Band is one of the most successful and enduring ensembles in Dominican popular music, a group whose command of merengue and bachata has won them decades of consistent popularity both at home and among Dominican communities around the world. Founded in the 1980s, the group built their reputation through relentless touring and a series of recordings that demonstrated their ability to craft irresistible dance floor hits while maintaining the rhythmic integrity of the genres they work in.

Their sound is polished and professional without sacrificing the heat and spontaneity that make merengue and bachata effective as social and recreational music. Los Toros Band has been a reliable presence on the Dominican music circuit through multiple cycles of fashion, adapting their approach as needed while retaining a core identity that their fans recognize and return to. They represent the professional, seasoned wing of Dominican tropical music — artists who have made a career out of consistent quality and genuine engagement with their audience.'
WHERE slug = 'los-toros-band';

COMMIT;
