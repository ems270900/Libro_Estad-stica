# Capítulo 9. Medidas de tendencia central, posición y variabilidad

Fecha: 2026-11-25. Estado: borrador.

- Escrito: notación de sumatoria explicada desde cero; media, media ponderada, media de datos agrupados, mediana, moda, media geométrica; resistencia a atípicos; cuantiles, cuartiles, deciles, percentiles (posición p(n+1), tipo 6 de Hyndman y Fan, como en las diapositivas del curso, con aviso sobre el tipo 7 de R); puntaje z; rango, RIC, varianza poblacional y muestral (por qué n − 1), desviación estándar, coeficiente de variación; forma y coeficiente de asimetría (g1 y G1); vallas de Tukey y diagrama de caja; cuadro resumen.
- Sin epígrafe (decisión del autor, 2026-11-25).
- Interactivos: mover un dato y ver la media, la mediana y la desviación estándar (`#fig-med-interactivo-centro`); calculadora de medidas descriptivas con datos que escribe el lector (`#fig-med-calculadora`).
- Ejemplos: compactación media por tramos (media ponderada); variación del precio del acero (media geométrica); resumen completo de 12 cilindros con cuadro de desviaciones; diagrama de caja y asimetría de la lluvia máxima. Todos los números de la Solución se verificaron en R.
- Paquete nuevo: e1071, solo para comprobar el coeficiente de asimetría (se dice en el texto).
- Fuentes: Illowsky y Dean (2013), Montgomery y Runger (2014), Helsel et al. (2020), Hyndman y Fan (1996), Joanes y Gill (1998), Tukey (1977), Wasserman (2004), Lane (s.f.), Ayala (2026).
- El ejercicio 1 usa el conjunto de 30 datos del repaso de la semana 3 del curso.

## Ampliación (2026-11-25)

- No se tocó el recuadro de los doce cilindros (lo cambia el hilo de diversificación de ramas).
- Nuevo: la media como punto de equilibrio con siete asentamientos de zapatas (geotecnia); cuadro de qué medida de centro usar; ejemplo completo del percentil 85 de la velocidad de punto (transportes, datos nuevos `velocidades_punto_hipoteticas.csv`); varianza como área de cuadrados; desviación media absoluta y desviación absoluta mediana; coeficiente de variación en hidrología y en control del concreto (ACI 214R-11); regla empírica y desigualdad de Chebyshev (Walpole et al., 2012; Wasserman, 2004) con comprobación en la lluvia; guía para leer g1; cuarteto de Anscombe (1973) y Datasaurus (Matejka y Fitzmaurice, 2017).
- Diagrama de caja a fondo (pedido del autor): anatomía con vallas y atípico; por qué 1.5 RIC y vallas externas a 3 RIC; proporción marcada en datos normales (Hoaglin et al., 1986); cuándo usarlo y cuándo no; figura de una distribución bimodal que la caja esconde; variantes (muesca y ancho variable de McGill et al., 1978; violín de Hintze y Nelson, 1998; caja con puntos); ejemplo completo con cajas con muesca de los caudales 1966–1992 y 1993–2018 (hidráulica), en R base y ggplot2.
- Interactivos nuevos: interpolación de un percentil (`#fig-med-int-percentil`); fracción dentro de x̄ ± ks con regla empírica y Chebyshev (`#fig-med-int-chebyshev`); diagrama de caja que se arma agregando datos, con vallas a 1.5 o 3 RIC (`#fig-med-int-caja`).
- Cuadro de equivalencias R y Excel en español (CUARTIL.EXC = tipo 6, CUARTIL.INC = tipo 7) y recuadro de errores frecuentes.
- Ejercicios 10 a 15 nuevos (transportes, ambiental, hidráulica).
- Todos los números de las soluciones se verificaron en R.
- Percentil 85 citado con el MUTCD 2009, sección 2B.13 (2026-11-25).
