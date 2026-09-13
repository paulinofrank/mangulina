BEGIN;

-- Registra los tres reconocimientos de Felix del Rosario, que no tenia ninguno
-- guardado. No hace falta crear categorias: las tres ya existen.
--
-- Salio al reescribir su ficha, la vigesimosegunda de las 211 que seguian solo
-- en ingles.
--
-- LAS TRES ADJUDICACIONES
--
--   1973  Reconocimientos Municipales  Hijo Meritorio de San Francisco de Macoris
--   ----  Premios Casandra/Soberano    Casandra Especial
--   1995  Gobierno de la R.D.          Orden del Merito de Duarte, Sanchez y Mella
--
-- EL CASANDRA ESPECIAL VA SIN ANO, y es deliberado. La fuente dice "un Casandra
-- Especial" sin fecharlo, y no encontre en que entrega fue. `year` NULL es la
-- convencion de la tabla para adjudicaciones sin fecha, y es preferible a
-- estimar una edicion.
--
-- ---------------------------------------------------------------------------
-- UN DESAJUSTE DE ENTIDAD QUE ENCUENTRO Y NO CORRIJO
--
-- La categoria "Casandra Especial" cuelga en la base de **Premios Soberano**,
-- cuando el galardon se llamo Casandra hasta 2012 y Soberano despues. Por la
-- disciplina que vengo aplicando -- la fecha decide el cuerpo -- deberia colgar
-- de Premios Casandra.
--
-- NO LA MUEVO AQUI: es una entidad compartida, ya tiene un uso previo, y
-- moverla cambiaria la ficha de otro artista. Ademas, sin ano no puedo ni
-- afirmar que esta adjudicacion sea anterior a 2012, aunque el nombre lo
-- sugiera.
--
-- Queda anotada junto a la otra errata del mismo tipo, "Bachatero de Ano" sin
-- el "del", en ORTOGRAFIA_PENDIENTE.md.
-- ---------------------------------------------------------------------------
--
-- "HIJO MERITORIO" SE REGISTRA BAJO LA CATEGORIA "Hijo Ilustre / Visitante
-- Distinguido", que es la que el catalogo tiene para las distinciones
-- municipales, con el nombre exacto de la distincion en `work`. No creo una
-- categoria nueva para una variante de la misma cosa.
--
-- NO SE REGISTRA nada mas: las fuentes hablan de "varios reconocimientos y
-- distinciones" sin nombrarlos.
--
-- year ES EL ANO DE ENTREGA.
--
-- PARA REVERTIR: supabase/rollback/20260908008800_revert_felix_del_rosario_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrio ninguna funcion de Vercel
-- y no se revalido nada.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('8fc78100-e51e-48a8-91e9-3007f4c67ec0'::uuid, 'da226f39-3350-4d25-be0e-2a24c4daccc2'::uuid,
   '7e334a61-76b4-4f04-aca1-ad5416f8749f'::uuid, 1973,
   'Hijo Meritorio de San Francisco de Macoris', true,
   'Wikipedia (es); EcuRed'),

  ('8fc78100-e51e-48a8-91e9-3007f4c67ec0'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'b336bbd9-0dfa-4331-8567-0b3e5a874252'::uuid, NULL,
   'La fuente no fecha la entrega', true,
   'Wikipedia (es); EcuRed'),

  ('8fc78100-e51e-48a8-91e9-3007f4c67ec0'::uuid, 'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid, 1995,
   NULL, true,
   'Wikipedia (es); EcuRed');

COMMIT;
