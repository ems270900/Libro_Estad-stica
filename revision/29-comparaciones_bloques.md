# Capítulo 29. Comparaciones múltiples y diseño en bloques

## Qué se escribió (2026-11-25)

- Familia de comparaciones y error familiar.
- Tukey (HSD) y Tukey-Kramer: ejemplo a mano con cuadro de parejas y letras, base R (`qtukey`, `outer`) y `TukeyHSD()`, figura de intervalos simultáneos.
- Bonferroni: diferencia mínima y `pairwise.t.test()`; comparación con Tukey.
- Contrastes: definición, prueba t y suma de cuadrados; ejemplo agua contra el resto a mano, en base R y con `lm()` y matriz de contrastes.
- Supuestos con residuos: cuadro de patrones, gráficos en base R, Shapiro-Wilk, Levene en base R (ANOVA de residuos absolutos) y Bartlett; transformaciones y Kruskal-Wallis.
- Bloques completos aleatorizados: modelo, sumas de cuadrados, cuadro ANOVA, ejemplo con cinco lotes (a mano, base R, `aov()`), comparación con el análisis sin bloques, Tukey con bloques, figura de perfiles por lote e interactivo que cambia la diferencia entre lotes.
- Seis ejercicios sin solucionario y lecturas recomendadas.

## Fuentes

- Montgomery (2017), cap. 3 y 4. Tukey (1949), Kramer (1956), Levene (1960). Lane, cap. 12.
- Diapositivas de la Semana 8: datos del ejemplo de bloques.

## Pendiente para el autor

## Cambios (2026-11-24, noche)

- Sin epígrafe, por decisión del autor.
- Referencias cruzadas a las Partes IV a VI y al Apéndice A.
- Tukey a mano con la tabla q del Apéndice A (@tbl-apa-q05).
