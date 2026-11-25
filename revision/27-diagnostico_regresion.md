# Capítulo 27. Supuestos, diagnóstico y medidas remediales

Fecha: 2026-11-25. Estado: borrador.

- Escrito: supuestos LINE y consecuencias de su falla (cuadro); residuos estandarizados y estudentizados; patrones de residuos; los cuatro gráficos de `plot()`; pruebas de Shapiro-Wilk, Breusch-Pagan (versión de Koenker) y Durbin-Watson, con sus limitaciones; atípicos, apalancamiento ($h_{ii}$) e influencia (distancia de Cook); qué hacer con un punto influyente; cuadro de medidas remediales; transformaciones y su interpretación; Box-Cox; corrección del sesgo al volver de logaritmos (recuadro para profundizar); estrategia completa de un análisis de regresión.
- Base: diapositivas de la Semana 7, @montgomery2012introduction caps. 4 a 6, @fox2019companion cap. 8, @helsel2020statistical cap. 9 y las fuentes originales (@shapiro1965analysis, @breusch1979simple, @koenker1981note, @durbin1950testing, @cook1977detection, @box1964analysis).
- Ejemplos (Solución:, pseudocódigo, base R y función de R): curvatura en el modelo de los 48 cilindros y corrección con $\ln(\text{edad})$; apalancamiento, residuos estandarizados y Cook de las diez mezclas (a mano y con `hatvalues()`, `rstandard()`, `cooks.distance()`); caudal contra área de 20 cuencas (Breusch-Pagan a mano y con `lmtest::bptest()`, `MASS::boxcox()`, modelo log-log y predicción).
- Paquete nuevo: lmtest, para `bptest()` y `dwtest()`. MASS viene con R.
- Figuras propias: patrones de residuos, `plot()` del modelo de las mezclas, residuos contra edad, tres casos de atípico, apalancamiento e influencia, residuos de las cuencas.
- Interactivo: mezcla adicional movible con recta, $h$, $r$ y distancia de Cook en vivo (`#fig-diag-interactivo`).
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).

## Cambios (2026-11-25): ejemplos de otras ramas

- A pedido del autor (menos ejemplos de concreto), el hilo de las diez mezclas agua/cemento pasa a velocidad contra densidad del tránsito en diez periodos hipotéticos de un tramo de autopista (modelo de Greenshields, `@greenshields1935study`, entrada nueva en `references.bib`). Datos: `datos/greenshields_tramo_hipotetico.csv` (semilla 1935 en `herramientas/datos_parte6.R`), que reemplaza a `mezclas_ac_hipoteticas.csv`.
- Cifras a mano verificadas con R 4.3.3: x̄ = 42, ȳ = 54.30, Sxx = 4240, Syy = 2675.92, Sxy = −3346.8, r = −0.994, t = −24.87, b0 = 87.452, b1 = −0.78934, SSE = 34.158, R² = 0.987, s = 2.066, F = 618.7, ŷ(40) = 55.88 con intervalos 54.36–57.39 (media) y 50.88–60.88 (predicción); en el capítulo 27, periodo 8 con h = 0.176, r = 1.92 y D = 0.397.
- Interactivos actualizados con los datos nuevos. Etiquetas sin renombrar (`fig-cor-mezclas`, `tbl-cor-mano`, etc.).
