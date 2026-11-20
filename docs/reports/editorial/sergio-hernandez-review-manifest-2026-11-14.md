# Sergio Hernández — manifiesto de revisión (14 de noviembre de 2026)

## Alcance

- UUID existente: `f0bd28a5-4cf3-48c3-9c54-57af94582655`; `artists.status = published`.
- Entregables aprobados: registrar el 15 de junio si el modelo de datos lo permite y publicar revisiones EN/ES de sus dos documentos `artist_biography` ya públicos.
- Fuera de alcance: discografía, seguridad, despliegue, relaciones compartidas y biografías de otros artistas. No se ha escrito todavía en producción.

## Cambios de campo

| Campo | Antes | Propuesto | Evidencia / límite |
|---|---|---|---|
| `birth_day` | `NULL` | No aplicado; sigue `NULL` | Felicitaciones públicas explícitas del 15-06-2019 y 15-06-2026. Columna generada desde `date_of_birth`; rechaza actualización directa. |
| `birth_month` | `NULL` | No aplicado; sigue `NULL` | Misma limitación: columna generada desde `date_of_birth`. No se rellenó una fecha completa ficticia. |
| `birth_year`, `date_of_birth` | `NULL` | Sin cambio | No hay año verificable; no deducirlo de la duración de su carrera. |
| `birth_place`, `province` | Santiago de los Caballeros / Santiago | Sin cambio | La prensa sitúa su nacimiento específicamente en Gurabo, barrio de la ciudad; incorporar la precisión en la bio. |
| Nombre personal | Sergio Antonio Hernández Fernández, desglosado | Sin cambio | Confirmado por reportaje de Máximo Laureano. |
| `primary_role`, `occupations`, `primary_genre`, `genres` | singer / dancer / merengue / bolero, balada | Sin cambio | Valores distintos y compatibles con su trayectoria. |
| Redes y Spotify | Handles e ID existentes | Sin cambio | Facebook confirmado en su perfil público; el Instagram `@sergiohernandez3981` figura en [cartelera de un concierto de 2026](https://donde.do/events); el reproductor Spotify de la ficha pública muestra «Feliciana», «Pedacito de mi vida» y «Lágrimas». |

## Biografías públicas

- Documentos existentes: EN `667a6c41-c587-43ca-ad9a-c490b49c1e78` y ES `7add34ee-3d78-491c-99a1-de5da2670659`, ambos `published`, revisión 1.
- Texto completo propuesto: [sergio-hernandez-biographies-proposed-2026-11-14.md](sergio-hernandez-biographies-proposed-2026-11-14.md).
- Añadir Gurabo, Los Nietos del Rey, Revelación del Año 1981, las presentaciones de 2011/2016/2019 y el título literal del homenaje de 2023 según el lanzamiento digital.
- Quitar frases que explican la verificación de fuentes al lector, juicios vagos y detalles de conciertos de 2025-26 que no se pudieron corroborar adecuadamente.
- Conservar párrafos de sección exclusivamente en negrita, sin nodos H2 y sin negrita dentro de párrafos narrativos. Crear referencias estructuradas para cada mención de artista con ficha publicada. Los Nietos del Rey y Cholo Brenes no tienen ficha localizada; sus nombres quedarán en texto plano.

## Fuentes

1. Máximo Laureano, [entrevista de Sergio Hernández en Casa de Arte, 2019](https://hormigaradio.com/?p=7187): nombre completo, Gurabo, orquestas y reconocimiento de 1981. [Cobertura de Acento](https://acento.com.do/cultura/sergio-hernandez-al-merengue-lo-mantenemos-vivo-nosotros-8733823.html).
2. Servio Pérez, [felicitación del 15 de junio de 2019](https://www.facebook.com/photo/?fbid=10156196148172050&set=a.10150158224432050), nombra a Sergio Hernández y dice expresamente que es su cumpleaños.
3. Melody Then, [felicitación del 15 de junio de 2026](https://www.facebook.com/photo/?fbid=27667265259537426&set=a.417348394955814), nombra al «Marqués» Sergio Hernández. [Captura de la búsqueda](sergio-hernandez-facebook-birthday-2026-11-14.png).
4. [Diario Libre, 15 julio 2022](https://www.diariolibre.com/revista/musica/2022/07/15/sergio-hernandez-retoma-el-merengue-en-su-disco/1950411): repertorio de José José y arreglos de Herodys Ureña. Anuncia «En honor a la amistad»; no prueba su publicación. La nota contiene un error de copia al llamarlo Sergio Vargas en un párrafo: no se usa ese párrafo como evidencia.
5. [Apple Music, lanzamiento del 24 febrero 2023](https://music.apple.com/us/album/honor-a-anthony-rios/1674427919): título publicado «Honor a Anthony Rios», ocho pistas. [Diario Libre, 26 abril 2023](https://www.diariolibre.com/revista/musica/2023/04/26/sergio-hernandez-suena-en-la-radio-nacional-con-merengue/2297566) y [El Caribe](https://www.elcaribe.com.do/gente/a-y-e/sergio-hernandez-lanzo-la-z/) imprimieron «Honor a Anthony Ríos Kinder»; el descriptor «Kinder» no figura en el lanzamiento digital, por lo que no se propone como título de la obra.
6. [El Día, 29 abril 2016](https://eldia.com.do/cantante-sergio-hernandez-aboga-por-apoyo-a-ritmos-criollos/): «Cántame un cuento» y su repertorio.
7. [Crónica contemporánea de 2011](https://wwwnuevardnet.blogspot.com/2011_07_01_archive.html): «Dos voces por el bolero y la balada» en Maunaloa.
8. [Archivo General de la Nación, «Merengazo 85»](https://colecciones.agn.gob.do/opac/ficha.php?codopac=OP003&idpag=0029461263&informatico=00277472SR): registra «Pedacito de mi vida» y «Brindemos por ella», este último a dúo con Fausto Rey. [Fausto Polanco, El Día](https://eldia.com.do/el-merengue-se-nutrio-de-las-canciones-de-jose-jose/): registra la adaptación de «Lágrimas» en 1984 y «Por ella» junto a Fausto Rey. Se mantienen como títulos distintos; no se equiparan.
9. [Spotify](https://open.spotify.com/album/2zXgSNLoDTHq2kylTDbq5r) y [Apple Music](https://music.apple.com/us/album/%C3%A9xitos-del-merengrande/1467752591): recopilación «Éxitos del Merengrande», 13 pistas, 23 de noviembre de 2018.

## Ejecución y límite técnico

El editor aprobó el manifiesto completo en esta sesión. El 14 de noviembre de 2026 se publicaron ambos documentos mediante el editor administrativo: EN `667a6c41-c587-43ca-ad9a-c490b49c1e78`, revisión 1 → 3, y ES `7add34ee-3d78-491c-99a1-de5da2670659`, revisión 1 → 3. La revisión 3 enlaza la mención de Chery Jiménez y su Tercera Brigada que quedó en texto plano en la revisión 2. Cada documento conserva 11 párrafos, 5 títulos como párrafos en negrita, 12 referencias estructuradas con 12 filas de referencia y 0 encabezados. La ficha permanece `published`. Ambas páginas públicas muestran las referencias, incluido Chery: [español](https://mangulina.do/es/artists/sergio-hernandez), [inglés](https://mangulina.do/artists/sergio-hernandez). Capturas: [ES](sergio-hernandez-public-es-2026-11-14.png), [EN](sergio-hernandez-public-en-2026-11-14.png).

El intento acotado y guardado de asignar `birth_day=15` y `birth_month=6` fue rechazado por PostgreSQL con error `428C9`: ambas columnas son generadas a partir de `date_of_birth` y sólo aceptan `DEFAULT`. La consulta posterior confirmó que `date_of_birth`, `birth_year`, `birth_day` y `birth_month` permanecen en `NULL`. El día y mes constan únicamente en el texto de ambas biografías. Para que aparezca en el calendario de cumpleaños sin inventar el año se necesitaría una futura modificación del modelo de datos, fuera del alcance de esta revisión. No se modificaron relaciones compartidas, otras fichas ni discografía.
