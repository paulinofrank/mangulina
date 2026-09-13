BEGIN;

-- Corrige la nota del Gran Soberano de Luis Segura, que afirmaba un año que las
-- fuentes no sostienen.
--
-- La migración 20260908006200 guardó en `work`: "Gran Soberano correspondiente a
-- 2021, entregado en la 38.a entrega, marzo de 2023". Escribí ese "2021" a
-- partir de la prensa dominicana, que llamó al galardón "Gran Soberano 2021".
--
-- LA TABLA DE GANADORES DE ACROARTE LO COLOCA EN 2022, con Alicia Ortega en
-- 2023, y las dos estatuillas se entregaron la misma noche porque la ceremonia
-- de 2022 no se celebró y la de 2023 premió los dos años anteriores. Prensa y
-- historial no coinciden, y no tengo con qué desempatar.
--
-- SE QUEDA LO QUE NADIE DISCUTE: la 38.a entrega, marzo de 2023, que es lo que
-- ya guarda la columna `year`. El año al que corresponde el premio sale del
-- campo en vez de afirmarse mal.
--
-- El detalle completo y los otros cinco desacuerdos entre esta tabla y el
-- historial de ACROARTE están en el documento de trabajo
-- PREMIOS_GRAN_SOBERANO.md. Ninguno de esos cinco se toca aquí.
--
-- PARA REVERTIR: supabase/rollback/20260908006500_revert_luis_segura_gran_soberano_note.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

UPDATE artist_awards
   SET work = '38.a entrega de los Premios Soberano, marzo de 2023'
 WHERE artist_id = '5ceceef0-765d-4e01-8017-85422a263357'::uuid
   AND category_id = '26e1ac30-c00d-4cc8-922f-bd7fd58502ce'::uuid;

COMMIT;
