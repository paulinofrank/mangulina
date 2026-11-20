# Grupo Hope — verificación y ficha preparada (2026-11-07)

**Corrección posterior:** el editor aclaró que Hope es una plataforma de adoración, no una entidad artística de tipo `group`. La ficha descrita abajo queda marcada como clasificación errónea y pendiente de la corrección destructiva documentada en [grupo-hope-entity-correction-2026-11-07.md](grupo-hope-entity-correction-2026-11-07.md). No usar este informe como precedente para crear otra ficha de artista para Hope.

## Alcance y resultado

El editor aportó Facebook, YouTube, Instagram y Spotify como seguimiento a la investigación de relaciones de Hope. No había ninguna ficha coincidente por nombre, slug, alias o Spotify. Se creó `Grupo Hope` (`04788dac-8c1b-40ec-8c3e-c6a375838f20`) como **draft**, con biografías EN/ES estructuradas y **published**, revisión 1. Se añadió la relación `founder_of` de Junior Ponciano (`409d3939-d5b7-47d8-b72d-206e01542d3e`). No se importó discografía ni se cambió ninguna ficha ajena.

## Identidad y evidencia

| Hecho | Evidencia | Decisión |
| --- | --- | --- |
| `Grupo Hope` y `Hope W Music` son dos nombres públicos del mismo proyecto | El canal oficial [@GrupoHopew](https://www.youtube.com/@GrupoHopew), visto en Chrome el 7 de noviembre de 2026, se titula Grupo Hope y dice en su descripción «El Proyecto Musical Hope W Music nació en el corazón de Junior Ponciano». Publica «Rodeado», «Kadosh» y «Te Mostraré Mi Gloria», los mismos títulos del [Spotify](https://open.spotify.com/artist/0EmliyVpOhBPUadxwy5n2u) acreditado como Hope W Music. | Nombre Grupo Hope, alias Hope W Music, Spotify ID verificado. No abrir dos fichas. |
| Identificadores sociales | [Facebook oficial](https://www.facebook.com/GrupoHopew) se titula Grupo Hope y enlaza sus otras cuentas; [YouTube](https://www.youtube.com/@GrupoHopew) enlaza [Instagram](https://www.instagram.com/grupohopew/), que publica el mismo repertorio. | Guardados como handles: `GrupoHopew`, `@GrupoHopew`, `grupohopew`. |
| Junior Ponciano creó el proyecto | [Descripción del canal oficial](https://www.youtube.com/@GrupoHopew), verificada directamente en Chrome. | `founder_of` sin fecha de inicio porque el texto oficial no la especifica. |
| Modelo de voces variables | La descripción oficial explica que Hope W Music reúne «diferentes voces, cantantes y adoradores». | Carolina Ponciano, Misael J y otros colaboradores figuran en las biografías como invitados, sin `member_of`. |
| Música y cronología | [«Espíritu Santo (Live)» (2019)](https://music.apple.com/us/album/esp%C3%ADritu-santo-live/1591114171?i=1591114173), [«Dios de Gloria (Live)» (2020)](https://music.apple.com/us/album/dios-de-gloria-live/1591114266?i=1591114267), [«Rodeado» (2022)](https://music.apple.com/us/song/1628975442), [«Kadosh» (2023)](https://music.apple.com/us/album/kadosh-feat-averly-morillo-single/1700621106), [«Alfa & Omega» (2024)](https://music.apple.com/us/album/alfa-omega-ep/1774969309), [«Te Mostraré Mi Gloria» (2026)](https://www.qobuz.com/us-en/album/te-mostrare-mi-gloria-hope-w-music-amp-carolina-ponciano-amp-karen-ponciano-ministry/uvzmsj2gyjmip). El canal oficial confirma los nombres de invitados de sus videos. | Sólo contexto biográfico; ninguna importación musical. |

## Límites

- [Una crónica de 2018](https://diariosocialrd.com/pastor-junior-ponciano-presenta-su-libro-no-soy-santo-gaste-su-gracia/) documenta el debut de «Hope Worship», pero no demuestra formalmente que ya usara la identidad actual. El año de formación queda vacío.
- Las fuentes ubican actividades y la iglesia de Junior en Santo Domingo Este, pero no establecen explícitamente la ciudad de formación de Grupo Hope. `birth_place` (Origin) y `province` permanecen vacíos.
- El catálogo de Apple Music contiene un segundo perfil «Grupo Hope» y títulos en portugués bajo «Hope W Music» que no se adjudican a esta ficha por nombre solamente. Se debe resolver la identidad de cada edición antes de una futura discografía.
- Falta una imagen oficial con derechos de uso comprobados. No se modificó `has_image` ni se usó una portada como retrato.
- Las biografías públicas de Carolina y Junior aún mencionan a Grupo Hope en texto sin vínculo, porque el nuevo artista continúa en draft. Al publicar la ficha con autorización separada, enlazar esas referencias y refrescar sólo las páginas afectadas.

## Comprobaciones

El manifiesto exacto está en `grupo-hope-change-manifest-2026-11-07.json`; los textos fuente en `grupo-hope-content-2026-11-07.json`. El constructor pasó `validateEditorialDocument` para ambos idiomas antes de guardar. La lectura posterior confirmó artista `draft`, `spotify=0EmliyVpOhBPUadxwy5n2u`, alias, cuatro identificadores normalizados, sin origen ni año de formación inventados, espejos EN/ES de 1667/1753 caracteres, dos documentos `published` revisión 1 con nueve bloques cada uno y 10 referencias sincronizadas por idioma. La relación de Junior se leyó de vuelta con año de inicio y fin nulos. No hubo despliegue, invalidación de caché ni visita a una URL pública de borrador.
