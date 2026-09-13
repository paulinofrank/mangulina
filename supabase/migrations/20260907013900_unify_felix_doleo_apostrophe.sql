BEGIN;

-- Unifica el apóstrofo del nombre de Félix D'Oleo dentro de su propia
-- biografía. El campo name guarda el apóstrofo recto (U+0027), que es la
-- convención de la base -- la misma de "D'Soto" y "Juliana O'Neal" --, pero la
-- prosa había quedado con el tipográfico (U+2019).
-- 
-- Es invisible al leer y no cambia ningún hecho, pero el nombre canónico de un
-- artista y el nombre que aparece en su propia ficha deben ser la misma cadena.
-- En cuanto alguien busque, compare o cite por texto, dejan de coincidir.
--
-- El documento y el espejo markdown se mueven juntos: la página pública sirve
-- el documento, pero una ficha en borrador cae al espejo, y dejar los dos
-- diciendo cosas distintas es un fallo invisible hasta que alguien lo lee.
--
-- Solo cambia texto. Ningún nodo artistReference se toca, así que los enlaces
-- y sus occurrence_id quedan como estaban y editorial_entity_references no se
-- reconstruye.
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.
--
-- PARA REVERTIR: supabase/rollback/20260907013900_revert_unify_felix_doleo_apostrophe.sql

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Félix D’Oleo is a Dominican', 'Félix D''Oleo is a Dominican')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'felix-doleo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Félix D’Oleo is a Dominican' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Félix D’Oleo is a Dominican', 'Félix D''Oleo is a Dominican'),
       updated_at = now()
 WHERE slug = 'felix-doleo'
   AND position('Félix D’Oleo is a Dominican' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Félix D’Oleo es un cantautor', 'Félix D''Oleo es un cantautor')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'felix-doleo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Félix D’Oleo es un cantautor' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Félix D’Oleo es un cantautor', 'Félix D''Oleo es un cantautor'),
       updated_at = now()
 WHERE slug = 'felix-doleo'
   AND position('Félix D’Oleo es un cantautor' in bio_es) > 0;

COMMIT;
