/**
 * Spanish editorial content for genre pages.
 *
 * Genre title/subtitle/description/history are sourced from the Supabase
 * `genres` table (falling back to `genres.ts`), and that content is authored in
 * English. Rather than add `*_es` columns + a migration + an editor workflow
 * for ~14 mostly-static genres, the Spanish copy lives here, version-controlled
 * and reviewable, and is applied as an override when the active locale is `es`.
 * Genres without an entry fall back to the English source.
 *
 * Coverage is enforced by `npm run i18n:audit` (genre-content parity check).
 */

export type GenreContentOverride = {
  title?: string;
  subtitle?: string;
  description?: string;
  history?: string;
};

const bachataHistoryEs = [
  "La bachata no nació en un escenario de conciertos, sino en los espacios más cotidianos de la vida dominicana: bares de carretera, reuniones de barrio y hogares de clase trabajadora dispersos por el campo. En los años antes de tener un nombre, la música era simplemente el sonido de una guitarra acompañando los desamores y las penurias diarias que la cultura dominicana académica y de clase alta prefería no reconocer.",
  "Las primeras grabaciones documentadas aparecieron en 1962, cuando José Manuel Calderón entró a un estudio y grabó dos temas, Borracho de amor y Condena, considerados hoy los ejemplos más tempranos que se conocen del género. Calderón trabajaba en un estilo claramente descendiente del bolero y el son cubanos, pero filtrado a través de una sensibilidad dominicana arraigada en la intimidad informal y acústica. Lo que grabó aún no se llamaba bachata; a veces se le llamaba amargue, un nombre que capturaba tanto la franqueza emocional del género como el estigma social que lo acompañaría durante décadas.",
  "Ese estigma era real y severo. La sociedad dominicana dominante —incluidas muchas emisoras de radio, instituciones culturales y públicos de clase media y alta— rechazaba la música como vulgar y de baja clase, asociándola con la pobreza, los prostíbulos y los migrantes de los barrios marginales que inundaron Santo Domingo desde el campo durante las décadas de 1960 y 1970. Durante años, solo Radio Guarachita, una única emisora de alcance nacional, estuvo dispuesta a transmitirla. Los artistas que hacían bachata lo hacían en los márgenes, tocando para públicos que se reconocían en cada letra sobre traición, anhelo y dificultad económica.",
  "Artistas pioneros como Luis Segura, Aridia Ventura y Edilio Paredes mantuvieron viva la tradición durante esas décadas difíciles, construyendo públicos leales a base de pura autenticidad en una época en que el reconocimiento masivo era completamente inalcanzable. Luego, en 1987, Blas Durán introdujo la guitarra eléctrica en la bachata con su grabación Mujeres hembras, un cambio que le dio a la música un filo más marcado y enérgico. Luis Vargas fue aún más lejos, convirtiéndose en el primer guitarrista de bachata en usar pedales de guitarra, ampliando la paleta sonora del género.",
  "El momento que verdaderamente llevó la bachata a la conversación nacional llegó con Antony Santos. En 1991, su álbum debut La Chupadera, encabezado por la canción Voy pa'llá, redefinió cómo podía sonar la bachata: más romántica, más comercialmente viable, pero aún inconfundiblemente arraigada en el vocabulario emocional original. Santos fue el primer artista de bachata nacido en el campo en alcanzar un reconocimiento nacional genuino y en llegar a las comunidades dominicanas en el exterior, abriendo una puerta que con el tiempo se abriría de par en par.",
  "El momento decisivo para la legitimidad internacional de la bachata llegó en 1992, cuando Juan Luis Guerra ganó el Premio Grammy al Mejor Álbum Tropical Latino con Bachata Rosa. Guerra abordó el género con sofisticación literaria y una producción exuberante, escribiendo canciones que resonaron con los dominicanos educados de clase media que antes habían despreciado el estilo. Bachata Rosa no solo ganó un premio; reescribió la narrativa cultural en torno a una música que había sido estigmatizada durante treinta años.",
  "El salto global llegó desde una dirección inesperada: el sur del Bronx. Aventura, un grupo de jóvenes dominicano-estadounidenses que navegaban la tensión entre su herencia caribeña y su crianza neoyorquina, fusionó la bachata con el hip-hop, el R&B y los estilos de producción urbana. Su sencillo de 2002, Obsesión, encabezó las listas musicales en Francia, Alemania, Italia y Estados Unidos, llegando a públicos que nunca habían escuchado una guitarra dominicana. El cantante principal, Romeo Santos, más tarde llenó el Yankee Stadium como solista, un logro que hizo imposible discutir la magnitud de la conquista del mundo por parte de la bachata.",
  "Mientras tanto, el género se había estado expandiendo a través de la diáspora dominicana en España e Italia, donde echó raíces en escuelas de baile y clubes sociales y comenzó a evolucionar hacia nuevas formas. La bachata sensual, desarrollada por los bailarines españoles Korke Escalona y Judith Cordero a mediados de la década de 2000, introdujo ondas corporales fluidas y una conexión cercana de pareja influenciada por el zouk brasileño, dándole al baile su propio circuito competitivo internacional. La bachata urbana y el bachatango surgieron de cruces similares en Estados Unidos y Europa, cada uno ampliando lo que el género podía contener sin romper su conexión con el sonido original de la guitarra.",
  "El 12 de diciembre de 2019, la UNESCO inscribió la música y el baile de la bachata dominicana en su Lista Representativa del Patrimonio Cultural Inmaterial de la Humanidad, el segundo género dominicano en recibir esa distinción, tras el merengue en 2016. El reconocimiento formalizó lo que músicos y públicos habían sabido durante décadas: que la bachata, nacida en los márgenes y rechazada por el establishment de su propio país, se había convertido en una de las tradiciones musicales más emocionalmente poderosas y globalmente queridas que el Caribe haya producido jamás.",
].join("\n\n");

export const genreContentEs: Record<string, GenreContentOverride> = {
  merengue: {
    subtitle: "Pambiche, Típico",
    description:
      "El merengue es uno de los sonidos más representativos de la identidad dominicana, combinando baile, ritmo, orquestación y narrativa popular.",
  },
  bachata: {
    subtitle: "Romántica, Tradicional, Moderna",
    description:
      "La bachata es un género dominicano moldeado por la expresión romántica con guitarra, la influencia del bolero y la narrativa popular de los barrios.",
    history: bachataHistoryEs,
  },
  salsa: {
    subtitle: "Tropical, Bailable",
    description:
      "La salsa, en el contexto dominicano, conecta el ritmo caribeño, la cultura del baile y a los intérpretes dominicanos que aportaron a la escena más amplia de la música tropical.",
  },
  urbano: {
    subtitle: "Dembow, Reggaetón",
    description:
      "La música urbana dominicana incluye dembow, reggaetón, rap, trap y estilos contemporáneos relacionados que reflejan la cultura juvenil, la expresión callejera y las tendencias latinas globales.",
  },
  pop: {
    subtitle: "Pop Latino, Contemporáneo",
    description:
      "El pop destaca a artistas y grabaciones dominicanas moldeadas por la composición contemporánea, la producción comercial y las influencias del pop latino.",
  },
  rock: {
    subtitle: "Rock, Alternativo",
    description:
      "El rock abarca el rock dominicano, el alternativo, el punk, el metal y la música impulsada por guitarras a través de las generaciones.",
  },
  reggae: {
    subtitle: "Reggae, Caribeño",
    description:
      "El reggae incluye grabaciones dominicanas conectadas con el reggae, el dancehall y el intercambio musical caribeño más amplio.",
  },
  jazz: {
    subtitle: "Jazz, Jazz Latino",
    description:
      "El jazz documenta a músicos de jazz dominicanos, improvisadores, agrupaciones y grabaciones moldeadas por las tradiciones latinas y caribeñas.",
  },
  electronic: {
    title: "Electrónica",
    subtitle: "Electrónica, Dance",
    description:
      "La música electrónica abarca a DJs, productores, música de baile y grabaciones dominicanas construidas en torno a la producción electrónica y la experimentación.",
  },
  instrumental: {
    subtitle: "Clásica",
    description:
      "La música instrumental destaca a músicos, arreglistas, orquestas e intérpretes clásicos dominicanos, así como obras instrumentales conectadas con la cultura musical dominicana.",
  },
  ballads: {
    title: "Baladas",
    subtitle: "Bolero, Romántica",
    description:
      "Las baladas incluyen canciones románticas, grabaciones con influencia del bolero e interpretaciones vocales centradas en la melodía, la letra y la interpretación emocional.",
  },
  folklore: {
    title: "Folclore",
    subtitle: "Tradicional, Raíces",
    description:
      "El folclore representa la música tradicional y de raíces dominicana, preservando los ritmos regionales, la memoria cultural y el patrimonio popular.",
  },
  fusion: {
    title: "Fusión",
    subtitle: "Tropical, Experimental",
    description:
      "La fusión incluye a artistas y grabaciones dominicanas que mezclan deliberadamente géneros establecidos, tradiciones tropicales e influencias globales.",
  },
  more: {
    title: "Más Géneros",
    subtitle: "Explora más sonidos dominicanos",
    description:
      "Explora géneros, estilos y categorías musicales dominicanas adicionales que no encajan en los grupos principales.",
  },
};

/**
 * Returns a genre-like object with its editorial fields replaced by Spanish
 * copy when `locale === "es"` and a translation exists; otherwise unchanged.
 */
export function localizeGenreContent<
  T extends {
    slug: string;
    title: string;
    subtitle?: string | null;
    description?: string | null;
    history?: string | null;
  },
>(genre: T, locale: string): T {
  if (locale !== "es") return genre;
  const es = genreContentEs[genre.slug];
  if (!es) return genre;
  return {
    ...genre,
    title: es.title ?? genre.title,
    subtitle: es.subtitle ?? genre.subtitle,
    description: es.description ?? genre.description,
    history: es.history ?? genre.history,
  };
}
