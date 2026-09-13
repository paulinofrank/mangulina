BEGIN;

-- Registra los cuatro reconocimientos de Rafael Solano, que no tenía ninguno.
--
-- Salió al reescribir su ficha, la segunda de las 211 que siguen solo en inglés
-- por número de enlaces entrantes (26) y la MÁS CORTA de todo el lote: 1.036
-- caracteres que no nombraban ni "Por Amor" ni uno solo de estos premios.
--
-- NINGUNA CATEGORÍA NUEVA Y NINGÚN PREMIO NUEVO. Las cuatro que hacen falta ya
-- existen, lo que es buena señal: la infraestructura de premios que fui
-- levantando estos días ya cubre a un artista de esta talla sin tocar nada.
--
--   "Gran Dorado, Artista del Año" bajo Premios El Dorado.
--   "El Soberano" bajo Premios Casandra.
--   "Premio a la Excelencia Musical" bajo Latin Grammy.
--   "Orden del Mérito de Duarte, Sánchez y Mella" bajo Gobierno de la República
--   Dominicana. Van ya CUATRO artistas con esta condecoración -- Julio Alberto
--   Hernández, Luis Kalaff, Carlos Piantini y ahora Solano -- lo que confirma
--   que valía la pena registrarla como categoría con el grado en work.
--
-- EL SOBERANO DE 2005 VA BAJO "PREMIOS CASANDRA" Y NO BAJO "PREMIOS SOBERANO".
-- No es descuido: el galardón se llamó Casandra hasta 2012, cuando cambió de
-- nombre por el conflicto entre Acroarte y la familia de Casandra Damirón. Una
-- adjudicación de 2005 pertenece a la etapa Casandra. El catálogo mantiene las
-- dos entidades separadas justamente para no perder esa distinción.
--
-- LAS CUATRO ADJUDICACIONES
--
--   1976  Premios El Dorado   Gran Dorado, Artista del Año
--   2005  Premios Casandra    El Soberano
--   2016  Latin Grammy        Premio a la Excelencia Musical
--   --    Gobierno RD         Orden del Mérito de Duarte, Sánchez y Mella
--
-- LA ORDEN VA SIN AÑO Y SIN GRADO porque la fuente no los da. year admite NULL.
--
-- QUEDA FUERA Y SE REPORTA: el PREMIO NACIONAL FERIA DEL LIBRO de 2005, que
-- ganó con "El merengue, música y baile de la República Dominicana", escrito
-- con la musicóloga Catana Pérez de Cuello. Es un galardón LITERARIO, no
-- musical, y crear esa entidad dentro de una base de música es decisión del
-- editor. El hecho está contado en la biografía, donde informa igual.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908003900_revert_rafael_solano_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('ba42e200-51b0-437b-99ac-1daf39ade337'::uuid, 'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   'c39d5fb6-7048-4ea3-b256-91d4c07f3e8a'::uuid, 1976, NULL, true, 'Wikipedia (es)'),

  ('ba42e200-51b0-437b-99ac-1daf39ade337'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '6d483d83-448c-4007-861d-89d53ce5f8fb'::uuid, 2005,
   'Máxima distinción de Acroarte; en 2005 el galardón se llamaba Casandra', true,
   'Wikipedia (es)'),

  ('ba42e200-51b0-437b-99ac-1daf39ade337'::uuid, '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   'd2799d5d-a14f-4f49-a317-52199253a8f5'::uuid, 2016, NULL, true, 'Wikipedia (es)'),

  ('ba42e200-51b0-437b-99ac-1daf39ade337'::uuid, 'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid, NULL, NULL, true,
   'Wikipedia (es); la fuente no da año ni grado');

COMMIT;
