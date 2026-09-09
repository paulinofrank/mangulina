BEGIN;

-- Revierte 20260909011000_rewrite_hector_acosta_biography.sql
-- Devuelve a Héctor Acosta al relleno legacy en inglés, sin documentos,
-- restaura los alias cruzados y retira las ocho adjudicaciones Casandra.

-- 1. Referencias y documentos editoriales
DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents
    WHERE owner_artist_id = 'dee014d6-cb3c-4abb-9262-165538277a0d'
      AND document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = 'dee014d6-cb3c-4abb-9262-165538277a0d'
   AND document_type = 'artist_biography';

-- 2. Espejo legacy: texto anterior a la reescritura
UPDATE artists SET
  bio_es = NULL,
  bio_en = 'Héctor Acosta, known universally as El Torito, is one of the most successful and enduring stars in Dominican popular music, a singer born in 1967 in Bonao, Monseñor Nouel whose voice and charisma have made him a beloved figure in both merengue and bachata for more than three decades. Acosta began his career as the lead vocalist of the legendary merengue orchestra Los Toros Band, where he developed the powerful, emotionally direct vocal style that would become his trademark.

His time with Los Toros Band produced some of the most celebrated merengue recordings of the 1990s, making the group one of the dominant forces in Dominican popular music during that decade. When Acosta launched his solo career, he demonstrated remarkable artistic growth by embracing bachata alongside merengue, mastering a second genre with the same authority he had shown in the first.

His bachata recordings broadened his audience and deepened his artistic range, allowing him to connect with the intimate, romantic sensibility of that tradition while retaining the showmanship of a merengue star. El Torito has been a fixture at major Dominican and Latin music events for decades, and his sustained popularity across shifting musical trends speaks to a genuine connection with audiences that commercial calculation alone cannot explain. He remains one of the living treasures of Dominican popular music.'
WHERE id = 'dee014d6-cb3c-4abb-9262-165538277a0d';

-- 3. Alias cruzados que la migración retiró
UPDATE artists
   SET aliases = array_append(aliases, 'Los Toros Band')
 WHERE id = 'dee014d6-cb3c-4abb-9262-165538277a0d'
   AND NOT ('Los Toros Band' = ANY(aliases));

UPDATE artists
   SET aliases = ARRAY['Hector Acosta', 'El Torito']
 WHERE id = '73032c71-e46c-45b1-b02c-8f4de18426ad';

-- 4. Las ocho adjudicaciones Casandra añadidas (2013 y 2019 son previas: no se tocan)
DELETE FROM artist_awards w
 USING award_categories cat, awards aw
 WHERE w.category_id = cat.id
   AND cat.award_id = aw.id
   AND aw.name = 'Premios Casandra'
   AND w.artist_id = 'dee014d6-cb3c-4abb-9262-165538277a0d'
   AND w.year BETWEEN 2007 AND 2010;

-- 5. Relación con la agrupación
DELETE FROM artist_relationships
 WHERE source_artist_id = 'dee014d6-cb3c-4abb-9262-165538277a0d'
   AND target_artist_id = '73032c71-e46c-45b1-b02c-8f4de18426ad'
   AND relationship_type = 'member_of';

COMMIT;
