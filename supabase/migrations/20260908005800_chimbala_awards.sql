BEGIN;

-- Registra los nueve reconocimientos de Chimbala, que no tenía ninguno, y crea
-- tres categorías.
--
-- Salió al reescribir su ficha, la décima de las 211 que siguen solo en inglés
-- por enlaces entrantes.
--
-- TRES CATEGORÍAS NUEVAS, NINGÚN PREMIO NUEVO
--
--   "Mejor Colaboración" bajo Premios Heat. El premio ya tenía cuatro
--   categorías, ninguna de colaboración.
--
--   "La Mezcla Perfecta" y "La Coreo Más Hot" bajo Premios Juventud. Son los
--   nombres literales de dos categorías de ese galardón -- canción con la mejor
--   colaboración y videos con coreografías auténticas -- y no se traducen ni se
--   normalizan, porque así es como se entregan.
--
-- SE REUTILIZAN TRES: "Urbano Dominicano" de Premios Heat, "Artista Dembow" de
-- Premios Tu Música Urbano, y "Platinum Records" de Sales Certifications.
--
-- SEIS DE LAS NUEVE VAN CON won = false. Son nominaciones, y la fuente las
-- distingue expresamente de las victorias en su propia tabla. Solo GANÓ una
-- cosa: Mejor Colaboración en los Premios Heat de 2022 por "Loco". Registrar
-- las nominaciones como premios le atribuiría siete galardones que no tiene,
-- que es la clase de error que encontré en martha-heredia y que desde entonces
-- reviso una por una.
--
-- LAS NUEVE ADJUDICACIONES
--
--   2021  Premios Heat            Urbano Dominicano                    NOMINACIÓN
--   2022  Premios Heat            Urbano Dominicano                    NOMINACIÓN
--   2022  Premios Heat            Mejor Colaboración      Loco         GANADA
--   2023  Premios Heat            Urbano Dominicano                    NOMINACIÓN
--   2022  Premios Tu Música Urbano  Artista Dembow                     NOMINACIÓN
--   2022  Premios Juventud        La Mezcla Perfecta      WOW BB       NOMINACIÓN
--   2022  Premios Juventud        La Coreo Más Hot        WOW BB       NOMINACIÓN
--   2022  Sales Certifications    Platinum Records        Loco
--   2022  Sales Certifications    Platinum Records        Wow BB
--
-- SOBRE LAS DOS CERTIFICACIONES. "Loco" es TRIPLE PLATINO de la RIAA, más oro
-- en España e Italia; el catálogo no tiene categoría para múltiplos, así que va
-- bajo "Platinum Records" y el grado exacto queda en work, que es el mismo
-- criterio que se usó con Tokischa y su séxtuple platino. "Wow BB" es platino
-- simple, certificado en marzo de 2022.
--
-- QUEDA FUERA Y SE REPORTA: la certificación de la RIAA de 2021 por "Se Me Nota
-- (Agárrame)", su colaboración con Omega. La fuente dice que existe PERO NO DICE
-- DE QUÉ GRADO, y elegir entre oro y platino sería inventarlo. En la biografía
-- sí se menciona que la canción obtuvo una certificación.
--
-- TAMPOCO SE REGISTRA la nominación de 2022 a los Monitor Music Awards como
-- Mejor Artista Dembow: crear una entidad de premio entera para una sola
-- nominación es desproporcionado. Queda anotado por si aparece más.
--
-- NO SON PREMIOS y por eso no entran aquí: el número uno de "Loco" en Latin
-- Airplay, el de Los 40 en España, y los de "Feliz" y "Déjate Ver" en Monitor
-- Latino. Son posiciones de lista y están en la biografía.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908005800_revert_chimbala_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('3cf41179-5375-4e4e-a229-52ce949e9e73'::uuid,
   '8cda1620-8b37-487d-9491-0c4108e133a4'::uuid, 'Mejor Colaboración'),
  ('b6815c83-548d-471e-87a3-645664e5a80f'::uuid,
   '8304c63b-ff51-40ed-80bb-ea7c4079ca6f'::uuid, 'La Mezcla Perfecta'),
  ('84338039-8f45-480f-b07a-dff00529f772'::uuid,
   '8304c63b-ff51-40ed-80bb-ea7c4079ca6f'::uuid, 'La Coreo Más Hot')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, '8cda1620-8b37-487d-9491-0c4108e133a4'::uuid,
   'ea2b8a92-90c7-4a79-a1fa-b8da8fa9d155'::uuid, 2021, NULL, false, 'Wikipedia (es); nominación'),
  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, '8cda1620-8b37-487d-9491-0c4108e133a4'::uuid,
   'ea2b8a92-90c7-4a79-a1fa-b8da8fa9d155'::uuid, 2022, NULL, false, 'Wikipedia (es); nominación'),
  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, '8cda1620-8b37-487d-9491-0c4108e133a4'::uuid,
   '3cf41179-5375-4e4e-a229-52ce949e9e73'::uuid, 2022,
   'Loco, con Justin Quiles y Zion & Lennox', true, 'Wikipedia (es); ganada'),
  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, '8cda1620-8b37-487d-9491-0c4108e133a4'::uuid,
   'ea2b8a92-90c7-4a79-a1fa-b8da8fa9d155'::uuid, 2023, NULL, false, 'Wikipedia (es); nominación'),

  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, '32d73576-29be-40c4-b529-a7ce943fe2ec'::uuid,
   '96cd0802-d976-4d4b-8ff2-cc17bcd6a2ae'::uuid, 2022, NULL, false, 'Wikipedia (es); nominación'),

  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, '8304c63b-ff51-40ed-80bb-ea7c4079ca6f'::uuid,
   'b6815c83-548d-471e-87a3-645664e5a80f'::uuid, 2022, 'WOW BB', false,
   'Wikipedia (es); nominación'),
  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, '8304c63b-ff51-40ed-80bb-ea7c4079ca6f'::uuid,
   '84338039-8f45-480f-b07a-dff00529f772'::uuid, 2022, 'WOW BB', false,
   'Wikipedia (es); nominación'),

  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, 'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid, 2022,
   'Loco; triple platino de la RIAA, más oro en España e Italia', true, 'Wikipedia (es)'),
  ('cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid, 'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid, 2022,
   'Wow BB; platino de la RIAA, certificado en marzo', true, 'Wikipedia (es)');

COMMIT;
