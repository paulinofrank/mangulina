BEGIN;

-- Registra los diez reconocimientos de Sonia Silvestre, que no tenía NI UNO
-- guardado, crea el Premio Paoli y tres categorías.
--
-- Salió al reescribir su ficha, que era una de las 229 publicadas solo en
-- inglés. La ganadora de El Soberano del año 2000 tenía la tabla de premios
-- vacía.
--
-- UN PREMIO NUEVO
--
--   "Premio Paoli", que entrega Puerto Rico en memoria del tenor Antonio Paoli.
--   Lo recibió como artista internacional del año en 1991. No cabe en ninguno
--   de los 52 que el catálogo ya tiene.
--
-- TRES CATEGORÍAS NUEVAS
--
--   "Cantante Más Popular" bajo Premios El Dorado. NO SE REUTILIZA la
--   "Cantante del Año" que ya existe bajo ese mismo premio, creada al escribir
--   la ficha de Cecilia García: la fuente dice consistentemente "cantante más
--   popular", que en un premio de votación popular no es lo mismo que cantante
--   del año. QUEDA REPORTADO POR SI SON LA MISMA: si el editor confirma que lo
--   son, se funden y esta desaparece.
--
--   "Mejor Espectáculo del Año" bajo Premios El Dorado. Mismo caso: existe
--   "Realizadora del Mejor Espectáculo del Año", en femenino y referida a quien
--   produce. La fuente sobre Silvestre dice solo "Premio El Dorado al mejor
--   espectáculo", sin decir que fuera como realizadora, y atribuirle una
--   producción que no consta sería inventar un crédito. SE REPORTA LA POSIBLE
--   FUSIÓN igual que la anterior.
--
--   "Gloria Nacional del Canto Popular" bajo Congreso Nacional de la República
--   Dominicana. Ojo: existe una "Gloria Nacional de la Comunicación" bajo
--   Gobierno de la República Dominicana, que es otra distinción de otra entidad
--   y no se toca.
--
-- SE REUTILIZAN CUATRO CATEGORÍAS EXISTENTES: "Female Artist of the Year" y
-- "Videoclip del Año" y "El Soberano" de Premios Casandra, y "Reserva Musical
-- Nacional". La primera está en INGLÉS dentro de un premio dominicano, que es
-- una inconsistencia anterior a esta migración; la reutilizo para no crear un
-- duplicado y la dejo reportada.
--
-- LAS DIEZ ADJUDICACIONES
--
--   1975  El Dorado          Cantante Más Popular
--   1976  El Dorado          Cantante Más Popular
--   1977  El Dorado          Cantante Más Popular
--   1977  El Dorado          Mejor Espectáculo del Año
--   1990  Premios Casandra   cantante más destacada
--   1990  Premios Casandra   Videoclip del Año
--   1991  Premio Paoli       Artista Internacional del Año
--   2000  Premios Casandra   El Soberano
--   2004  Congreso Nacional  Gloria Nacional del Canto Popular
--   2011  Reserva Musical    Reserva Musical Nacional
--
-- LA FECHA DEL SENADO ES EXACTA y la fuente la da: 16 de marzo de 2004. Como
-- la tabla guarda solo el año, el día va en work para no perderlo.
--
-- QUEDAN FUERA, POR NO SER PREMIOS: que la revista Tele-3 la eligiera cantante
-- más popular en 1972 y el programa Farándula en 1973, que son encuestas de
-- medios; el segundo lugar del Festival de AMUCABA de 1971 y su condición de
-- finalista en Bogotá el mismo año, que son puestos de concurso y están en la
-- biografía; y la selección de La Nación entre los diez mejores cantantes del
-- siglo XX, que es una lista periodística.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908001700_revert_sonia_silvestre_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country)
VALUES
  ('8a093a7b-6986-4701-a2ae-3ce96d08f778'::uuid,
   'Premio Paoli', 'Fundación Antonio Paoli', 'Puerto Rico')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('3aa0c007-c004-41f0-9fc9-93d5d5be8d5a'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid, 'Cantante Más Popular'),
  ('6578feb5-704f-486e-b053-aa894a521506'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid, 'Mejor Espectáculo del Año'),
  ('2f16077d-d314-4bb6-8579-cd3efc6264bc'::uuid,
   '8a093a7b-6986-4701-a2ae-3ce96d08f778'::uuid, 'Artista Internacional del Año'),
  ('2bc60fbf-2024-4f99-88ba-a60009e7a769'::uuid,
   '748be643-80ea-4c18-9558-b9a1a414f4f9'::uuid, 'Gloria Nacional del Canto Popular')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, 'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   '3aa0c007-c004-41f0-9fc9-93d5d5be8d5a'::uuid, 1975, NULL, true, 'Wikipedia (es)'),
  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, 'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   '3aa0c007-c004-41f0-9fc9-93d5d5be8d5a'::uuid, 1976, NULL, true, 'Wikipedia (es)'),
  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, 'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   '3aa0c007-c004-41f0-9fc9-93d5d5be8d5a'::uuid, 1977, NULL, true, 'Wikipedia (es)'),
  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, 'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   '6578feb5-704f-486e-b053-aa894a521506'::uuid, 1977, NULL, true, 'Wikipedia (es)'),

  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '44c68aef-7ce3-4d58-a287-069f2816056b'::uuid, 1990, 'Cantante más destacada', true,
   'Wikipedia (es); la ficha marca esta línea como falta de cita, el listado de reconocimientos la repite'),
  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'a828f9ca-5b81-4c2e-aad2-ee2b93fefcc7'::uuid, 1990, NULL, true, 'Wikipedia (es)'),

  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, '8a093a7b-6986-4701-a2ae-3ce96d08f778'::uuid,
   '2f16077d-d314-4bb6-8579-cd3efc6264bc'::uuid, 1991, 'Puerto Rico', true, 'Wikipedia (es)'),

  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '6d483d83-448c-4007-861d-89d53ce5f8fb'::uuid, 2000, 'Máxima distinción de Acroarte', true,
   'Wikipedia (es)'),

  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, '748be643-80ea-4c18-9558-b9a1a414f4f9'::uuid,
   '2bc60fbf-2024-4f99-88ba-a60009e7a769'::uuid, 2004,
   'Declaratoria del Senado del 16 de marzo, por treinta años de aporte', true, 'Wikipedia (es)'),

  ('2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid, '2b6d84f1-3a95-4c07-8e12-5d70bf9a3c48'::uuid,
   '5e90b7c4-6dc8-4f3a-b145-80a3ec2d6f7b'::uuid, 2011,
   'Banco de Reservas; incluyó un disco recopilatorio producido por Luis Ovalles', true,
   'Wikipedia (es)');

COMMIT;
