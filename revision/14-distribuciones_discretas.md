# Capítulo 14. Distribuciones discretas

Fecha: 2026-11-25. Estado: borrador.

- Escrito: distribuciones con parámetros y las funciones d, p, q y r de R; uniforme discreta; Bernoulli y proceso de Bernoulli; binomial (con su deducción desde el coeficiente binomial); geométrica y su relación con el periodo de retorno; binomial negativa; hipergeométrica y factor de corrección por población finita; Poisson con ajuste de λ al intervalo; aproximación de Poisson a la binomial; cuadro para elegir la distribución.
- Base: diapositivas de la semana 5 (Distribuciones_Parametricas.Rmd); @illowsky2018introductory cap. 4 (condiciones del proceso de Bernoulli y de la Poisson, regla n ≥ 20 y p ≤ 0.05).
- Ejemplos (con Solución:, pseudocódigo y R): cilindros que no cumplen (binomial), sondeos SPT hasta encontrar arcilla expansiva (geométrica), aditivo para concreto (binomial negativa), inspección de un lote de barras (hipergeométrica contra binomial), llegadas de camiones a una planta con datos descargables (ajuste de Poisson y comparación de frecuencias).
- Advertencias sobre cómo cuentan `dgeom()` y `dnbinom()` (fracasos, no ensayos) y sobre los argumentos de `dhyper()`.
- Interactivo: binomial, Poisson, geométrica y binomial negativa con parámetros y umbral k (`#fig-disc-interactivo`); probado en el navegador contra `pbinom()`.
- Correcciones respecto a las diapositivas: la binomial negativa se presenta como número de ensayos hasta el éxito k, con media k/p (la diapositiva daba k(1 − p)/p, que es la media del número de fracasos); el ejemplo del lago Cayuga no se usó porque mezclaba n = 230 y n = 10.
- Diversificación de ramas (2026-11-25): el ejemplo de la binomial negativa pasa de un aditivo para concreto a pozos de monitoreo junto a un derrame de combustible (mismos números, P = 0.1866 y E(X) = 8.33).

## Ampliación (2026-11-25)

- Agregado: independencia en el proceso de Bernoulli y cuadro de las tres preguntas (binomial, geométrica, binomial negativa), árbol de tres ensayos, cómo reconocer una binomial y cuándo no usarla, sección "Periodo de retorno y riesgo de excedencia" (alcantarilla de 25 años en 30 años de vida útil, con simulación), sobredispersión, regla del 5 % para la hipergeométrica, historia de Bortkiewicz, formas de la Poisson, aditividad, cuándo no usar la Poisson, red de relaciones entre discretas y sección de errores comunes.
- Citas nuevas: @bortkiewicz1898gesetz, @chow1988applied, @montgomery2014applied cap. 3.
- Figuras nuevas: árbol de Bernoulli y red de relaciones con el estilo común de diagramas (`R/diagramas_red.R`), riesgo de excedencia, hipergeométrica contra binomial, formas de la Poisson.
- Interactivo nuevo (`#fig-disc-int-riesgo`): riesgo de excedencia según el periodo de retorno y la vida útil.
- Pendiente: fuente normativa del criterio de 10 % de excedencia en 50 años (475 años), marcada con CITA PENDIENTE.
- Ejercicios 10 a 12 y lecturas recomendadas.
