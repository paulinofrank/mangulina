BEGIN;

-- Limpieza de alias redundantes. Bloques A y B del barrido de ortografia.
--
-- QUITA 242 ALIAS EN 207 FILAS, y nada mas. Ningun otro alias se toca:
-- las 107 filas que tenian algo distinto lo conservan.
--
--   Bloque A -- el alias repetia el NOMBRE LEGAL: 155 alias
--               (76 de ellos escritos SIN ACENTOS)
--   Bloque B -- el alias era el PROPIO `name` de la fila: 87 alias
--
-- ===========================================================================
-- POR QUE ESTO NO PIERDE NADA, comprobado en el codigo del sitio
-- ===========================================================================
--
-- 1. EL BUSCADOR NO MIRA `aliases`. La funcion `global_search` busca sobre
--    `artists.name`, `recordings.title` y `releases.title`; la consulta
--    directa de `searchApi.ts` tambien solo sobre `name`. Quitar un alias no
--    quita ni una busqueda.
--
--    Y de paso: `search_normalize` es `unaccent(lower(...))` y se aplica A LOS
--    DOS LADOS, al termino y al nombre guardado. Es decir que buscar "cheche"
--    ya encuentra "Cheche Abreu" hoy y encontraria "Cheche Abreu" con tilde
--    manana. Los alias sin acentos NO estaban sosteniendo ninguna busqueda,
--    que era la duda que tenia abierta este proceso desde el principio.
--
-- 2. LA FICHA YA MUESTRA EL NOMBRE LEGAL POR SU CUENTA. `ArtistFactsCard` arma
--    un campo "Nombre real" con los cuatro campos de nombre. Lo que hacian los
--    alias del bloque A era repetir ese campo justo debajo, y 78 de ellos lo
--    repetian MAL ESCRITO. En la ficha de Frank Reyes, por ejemplo, se leia:
--
--        Nombre real:  Francisco Lopez Reyes
--        Alias:        Francisco Lopez Reyes
--
-- 3. `alternateName` DEL JSON-LD TIENE RESPALDO: si `aliases` queda vacio, la
--    pagina cae en `stage_name`, asi que el dato estructurado no se queda sin
--    valor.
--
-- ===========================================================================
-- LO QUE NO ENTRA AQUI
-- ===========================================================================
--
-- Los nombres a los que hay que ponerles tilde (bloque C) van en migracion
-- aparte: cambiar `artists.name` obliga a actualizar el `displayText` de
-- todas las biografias que citan esa fila, y eso es otro trabajo.
--
-- PARA REVERTIR: supabase/rollback/20260908009500_revert_clean_redundant_aliases.sql
--
-- Aplicado directamente por DATABASE_URL. No corrio ninguna funcion de Vercel
-- y no se revalido nada.

-- ada-betsabe
--   [B] Ada Betsabe
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'ada-betsabe';

-- adalgisa-pantaleon
--   [B] Adalgisa Pantaleón
--   [B] Adalgisa Pantaleon
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'adalgisa-pantaleon';

-- adriel-sfx
--   [B] Adriel sfx
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'adriel-sfx';

-- ala-jaza
--   [A] Enmanuel Jiménez
UPDATE artists SET aliases = ARRAY['El Bachatú del Merengue', 'Rey del Merengue Electrónico', 'Rompe Plantica']::text[] WHERE slug = 'ala-jaza';

-- alberto-beltran
--   [A] Alberto Amancio Beltrán
UPDATE artists SET aliases = ARRAY['El Negrito del Batey']::text[] WHERE slug = 'alberto-beltran';

-- alex-linares
--   [A] Felipe Alejandro Linares Jiménez
--   [B] Alex Linares
UPDATE artists SET aliases = ARRAY['Felipe A. Linares']::text[] WHERE slug = 'alex-linares';

-- alexandra-queen
--   [A] Alexandra Cabrera de la Cruz
UPDATE artists SET aliases = ARRAY['La Reina de la Bachata', 'Alexandra']::text[] WHERE slug = 'alexandra-queen';

-- allendy
--   [A] Agapito Decena Geraldo
UPDATE artists SET aliases = ARRAY['Allendy Decena']::text[] WHERE slug = 'allendy';

-- alnastry
--   [A] Alnastry Valentín
UPDATE artists SET aliases = ARRAY['Flow Nastry']::text[] WHERE slug = 'alnastry';

-- amarfis
--   [A] Amarfis Aquino
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'amarfis';

-- anais
--   [A] Anaís Martínez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'anais';

-- ander-bock
--   [A] Ander Antonio Bock Sánchez
UPDATE artists SET aliases = ARRAY['AnderBock']::text[] WHERE slug = 'ander-bock';

-- angel-brown
--   [B] Angel Brown
UPDATE artists SET aliases = ARRAY['Ángel Brown Abreu']::text[] WHERE slug = 'angel-brown';

-- angel-viloria-y-su-conjunto-tipico-cibaeno
--   [A] Ángel Salvador Viloria
UPDATE artists SET aliases = ARRAY['Conjunto Típico Cibaeño']::text[] WHERE slug = 'angel-viloria-y-su-conjunto-tipico-cibaeno';

-- anibal-de-pena
--   [A] Newton Aníbal de Peña
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'anibal-de-pena';

-- anmily
--   [A] Anmily Brown
--   [B] ANMILY
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'anmily';

-- anthony-rios
--   [B] Anthony Rios
UPDATE artists SET aliases = ARRAY['El Sentimental', 'Antonio Jiménez', 'El Kínder']::text[] WHERE slug = 'anthony-rios';

-- arianna-puello
--   [A] Arianna Isabel Puello Pereyra
UPDATE artists SET aliases = ARRAY['Ari']::text[] WHERE slug = 'arianna-puello';

-- asdrubar
--   [A] Asdrúbar Báez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'asdrubar';

-- bertico-sosa
--   [A] Francisco Alberto Sosa Paredes
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'bertico-sosa';

-- bonny-cepeda
--   [A] Fernando Antonio Cruz Paz
UPDATE artists SET aliases = ARRAY['El Maestro Bonny Cepeda', 'Fernando Cruz', 'El Maestro Joven del Merengue', 'El Inestable']::text[] WHERE slug = 'bonny-cepeda';

-- brayan-booz
--   [A] Bryan Misael García Brito
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'brayan-booz';

-- bs-el-ideologo
--   [A] Josué Abel Guzmán Cruz
UPDATE artists SET aliases = ARRAY['El Ideologo', 'Josué Guzmán', 'El Ideologo BS']::text[] WHERE slug = 'bs-el-ideologo';

-- bullumba-landestoy
--   [A] Pedro Rafael Landestoy Duluc
UPDATE artists SET aliases = ARRAY['Rafael Bullumba Landestoy']::text[] WHERE slug = 'bullumba-landestoy';

-- calacote
--   [A] Camilo Marichal
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'calacote';

-- candelario
--   [A] Greilyn Candelario
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'candelario';

-- canoto
--   [B] Canoto
--   [A] Arístides Ortiz Luis
UPDATE artists SET aliases = ARRAY['Conceptual']::text[] WHERE slug = 'canoto';

-- carlos-alfredo-fatule
--   [A] Carlos Alfredo Fatule Guerrero
UPDATE artists SET aliases = ARRAY['Carlos Alfredo']::text[] WHERE slug = 'carlos-alfredo-fatule';

-- chelion
--   [A] José Luis Green
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'chelion';

-- chery-jimenez-y-su-tercera-brigada
--   [B] Chery Jimenez y su Tercera Brigada
UPDATE artists SET aliases = ARRAY['La Tercera Brigada']::text[] WHERE slug = 'chery-jimenez-y-su-tercera-brigada';

-- chichi-peralta
--   [B] Chichi Peralta
--   [A] Pedro René Peralta Soto
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'chichi-peralta';

-- chiky-bombom-la-pantera
--   [A] Lissette Eduardo Cleto
UPDATE artists SET aliases = ARRAY['Chiky Bom Bom "La Pantera"', 'Chikybombom La Pantera', 'La Pantera']::text[] WHERE slug = 'chiky-bombom-la-pantera';

-- coral-la-luz
--   [A] Coral
UPDATE artists SET aliases = ARRAY['Coral Laluz']::text[] WHERE slug = 'coral-la-luz';

-- cromo-x
--   [A] Martín Rodríguez Vicente
UPDATE artists SET aliases = ARRAY['Cromo La X']::text[] WHERE slug = 'cromo-x';

-- damiron
--   [A] Francisco Alberto Simo Damiron
UPDATE artists SET aliases = ARRAY['El Rey del Piano Merengue', 'Los Alegres Tres']::text[] WHERE slug = 'damiron';

-- didi-hernandez
--   [B] Didí Hernández
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'didi-hernandez';

-- dj-adoni
--   [B] DJ Adoni
--   [A] Julio Adonis Gross Gonzalez
UPDATE artists SET aliases = ARRAY['DJADONI', 'Julio Adoni Gross', 'Julio Adonis Gross']::text[] WHERE slug = 'dj-adoni';

-- dj-aneudy
--   [A] Aneudy Reynoso
UPDATE artists SET aliases = ARRAY['El Gigante', 'DJ Aneudy El Gigante']::text[] WHERE slug = 'dj-aneudy';

-- dj-arelis-hot
--   [B] DJ Arelis Hot
--   [A] Arelis Hernández Gómez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'dj-arelis-hot';

-- dj-joe-catador
--   [B] DJ Joe Catador
--   [A] Joel Tapia
UPDATE artists SET aliases = ARRAY['DJ Joe']::text[] WHERE slug = 'dj-joe-catador';

-- dj-plano
--   [B] DJ Plano
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'dj-plano';

-- dj-urba
--   [A] Urbani Mota Cedeño
UPDATE artists SET aliases = ARRAY['Urba y Rome', 'Los Evo Jedis', 'Los Jedis']::text[] WHERE slug = 'dj-urba';

-- donaty
--   [A] Yeifry Sanchez
UPDATE artists SET aliases = ARRAY['El Nene']::text[] WHERE slug = 'donaty';

-- draconum-oth
--   [A] Frank Sánchez
UPDATE artists SET aliases = ARRAY['Draconum Oth Neghor']::text[] WHERE slug = 'draconum-oth';

-- duluc
--   [A] Jose Duluc
UPDATE artists SET aliases = ARRAY['Duluc Folclor']::text[] WHERE slug = 'duluc';

-- eddie-bastian
--   [B] Eddie Bastián
--   [A] Eduardo Bastian
--   [B] Eddie Bastian
UPDATE artists SET aliases = ARRAY['Eddy Bastian', 'El Único', 'Eddy El Único', 'Eddie Bastian y su Orquesta', 'Eduardo Bastian y su Orquesta', 'Eddie Bastian And His Swinging Band']::text[] WHERE slug = 'eddie-bastian';

-- el-alfa
--   [A] Emanuel Herrera Batista
UPDATE artists SET aliases = ARRAY['El Alfa El Jefe']::text[] WHERE slug = 'el-alfa';

-- el-cata
--   [A] Edward Bello Pou
UPDATE artists SET aliases = ARRAY['El Cata Mundial']::text[] WHERE slug = 'el-cata';

-- el-jeffrey
--   [A] Jose Gabriel Garcia
UPDATE artists SET aliases = ARRAY['El Canta Lindo', 'La Artilleria']::text[] WHERE slug = 'el-jeffrey';

-- el-mayor-clasico
--   [A] Emmanuel Reyes
UPDATE artists SET aliases = ARRAY['El Mayor']::text[] WHERE slug = 'el-mayor-clasico';

-- el-philippe
--   [A] Esteban Philippe
UPDATE artists SET aliases = ARRAY['Philippe', 'Fhilippe']::text[] WHERE slug = 'el-philippe';

-- el-rubio-acordeon
--   [A] Enmanuel García Batista
UPDATE artists SET aliases = ARRAY['El Rubito']::text[] WHERE slug = 'el-rubio-acordeon';

-- el-varon-de-la-bachata
--   [A] Eduardo José Acevedo Cabrera
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'el-varon-de-la-bachata';

-- emetede
--   [A] Andy Mora
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'emetede';

-- enrique-de-marchena
--   [B] Enrique de Marchena
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'enrique-de-marchena';

-- epico-gelato
--   [B] Epico Gelato
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'epico-gelato';

-- esme
--   [A] Elmer Abreu Suriel
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'esme';

-- fausto-rey
--   [A] Fausto Ramon Sepulveda
UPDATE artists SET aliases = ARRAY['El Niche']::text[] WHERE slug = 'fausto-rey';

-- flow-28
--   [A] Carlos Flores
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'flow-28';

-- fortuna-la-super-f
--   [A] Israel Domingo Rodríguez de la Cruz
UPDATE artists SET aliases = ARRAY['La Super F']::text[] WHERE slug = 'fortuna-la-super-f';

-- gda-el-unico
--   [A] Delvi Antonio Abreu Martínez
UPDATE artists SET aliases = ARRAY['GDA']::text[] WHERE slug = 'gda-el-unico';

-- ghetto
--   [A] Axel Rafael Quezada Fulgencio
UPDATE artists SET aliases = ARRAY['GhettoSPM']::text[] WHERE slug = 'ghetto';

-- hector-acosta-el-torito
--   [A] Hector Elpidio Acosta Restituyo
UPDATE artists SET aliases = ARRAY['El Torito', 'Hector Acosta y Su Orquesta', 'Los Toros Band']::text[] WHERE slug = 'hector-acosta-el-torito';

-- henry-santos
--   [A] Henry Santos Jeter
UPDATE artists SET aliases = ARRAY['Aventura']::text[] WHERE slug = 'henry-santos';

-- inka
--   [B] INKA
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'inka';

-- isabelle-valdez
--   [B] Isabelle Valdéz
--   [A] Isabelle Valdéz Santana
UPDATE artists SET aliases = ARRAY['Isabelle', 'Isabel Valdez']::text[] WHERE slug = 'isabelle-valdez';

-- jacinto-gimbernard
--   [A] Jacinto Gimbernard Pellerano
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'jacinto-gimbernard';

-- jandy-ventura
--   [A] Juan de Dios Ventura Flores
UPDATE artists SET aliases = ARRAY['Jandy Ventura el Legado', 'Los Potros']::text[] WHERE slug = 'jandy-ventura';

-- jankobow
--   [A] Jean Carlos Nami Encarnación
UPDATE artists SET aliases = ARRAY['El Criminal']::text[] WHERE slug = 'jankobow';

-- jay-miky-flow
--   [A] Yefri Mecredy de la Cruz
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'jay-miky-flow';

-- jc
--   [A] Juan Carlos Cabrera
UPDATE artists SET aliases = ARRAY['Jon Clasic']::text[] WHERE slug = 'jc';

-- joa-el-super-mc
--   [A] Jose Manuel Almonte
UPDATE artists SET aliases = ARRAY['Joa']::text[] WHERE slug = 'joa-el-super-mc';

-- jordan-mateo
--   [A] Jordan Joel Mateo Green
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'jordan-mateo';

-- jorge-luis-rosario-rodriguez
--   [B] Jorge Luis Rosario Rodriguez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'jorge-luis-rosario-rodriguez';

-- jose-el-calvo
--   [A] Jose Gabriel Guaba
UPDATE artists SET aliases = ARRAY['Jose El Calvo y Su Conjunto Tipico']::text[] WHERE slug = 'jose-el-calvo';

-- jose-luis-hernandez-moreno
--   [B] Jose Luis Hernandez Moreno
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'jose-luis-hernandez-moreno';

-- jose-pena-suazo-y-la-banda-gorda
--   [A] Jose Virgilio Peña Suazo
UPDATE artists SET aliases = ARRAY['La Banda Gorda']::text[] WHERE slug = 'jose-pena-suazo-y-la-banda-gorda';

-- juan-luis-guerra
--   [A] Juan Luis Guerra Seijas
UPDATE artists SET aliases = ARRAY['Juan Luis Guerra & 440', '440']::text[] WHERE slug = 'juan-luis-guerra';

-- juliana-o-neal
--   [A] Juliana Ynurika O'neal Brito
UPDATE artists SET aliases = ARRAY['La Reina del Mambo']::text[] WHERE slug = 'juliana-o-neal';

-- july-mateo-rasputin
--   [B] July Mateo Rasputin
UPDATE artists SET aliases = ARRAY['Rasputin', 'Rasputín', 'El Monje']::text[] WHERE slug = 'july-mateo-rasputin';

-- junior-cabrera
--   [A] Milton Cabrera
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'junior-cabrera';

-- kalimete
--   [A] Ramfis Reyes
UPDATE artists SET aliases = ARRAY['Kalimete La Fórmula']::text[] WHERE slug = 'kalimete';

-- karlos-rose
--   [B] Karlos Rose
--   [A] Carlos De La Rosa
UPDATE artists SET aliases = ARRAY['K. Rose']::text[] WHERE slug = 'karlos-rose';

-- kiko-el-crazy
--   [B] Kiko El Crazy
UPDATE artists SET aliases = ARRAY['Kiko El Creizy']::text[] WHERE slug = 'kiko-el-crazy';

-- la-baby
--   [B] La BABY
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'la-baby';

-- la-fiera-tipica
--   [A] Cristhofher Reyes Rodríguez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'la-fiera-tipica';

-- la-noe-aposento-alto
--   [A] Noemí Martínez
UPDATE artists SET aliases = ARRAY['La Noe']::text[] WHERE slug = 'la-noe-aposento-alto';

-- la-ross-maria
--   [A] Rosa María Pineda Aguavivas
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'la-ross-maria';

-- leton-pe
--   [A] Leticia Pelliccione
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'leton-pe';

-- lizzy-parra
--   [A] Lisbet Margarita Plata Parra
UPDATE artists SET aliases = ARRAY['La Pastora', 'Lizzy']::text[] WHERE slug = 'lizzy-parra';

-- lors-el-prieto
--   [A] Osiris Rincón
UPDATE artists SET aliases = ARRAY['Lors', 'LorsRD']::text[] WHERE slug = 'lors-el-prieto';

-- luis-caracter
--   [A] Jorge Luis Mena Reynoso
--   [B] Luis Carácter
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'luis-caracter';

-- luis-terror-dias
--   [B] Luis Terror Dias
--   [A] Luis Días Portorreal
UPDATE artists SET aliases = ARRAY['El Terror', 'Transporte Urbano', 'El Terror', 'Luis Díaz', 'Luis Dias']::text[] WHERE slug = 'luis-terror-dias';

-- luny-tunes
--   [B] Luny Tunes
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'luny-tunes';

-- luys-bien
--   [A] Luis Bienvenido Gómez Luciano
UPDATE artists SET aliases = ARRAY['Luis Bienvenido Gómez', 'Luis Gómez']::text[] WHERE slug = 'luys-bien';

-- maffio
--   [B] Maffio
--   [A] Carlos Ariel Peralta Mendoza
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'maffio';

-- mamajuana
--   [B] mamajuana
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mamajuana';

-- manny-cruz
--   [B] Manny Cruz
--   [A] Emmanuel Cruz Sánchez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'manny-cruz';

-- manny-manz
--   [A] Enmanuel Castillo
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'manny-manz';

-- manole-y-la-banda-del-truco
--   [B] Manolé y la Banda del Truco
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'manole-y-la-banda-del-truco';

-- manuel-jimenez
--   [B] Manuel Jiménez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'manuel-jimenez';

-- manuel-miller
--   [B] DJ Miller
--   [A] Manuel de Jesús Díaz Miller
UPDATE artists SET aliases = ARRAY['Manuel Miller', 'DJ Mastermix']::text[] WHERE slug = 'manuel-miller';

-- manuel-sanchez-acosta
--   [B] Manuel Sánchez Acosta
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'manuel-sanchez-acosta';

-- manuel-simo
--   [B] Manuel Simó
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'manuel-simo';

-- manuel-troncoso
--   [B] Manuel Troncoso
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'manuel-troncoso';

-- manyee-audio
--   [B] Manyee Audio
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'manyee-audio';

-- marco-hernandez
--   [A] Marco Hernández Taveras
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'marco-hernandez';

-- marcos-andres-peguero-familia
--   [B] Marcos Andres Peguero Familia
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'marcos-andres-peguero-familia';

-- marcos-yaroide
--   [B] Marcos Yaroide
--   [A] Marcos Yaroide Mejía Rambalde
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'marcos-yaroide';

-- mariangel
--   [B] Mariangel
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mariangel';

-- maridalia-hernandez
--   [B] Maridalia Hernández
--   [A] Maridalia Hernández Morel
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'maridalia-hernandez';

-- mariela-valdez
--   [A] Mariela Pérez
UPDATE artists SET aliases = ARRAY['Ministerios Mariela Valdez']::text[] WHERE slug = 'mariela-valdez';

-- marielle-hazlo
--   [B] Marielle Hazlo
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'marielle-hazlo';

-- marino-perez
--   [A] Esteban Marinito Pérez
UPDATE artists SET aliases = ARRAY['El Padre de la Bachata de Amargue', 'El Bachatero del Pueblo']::text[] WHERE slug = 'marino-perez';

-- mark-b
--   [A] Mark Burdier
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mark-b';

-- martin-valoy
--   [B] Martín Valoy
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'martin-valoy';

-- mc-wayne
--   [B] Mc Wayne
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mc-wayne';

-- mecal
--   [A] Isaac Elías Sánchez Camilo
UPDATE artists SET aliases = ARRAY['La M Mayúscula']::text[] WHERE slug = 'mecal';

-- mediopicky
--   [A] Pablo Alcántara
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mediopicky';

-- medusa
--   [B] Medusa
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'medusa';

-- melida-rodriguez
--   [B] Melida Rodriguez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'melida-rodriguez';

-- melymel
--   [A] Melony Redondo
UPDATE artists SET aliases = ARRAY['La Mamá del Rap', 'La Mermelada']::text[] WHERE slug = 'melymel';

-- memin
--   [B] Memín
--   [A] Giovanny Belliard
UPDATE artists SET aliases = ARRAY['El Sucesor']::text[] WHERE slug = 'memin';

-- messiah
--   [B] Messiah
UPDATE artists SET aliases = ARRAY['El Artista', 'Young Messi', 'El Monito']::text[] WHERE slug = 'messiah';

-- michel-el-buenon
--   [A] Michel Batista
UPDATE artists SET aliases = ARRAY['El Buenón']::text[] WHERE slug = 'michel-el-buenon';

-- mickey-dastinz
--   [B] Mickey Dastinz
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mickey-dastinz';

-- mickey-taveras
--   [B] Mickey Taveras
--   [A] Miguel Vinicio Almánzar Taveras
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mickey-taveras';

-- mike-el-beta
--   [A] Michael Luis López
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mike-el-beta';

-- milly-quezada
--   [B] Milly Quezada
--   [A] Milagros del Rosario Quezada Borbón
UPDATE artists SET aliases = ARRAY['La Reina del Merengue', 'Queen of Merengue']::text[] WHERE slug = 'milly-quezada';

-- miriam-cruz
--   [A] Miriam Aracelis Cruz Ramírez
UPDATE artists SET aliases = ARRAY['La Diva del Merengue']::text[] WHERE slug = 'miriam-cruz';

-- miriam-y-las-chicas
--   [B] Miriam y las Chicas
UPDATE artists SET aliases = ARRAY['Míriam Cruz y Las Chicas']::text[] WHERE slug = 'miriam-y-las-chicas';

-- misael-j
--   [A] Misael Josué Rosario Mena
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'misael-j';

-- monchy
--   [B] Monchy
--   [A] Ramón Rijo
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'monchy';

-- monchy-alexandra
--   [B] Monchy & Alexandra
UPDATE artists SET aliases = ARRAY['Monchy y Alexandra']::text[] WHERE slug = 'monchy-alexandra';

-- monchy-nathalia
--   [B] Monchy & Nathalia
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'monchy-nathalia';

-- monsanto
--   [B] MonSanto
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'monsanto';

-- morbid
--   [B] Morbid
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'morbid';

-- moria
--   [B] MÓRIA
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'moria';

-- mr-yeison
--   [B] MR. Yeison
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mr-yeison';

-- mula
--   [B] Mula
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mula';

-- mundito-espinal
--   [A] Rafael Edmundo Espinal Hernández
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'mundito-espinal';

-- musicologo-the-libro
--   [B] Musicólogo The Libro
UPDATE artists SET aliases = ARRAY['Musicólogo']::text[] WHERE slug = 'musicologo-the-libro';

-- musiquito
--   [B] Musiquito
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'musiquito';

-- n-o-r-m-a-l
--   [B] N o R M a L
--   [A] Gabriel Ernesto López Valdez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'n-o-r-m-a-l';

-- nancy-amancio
--   [A] María Saray Amancio
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'nancy-amancio';

-- natan-el-profeta
--   [B] Natán el Profeta
--   [A] Natanael Philippe
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'natan-el-profeta';

-- necro
--   [B] Necro
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'necro';

-- negrito-chapuseaux
--   [B] Negrito Chapuseaux
--   [A] José Ernesto Chapuseaux
UPDATE artists SET aliases = ARRAY['El Negrito Chapuseaux']::text[] WHERE slug = 'negrito-chapuseaux';

-- nelson-de-la-olla
--   [A] Nelson Mendoza Batista
UPDATE artists SET aliases = ARRAY['Nelson de la Olla y La Banda Chula']::text[] WHERE slug = 'nelson-de-la-olla';

-- nico-clinico
--   [A] Alberto Nicolás Aponte Castillo
UPDATE artists SET aliases = ARRAY['El Maestro del Género Urbano']::text[] WHERE slug = 'nico-clinico';

-- nini-caffaro
--   [B] Niní Cáffaro
--   [A] Erasmo Alfonso Cáffaro Durán
UPDATE artists SET aliases = ARRAY['Rey de los Festivales']::text[] WHERE slug = 'nini-caffaro';

-- nino-freestyle
--   [A] Yeifry Severino de la Rosa
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'nino-freestyle';

-- ninon-lapeiretta-de-brouwer
--   [B] Ninón Lapeiretta de Brouwer
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'ninon-lapeiretta-de-brouwer';

-- nj-melody
--   [B] NJ Melody
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'nj-melody';

-- nmnl
--   [A] Enmanuel Cuello Reynoso
UPDATE artists SET aliases = ARRAY['Nominal']::text[] WHERE slug = 'nmnl';

-- o-g-black
--   [A] Adolfo Ramírez Bruno
UPDATE artists SET aliases = ARRAY['OG Black', 'El Francotirador']::text[] WHERE slug = 'o-g-black';

-- omega
--   [A] Antonio Peter de la Rosa
UPDATE artists SET aliases = ARRAY['Omega "El Fuerte"', 'El Fuerte']::text[] WHERE slug = 'omega';

-- oscar-dominic
--   [A] Oscar Enrique Socías Santana
UPDATE artists SET aliases = ARRAY['Oscar La Entonación']::text[] WHERE slug = 'oscar-dominic';

-- pamela-lebron
--   [B] Pamela Lebrón
UPDATE artists SET aliases = ARRAY['La Lebrón']::text[] WHERE slug = 'pamela-lebron';

-- papi-sanchez
--   [A] Robert José de León Sánchez
UPDATE artists SET aliases = ARRAY['El Rey De La República']::text[] WHERE slug = 'papi-sanchez';

-- paramba
--   [A] Johan Pavel Domínguez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'paramba';

-- pedro-samuel-rodriguez
--   [A] Pedro Samuel Rodríguez-Reyes
UPDATE artists SET aliases = ARRAY['P. S. Rodz']::text[] WHERE slug = 'pedro-samuel-rodriguez';

-- peter-metivier
--   [A] Pedro Julio Pérez Metivier
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'peter-metivier';

-- pierre-carbuccia
--   [A] Pierre Carbuccia Abbott
UPDATE artists SET aliases = ARRAY['Juracán']::text[] WHERE slug = 'pierre-carbuccia';

-- profeta-lirical
--   [A] Jeyson Rey Piñeiro Azcona
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'profeta-lirical';

-- puyalo-pantera
--   [B] Púyalo Pantera
--   [A] Jarlin José Beltre Lara
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'puyalo-pantera';

-- quimico-ultra-mega
--   [A] Jesús Jiménez
UPDATE artists SET aliases = ARRAY['Químico']::text[] WHERE slug = 'quimico-ultra-mega';

-- raphy-colon
--   [A] Silvestre Colón Casilla
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'raphy-colon';

-- raquel-arias
--   [A] Raquel Arias Jiménez
UPDATE artists SET aliases = ARRAY['La Estrella del Merengue Típico', 'La Fiera', 'La Insuperable']::text[] WHERE slug = 'raquel-arias';

-- raulin-rodriguez
--   [B] Raulin Rodriguez
--   [A] Raulín Marte Rodríguez
UPDATE artists SET aliases = ARRAY['El Cacique', 'El Cacique del Amargue']::text[] WHERE slug = 'raulin-rodriguez';

-- redimi2
--   [A] Willy González Cruz
UPDATE artists SET aliases = ARRAY['Oh Man', 'La Resistencia', 'MC1615', 'Willy Cruz', 'GC Willy']::text[] WHERE slug = 'redimi2';

-- rene-de-leon-vanterpool
--   [B] Rene De Leon Vanterpool
UPDATE artists SET aliases = ARRAY['Wrisberg René De León']::text[] WHERE slug = 'rene-de-leon-vanterpool';

-- ricardo-rico
--   [A] Herminio Ricardo Rico
UPDATE artists SET aliases = ARRAY['Ricardo Rico y su Conjunto Los Típicos Dominicanos']::text[] WHERE slug = 'ricardo-rico';

-- ricky-webber
--   [A] José Miguel Guzmán Sandoval
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'ricky-webber';

-- rico-lopez
--   [A] Benigno Ricardo López
UPDATE artists SET aliases = ARRAY['Rico López y su Orquesta']::text[] WHERE slug = 'rico-lopez';

-- roger-zayas-bazan
--   [A] Roger Zayas
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'roger-zayas-bazan';

-- rosangela-abreu
--   [A] Rosangela Abreu Crespo
UPDATE artists SET aliases = ARRAY['Rosángela']::text[] WHERE slug = 'rosangela-abreu';

-- rubinsky-rbk
--   [A] Manuel Enrique Núñez Espinoza
UPDATE artists SET aliases = ARRAY['Rubinsky']::text[] WHERE slug = 'rubinsky-rbk';

-- sammy-the-greatest
--   [B] Sammy the Greatest
--   [A] Samuel Dilone Castillo
UPDATE artists SET aliases = ARRAY['DJ Sammy']::text[] WHERE slug = 'sammy-the-greatest';

-- sandy-mc
--   [A] Sandy Carriello
UPDATE artists SET aliases = ARRAY['Sandy', 'Sandy A. Carriello']::text[] WHERE slug = 'sandy-mc';

-- sandy-reyes
--   [A] Salvador Reyes Pichardo
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'sandy-reyes';

-- santana
--   [A] Rayniel Santana
UPDATE artists SET aliases = ARRAY['Santana Official']::text[] WHERE slug = 'santana';

-- shamir-massih
--   [A] Jorge Shamir Massih
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'shamir-massih';

-- sharlene
--   [A] Sharlene Taulé Ponciano
UPDATE artists SET aliases = ARRAY['Sharlene Taulé']::text[] WHERE slug = 'sharlene';

-- shecka-sanchez
--   [A] Fransheska Felicia Sánchez
UPDATE artists SET aliases = ARRAY['Shecka']::text[] WHERE slug = 'shecka-sanchez';

-- skeem
--   [A] Lenin Arias
UPDATE artists SET aliases = ARRAY['Skeem El Conde']::text[] WHERE slug = 'skeem';

-- snova
--   [A] Marcos Peralta
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'snova';

-- sr-perez
--   [A] Franklin Pérez de los Santos
--   [B] Sr Perez
UPDATE artists SET aliases = ARRAY['Franklin Pérez']::text[] WHERE slug = 'sr-perez';

-- t-y-s
--   [A] Steven Domínguez Carmona
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 't-y-s';

-- tangowhiskyman
--   [B] TangoWhiskyMan
--   [B] Tangowhiskyman
UPDATE artists SET aliases = ARRAY['TWM']::text[] WHERE slug = 'tangowhiskyman';

-- tony-berroa
--   [A] Basilio Berroa
UPDATE artists SET aliases = ARRAY['El Solterito del Este', 'El Macho de la Bachata']::text[] WHERE slug = 'tony-berroa';

-- tony-seval
--   [A] Felipe Antonio Sepúlveda Caraballo
UPDATE artists SET aliases = ARRAY['Kuky']::text[] WHERE slug = 'tony-seval';

-- toxic-crow
--   [A] Caonabo Enrique Mesa Ureña
--   [B] Tóxic Crow
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'toxic-crow';

-- tunes
--   [A] Víctor Cabrera
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'tunes';

-- vakero
--   [B] Vakero
--   [A] Manuel Varet Marte
UPDATE artists SET aliases = ARRAY['El Vakero']::text[] WHERE slug = 'vakero';

-- valeria-la-mujer
--   [A] Valeria
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'valeria-la-mujer';

-- vicente-mercedes
--   [A] Vicente Mercedes Payano
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'vicente-mercedes';

-- victor-irizarry-y-su-orquesta
--   [A] Víctor Irizarry
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'victor-irizarry-y-su-orquesta';

-- vizkel
--   [A] Omar Sánchez
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'vizkel';

-- voz-a-voz
--   [B] Voz A Voz
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'voz-a-voz';

-- whitest-taino-alive
--   [B] Whitest Taíno Alive
UPDATE artists SET aliases = ARRAY['WTA', 'Los Taínos']::text[] WHERE slug = 'whitest-taino-alive';

-- wilmelia
--   [A] Wilmelia Soto
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'wilmelia';

-- yailin-la-mas-viral
--   [B] Yailín la Más Viral
--   [A] Jorgina Guillermo Díaz
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'yailin-la-mas-viral';

-- yamilka
--   [A] Yamilka Del Rosario Aristy
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'yamilka';

-- yeidy-eish
--   [A] Jennifher Danielle Heredia
UPDATE artists SET aliases = '{}'::text[] WHERE slug = 'yeidy-eish';

-- yomel-el-meloso
--   [B] Yomel El Meloso
UPDATE artists SET aliases = ARRAY['Yomel']::text[] WHERE slug = 'yomel-el-meloso';

-- zacarias-ferreira
--   [A] Zacarías Ferreira de la Cruz
UPDATE artists SET aliases = ARRAY['La Voz de la Ternura']::text[] WHERE slug = 'zacarias-ferreira';

COMMIT;
