# El Fiera — revisión de ficha y biografías

**Fecha:** 2026-11-07  
**Artista:** `92169757-a877-433f-9dcf-5f8a5ad90d3f` (`el-fiera`)  
**Alcance autorizado:** revisión de esta ficha pública y sus biografías ES/EN. Sin cambios de discografía, relaciones, publicación, código ni seguridad.

## Fuentes y comprobaciones

- [Web oficial — biografía](https://el-fiera-official.lovable.app/biografia): confirma nacimiento en Santo Domingo, residencia en Córdoba, géneros y repertorio. El enlace a esta web aparece en una publicación del [Facebook personal vinculado al artista](https://www.facebook.com/danielitoswagtt.garcia). La web remite al mismo [Spotify](https://open.spotify.com/artist/5Zn4k0gLr9pfu64NUSkfER), Instagram y YouTube ya guardados en Mangulina.
- [Web oficial — música](https://el-fiera-official.lovable.app/musica): destaca «UN DOMINGO», el EP, «Me voy rulay», «Fenómeno» y «Contacto» con Hampa. «Haciendo historia» aparece allí, pero aún no se encontró un registro independiente de lanzamiento; queda fuera de la bio.
- [Apple Music — artista](https://music.apple.com/us/artist/el-fiera/1783850047): documenta los sencillos de 2024–25, las colaboraciones visibles, y el EP de seis canciones «MÁS DEMBOW» fechado el 19 de diciembre de 2025.
- [Apple Music — «Me voy rulay»](https://music.apple.com/us/album/me-voy-rulay-feat-shadowonthebeat-single/1785524939): 23 de diciembre de 2024 y participación de ShadowOntheBeat.
- [Apple Music — «UN DOMINGO»](https://music.apple.com/us/album/un-domingo-feat-shadowonthebeat-single/1793909147): 28 de enero de 2025 y participación de ShadowOntheBeat.
- [Apple Music — «Más loco que jackas»](https://music.apple.com/us/album/m%C3%A1s-loco-que-jackas-single/1785365334): fecha mostrada de 10 de julio de 2017, pero copyright de 2024. No se halló prueba contemporánea de su publicación en 2017. Por tanto, se retira la afirmación de que fue el inicio documentado de su carrera en 2017; no se altera por ello la fecha guardada en discografía sin su revisión específica.
- El nombre personal completo y el 17 de febrero de 1997 proceden del expediente editorial anterior de Mangulina, que registra confirmación del editor pero no cita una fuente pública concreta. Se conservan como datos aportados por el editor; esta revisión no los presenta como comprobados de manera independiente.

## Manifiesto de cambios

| Registro/campo | Antes | Después |
|---|---|---|
| `artists.website` | `null` | `https://el-fiera-official.lovable.app` |
| `artists.disambiguation` | `Dominican urban artist from Santo Domingo, based in Spain` | `Dominican urban singer from Santo Domingo, based in Córdoba, Spain` |
| Biografía ES, revisión 2 | Un párrafo cronológico denso con comienzo de carrera en 2017 y cierre promocional | Revisión 3: cronología documentada de 2024–26, Córdoba y cierre descriptivo |
| Biografía EN, revisión 2 | Mismas afirmaciones en inglés | Revisión 3 equivalente |
| `artists.bio_es` y `artists.bio_en` | Espejos de revisión 2 | Espejos Markdown de revisión 3 |

Se mantienen nombre, fecha de nacimiento, lugar de nacimiento, provincia, géneros, redes, Spotify, imagen y estado publicado. No hay referencias estructuradas nuevas: ShadowOntheBeat, Hampa y Jhoansito Bo aún no tienen ficha coincidente en el catálogo.

La web oficial enlaza TikTok `@fieraswag`, pero `artists` no dispone de un campo TikTok; no se intenta introducirlo en otro campo ni cambiar el esquema.

## Pendientes separados

- Investigar la fecha original de «Más loco que jackas» con evidencia contemporánea antes de corregir su ficha discográfica.
- Comprobar si «Haciendo historia» corresponde a una grabación publicada o solo a material promocionado en la web oficial.
- Verificar externamente el nombre completo y la fecha de nacimiento si el editor aporta documento o declaración primaria.

## Ejecución y verificación

- Se actualizaron `artists.website`, `artists.disambiguation`, `artists.bio_es` y `artists.bio_en` para `92169757-a877-433f-9dcf-5f8a5ad90d3f`.
- Las dos filas `editorial_documents` permanecen en `published` y pasaron de revisión 2 a revisión 3; ambas contienen ocho párrafos. La validación de documentos se ejecutó durante `upsert_editorial_document`.
- Una lectura posterior de base de datos confirmó la web, la desambiguación y que la afirmación de 2017 ya no aparece en ninguno de los dos espejos Markdown.
- Primer intento de refresco dirigido: falló por conectividad de la red restringida, sin confirmar invalidación. Segundo intento, con permiso de red: correcto, `artists=1`, `songs=0`, `releases=0`, `allArtists=false`.
- Se abrieron únicamente las páginas públicas ES y EN de `el-fiera`. Ambas mostraron la nueva biografía y el enlace a la web oficial. No hubo despliegue ni verificación amplia de producción.
