# Creación y revisión de perfiles de artistas

Procedimiento operativo de Mangulina. Actualizado el 12 de noviembre de 2026 por solicitud del editor. Complementa AI_INSTRUCTIONS.md, DATA_GOVERNANCE.md, EDITORIAL_GUIDELINES.md, ROLE_DICTIONARY.md y EDITORIAL_BIOGRAPHY_FORMAT.md; aplica la excepción para borradores de discography.md, Gate B, y conserva sus límites de seguridad.

## 1. Definir la ficha antes de escribir

Identificar artista, UUID existente o identidad nueva propuesta, nombres alternativos y alcance autorizado. Buscar coincidencias por nombre, nombre personal, alias y slug en todos los estados. Conservar UUID y URL existentes. Separar cambios de ficha, biografía, imagen, discografía y publicación; ninguno autoriza implícitamente los demás. Aplicar las puertas de revisión de discography.md cuando correspondan.

Preparar un manifiesto por campo con valor anterior, valor propuesto, evidencia y limitación. Una instrucción de corregir campos concretos autoriza el trabajo dentro de ese alcance; no amplía permisos a otros artistas, seguridad ni publicación. No repetir una aprobación que ya cubre exactamente el cambio.

Cuando el editor solicita crear o completar el perfil de un artista, mantener la ficha en artists.status = draft y publicar sus biografías terminadas y validadas en español e inglés con editorial_documents.status = published, sin pedir una segunda aprobación del manifiesto. Aclaración del editor del 16 de octubre de 2026: el borrador corresponde al artista; las biografías deben quedar listas para cuando se publique su ficha. Preparar el manifiesto como registro de evidencia y ejecutar el trabajo solicitado; no convertirlo en una pausa de aprobación. Mantener la investigación, las comprobaciones de identidad y la verificación posterior. Esta excepción no autoriza publicar la ficha del artista, publicar biografías de un artista ya público sin autorización, cambios destructivos o compartidos, importaciones discográficas, cambios de otros artistas ni seguridad.

## 2. Investigar todos los campos de la ficha

Cada campo debe terminar como verificado y completado, investigado pero no verificado, no aplicable o pendiente de una fuente identificada. Una casilla vacía no equivale a una investigación terminada. Registrar búsquedas y accesos fallidos. Si el lector web no abre una fuente relevante, probar el navegador disponible antes de declararla inaccesible.

Revisar directamente los recursos públicos pertinentes disponibles: las cuentas oficiales aportadas por el editor y sus secciones de información, además de fuentes biográficas y plataformas musicales. En Facebook, abrir Información > Datos personales y comprobar ciudad de origen, ciudad actual y los demás datos públicos pertinentes. No dar por agotada la investigación con los resultados del buscador o con un fallo del lector web cuando el navegador permite acceder a la cuenta.

### Búsqueda de cumpleaños dentro del perfil — instrucción del editor, 17 de octubre de 2026

Aplicar siempre como parte de la investigación de nacimiento cuando exista un perfil público de Facebook accesible: usar Buscar en este perfil/página y consultar términos como Cumple, Cumpleaños, Happy, Birthday, Año, Años y Feliz, además de variantes pertinentes. Revisar publicaciones de la propia persona, felicitaciones públicas y fotos o videos de celebraciones; no limitarse a Información ni al buscador general. Abrir los resultados útiles y conservar el enlace permanente, fecha completa de publicación, texto relevante, autor y contexto de la imagen.

Contrastar celebraciones del mismo día y mes en años diferentes. Distinguir el cumpleaños real de una fiesta adelantada o posterior, una felicitación tardía, un aniversario musical o el cumpleaños de otra persona. Una publicación aislada o su fecha de subida no basta automáticamente para fijar el nacimiento. Registrar búsquedas sin resultados y límites de acceso.

Una edad declarada por la persona o un número claramente visible en una foto de su cumpleaños puede apoyar una deducción del año: año de la celebración menos edad cumplida, siempre que estén establecidos la persona, la fecha del cumpleaños y el significado del número. Registrar el cálculo como deducción y contrastarlo con otras publicaciones o datos explícitos del perfil. No identificar edades por apariencia ni interpretar cualquier número decorativo como edad. Una edad en una entrevista sin día de cumpleaños solo permite un intervalo de años, no una fecha exacta. Completar date_of_birth únicamente cuando día, mes y año estén suficientemente sustentados; conservar incertidumbres y contradicciones en el manifiesto.

| Campo | Comprobación obligatoria |
| --- | --- |
| Nombre artístico y nombre personal | Investigar y guardar por separado; completar los campos de nombre personal con el nombre completo documentado, sin deducir el orden de apellidos del nombre artístico ni sustituir estos campos por un alias |
| Tipo de artista | Valor actual admitido por el formulario; para solista, solo_artist; no insertar Person por analogía con otro proveedor |
| Rol principal | Valor del selector vigente; una ocupación válida no es necesariamente un rol principal admitido |
| Otras ocupaciones e instrumentos | Vocabulario documentado y opciones actuales; no repetir el rol principal ni mezclar créditos con ocupaciones |
| Género principal y géneros adicionales | primary_genre contiene el género principal; genres contiene únicamente otros géneros documentados. Deben provenir estrictamente de la tabla genres. Nunca inventar géneros ni subgéneros (p. ej. no inventar «merengue jocoso»). Nunca repetir en genres el valor de primary_genre. Si no hay otros géneros verificados en BD, dejar genres vacío; si no existe en BD, preguntar al editor |
| Sexo o género | Campo gender del editor, con evidencia pública explícita o indicación del editor; nunca deducir de foto, voz o nombre |
| Christian o Secular | Revisar el repertorio y las definiciones de EDITORIAL_GUIDELINES.md; la etiqueta describe música, no la religión personal |
| Fecha y año de nacimiento | Buscar fuentes biográficas y datos públicos de la propia artista; no calcular una fecha exacta a partir de una edad periodística |
| Lugar de nacimiento | Requiere evidencia de nacimiento; no equipararlo automáticamente con ciudad de origen, residencia u origen familiar |
| Procedencia y provincia | Registrar la ciudad de origen y provincia documentadas aunque el lugar exacto de nacimiento siga sin confirmar; province puede reflejar la procedencia documentada, no exige prueba de nacimiento |
| Redes sociales | Verificar identidad de la cuenta y normalizar el identificador según la sección siguiente |
| Spotify | Buscar dentro de Spotify si el buscador general no encuentra el perfil; abrir el artista y contrastar nombre, repertorio y otra evidencia independiente |
| Biografías | Español e inglés, documentos estructurados, formato editorial y referencias íntegros |
| Imagen | Comprobar existencia y dejar constancia si falta; cargar únicamente dentro del alcance autorizado y con derechos adecuados |

No inventar fechas, lugares ni IDs para completar la ficha. Los campos no verificados permanecen vacíos y se enumeran claramente al entregar el trabajo. No usar páginas de búsqueda de personas ni datos de homónimos como prueba biográfica.

### Nombre personal y nombre artístico — instrucción compartida del editor, 19 de octubre de 2026

Aplicable a cualquier IA que cree o revise perfiles. Una persona puede usar su segundo apellido, su primer apellido, un segundo nombre o cualquier otra forma documentada como nombre artístico. No juzgar esa elección ni tratarla como una contradicción del nombre personal. Tampoco reconstruir, invertir o reinterpretar el nombre completo a partir del nombre artístico.

### Nombre de colectivos: descriptor genérico frente a nombre propio

No anteponer «Orquesta», «Grupo», «Banda» o «Conjunto» sólo porque el registro
sea colectivo. Esas palabras describen el tipo de entidad y no forman parte del
nombre salvo que las fuentes fiables demuestren que son parte del nombre propio.
Por ejemplo, «Orquesta Internacional» sí conserva «Orquesta» porque es el
nombre documentado asociado con Ramón Orlando. Separar siempre el nombre
canónico del campo de tipo de artista y usar el nombre canónico, carácter por
carácter, en las referencias editoriales. Si el nombre guardado está equivocado,
corregir primero el registro dentro del alcance autorizado; no compensarlo
alterando una biografía.

Cuando el editor proporciona o confirma un nombre completo sustentado y su estructura está establecida, completar los campos correspondientes: First Name, Middle Name, Last Name y Second Last Name. Mantener por separado el nombre de presentación y Stage Name. Conservar el nombre completo como alias cuando ayude a la búsqueda, pero nunca usar ese alias como sustituto de los campos personales. No exigir que el apellido usado profesionalmente coincida con Last Name.

Ejemplo expresamente aclarado por el editor: nombre personal «José Miguel Vásquez Lacay» → First Name = José; Middle Name = Miguel; Last Name = Vásquez; Second Last Name = Lacay. Nombre de presentación y Stage Name = José Lacay. El uso profesional de Lacay es compatible con que sea el segundo apellido.

Evaluar las fuentes sigue siendo obligatorio: si existe una contradicción real entre fuentes identificables, registrar los valores, su procedencia y el motivo de la decisión. No convertir una variante secundaria en motivo automático para omitir todos los campos cuando el editor ya aclaró el nombre y el orden. Si sólo una parte permanece incierta, completar las partes confirmadas y declarar el pendiente concreto. No aplicar mecánicamente el esquema de dos apellidos a otras tradiciones de nombres. Antes de entregar, comprobar que los campos personales sustentados están poblados y que Stage Name conserva la forma artística documentada.

La incertidumbre sobre el nacimiento no invalida una procedencia conocida. Por ejemplo, si la cuenta oficial declara Río San Juan, María Trinidad Sánchez como ciudad de origen, conservar esa procedencia en la investigación y registrarla en los campos o texto de procedencia autorizados; completar province con María Trinidad Sánchez. No dejar también la provincia vacía por falta de fecha o lugar exacto de nacimiento. Mantener birth_place y date_of_birth sin confirmar cuando la fuente no los establece, y conservar la URL y el texto que sustentan la procedencia. Esta regla no autoriza cambios biográficos fuera del alcance del encargo.

### Origin es una ciudad — aclaración del editor, 19 de octubre de 2026

Nunca escribir «República Dominicana», «Dominican Republic» ni otro país en Origin: el campo corresponde a la ciudad, no a la nacionalidad. La plataforma documenta artistas dominicanos; no usar ese campo para reiterar su condición dominicana. Si la ciudad no está verificada, dejar el campo vacío y registrar el pendiente, sin sustituirla por el país. Para agrupaciones, Origin es la ciudad de origen documentada; el formulario actual la guarda en birth_place. Para personas, conservar el requisito de evidencia de nacimiento antes de completar Place of Birth/birth_place; no convertir una residencia o ciudad de procedencia en lugar de nacimiento.

Para artistas dominicanos nacidos en el extranjero, registrar la ciudad de nacimiento verificada y seleccionar «Born Abroad» en Province. Usar la opción equivalente «Nacido en el Exterior» cuando así aparezca en el selector vigente: es el valor admitido actualmente y representa «Born Abroad». No asignar una provincia dominicana ficticia ni sustituir la ciudad extranjera por el país. Haber residido o trabajado fuera del país no demuestra nacimiento en el extranjero. Esta aclaración actualiza las instrucciones; no autoriza por sí sola corregir registros existentes.

## 3. Guardar identificadores y valores compatibles

Contrato vigente en src/lib/artistSocialLinks.ts:

| Campo | Valor que se guarda | Ejemplo |
| --- | --- | --- |
| facebook | Username sin dominio, @, barra final ni subpágina; alternativamente ID numérico | ladoncella.delacordeon |
| instagram | Username sin dominio ni @ | ladoncelladelacordeon |
| youtube | @handle; sin handle, channel/UC..., c/Name o user/Name | @LADONCELLATIPICA |
| spotify | ID de artista de 22 caracteres; no URL de artista, álbum, pista ni playlist | Extraer de open.spotify.com/artist/ID |
| website | URL completa con esquema | https://sitio-del-artista.example |

Las URLs originales se conservan como evidencia en el manifiesto. El hecho de que el renderizador tolere URLs completas no cambia el contrato de almacenamiento. Quitar /photos, /reels y parámetros de seguimiento antes de guardar un handle de Facebook.

### Verificar enlaces antes de guardarlos — instrucción del editor, 12 de noviembre de 2026

Abrir **cada URL externa exacta** antes de incorporarla a la ficha, biografía o manifiesto como enlace activo, incluso cuando la proporcione una fuente aparentemente oficial o figure en una cuenta social. Confirmar que la página final carga, contiene información útil y pertenece al artista o recurso correcto; revisar redirecciones y destino final. Un HTTP exitoso, una portada vacía, una página «not found», una página de cuenta inexistente o un dominio que sólo abre su inicio no bastan. Para un handle, probar también la URL que construirá Mangulina con el valor normalizado. Registrar URL consultada, destino final, fecha y resultado en el manifiesto.

Si el enlace está roto, vacío, inaccesible o apunta a otra identidad, **dejar el campo sin valor y no publicarlo**. Conservar la URL fallida como evidencia de investigación, marcada explícitamente como no válida; no inventar una variante ni sustituirla por una cuenta homónima. Si un lector web falla, comprobar con el navegador disponible antes de decidir. Al guardar, probar de nuevo el enlace renderizado en la página pública. Esta comprobación posterior no sustituye la verificación previa.

Consultar el selector actual, no solo ROLE_DICTIONARY.md. Para un acordeonista cuyo selector no ofrece accordionist: usar musician como rol principal y accordionist como otra ocupación, si corresponde a su práctica documentada. No insertar un valor fuera del selector mediante SQL para sortear una limitación visual. En instrumentos, usar voice cuando esa sea la opción vigente, sin crear una segunda variante vocals.

Revisar artist_tags: christian o secular según repertorio documentado. No marcar ambas por defecto ni deducir christian de agradecimientos religiosos, conciertos patronales o creencias personales. No agregar legend/emerging sin evidencia y criterio editorial.

Aplicar la regla de higiene ya establecida en EDITORIAL_BIOGRAPHY_FORMAT.md: `genres` no repite `primary_genre`, igual que `occupations` no repite `primary_role`. Por ejemplo, con `primary_genre = merengue` y sin otros géneros verificados, guardar `genres = []`, no `["merengue"]`. No marcar la casilla Merengue en Musical Genres para reiterar el género ya seleccionado como principal. Si se cambia el género principal, revisar la lista adicional para evitar duplicados y conservar sólo otros géneros sustentados por fuentes. **Nunca inventar géneros o subgéneros musicales**: todos los géneros asignados a la ficha o nombrados en la biografía deben provenir estrictamente de la taxonomía oficial existente en la tabla `genres` (por ejemplo, «merengue jocoso» no existe en Mangulina y no debe usarse ni asignarse). Si un género no se encuentra en la base de datos, preguntar siempre al editor antes de crearlo o introducirlo.

## 4. Guardar con límites y comprobar persistencia

Preferir el API o editor administrativo y enviar solo los campos modificados. Mantener artistas nuevos en draft. Las biografías se guardan por el editor o endpoint de documentos, no en el payload de artistas. Tras completar y validar cada idioma, usar Publish para dejar ambos documentos en published; Save draft sirve para trabajo incompleto y no es el estado final de una biografía terminada. Respetar revisión y referencias. No publicar la ficha del artista para previsualizarla. Las columnas birth_day y birth_month son generadas y no se escriben.

Al trabajar en varias fichas consecutivas en el administrador, recargar `/admin/artists` antes de seleccionar cada artista y abrir `Edit Biography` desde esa selección nueva. El encabezado de la ficha puede cambiar antes de que termine de cargar el documento del artista anterior. Antes de pulsar `Publish`, comprobar juntos el nombre de la ficha, el comienzo real del texto en el editor y la revisión esperada; si alguno no corresponde, detenerse y recargar, sin publicar. Tras guardar, confirmar que la revisión aumenta y que la página pública de **ese mismo artista** muestra el contenido correcto en ambos idiomas. No encadenar publicaciones de artistas distintos en un editor que conserva un documento previo. Si se atribuye contenido a la ficha equivocada, detener el lote, restaurar documento y espejo desde las versiones verificadas, refrescar las páginas afectadas y comparar todas las fichas tocadas antes de seguir.

Los estados son independientes: getArtistProfile (src/lib/artistApi.ts) exige artists.status = published para servir la ficha pública; el lector de biografías (src/lib/editorial/publicData.ts) exige editorial_documents.status = published. Por eso una biografía publicada no hace pública la ficha de un artista en draft, mientras que una biografía que siga en draft no aparecerá al publicar posteriormente al artista. Esta regla describe la página pública del artista; no implica cambiar permisos ni garantías sobre otros canales de acceso.

No cambiar código, esquema o seguridad para acomodar una ficha. Si un campo no puede representarse con las opciones actuales, documentar el problema y resolver el valor dentro del alcance autorizado. No usar escrituras directas para introducir un valor que el formulario no reconoce.

## 5. Puerta de entrega

### Revisión de menciones anteriores — 24 de octubre de 2026

Al crear o completar una ficha y nuevamente al publicarla con autorización,
buscar su nombre canónico y variantes documentadas en las biografías
estructuradas existentes de ambos idiomas. Revisar menciones en texto plano o
entre comillas angulares, aunque la validación de integridad no señale errores.
No basta con recordar conversaciones ni con enlazar colaboradores desde la
biografía nueva: comprobar también quién ya mencionaba al artista.

Confirmar cada identidad por contexto y registrar artista propietario, UUID de
documento, idioma, revisión, texto exacto y UUID de destino. Dentro del alcance
autorizado, convertir sólo la mención comprobada en artistReference, conservando
la prosa y las referencias existentes; usar nombre canónico, occurrenceId nuevo
y el ciclo de guardado editorial para sincronizar la relación y el espejo.
No inventar frases recíprocas. Seguir el procedimiento completo de
EDITORIAL_BIOGRAPHY_FORMAT.md, Required backward-reference audit.

La revisión es obligatoria; cambiar una biografía ya pública o de otro artista
sigue sujeto a las autorizaciones existentes. Si falta alcance para corregir,
entregar la lista concreta de menciones pendientes y no declarar completos los
enlaces recíprocos. Ejemplo: al completar Martox, revisar las menciones «Martox»
que ya existían en Solo Fernández, en español e inglés.

### Evitar 404 persistentes al publicar — 23 de octubre de 2026

Mientras la ficha siga en borrador, verificarla y construir su discografía en el editor administrativo y la base de datos. No abrir la URL pública del artista para previsualizar un borrador: devuelve un 404 legítimo que puede quedar en caché. Esto no impide guardar discografía autorizada en un artista draft.

Al publicar con autorización, invalidar siempre las rutas concretas del artista en ambos idiomas, aunque nunca haya tenido una ficha pública: otra persona o un bot pudo solicitar antes esa URL. Usar el mecanismo administrativo existente; si se publica directamente en la base de datos, realizar una única actualización dirigida por slug después del lote. Comprobar que la respuesta pública muestra al artista, no sólo que el endpoint de actualización devuelva éxito. Si sigue en 404, conservar evidencias y revisar la invalidación; no recrear la ficha, reimportar música, alternar estados ni vaciar la caché global. En Next.js, los paths concretos usan revalidatePath(path) sin el argumento de patrón "page".

Después de guardar, recargar y seleccionar nuevamente al artista. Verificar en el formulario que tipo, rol principal, sexo/género, etiqueta, género musical, instrumentos, handles y Spotify aparecen seleccionados o poblados; verificar también la base de datos contra el manifiesto. Probar nuevamente que los enlaces reconstruidos llevan a las cuentas correctas y no a subpáginas accidentales, conforme a la verificación previa obligatoria de la sección 3.

Comprobar expresamente que `genres` no contiene el valor de `primary_genre` y que `occupations` no contiene `primary_role`. Una selección visual correcta no sustituye esta comprobación de los valores persistidos. Esta instrucción no autoriza limpiar registros existentes fuera del alcance solicitado.

Validar las dos biografías con el validador e informe de integridad existentes. Comprobar sus títulos y referencias, y revisar visualmente el contenido guardado. Recargar y confirmar artists.status = draft y ambos editorial_documents.status = published; registrar UUIDs y revisiones. Si alguna biografía está incompleta o bloqueada por validación, conservarla en draft y declarar ese pendiente, sin publicar contenido inválido. No confundir validación de JSON con una ficha completa. Tras escrituras directas autorizadas, refrescar las cachés mediante el mecanismo existente y registrar el resultado.

Una relación `artist_relationships` aparece en las dos fichas. Si se guarda directamente en la base de datos, invalidar mediante el mecanismo administrativo existente las rutas EN/ES del artista de origen **y** las del artista de destino; una fila correcta en la base no basta mientras una de las páginas públicas conserve su caché. Comprobar el vínculo desde ambos lados sin repetir ni alterar la relación para forzar una actualización general de catálogos.

Entregar valores corregidos, UUID, estado, fuentes, archivos de auditoría, comprobaciones reales y pendientes. Distinguir «borrador creado con campos pendientes» de «ficha completa». No afirmar que fecha, lugar o Spotify se verificaron si solo se encontraron candidatos. Conservar los informes históricos; una corrección nueva debe documentarse por separado.
