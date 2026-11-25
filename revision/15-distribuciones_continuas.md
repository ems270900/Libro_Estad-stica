# Capítulo 15. Distribuciones continuas

Fecha: 2026-11-25. Estado: borrador.

- Escrito: parámetros de localización, escala y forma; uniforme continua; exponencial deducida desde la Poisson, falta de memoria; gamma (Erlang y FDA con la Poisson para α entero); beta; log-normal (cálculo con la normal estándar); Weibull y lectura física del parámetro de forma; cuadro para elegir y advertencia de no promediar modelos.
- Base: diapositivas de la semana 5; @illowsky2018introductory cap. 5; @wasserman2004all cap. 2 (densidades gamma, beta y log-normal).
- Ejemplos (con Solución:, pseudocódigo y R): tiempo entre tormentas (exponencial), días entre fallas de bombas con datos descargables (ajuste, mediana y cuantiles), vida útil de apoyos de neopreno (Weibull, con simulación).
- Figuras propias con R: histograma de los días entre fallas con la densidad ajustada, familia gamma.
- Interactivo: seis distribuciones con parámetros y área P(X ≤ x0) por integración numérica (`#fig-cont-interactivo`); sus resultados se compararon con `pgamma()`, `pweibull()`, `plnorm()` y `pbeta()` y coinciden a cuatro decimales.
- Correcciones respecto a las diapositivas: en el ejemplo de las tormentas, E(T) = 45 h y Var(T) = 2025 h² (la diapositiva escribía 1/45); la Weibull se escribe con forma α y escala β, igual que `dweibull()`.

## Ampliación (2026-11-25)

- Agregado: flujo de cuatro pasos para usar una distribución, papel de los parámetros de localización, escala y forma, cuándo usar la uniforme y transformación inversa (para profundizar), proceso de Poisson visto en dos escalas, gamma y Pearson III en hidrología, formas de la beta, origen multiplicativo de la log-normal y paso de media y CV a sus parámetros, función de riesgo y curva de la bañera para la Weibull, sección nueva de la distribución de Gumbel (caudal máximo anual con datos descargables, método de momentos, caudales de 10, 50 y 100 años), resumen con Gumbel y sección de errores comunes.
- Citas nuevas: @chow1988applied, @gumbel1958statistics, @weibull1951statistical.
- Figuras nuevas: papeles de los parámetros, proceso de Poisson, formas de la beta, log-normal en escala logarítmica, curva de la bañera, ajuste de Gumbel con posición de graficación de Weibull.
- Interactivo nuevo (`#fig-cont-int-poisson`): llegadas de un proceso de Poisson con sus conteos y sus tiempos de espera.
- Ejercicios 10 a 13 y lecturas recomendadas.
