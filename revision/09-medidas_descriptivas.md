# Capítulo 9. Medidas de tendencia central, posición y variabilidad

Fecha: 2026-11-25. Estado: borrador.

- Escrito: notación de sumatoria explicada desde cero; media, media ponderada, media de datos agrupados, mediana, moda, media geométrica; resistencia a atípicos; cuantiles, cuartiles, deciles, percentiles (posición p(n+1), tipo 6 de Hyndman y Fan, como en las diapositivas del curso, con aviso sobre el tipo 7 de R); puntaje z; rango, RIC, varianza poblacional y muestral (por qué n − 1), desviación estándar, coeficiente de variación; forma y coeficiente de asimetría (g1 y G1); vallas de Tukey y diagrama de caja; cuadro resumen.
- Sin epígrafe (decisión del autor, 2026-11-25).
- Interactivos: mover un dato y ver la media, la mediana y la desviación estándar (`#fig-med-interactivo-centro`); calculadora de medidas descriptivas con datos que escribe el lector (`#fig-med-calculadora`).
- Ejemplos: compactación media por tramos (media ponderada); variación del precio del acero (media geométrica); resumen completo de 12 cilindros con cuadro de desviaciones; diagrama de caja y asimetría de la lluvia máxima. Todos los números de la Solución se verificaron en R.
- Paquete nuevo: e1071, solo para comprobar el coeficiente de asimetría (se dice en el texto).
- Fuentes: Illowsky y Dean (2013), Montgomery y Runger (2014), Helsel et al. (2020), Hyndman y Fan (1996), Joanes y Gill (1998), Tukey (1977), Wasserman (2004), Lane (s.f.), Ayala (2026).
- El ejercicio 1 usa el conjunto de 30 datos del repaso de la semana 3 del curso.
