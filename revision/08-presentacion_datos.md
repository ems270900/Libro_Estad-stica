# Capítulo 8. Presentación de datos: cuadros y gráficos

Fecha: 2026-11-25. Estado: borrador.

- Escrito: presentación en texto, cuadro y gráfico; cuadros de frecuencia de variables cualitativas (absoluta, relativa, acumulada para ordinales); gráfico circular frente a barras; frecuencias agrupadas (regla de Sturges, ancho de clase, marca de clase, frecuencias acumuladas); histograma, polígono de frecuencias y ojiva; cuadros de contingencia con porcentajes por fila; dispersión; series de tiempo; qué gráfico usar y errores de presentación (eje truncado, 3D, pasteles con muchas categorías, doble eje).
- Sin epígrafe (decisión del autor, 2026-11-25).
- Interactivo: lectura de la ojiva de la lluvia máxima (`#fig-pres-interactivo`). No repite el del capítulo 4 (ancho de clase).
- Ejemplos: frecuencias del material y el estado de los puentes; cuadro de frecuencias agrupadas de la lluvia máxima (65 años, 7 clases de 16 mm, verificado en R: 14, 26, 14, 4, 6, 0, 1); cuadro de contingencia material × estado.
- Paquete nuevo: patchwork, solo para poner dos gráficos de ggplot2 lado a lado (se dice en el texto).
- Fuentes: Illowsky y Dean (2013), Lane (s.f.), Sturges (1926), Wilke (2019), Healy (2018), Helsel et al. (2020), Chang (2018).
- Las series de lluvia y caudal son reales y van anonimizadas (decisión del autor).

## Ampliación (2026-11-25)

- Nuevo: percepción visual de Cleveland y McGill (1984) y cuándo sí sirve un gráfico circular; diagrama de Pareto con ejemplo completo de causas de atraso en obras (gestión de proyectos; Montgomery, 2013); diagrama de tallo y hojas (`stem()`, Tukey, 1977) y gráfico de puntos; reglas de Scott (1979) y de Freedman y Diaconis (1981) en un recuadro "Para profundizar"; anatomía del histograma; seis formas de histograma con su mecanismo; aviso sobre picos con pocos datos; barras agrupadas, apiladas y al 100 %; media móvil de 11 años en la serie de caudales; factor de mentira de Tufte (2001).
- Figuras nuevas (propias): gráfico de puntos de la lluvia, anatomía del histograma, galería de formas, Pareto en R base y ggplot2, tres tipos de barras, media móvil.
- Interactivos nuevos: ancho y punto de partida de las clases (`#fig-pres-int-origen`); inicio del eje y factor de mentira (`#fig-pres-int-eje`).
- Ejercicios 9 a 13 nuevos (ambiental: quejas de un acueducto; hidráulica; lectura de interactivos).
- Fuentes nuevas verificadas (DOI en Crossref): Cleveland y McGill (1984), Scott (1979), Freedman y Diaconis (1981); libros: Tufte (2001), Montgomery (2013).
