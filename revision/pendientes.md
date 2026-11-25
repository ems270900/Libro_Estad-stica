# Trabajo pendiente del libro

## Antes de empezar los capítulos

- Lista de referencias bibliográficas base (la entrega el autor).
- Contenido, nivel y lista de capítulos (la entrega el autor).
- Cambios futuros de estética que decida el autor. Por ahora la portada usa la misma imagen del libro de hidrología (`assets/img/ciclo_h.png`, USGS).

## Parte I (R y RStudio)

- Capturas de pantalla de RStudio, CRAN y Posit: ya están en `assets/img/cap01/`, `cap03/` y `cap05/` (RStudio 2026.11.1, R 4.6.2). Falta integrarlas en el texto y actualizar en el capítulo 1 la dirección de descarga de RStudio, que ahora es <https://docs.posit.co/ide/user/download.html>.
- El HTML de un solo archivo necesita MathJax; en la nube de este proyecto el CDN está bloqueado, así que se compila en un entorno con red abierta.
- Revisión del autor de los capítulos 1 a 6.

## Parte II (estadística descriptiva)

- Fuente y permiso de las series reales de lluvia máxima diaria (1956–2020) y de caudal máximo anual (1966–2018), tomadas del material del curso. Mientras tanto se presentan sin identificar la estación.
- Cita del Código Sísmico de Costa Rica en el capítulo 7 (CITA PENDIENTE).
- Confirmar la página del epígrafe de Box (1979) y si se quiere otro epígrafe en el capítulo 8 (repite el de Tukey del capítulo 4).
- Revisión del autor de los capítulos 7 a 9.
## Parte III (Probabilidad)

- Revisión del autor de los capítulos 10 a 12.
- Los datos de atrasos de obra, de varillas, de plantas de concreto y de ensayos en pilotes son hipotéticos. Si el autor tiene datos reales publicables (por ejemplo, de un informe de laboratorio con permiso), se pueden sustituir.
- Epígrafes: el del capítulo 10 es de Laplace (*Essai philosophique sur les probabilités*, 1814) y el del capítulo 12 de Joseph Butler (*The Analogy of Religion*, 1736, introducción). El capítulo 11 no lleva epígrafe porque no se encontró uno con fuente verificable; el autor puede proponer uno.
- `laneintroduction` y `watkinsintroduction` no tienen año de publicación en el PDF; salen como "s. f.". Confirmar si el autor prefiere otra edición fechada.

## Parte IV (variables aleatorias y distribuciones)

- Revisión del autor de los capítulos 13 a 17.
- Todos los datos de la parte son hipotéticos (`herramientas/datos_parte4.R`). Si el autor tiene series reales publicables (llegadas de camiones, fallas de bombas, resistencias de una obra), se pueden sustituir sin cambiar el texto de los métodos.
- Epígrafes: capítulo 13, Laplace (*Essai philosophique sur les probabilités*, 1814), el mismo autor que el del capítulo 10; el autor puede preferir otro. Capítulo 15, Box y Draper (*Empirical Model-Building and Response Surfaces*, 1987; la frase está en la p. 424 según las citas habituales, confirmar con el libro). Los capítulos 14, 16 y 17 no llevan epígrafe.
- Las diapositivas de la semana 4 traían datos de huracanes atribuidos a la NOAA; no se usaron porque no se pudo verificar la fuente exacta.
- El capítulo 16 menciona la resistencia característica del concreto sin dar el criterio de un código; si el autor quiere, se agrega el criterio del código que use el curso, con su cita.

## Apéndices

- Apéndice B: las funciones de las partes II a VII se anotaron con el capítulo previsto en la estructura. Al cerrar cada parte se revisa qué funciones usa de verdad y se ajusta la columna "Cap." y las filas.
- Apéndice C: agregar los términos nuevos que aparezcan en las partes II a VII.
- Notación de las tablas: $z_\alpha$, $t_{\alpha,\nu}$, $\chi^2_{\alpha,\nu}$ y $F_{\alpha,\nu_1,\nu_2}$ dejan un área $\alpha$ a la derecha. Los capítulos 16 a 23 deben usar la misma convención.
- Revisión del autor de los tres apéndices.

## Decisiones del autor

- Publicación en la web: no se publica sin su permiso.
- Formato de salida: solo HTML por ahora.
- Título: Probabilidad e Inferencia Estadística Aplicada a la Ingeniería Civil. Subtítulo: Fundamentos, métodos y aplicaciones con R. Institución: Escuela de Ingeniería Civil, UCR (2026-11-24).
- "Material Eduardo": solo como referencia de consulta; no entra en el libro.
