BEGIN;

-- Registra los tres reconocimientos de Francis Santana y crea las tres
-- entidades dominicanas que faltaban para poder guardarlos.
--
-- Salió al escribir su ficha, que era una de las dieciséis publicadas sin una
-- sola línea de biografía. No tenía ningún premio guardado.
--
-- TRES ENTIDADES NUEVAS. Ninguna es una premiación artística al uso, y las tres
-- entran por la misma razón: son distinciones públicas dominicanas que varias
-- figuras del catálogo han recibido, y registrarlas de manera uniforme vale más
-- que dejarlas sueltas en la prosa de cada ficha.
--
--   BANRESERVAS. El banco estatal declara Reserva Musical Nacional a figuras de
--   la música dominicana y acompaña el honor con una producción discográfica.
--   En el caso de Santana, el disco "Reserva Musical" de 2006 que aparece en su
--   discografía ES ese CD recopilatorio, cosa que conviene tener presente para
--   no contarlo como un álbum de estudio más.
--
--   MINISTERIO DE CULTURA. En 2007 se llamaba Secretaría de Estado de Cultura.
--   La entidad se registra con su nombre actual y la descripción deja
--   constancia del anterior, para que las distinciones de las dos épocas
--   queden bajo una sola fila y no se dupliquen más adelante.
--
--   CONAPE, Consejo Nacional de la Persona Envejeciente.
--
-- LAS TRES ADJUDICACIONES
--
--   2005  BanReservas   Reserva Musical Nacional        6 de julio
--   2007  Cultura       Gloria Nacional del Arte Popular  18 de noviembre, al
--                                                          cumplir 63 años en
--                                                          la música
--   2012  Conape        Reconocimiento a la Trayectoria   19 de noviembre, el
--                                                          último honor que
--                                                          recibió en vida
--
-- FUENTE ÚNICA PERO PRECISA: el obituario de La Crónica del 11 de enero de
-- 2014, firmado por Máximo Jiménez, expresidente de Acroarte, que da las tres
-- fechas al día. No encontré una segunda fuente que las repita, y así queda
-- anotado en el campo source de cada fila.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260907013500_revert_francis_santana_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country, description)
VALUES
  ('2b6d84f1-3a95-4c07-8e12-5d70bf9a3c48'::uuid, 'Reserva Musical Nacional',
   'Banco de Reservas de la República Dominicana (BanReservas)',
   'República Dominicana',
   'Distinción del banco estatal a figuras de la música dominicana, acompañada de una producción discográfica recopilatoria.'),
  ('3c7e95a2-4ba6-4d18-9f23-6e81ca0b4d59'::uuid, 'Ministerio de Cultura',
   'Ministerio de Cultura de la República Dominicana', 'República Dominicana',
   'Distinciones de la cartera de Cultura. Hasta 2010 se denominó Secretaría de Estado de Cultura; las distinciones de ambas etapas se registran aquí.'),
  ('4d8fa6b3-5cb7-4e29-a034-7f92db1c5e6a'::uuid, 'CONAPE',
   'Consejo Nacional de la Persona Envejeciente', 'República Dominicana',
   'Reconocimientos del consejo estatal a figuras mayores por su aporte a la cultura dominicana.')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('5e90b7c4-6dc8-4f3a-b145-80a3ec2d6f7b'::uuid,
   '2b6d84f1-3a95-4c07-8e12-5d70bf9a3c48'::uuid, 'Reserva Musical Nacional'),
  ('6fa1c8d5-7ed9-4a4b-c256-91b4fd3e708c'::uuid,
   '3c7e95a2-4ba6-4d18-9f23-6e81ca0b4d59'::uuid, 'Gloria Nacional del Arte Popular'),
  ('70b2d9e6-8fea-4b5c-d367-a2c50e4f819d'::uuid,
   '4d8fa6b3-5cb7-4e29-a034-7f92db1c5e6a'::uuid, 'Reconocimiento a la Trayectoria')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('3a69af3c-1b9a-402b-8a3f-66e51dacdffe'::uuid,
   '2b6d84f1-3a95-4c07-8e12-5d70bf9a3c48'::uuid,
   '5e90b7c4-6dc8-4f3a-b145-80a3ec2d6f7b'::uuid,
   2005, NULL, true,
   'La Crónica, obituario del 11 de enero de 2014; declarado el 6 de julio de 2005'),
  ('3a69af3c-1b9a-402b-8a3f-66e51dacdffe'::uuid,
   '3c7e95a2-4ba6-4d18-9f23-6e81ca0b4d59'::uuid,
   '6fa1c8d5-7ed9-4a4b-c256-91b4fd3e708c'::uuid,
   2007, NULL, true,
   'La Crónica, obituario del 11 de enero de 2014; declarado el 18 de noviembre de 2007'),
  ('3a69af3c-1b9a-402b-8a3f-66e51dacdffe'::uuid,
   '4d8fa6b3-5cb7-4e29-a034-7f92db1c5e6a'::uuid,
   '70b2d9e6-8fea-4b5c-d367-a2c50e4f819d'::uuid,
   2012, NULL, true,
   'La Crónica, obituario del 11 de enero de 2014; otorgado el 19 de noviembre de 2012');

COMMIT;
