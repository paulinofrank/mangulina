BEGIN;

-- Registra los cuatro premios de José Alberto "El Canario", que no tenía
-- ninguno en la base pese a haber ganado tres Latin Grammy.
--
-- Salió al escribir su ficha, que era una de las dieciséis publicadas sin una
-- sola línea de biografía. La tabla de premios de Wikipedia en español los
-- lista con año, obra, categoría y resultado:
--
--   2005  Congo de Oro   Festival de Orquestas del Carnaval de Barranquilla
--   2013  Latin Grammy   Salsa Giants
--   2015  Latin Grammy   Tributo a los Compadres
--   2018  Latin Grammy   A Mí Qué: Tributo a los Clásicos Cubanos
--
-- TRES CATEGORÍAS NUEVAS, y en inglés a propósito. La convención dominante de
-- las categorías de Latin Grammy en esta tabla es inglesa -- "Best
-- Merengue/Bachata Album" con once usos, "Album of the Year", "Best
-- Contemporary Tropical Album" --, así que las nuevas la siguen.
--
-- DEUDA QUE DEJO ANOTADA: "Mejor Álbum de Fusión Tropical", que creé ayer para
-- gabriel-pagan, se sale de esa convención y debería pasar a "Best Tropical
-- Fusion Album". No se toca aquí porque cambiarla es otra decisión y esta
-- migración va de otra cosa. Lo mismo con "Person of the Year" y "Latin
-- Recording Academy Person of the Year", que son la misma categoría duplicada.
--
-- SE USA EL award_id 1d8267d6 ("Latin Grammy"), que es el que tiene 30 filas.
-- El duplicado "Premios Latin Grammy" (ef51dad4) sigue con 2 y sigue pendiente
-- de fusionar.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260907011800_revert_jose_alberto_el_canario_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel y
-- no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('3c7e91a5-40b8-4d21-9f6e-2a1c85d3b70f'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid, 'Best Salsa Album'),
  ('8b5d2f14-6c9a-4e03-b7d8-51f04a6c2e93'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid, 'Best Traditional Tropical Album'),
  ('a1f60c78-2d94-4b55-8e17-93cb70d18a26'::uuid,
   'd86f297c-3b97-48bf-953b-ef64a7b74a08'::uuid, 'Salsa')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('e8ba0f32-1d96-494d-9861-b1dc3937331e'::uuid,
   'd86f297c-3b97-48bf-953b-ef64a7b74a08'::uuid,
   'a1f60c78-2d94-4b55-8e17-93cb70d18a26'::uuid,
   2005, NULL, true,
   'Festival de Orquestas del Carnaval de Barranquilla'),
  ('e8ba0f32-1d96-494d-9861-b1dc3937331e'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   '3c7e91a5-40b8-4d21-9f6e-2a1c85d3b70f'::uuid,
   2013, 'Salsa Giants', true,
   'Wikipedia (es), tabla de premios'),
  ('e8ba0f32-1d96-494d-9861-b1dc3937331e'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   '8b5d2f14-6c9a-4e03-b7d8-51f04a6c2e93'::uuid,
   2015, 'Tributo a los Compadres', true,
   'Wikipedia (es), tabla de premios'),
  ('e8ba0f32-1d96-494d-9861-b1dc3937331e'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   '8b5d2f14-6c9a-4e03-b7d8-51f04a6c2e93'::uuid,
   2018, 'A Mí Qué: Tributo a los Clásicos Cubanos', true,
   'Wikipedia (es), tabla de premios');

COMMIT;
