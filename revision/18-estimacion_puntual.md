# Capítulo 18. Estimación puntual

Fecha: 2026-11-25. Estado: borrador.

- Escrito: parámetro, estimador y estimación (cuadro de estimadores); sesgo, con demostración de por qué se divide entre n − 1 (recuadro plegable) y simulación del sesgo de la varianza; error estándar de la media y de la proporción; error cuadrático medio, eficiencia y consistencia; máxima verosimilitud para una proporción y para la exponencial, con Newton-Raphson y cuadro de iteraciones; método de los momentos.
- Ejemplos: estimaciones puntuales de un lote de 25 cilindros (a mano, base R); tiempo medio entre fallas de 20 bombas por máxima verosimilitud (fórmula exacta, Newton-Raphson, `optimize()` y `MASS::fitdistr()`).
- Interactivo: función de verosimilitud binomial con controles de n y x.
- Figuras propias (R): sesgo de los dos estimadores de la varianza, log-verosimilitud de la exponencial.
- Datos: `lote_cilindros_hipotetico.csv`, `tiempo_falla_bombas_hipotetico.csv`.
- Fuentes: Montgomery y Runger (2014), Walpole et al. (2012), Wasserman (2004), Illowsky y Dean (2018), Fisher (1922).
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).
