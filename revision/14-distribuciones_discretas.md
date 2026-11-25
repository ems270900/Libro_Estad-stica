# Capítulo 14. Distribuciones discretas

Fecha: 2026-11-25. Estado: borrador.

- Escrito: distribuciones con parámetros y las funciones d, p, q y r de R; uniforme discreta; Bernoulli y proceso de Bernoulli; binomial (con su deducción desde el coeficiente binomial); geométrica y su relación con el periodo de retorno; binomial negativa; hipergeométrica y factor de corrección por población finita; Poisson con ajuste de λ al intervalo; aproximación de Poisson a la binomial; cuadro para elegir la distribución.
- Base: diapositivas de la semana 5 (Distribuciones_Parametricas.Rmd); @illowsky2018introductory cap. 4 (condiciones del proceso de Bernoulli y de la Poisson, regla n ≥ 20 y p ≤ 0.05).
- Ejemplos (con Solución:, pseudocódigo y R): cilindros que no cumplen (binomial), sondeos SPT hasta encontrar arcilla expansiva (geométrica), aditivo para concreto (binomial negativa), inspección de un lote de barras (hipergeométrica contra binomial), llegadas de camiones a una planta con datos descargables (ajuste de Poisson y comparación de frecuencias).
- Advertencias sobre cómo cuentan `dgeom()` y `dnbinom()` (fracasos, no ensayos) y sobre los argumentos de `dhyper()`.
- Interactivo: binomial, Poisson, geométrica y binomial negativa con parámetros y umbral k (`#fig-disc-interactivo`); probado en el navegador contra `pbinom()`.
- Correcciones respecto a las diapositivas: la binomial negativa se presenta como número de ensayos hasta el éxito k, con media k/p (la diapositiva daba k(1 − p)/p, que es la media del número de fracasos); el ejemplo del lago Cayuga no se usó porque mezclaba n = 230 y n = 10.
