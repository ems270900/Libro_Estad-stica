# Capítulo 24. Asociación y correlación

Fecha: 2026-11-25. Estado: borrador.

- Escrito: asociación y diagrama de dispersión; covarianza; correlación de Pearson y sumas $S_{xx}$, $S_{yy}$, $S_{xy}$; referencias de Cohen (con aviso de que en ingeniería se quedan cortas); prueba $t$ para $\rho$ e intervalo con la transformación de Fisher (recuadro para profundizar); Spearman y Kendall (con $\tau_b$); cuál coeficiente usar; matriz de correlación; correlación y causalidad (variable de confusión); cuarteto de Anscombe; rango restringido.
- Base: diapositivas de la Semana 7 (Asociacion_Regresion_Manual.Rmd), @illowsky2018introductory cap. 12, @laneintroduction caps. 4, 10 y 14, @helsel2020statistical cap. 8, @ayala2026estadistica cap. 8, y las fuentes originales (@pearson1896mathematical, @spearman1904proof, @kendall1938new, @cohen1988statistical, @anscombe1973graphs).
- Ejemplos (Solución:, pseudocódigo, base R y función de R): correlación de las diez mezclas (cuadro de sumas a mano, `cov()`, `cor()`); prueba de la correlación (`cor.test()`); Spearman y Kendall para dos inspectores (conteo de pares con un ciclo `for`, `cor(method = )`, `cor.test(method = )`).
- El ejemplo de horas de estudio y notas de las diapositivas se sustituyó por mezclas de concreto, para mantener el contexto de ingeniería civil y no usar nada parecido a datos de estudiantes. El ejemplo de helados y rescates se cambió por caudal y deslizamientos (ambos dependen de la lluvia).
- Figuras propias generadas con R: cuatro patrones, dispersión de las mezclas, relación monótona no lineal, variable de confusión y cuarteto de Anscombe (datos `anscombe` de R, citados).
- Interactivo: nube de 60 puntos con $\rho$ elegido y un dato atípico opcional, con Pearson y Spearman en vivo (`#fig-cor-interactivo`).
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).

## Cambios (2026-11-25): ejemplos de otras ramas

- A pedido del autor (menos ejemplos de concreto), el hilo de las diez mezclas agua/cemento pasa a velocidad contra densidad del tránsito en diez periodos hipotéticos de un tramo de autopista (modelo de Greenshields, `@greenshields1935study`, entrada nueva en `references.bib`). Datos: `datos/greenshields_tramo_hipotetico.csv` (semilla 1935 en `herramientas/datos_parte6.R`), que reemplaza a `mezclas_ac_hipoteticas.csv`.
- Cifras a mano verificadas con R 4.3.3: x̄ = 42, ȳ = 54.30, Sxx = 4240, Syy = 2675.92, Sxy = −3346.8, r = −0.994, t = −24.87, b0 = 87.452, b1 = −0.78934, SSE = 34.158, R² = 0.987, s = 2.066, F = 618.7, ŷ(40) = 55.88 con intervalos 54.36–57.39 (media) y 50.88–60.88 (predicción); en el capítulo 27, periodo 8 con h = 0.176, r = 1.92 y D = 0.397.
- Interactivos actualizados con los datos nuevos. Etiquetas sin renombrar (`fig-cor-mezclas`, `tbl-cor-mano`, etc.).
