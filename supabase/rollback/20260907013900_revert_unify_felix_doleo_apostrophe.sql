BEGIN;

-- Revierte 20260907013900_unify_felix_doleo_apostrophe.sql.
--
-- Devuelve el texto anterior, con el registro conversacional que el editor
-- rechazó. Se conserva solo porque toda migración de este repositorio tiene
-- que ser reversible.

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Félix D''Oleo is a Dominican', 'Félix D’Oleo is a Dominican')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'felix-doleo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Félix D''Oleo is a Dominican' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Félix D''Oleo is a Dominican', 'Félix D’Oleo is a Dominican'),
       updated_at = now()
 WHERE slug = 'felix-doleo'
   AND position('Félix D''Oleo is a Dominican' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Félix D''Oleo es un cantautor', 'Félix D’Oleo es un cantautor')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'felix-doleo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Félix D''Oleo es un cantautor' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Félix D''Oleo es un cantautor', 'Félix D’Oleo es un cantautor'),
       updated_at = now()
 WHERE slug = 'felix-doleo'
   AND position('Félix D''Oleo es un cantautor' in bio_es) > 0;

COMMIT;
