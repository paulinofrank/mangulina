# Las Canelas y Juanchy Vásquez — revisión editorial

**Alcance (11 de noviembre de 2026):** auditoría de las fichas públicas `9c87060d-5078-45bd-ab2a-fd127090d774` y `a50b20f2-0fcf-42c9-a68d-22416ca9181d`, sus biografías EN/ES, fuentes y vínculos. El editor aprobó expresamente el manifiesto después de prepararse. Se aplicaron las correcciones enumeradas y se verificaron; no se importó discografía ni se alteró el estado de publicación.

## Evidencia nueva y evaluación

1. El reportaje de Joan Abreu muestra la lápida de Juanchy Vásquez y lee «Juan Enrique Vásquez», 15-11-1956 a 06-10-1999 ([video, 02:39–02:54](https://www.youtube.com/watch?v=7JYH8U3AzIs&t=159s)). Una nota secundaria anterior imprimía 1954, pero no mostraba documento. La lápida permite registrar el nombre y la fecha con procedencia expresa; **no** acredita un segundo apellido. No equiparar sin prueba «Enrique» con «Henrique» ni asumir que el apellido Jiménez de su hermano también sea suyo.
2. Alejandro de Jesús Vásquez Jiménez, hermano de Juanchy, explicó que ambos nacieron en el Hospital Juan Pablo Pina de San Cristóbal y llegaron de niños a Sabana de Hatillo ([05:11–05:27](https://www.youtube.com/watch?v=7JYH8U3AzIs&t=311s)). El campo de origen puede decir `San Cristóbal`; la infancia en Hatillo pertenece a la biografía.
3. El hermano dijo que Juanchy fue sastre y que estudió, pero no pudo identificar la carrera ni la universidad. La afirmación actual «estudió medicina en la UASD y de ahí viene El Galeno» es injustificada ([05:30–06:45](https://www.youtube.com/watch?v=7JYH8U3AzIs&t=330s)). Conservar el apodo sin explicar su origen.
4. La ficha actual afirma que murió instalando un aire acondicionado. Su hermano no sabía cómo ocurrió la caída; un antiguo director musical tampoco afirmó conocer sus circunstancias ([13:17–14:47](https://www.youtube.com/watch?v=7JYH8U3AzIs&t=797s), [36:24–36:50](https://www.youtube.com/watch?v=7JYH8U3AzIs&t=2184s)). La prensa ya registraba conjeturas sobre el caso ([Listín USA, 2021](https://listinusa.net/2021/07/03/juanchy-vasquez-el-galeno-su-potente-voz-se-adaptaba-y-acariciaba-cada-merengue-interpretaba-su-muerte-explicada-por-productor-musical-elvin-polanco-amigo-cercano/)). Escribiremos sólo que falleció tras una caída de un edificio en Nueva York, sin fijar una causa. No repetiremos las acusaciones especulativas del entrevistador.
5. El mismo reportaje entrevista a un bajista y director musical presentado como Chulí Montes, quien describe su trabajo con la orquesta ([25:00–35:00](https://www.youtube.com/watch?v=7JYH8U3AzIs&t=1500s)); la transcripción automática de su nombre varía. Dejaremos pendiente su nombre exacto hasta contrastarlo con un crédito impreso. Los créditos de Johnny Tulanga para «Vagabundo» y «Estrella de Plata» están documentados por [El Día](https://eldia.com.do/johnny-tulanga-un-compositor-y-musico-olvidado/); un registro de derechos reproducido [aquí](https://www.copyrightencyclopedia.com/me-quiere-la-morena-hable-con-la-luna-amor-imposible-%5Bet/) acredita «Vagabundo» a Juan de la Cruz Báez bajo el seudónimo Johnny Tulanga, aunque el apellido civil entra en conflicto con la ficha de Tulanga y no se trasladará a ella sin investigación separada.
   El LP de 1986 aparece identificado de maneras distintas en los catálogos: «El Galeno» en el registro de derechos, «Juanchy Vásquez y Orquesta La Diferencia» en una [lista de discos físicos](https://salsamixmax.blogspot.com/2015/06/) y «La Diferencia» en la reedición digital de Mangulina. Se evitará presentar uno de estos títulos como nombre inequívoco de la portada original sin inspeccionar el ejemplar. El [Smithsonian](https://www.si.edu/es/object/por-cantar%3Anmah_1694241) conserva «Por Cantar!» (1988) como objeto físico.
6. El LP original de Las Canelas «Hot Stuff» (Rico Records, RCSLP 904, 1985) tiene ocho cortes. La reedición digital contiene diez: [Amazon Music](https://music.amazon.com/artists/B008A4PS6E/grupo-las-canela) identifica «Siboney (Bonus Track)» y «No Hay Razon (Bonus Track)»; [Apple Music](https://music.apple.com/us/album/hot-stuff-remastered-special-edition/385527103) confirma diez canciones. La bio menciona sólo un extra y debe precisar los dos. Esto no autoriza importar pistas.
7. Roger Zayas, músico cercano a Janina Rosado, describe su trabajo anterior con la Orquesta Constelación y su llegada posterior a Las Canelas ([testimonio de 2014](https://www.flickr.com/photos/rogerzayas/15858849098)). La frase actual «punto de partida de la carrera de Janina» es falsa. El mismo testimonio dice que Johnny Ventura manejaba el grupo y que el proyecto duró cerca de un año. [Ileana Reynoso](https://www.diariolibre.com/revista/musica/yleana-reynoso-siento-que-no-he-sido-reconocida-lo-suficiente-en-mi-tierra-BF8711434) confirmó que fue su voz principal. No se verificó una fecha precisa de disolución; `dissolution_year = 1987` y el `end_year = 1987` del vínculo fundador son demasiado categóricos. La tesis de que el éxito de Las Chicas del Can causó el cierre tampoco tiene respaldo suficiente.

## Manifiesto concreto propuesto

| Registro | Antes | Después |
|---|---|---|
| Juanchy `first_name`, `middle_name`, `last_name` | null, null, null | `Juan`, `Enrique`, `Vásquez` |
| Juanchy `second_last_name` | null | null; sin prueba suficiente |
| Juanchy `date_of_birth`, `birth_year`, `birth_month`, `birth_day` | null | `1956-11-15`, `1956`, `11`, `15` |
| Juanchy `birth_place` | null | `San Cristóbal` (ciudad; provincia conservada `San Cristóbal`) |
| Juanchy documentos EN/ES | publicados, revisión 1 | reemplazar por los textos de abajo, publicados, revisión 2; actualizar espejos y referencias de artista |
| Las Canelas `dissolution_year` | `1987` | null; conservar `ended = true` |
| Johnny Ventura → Las Canelas, `founder_of`, `end_year` | `1987` | null; conservar relación, inicio `1985` y el resto de la nota; cambio compartido sujeto a aprobación ampliada |
| Las Canelas documentos EN/ES | publicados, revisión 1 | reemplazar por los textos de abajo, publicados, revisión 2; actualizar espejos y referencias de artista |

Se conservan los Spotify ID, alias, imágenes, roles, género, etiquetas y estados de publicación. Las dos biografías de Ileana Reynoso y las de Manolé y la Banda del Truco ya contienen enlaces correctos. La de Janina Rosado no menciona Las Canelas pese a su papel de directora musical: se propone como cambio compartido separado, sin escritura bajo este manifiesto. Tampoco se cambia la ficha de Johnny Tulanga ni sus créditos en la discografía.

`birth_month` y `birth_day` son columnas generadas: el escritor sólo asignará `date_of_birth` y `birth_year`, y comprobará que las dos primeras resulten 11 y 15.

## Las Canelas — texto español propuesto

Las Canelas fue una orquesta femenina dominicana de merengue impulsada por Johnny Ventura a mediados de los años ochenta. Su único álbum original, «Hot Stuff» (1985), se publicó en «Rico Records» con Ileana Reynoso como voz principal y Janina Rosado como pianista y directora musical. El grupo se presentó en Nueva York en el «Carnaval del Merengue» de 1986.

**Orígenes y formación**

Ventura manejó la agrupación y llamó a Rosado, que ya había tocado con «Orquesta Constelación» en Santiago Rodríguez, para asumir su dirección musical. Reynoso se incorporó después de haber cantado en Las Chicas del Can. Ambas agrupaciones formaron parte del auge del merengue interpretado por mujeres en los años ochenta, pero sus trayectorias no fueron idénticas.

**«Hot Stuff» y los escenarios**

El LP «Hot Stuff» (Rico Records, RCSLP 904) reunió ocho merengues: «Tu compañera», «De aquello ná'», «A mi amiga», «Canta conmigo», «Francisco el hombre», «Hipocresía», «Mi hombre» y «San Antonio». La edición digital remasterizada presenta diez pistas porque agrega «Siboney» y «No Hay Razon» como temas adicionales. Entre el 8 y el 10 de febrero de 1986, Las Canelas participaron en el «VIII Carnaval del Merengue» en el «Felt Forum» de Nueva York, en una cartelera que incluyó a Ventura y Fernando Villalona. Se conserva una interpretación televisiva de «Siboney».

**Legado**

El proyecto duró aproximadamente un año. Rosado pasó después a la orquesta de Ventura y, más adelante, a Grupo 440 de Juan Luis Guerra. El álbum original, sus dos cortes adicionales y los registros audiovisuales conservan el trabajo de una agrupación breve en la que coincidieron la voz de Reynoso y la dirección musical de Rosado.

## Las Canelas — proposed English text

Las Canelas was a Dominican all-female merengue orchestra promoted by Johnny Ventura in the mid-1980s. Its sole original album, «Hot Stuff» (1985), was issued on «Rico Records» with Ileana Reynoso as lead singer and Janina Rosado as pianist and musical director. The group performed in New York at the 1986 «Carnaval del Merengue».

**Origins and personnel**

Ventura managed the group and invited Rosado, who had already played with «Orquesta Constelación» in Santiago Rodríguez, to serve as musical director. Reynoso joined after singing with Las Chicas del Can. Both groups belonged to the rise of women's merengue orchestras in the 1980s, although their paths were distinct.

**«Hot Stuff» and live performances**

The original «Hot Stuff» LP (Rico Records, RCSLP 904) contained eight merengues: «Tu compañera», «De aquello ná'», «A mi amiga», «Canta conmigo», «Francisco el hombre», «Hipocresía», «Mi hombre» and «San Antonio». The remastered digital edition has ten tracks, adding «Siboney» and «No Hay Razon» as bonuses. From 8 to 10 February 1986, Las Canelas appeared at the «VIII Carnaval del Merengue» at New York's «Felt Forum», on a bill that included Ventura and Fernando Villalona. A television performance of «Siboney» also survives.

**Legacy**

The project lasted about a year. Rosado subsequently joined Ventura's orchestra and later Grupo 440, led by Juan Luis Guerra. The original album, its two bonus tracks and surviving video preserve the work of a short-lived group that brought together Reynoso's singing and Rosado's musical direction.

## Juanchy Vásquez — texto español propuesto

Juan Enrique Vásquez, conocido artísticamente como Juanchy Vásquez y apodado «El Galeno», fue un cantante dominicano de merengue romántico y líder de su propia orquesta. Nació el 15 de noviembre de 1956 en San Cristóbal y creció en Sabana de Hatillo, adonde su familia se trasladó cuando era niño. Falleció en Nueva York el 6 de octubre de 1999. Entre sus interpretaciones más difundidas están «Penélope», «Estrella de Plata» y «Vagabundo».

**De Hatillo a la orquesta**

Antes de dedicarse plenamente a la música, Vásquez trabajó como sastre. En los escenarios y en sus discos se presentó como Juanchy Vásquez y Orquesta o Juanchy Vásquez «El Galeno». Aunque se ha asociado ese apodo con estudios de medicina, los testimonios disponibles no permiten establecer el origen del nombre ni confirmar una carrera universitaria determinada.

**Grabaciones y colaboradores**

En 1986 publicó un LP con «Orquesta La Diferencia» en «Valette Records» (VLP 0015), del que proceden «Penélope», «Estrella de Plata», «Vagabundo» y «Dilo Tú», entre otros temas. Johnny Tulanga compuso «Vagabundo» y «Estrella de Plata». Vásquez continuó grabando: el disco «Por Cantar!» apareció en 1988, y en los años noventa circularon «Ayer y Hoy» y «Bachatiando». También quedó registrado en presentaciones televisivas, entre ellas una interpretación de «Cómo Fue» en 1987.

**Últimos años**

Tras establecerse en Nueva York continuó trabajando en su carrera musical. Murió después de caer de un edificio en esa ciudad; las circunstancias precisas de la caída no quedaron establecidas en los testimonios públicos de sus familiares y colaboradores.

**Legado**

Las grabaciones y las actuaciones televisivas conservan el timbre de una de las voces del merengue romántico de los años ochenta y noventa. Su catálogo volvió a circular en compilaciones digitales bajo el nombre Juanchy Vásquez «El Galeno».

## Juanchy Vásquez — proposed English text

Juan Enrique Vásquez, known professionally as Juanchy Vásquez and nicknamed «El Galeno», was a Dominican romantic-merengue singer and bandleader. He was born on 15 November 1956 in San Cristóbal and grew up in Sabana de Hatillo, where his family moved during his childhood. He died in New York on 6 October 1999. His best-known recordings include «Penélope», «Estrella de Plata» and «Vagabundo».

**From Hatillo to the orchestra**

Before devoting himself to music, Vásquez worked as a tailor. On stage and on record he was billed as Juanchy Vásquez y Orquesta or Juanchy Vásquez «El Galeno». The nickname has been linked to medical studies, but the available testimony does not establish where it came from or confirm a particular university course.

**Recordings and collaborators**

In 1986 he issued an LP with «Orquesta La Diferencia» on «Valette Records» (VLP 0015), containing «Penélope», «Estrella de Plata», «Vagabundo» and «Dilo Tú», among other songs. Johnny Tulanga wrote «Vagabundo» and «Estrella de Plata». Vásquez continued recording: «Por Cantar!» appeared in 1988, followed in the 1990s by «Ayer y Hoy» and «Bachatiando». Television appearances also survive, including a 1987 performance of «Cómo Fue».

**Later years**

After settling in New York, he continued pursuing his musical career. He died after falling from a building there; public accounts from his family and collaborators do not establish the precise circumstances of the fall.

**Legacy**

His recordings and televised performances preserve one of the voices of romantic merengue in the 1980s and 1990s. His catalogue later circulated in digital compilations under the name Juanchy Vásquez «El Galeno».

## Enlaces, publicación y verificación previstos

- Los nombres de artistas que ya tienen ficha (Johnny Ventura, Ileana Reynoso, Janina Rosado, Las Chicas del Can, Fernando Villalona, Grupo 440, Juan Luis Guerra y Johnny Tulanga) deben convertirse en nodos `artistReference` con el nombre canónico exacto; no dejar enlaces Markdown dentro del documento ni ponerlos entre comillas. «Orquesta Constelación», sin ficha comprobada, queda como entidad no catalogada.
- Tras aprobación: actualizar los cuatro documentos biográficos, los cuatro espejos Markdown, las referencias editoriales y los campos de perfil enumerados; conservar `artists.status = published` y `editorial_documents.status = published`.
- Verificar revisiones, enlaces, fecha en calendario, valores del formulario y páginas públicas EN/ES. No tocar lanzamientos, grabaciones ni créditos musicales.
- **Pendientes fuera de alcance:** enlazar Las Canelas en la bio de Janina; verificar segundo apellido civil de Juanchy; verificar nombre exacto de Chulí Montes; auditar crédito de «Penélope» en la discografía y año preciso de fin del grupo.

## Ejecución y comprobaciones

- El primer intento de escritura transaccional no se ejecutó porque venció una confirmación automática. Una consulta inmediata mostró que las fichas y documentos seguían en sus valores y revisiones anteriores. Se aplicó entonces el lote secuencial aprobado: dos solicitudes SQL para campos de perfil/vínculo y cuatro solicitudes de publicación de biografías mediante la función editorial existente, cada una con control de revisión y espejo Markdown. Retransmisiones de escrituras fallidas: cero; cambios repetidos: cero. No hubo importaciones discográficas, despliegues, cambios de esquema ni cambios de seguridad.
- Juanchy: `first_name Juan`, `middle_name Enrique`, `last_name Vásquez`, `second_last_name null`, `date_of_birth 1956-11-15`, `birth_year 1956`, `birth_place San Cristóbal`, `province San Cristóbal`. Las columnas generadas `birth_month=11` y `birth_day=15` se comprobaron después. Las Canelas: `dissolution_year null`, `ended true`. Vínculo Johnny Ventura → Las Canelas: `founder_of`, `start_year 1985`, `end_year null`.
- Los cuatro documentos `editorial_documents` permanecen `published`, revisión `1→2`. Los nodos `artistReference` y las filas correspondientes coinciden: 7 por idioma para Las Canelas, 1 por idioma para Juanchy. Los cuatro espejos Markdown están poblados. Las afirmaciones descartadas sobre estudios de medicina, instalación del aire acondicionado y comienzo de la carrera de Janina ya no figuran.
- Marcas de actualización de los documentos: 2026-11-12 03:36:57 a 03:37:08 UTC (hora local: 11 de noviembre). La primera llamada local de revalidación falló por restricción de red; una segunda llamada dirigida tuvo éxito con `artists:[las-canelas,juanchy-vasquez,johnny-ventura]` y respuesta `{artists:3,songs:0,releases:0,allArtists:false}`. No se hizo actualización global.
- Comprobación pública acotada: tres solicitudes GET, todas HTTP 200: `/es/artists/juanchy-vasquez` mostró «Juan Enrique Vásquez» y no mostró la atribución antigua a UASD; `/en/artists/juanchy-vasquez` mostró «15 November 1956»; `/es/artists/las-canelas` mostró «No Hay Razon» y no mostró «punto de partida de la carrera de Janina». La cuarta combinación de idioma se verificó en el documento de base de datos y el espejo, sin otra solicitud pública.
