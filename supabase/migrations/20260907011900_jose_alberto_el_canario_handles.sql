BEGIN;

-- Añade los handles de YouTube y Facebook de José Alberto "El Canario", que su
-- ficha dejó vacíos a propósito hace un rato.
--
-- POR QUÉ ESTABAN VACÍOS. Al escribir la ficha el handle de YouTube que
-- devolvían los buscadores era "@JoséAlbertoElCanario-l9u441" y al probarlo daba
-- 404, así que se dejó el campo vacío antes que guardar algo que no resuelve.
-- El sufijo real es "-l9u": el buscador había pegado caracteres de más. Lo
-- aportó el editor y está comprobado — la URL responde "José Alberto El Canario
-- - YouTube".
--
-- EL ACENTO EN EL HANDLE NO ES UN ERROR. Es la convención que ya sigue la tabla
-- para los canales autogenerados de artistas con nombre acentuado:
-- @HenryJiménezOficial, @RoyTavaréMusic, @DeyviSiméOficial y @ToñoRosario-p8s,
-- este último con exactamente la misma forma de sufijo.
--
-- FACEBOOK VA COMO ID NUMÉRICO PELADO, sin el "profile.php?id=". Ese perfil no
-- tiene nombre de usuario, y guardar solo el número es lo que hace la mayoría de
-- la tabla: 100063809615923 en jose-manuel-calderon, 61568425952172 en
-- sexappeal, 100059622788386 en the-nino.
--
-- DEUDA ANOTADA: dos filas guardan la forma larga con el prefijo de la consulta
-- -- arianna-puello con "profile.php?id=100044569503508" y epico-gelato con
-- "profile.php?id=61558073654117". Deberían quedar como el número solo. No se
-- tocan aquí porque son otras fichas y esta migración va de una.
--
-- PARA REVERTIR: supabase/rollback/20260907011900_revert_jose_alberto_el_canario_handles.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel y
-- no se revalidó nada.

UPDATE artists
   SET youtube    = '@JoséAlbertoElCanario-l9u',
       facebook   = '100044419929906',
       updated_at = now()
 WHERE slug = 'jose-alberto-el-canario'
   AND youtube IS NULL
   AND facebook IS NULL;

COMMIT;
