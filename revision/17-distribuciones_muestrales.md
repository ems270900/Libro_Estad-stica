# Capítulo 17. Muestreo, distribuciones muestrales y teorema del límite central

Fecha: 2026-11-25. Estado: borrador. Capítulo nuevo respecto al curso.

- Escrito: población, muestra, parámetro y estadístico; muestreo aleatorio simple; distribución muestral de la media construida por simulación y error estándar; corrección por población finita; teorema del límite central para medias y para sumas, con la regla n ≥ 30 y sus límites; distribución de la proporción muestral; chi-cuadrado, t y F como distribuciones muestrales, con la notación de las tablas del apéndice A.
- Base: @illowsky2018introductory cap. 7; @wasserman2004all caps. 2 y 5.
- Ejemplos (con Solución:, pseudocódigo y R): probabilidad de un tiempo promedio alto con la población de tiempos de viaje descargable (fórmula y simulación); comprobación por simulación de la distribución de (n − 1)S²/σ².
- Figuras propias con R: población y medias muestrales, cuadrícula del teorema del límite central (tres poblaciones y cuatro tamaños), t contra normal, histograma de la chi-cuadrado simulada. Los bloques de simulación llevan `cache: true`.
- Interactivo: teorema del límite central con cinco poblaciones, n de 1 a 100 y botón para repetir el muestreo (`#fig-muestreo-interactivo`).
