BEGIN;

-- Normaliza el formato de youtube, instagram, facebook y website, y CORRIGE
-- TRES ENLACES DE YOUTUBE QUE ESTABAN ROTOS.
--
-- Lista de formatos inconsistentes levantada por el editor. Al auditarla
-- apareció que no era solo cosmética.
--
-- ================================================================
-- PRIMERO: LO QUE NO ERA COSMÉTICO
-- ================================================================
--
-- El front-end (ArtistFactsCard.tsx, getYoutubeUrl) convierte un valor pelado
-- sin @ y sin URL en "youtube.com/@valor". Diez filas guardaban un valor así.
-- Probé las diez una por una y TRES DAN 404, también en sus formas /user/ y
-- /c/. Eran enlaces muertos en páginas publicadas:
--
--   michel-camilo   "MichelCamiloOfficial"  -> 404 en @, /user/ y /c/
--   nancy-amancio   "NancyAmancioOficial"   -> 404, el real es @Nancyamanciomusic
--   sandy-gabriel   "sandygabrieljazz"      -> 404, el real es @SandyGabriel
--
-- MICHEL CAMILO SE DEJA EN NULL Y SE REPORTA. Buscándolo solo aparece un canal
-- "Michel Camilo - Topic", que es el que YouTube genera automáticamente a
-- partir del catálogo discográfico, no una cuenta que él lleve. Prefiero el
-- campo vacío a guardar un canal automático como si fuera suyo, y que el editor
-- decida. Es la misma decisión que tomé con José Alberto "El Canario", donde él
-- después me pasó el handle correcto.
--
-- Las otras siete filas peladas SÍ resuelven como @handle y solo les falta el
-- signo: candelario, dj-arelis-hot, josean-jacobo, king-streetz,
-- las-gemelas-fantasticas-rd, maffio y olga-lara.
--
-- ================================================================
-- FORMATO DE DESTINO
-- ================================================================
--
-- Se guarda SIN esquema y SIN dominio, que es lo que el front-end espera:
--
--   youtube    "@handle" cuando existe handle; si no, "channel/UC...",
--              "c/Nombre" o "user/Nombre".
--   instagram  el handle pelado.
--   facebook   el handle, o el identificador numérico pelado.
--   website    CON esquema, porque ahí el valor es una URL completa y no un
--              identificador.
--
-- FACEBOOK NUMÉRICO: el editor pidió conservar el comportamiento actual, donde
-- una cuenta sin handle bonito muestra solo la palabra "Facebook" en vez del
-- número. Eso lo hace getFacebookDisplay, y funciona TANTO con
-- "profile.php?id=N" COMO con el número pelado. Pasar las nueve filas de
-- profile.php al número pelado NO cambia lo que se ve: sigue diciendo
-- "Facebook". Solo unifica el almacenamiento.
--
-- NINGUNA DE ESTAS NORMALIZACIONES CAMBIA UN ENLACE. El front-end ya tolera
-- todas las formas de entrada; lo único que cambia de comportamiento son las
-- tres correcciones de arriba, que pasan de roto a funcionando.
--
-- PARA REVERTIR: supabase/rollback/20260907014400_revert_social_handles.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

-- ---------------------------------------------------------------
-- 1. Correcciones de enlaces rotos. VAN PRIMERO, para que el paso 3 no le
--    ponga un "@" a un valor que no funciona.
-- ---------------------------------------------------------------

UPDATE artists SET youtube = NULL, updated_at = now()
 WHERE slug = 'michel-camilo' AND youtube = 'MichelCamiloOfficial';

UPDATE artists SET youtube = '@Nancyamanciomusic', updated_at = now()
 WHERE slug = 'nancy-amancio' AND youtube = 'NancyAmancioOficial';

UPDATE artists SET youtube = '@SandyGabriel', updated_at = now()
 WHERE slug = 'sandy-gabriel' AND youtube = 'sandygabrieljazz';

-- ---------------------------------------------------------------
-- 2. YouTube: quitar esquema y dominio, y la barra final.
-- ---------------------------------------------------------------

UPDATE artists
   SET youtube = regexp_replace(youtube, '^https?://(www\.)?youtube\.com/', ''),
       updated_at = now()
 WHERE youtube ~ '^https?://(www\.)?youtube\.com/';

UPDATE artists
   SET youtube = regexp_replace(youtube, '/+$', ''), updated_at = now()
 WHERE youtube ~ '/+$';

-- ---------------------------------------------------------------
-- 3. YouTube: los nombres pelados que quedan son handles sin el signo.
--    Todos verificados uno por uno antes de aplicar esto.
-- ---------------------------------------------------------------

UPDATE artists
   SET youtube = '@' || youtube, updated_at = now()
 WHERE youtube IS NOT NULL
   AND youtube <> ''
   AND youtube NOT LIKE '@%'
   AND youtube !~ '^(channel|c|user)/';

-- ---------------------------------------------------------------
-- 4. Instagram: dejar solo el handle.
-- ---------------------------------------------------------------

UPDATE artists
   SET instagram = regexp_replace(
         regexp_replace(instagram, '^https?://(www\.)?instagram\.com/', ''),
         '/+$', ''),
       updated_at = now()
 WHERE instagram ~ '^https?://(www\.)?instagram\.com/';

UPDATE artists
   SET instagram = regexp_replace(instagram, '^@', ''), updated_at = now()
 WHERE instagram LIKE '@%';

-- ---------------------------------------------------------------
-- 5. Facebook: dejar el handle, o el número pelado.
-- ---------------------------------------------------------------

UPDATE artists
   SET facebook = regexp_replace(
         regexp_replace(facebook, '^https?://(www\.)?facebook\.com/', ''),
         '/+$', ''),
       updated_at = now()
 WHERE facebook ~ '^https?://(www\.)?facebook\.com/';

UPDATE artists
   SET facebook = regexp_replace(facebook, '^profile\.php\?id=', ''),
       updated_at = now()
 WHERE facebook ~ '^profile\.php\?id=[0-9]+$';

-- ---------------------------------------------------------------
-- 6. Website: al revés que los demás, aquí SÍ va el esquema.
-- ---------------------------------------------------------------

UPDATE artists
   SET website = 'https://' || website, updated_at = now()
 WHERE website IS NOT NULL
   AND website <> ''
   AND website !~ '^https?://';

COMMIT;
