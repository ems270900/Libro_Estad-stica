# Capítulo 4. Gráficos en R

Fecha: 2026-11-25. Estado: borrador.

- Escrito: qué gráfico usar según la variable, gráficos de R base (barras, histograma, caja, líneas), gramática de ggplot2, geometrías, paneles, estilo y `ggsave()`.
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).
- Interactivo: ancho de clase de un histograma (`#fig-graf-interactivo`).
- Ejemplo: histograma de la resistencia a 28 días con clases de 2 MPa; frecuencias verificadas en R (1, 1, 6, 7, 2, 8, 4, 1).

## Ampliación (2026-11-25, rama `claude/ampliar-parte-1`)

- Agregado: Detalles en R base (líneas, `abline`, leyenda, `par(mfrow)`); colores, escalas y temas; líneas de referencia por faceta; barras calculadas con `geom_col`; tendencias con `geom_smooth`; cuadro de errores frecuentes; interactivo del gráfico capa por capa (`int-capas`); ejemplo del umbral de 800 veh/h (5 horas en día laboral, 0 en fin de semana); ejercicios 8 a 12.
- Pendiente: revisión del autor.

## Segunda ampliación (2026-11-25, rama `claude/parte-1-didactica`)

- Agregado: Diagrama de caja completo: partes con figura anotada, cuándo conviene y cuándo no (pocos datos, datos bimodales), ejemplo resuelto de atípicos en tiempos de recorrido de un bus (Q1 20.45, mediana 21.50, Q3 23.15, RIC 2.70, vallas 16.40 y 27.20, atípico 34.6), variantes (horizontal, muescas, ancho variable, con puntos, violín, dos variables) [@mcgill1978variations; @hintze1998violin], diferencia de cuartiles entre `boxplot()` y `geom_boxplot()` [@hyndman1996sample] e interactivo (`int-caja`). Barras: cuándo usarlas, eje desde cero, variantes agrupadas, apiladas, de proporción y horizontales ordenadas [@cleveland1984graphical]. Histograma: formas típicas con `airquality` y `faithful`, cuándo usarlo, densidad. Dispersión: patrones, causalidad, variantes. Líneas: cuándo usarlas y huecos.
- Pies de figura y títulos de cuadro acortados. Pendiente: revisión del autor.

## Cambios del 2026-11-25: límites de Tukey y reorganización de gráficos

- Terminología: "vallas" pasa a "límite inferior" y "límite superior" (Q1 − 1.5 RIC y Q3 + 1.5 RIC), como en el material del curso; se aclara que el bigote termina en un dato y no en el límite. Objetos de R `lim_inf` y `lim_sup`.
- Reorganización aprobada por el autor: el capítulo queda con cómo se hace cada gráfico en R (código, opciones, guardar). La explicación conceptual pasó a los capítulos 8 (barras, histograma, dispersión, líneas) y 9 (caja), con referencias cruzadas en ambos sentidos.
- Quitadas por duplicar figuras de los capítulos 8 y 9: `fig-graf-caja-partes`, `fig-graf-caja-bimodal`, `fig-graf-barras-eje`, `fig-graf-hist-formas` y el interactivo `fig-graf-caja-int` (lo cubren `fig-med-int-caja` y `fig-med-calculadora`). `fig-graf-dispersion-patrones` se movió al capítulo 8 con la misma etiqueta. `fig-graf-barras-variantes` ahora muestra su código.
