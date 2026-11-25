# Capítulo 7. La estadística en la ingeniería civil

Fecha: 2026-11-25. Estado: borrador.

- Escrito: qué es la estadística, descriptiva e inferencial, la estadística en el método de la ingeniería, población y muestra, parámetro y estadístico (con notación), unidad estadística, variable y observación (de las diapositivas de la semana 3), estudio observacional y experimento, métodos de muestreo, tipos de variables, escalas de medición de Stevens, tipos de variables en R (factores y factores ordenados) y aplicaciones por área de la ingeniería civil.
- Sin epígrafe (decisión del autor, 2026-11-25: el libro va sin epígrafes).
- Figuras: método de la ingeniería (redibujada en R con base en Montgomery y Runger, 2014, fig. 1-1); árbol de tipos de variables (propia); dos gráficos de la lluvia máxima diaria.
- Interactivo: población de 500 cilindros y muestras al azar de tamaño n (`#fig-est-interactivo`).
- Ejemplos: muestra aleatoria simple de 5 puentes (`sample()` y `slice_sample()`); tipos de variables del inventario de puentes (`factor()`, `glimpse()`); registro de lluvia máxima diaria (población, muestra, gráfico en R base y ggplot2).
- Fuentes: Illowsky y Dean (2013), Lane (s.f.), Montgomery y Runger (2014), Stevens (1946), Navidi (2006).
- Código Sísmico de Costa Rica citado (2026-11-25), junto con ASCE/SEI 7-22 para las combinaciones de carga. La serie de lluvia es real y va anonimizada (decisión del autor).

## Ampliación (2026-11-25)

- Nuevo: por qué varían los datos (variación natural, de ensayo, de muestreo y por falta de conocimiento; incertidumbre aleatoria y epistémica según Ang y Tang, 2007; analogía señal y ruido); figura de población, muestra e inferencia; datos ordenados (Wickham, 2014) con figura; variable de confusión (Freedman et al., 2007) y cuadro de estudio observacional contra experimento; cuadro de cuándo conviene cada método de muestreo (Lohr, 2019); sesgo y precisión con la analogía del tiro al blanco; cuadro de resúmenes y gráficos por tipo de variable; casos límite de la clasificación; recuadro de errores frecuentes (incluye sesgo de supervivencia).
- Figuras nuevas (propias): mediciones repetidas en cuatro ramas, población y muestra, datos ordenados, dianas de sesgo y precisión.
- Interactivos nuevos: cuatro métodos de muestreo sobre 48 alcantarillas (`#fig-est-int-metodos`); clasificador de variables con 16 casos de las seis ramas (`#fig-est-int-clasificar`).
- Ejemplo nuevo (transportes): muestreo sistemático de 30 núcleos en 12 km de pavimento, con cadenamiento km + m en R base y dplyr. Arranque con la semilla 2026: 220 m.
- Ejercicios 9 a 13 nuevos (ambiental, hidráulica, geotecnia, transportes).
- Fuentes nuevas verificadas: Ang y Tang (2007), Freedman, Pisani y Purves (2007), Lohr (2019), Wickham (2014, DOI verificado en Crossref).
