# Auditoría de 24 fichas procesadas el 8 de noviembre de 2026

**Alcance:** 24 artistas nombrados por el editor; revisión de fichas, biografías EN/ES y referencias. No se autoriza por este informe una importación musical, borrado, cambio de seguridad ni despliegue.

## Inventario inicial

| Artista | UUID | Estado | Biografías |
|---|---|---|---|
| Alberth Hernández | `ead1053c-ff65-4da7-bc59-2b23c01b95bc` | published | en r1 published; es r1 published |
| Alberto María | `a935395f-0c7a-4f24-a541-486279c2efa3` | published | en r1 published; es r1 published |
| Berenice | `ead21ece-b74f-4263-b6e1-b6cb5d71cb14` | published | en r1 published; es r1 published |
| Carlos Jáquez | `1a58f7f9-7d70-4478-80f2-761dde30540f` | published | en r2 published; es r2 published |
| César Flores | `4e01ada8-c845-4e4f-bbd9-18a10d8ae046` | published | en r1 published; es r1 published |
| Dahian El Apechao | `c94039ac-3321-4b91-aa98-287973b83bdc` | published | en r1 published; es r1 published |
| Danaes | `a2ee61d6-0582-4189-bb97-85e2771fb2ea` | published | en r1 published; es r1 published |
| Dionis K Da Uno | `fa4e0de8-a2b2-46fd-ab2a-459f363afd4f` | published | en r1 published; es r1 published |
| Eddy Rafael | `71e01be6-d053-4b13-9a37-6e803b09ee9e` | published | en r2 published; es r2 published |
| Elvis Montilla | `96ae40e3-2e26-4255-bb3d-98a64230c459` | published | en r2 published; es r2 published |
| Felipe Jorge | `f8431eca-7579-4a0c-8394-b4514c5055f6` | published | en r1 published; es r1 published |
| Fellé Vega | `65298af5-c621-4985-822f-90414c03c928` | published | en r1 published; es r1 published |
| Franklin Rivers | `05a5761f-9e1a-4090-8812-9d5c516ccc9a` | published | en r1 published; es r1 published |
| Freddy Kenton | `6f7faf81-f57d-4460-924e-31bd2de5f082` | published | en r1 published; es r1 published |
| Gabby Arias | `f079fa2d-aac9-4ec9-9c1e-6e2986cce551` | published | en r1 published; es r1 published |
| Guarionex Castro | `88abc9a2-b55a-4e1f-9694-65e772259f0a` | published | en r2 published; es r2 published |
| Henry Castro | `2c09c6dc-5de7-438d-8236-6bc085378377` | published | en r1 published; es r1 published |
| Henry Trinidad | `24559b36-54da-4458-ba50-13d806a666e8` | published | en r1 published; es r1 published |
| Iris y Franklyn | `ab5f3288-2c71-45d7-bdcc-a3542077c774` | published | en r5 published; es r5 published |
| Irisneyda Santos | `8cee8d5b-9ccd-4eef-8469-fd72842a92a1` | published | en r2 published; es r2 published |
| Miguel Miguel | `5c41b4db-f9f7-4435-a371-ffc0add215cb` | published | en r1 published; es r1 published |
| Nando Galán | `60a7f8d5-1310-4e1a-86ed-7eede85e9444` | published | en r1 published; es r1 published |
| Orquesta Liberación | `6e1b1d42-3fe5-4523-9999-479a7626fb9a` | published | en r1 published; es r1 published |
| Roland Roll | `415cc361-5124-4544-b60e-3038ece74f42` | published | en r1 published; es r1 published |

Las 24 fichas estaban publicadas y cada una tenía imagen y documentos EN/ES publicados. No había duplicación del género principal en `genres` ni del rol principal en `occupations`. Los campos de nacimiento vacíos se conservan cuando no hay evidencia suficiente.

## Correcciones de campos confirmadas

| Ficha | Antes | Después | Razón |
|---|---|---|---|
| Iris y Franklyn | `birth_year = 1988`, `formation_year = 1988` | `birth_year = NULL`, conservar `formation_year = 1988` | Es un dúo; 1988 documenta su formación en Nueva York, no el nacimiento de una persona. Véase `iris-y-franklyn-profile-2026-11-08.md`. |
| Roland Roll | `province = Duarte`, `birth_place = NULL` | `province = NULL`, conservar `birth_place = NULL` | El expediente distingue procedencia de San Francisco de Macorís de nacimiento no comprobado. Véase `roland-roll-profile-2026-11-08.md`; `ARTIST_PROFILE_WORKFLOW.md` exige evidencia de nacimiento para ese campo. |
| César Flores | `facebook = profile.php?id=61576489055855` | `facebook = 61576489055855` | El contrato de almacenamiento admite username o ID numérico, no rutas URL. Conserva la misma página identificada en `cesar-flores-profile-2026-11-07.md`. |
| Alberth Hernández | `first_name = Alberth`, `last_name = Hernández`; sin otros nombres personales ni nacimiento | `first_name = Alberto`, `middle_name = Fermín`, `last_name = Núñez`, `second_last_name = Hernández`, `date_of_birth = 1976-02-19`, `birth_year = 1976` | La biografía autobiográfica del artista documenta el nombre completo, la fecha y Bonagua; el registro de marca de ONAPI corrobora el nombre civil. Se conservaron nombre y apellido artísticos en `name` y `stage_name`. |
| Dionis K Da Uno | `birth_place = NULL` | `birth_place = Santo Domingo`; provincia aún `NULL` | Entrevista publicada en Barranquilla en 2019 declara expresamente que nació en Santo Domingo; no fija la demarcación provincial del campo. |

## Biografías revisadas

Los 48 documentos biográficos de las 24 fichas siguen en estado `published`; los perfiles siguen en estado `published`. Se guardaron revisiones EN/ES, más sus espejos `artists.bio_en` y `artists.bio_es`, de las ocho fichas siguientes:

| Ficha | Revisiones finales EN/ES | Cambio editorial |
|---|---:|---|
| Alberth Hernández | 3 / 2 | Nombre personal completo, 19 de febrero de 1976, infancia en Bonagua, traslado a Cristo Rey en 1985 y estudios de Filosofía y Letras. |
| Berenice | 3 / 2 | Se retiraron notas de investigación y descripciones infladas dirigidas al editor. |
| Dionis K Da Uno | 5 / 3 | Se retiró una predicción de listas; se añadió nacimiento en Santo Domingo y la primera etapa en orquestas documentada por entrevista de 2019. La página pública EN/ES se actualizó y verificó el 9 de noviembre con autorización expresa. |
| Eddy Rafael | 8 / 4 | Se retiraron juicios sobre la persona; el anuncio de Acroarte de 2007 permitió identificar su paso por El Equipo en los ochenta, que antes estaba descrito como incierto. |
| Elvis Montilla | 4 / 3 | Se distinguió el repertorio impreso del LP de la atribución vocal establecida por crónica posterior; se retiró una nota de investigación. |
| Felipe Jorge | 3 / 2 | Se retiraron instrucciones editoriales y comentarios sobre búsquedas de nacimiento del texto público. |
| Guarionex Castro | 4 / 3 | Se retiraron autorreferencias a la auditoría y dudas de catálogo ajenas al lector. |
| Roland Roll | 3 / 2 | Se retiró una conjetura retrospectiva del cierre. |

Las otras dieciséis conservaron sus biografías después de la revisión. Todas las biografías revisadas respetan el párrafo de apertura y los vínculos tipificados existentes. Se comprobó la visualización pública de Alberth, Berenice, Dionis, Eddy (incluida la revisión final), Elvis, Felipe, Guarionex y Roland.

## Manifiesto compartido ejecutado el 9 de noviembre

Tras la aprobación expresa del editor se insertaron las quince relaciones de integrantes y fundadores del manifiesto `new-artists-shared-links-manifest-2026-11-08.md` y la relación adicional `Eddy Rafael → El Equipo` (`member_of`, años exactos sin documentar) del suplemento `eddy-rafael-el-equipo-link-proposal-2026-11-09.md`. La comprobación final encontró las **16 de 16** filas esperadas, sin duplicados de esos pares y tipos.

En `Iris y Franklyn.aliases` se retiraron `Irisneyda Santos`, `Franklin Rivers`, `Franklyn Rivers` e `Iris-y-franklyn`. Quedaron las cuatro variantes documentadas del dúo: `Iris & Franklyn`, `Iris & Franklyn Rivers`, `Iris Y Franklin` y `Yris Y Franklyn`. La página pública muestra esas cuatro, su formación en 1988 y ambos fundadores enlazados.

Se insertaron **52 referencias tipificadas** en los 32 documentos EN/ES de las dieciséis biografías ajenas al grupo de 24: Mozaribe, Andre Veloz, Cruz Monty, Kilvin Peña, The New York Band, Los Kenton, Rikarena, Sony Ovalles, Alex Bueno, Canon Vilomar, Carlos David, Diómedes Núñez, July Pie, Manuel La Güira, Ray Polanco y Tony Medrano. El título del álbum «Carlos David y Orquesta Liberación» quedó como título completo; el nuevo vínculo se añadió a una mención separada de la agrupación. Se corrigieron además tres defectos tipográficos preexistentes detectados durante las escrituras: dos espacios ausentes antes de referencias en The New York Band EN y un espacio inicial dentro de la referencia a Fernando Villalona en July Pie EN. Las listas de Alex Bueno y Ray Polanco se conservaron íntegras en documentos y espejos.

**Revisiones finales de los documentos enlazados:** Alex Bueno EN 8/ES 7; Andre Veloz 7/3; Canon Vilomar 3/2; Carlos David 4/2; Cruz Monty 8/7; Diómedes Núñez 4/5; July Pie 6/4; Kilvin Peña 4/2; Los Kenton 6/5; Manuel La Güira 5/4; Mozaribe 7/4; Ray Polanco 7/6; Rikarena 5/3; Sony Ovalles 6/5; The New York Band 7/7; Tony Medrano 8/7. Los 32 documentos siguen `published`, su texto completo coincide con las versiones revisadas y todas las páginas EN/ES muestran el nombre y el enlace esperados.

**Incidente de editor y reparación:** al cambiar de artista con el espacio de biografías abierto, el panel mostró el nombre nuevo mientras el contenido anterior seguía cargado. Una publicación en lote atribuyó transitoriamente el texto de Dionis a Mozaribe EN y el de Mozaribe a Andre Veloz EN. Se detuvo la secuencia, se restauraron ambos documentos y espejos desde las versiones correctas, y se revalidaron sus páginas públicas. Una comparación final de los 32 documentos confirmó texto y número de referencias correctos en todos. Para las publicaciones restantes se recargó el panel por artista y se verificaron nombre, apertura y revisión del documento antes de pulsar `Publish`.

Las relaciones se refrescaron con el editor administrativo sin alterar valores; la página pública de cada persona y agrupación afectada muestra los vínculos autorizados. No se importó ni modificó discografía.

## Rechazos de revisión automática y resolución

- La eliminación de cuatro alias incorrectos del dúo Iris y Franklyn fue rechazada inicialmente por ser un cambio destructivo de identidad sin aprobación específica. Se ejecutó después de la aprobación explícita del manifiesto y se verificó en público.
- La propuesta de vaciar `birth_place = Santiago de los Caballeros` y `province = Santiago` de Carlos Jáquez fue rechazada porque la evidencia disponible no demuestra que sean falsos y por su carácter destructivo. Su ficha no se cambió. La biografía oficial de Space Coast Symphony documenta nacimiento en República Dominicana y estudios en Santiago, sin identificar la ciudad natal.
- La publicación adicional de Dionis mediante el botón del navegador fue rechazada inicialmente por considerar insuficiente la autorización general de revisión. Se realizó después de la aprobación específica del editor y se verificó en su ficha pública.
- La primera escritura propuesta para Alex Bueno EN fue rechazada porque el espejo de texto reconstruido omitía una lista; la segunda por omitir la actualización del espejo. Se corrigió el plan y se guardó el documento con su lista y espejo completos; lo mismo se aplicó preventivamente a Alex ES y Ray Polanco EN/ES. The New York Band EN y July Pie EN se guardaron después de corregir las referencias mal formadas detectadas por revisión automática.

## Pendientes de investigación

- No completar fechas de nacimiento, lugares, Spotify ni redes sociales a partir de homónimos o fechas de publicaciones aisladas.
- Las identidades Spotify añadidas después de los manifiestos iniciales se comprobaron directamente en sus páginas visibles: [Nando Galán `7tqpQLj03lGrM3Q5FOKCUn`](https://open.spotify.com/artist/7tqpQLj03lGrM3Q5FOKCUn) muestra «Faltaste A La Cita»; [Orquesta Liberación `6AiIFo4TiG53Z1Tt3WMrJz`](https://open.spotify.com/artist/6AiIFo4TiG53Z1Tt3WMrJz) muestra «Qué Cara Más Bonita» y «Me Muero por Ella» con Alex Bueno. Ambos IDs ya estaban guardados y no se modificaron.
- El lugar de nacimiento de Carlos Jáquez se conserva pendiente de evidencia más precisa; la fuente oficial consultada no confirma ni refuta Santiago de los Caballeros como ciudad natal.

## Fuentes internas

Los 24 expedientes individuales en `docs/reports/editorial/*-profile-2026-11-0*.md`, `docs/ARTIST_PROFILE_WORKFLOW.md`, `docs/EDITORIAL_BIOGRAPHY_FORMAT.md` y los documentos TipTap en producción. Los expedientes son pistas editoriales y se contrastan con el estado vivo antes de cada escritura.

Fuentes nuevas contrastadas: [biografía autobiográfica de Alberth Hernández](https://wwwelprincipealberthhernandez.blogspot.com/p/biografia-el-principe-alberth-hernandez.html), [registro de marca de ONAPI de octubre de 2024](https://www.onapi.gov.do/transparencia/index.php/institucional/publicaciones/3516-boletines-de-registros-publicados-del-2020-al-2026/2983-pub-2024/3299-octubre-pub-2024?download=17127%3Apublicacion-31-de-octubre-2024), [entrevista de Alberth a Mario Díaz](https://www.fattinostri.it/alberth-hernandez-il-principe-del-merengue/), [entrevista de Dionis K Da Uno publicada en 2019](https://noticiascoopercom.co/a-su-manera-de-dionis-k-da-uno/), [anuncio de Acroarte sobre exintegrantes de El Equipo en 2007](https://tiempohabitualonline.blogspot.com/2007/12/tiempo-habitual-online_4396.html) y [biografía oficial de Carlos Jáquez en Space Coast Symphony](https://spacecoastsymphony.org/our-family/our-violins/).
