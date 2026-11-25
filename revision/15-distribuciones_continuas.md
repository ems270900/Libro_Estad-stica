# Capítulo 15. Distribuciones continuas

Fecha: 2026-11-25. Estado: borrador.

- Escrito: parámetros de localización, escala y forma; uniforme continua; exponencial deducida desde la Poisson, falta de memoria; gamma (Erlang y FDA con la Poisson para α entero); beta; log-normal (cálculo con la normal estándar); Weibull y lectura física del parámetro de forma; cuadro para elegir y advertencia de no promediar modelos.
- Base: diapositivas de la semana 5; @illowsky2018introductory cap. 5; @wasserman2004all cap. 2 (densidades gamma, beta y log-normal).
- Ejemplos (con Solución:, pseudocódigo y R): tiempo entre tormentas (exponencial), días entre fallas de bombas con datos descargables (ajuste, mediana y cuantiles), vida útil de apoyos de neopreno (Weibull, con simulación).
- Figuras propias con R: histograma de los días entre fallas con la densidad ajustada, familia gamma.
- Interactivo: seis distribuciones con parámetros y área P(X ≤ x0) por integración numérica (`#fig-cont-interactivo`); sus resultados se compararon con `pgamma()`, `pweibull()`, `plnorm()` y `pbeta()` y coinciden a cuatro decimales.
- Correcciones respecto a las diapositivas: en el ejemplo de las tormentas, E(T) = 45 h y Var(T) = 2025 h² (la diapositiva escribía 1/45); la Weibull se escribe con forma α y escala β, igual que `dweibull()`.
