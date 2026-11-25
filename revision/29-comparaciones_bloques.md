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

## Cambios (2026-11-25): ejemplos de otras ramas

- Los cuatro ejemplos siguen la prueba de jarras del capítulo 28: Tukey entre coagulantes, contraste del sulfato de aluminio (el coagulante actual) contra los demás, revisión de supuestos y diseño en bloques con cinco muestras de agua cruda en lugar de cinco lotes de cemento. El interactivo de bloques usa las nuevas medias (79, 83, 89 y 85 %) y su eje va de 70 a 100 %.
- Datos nuevos: `datos/jarras_muestras_hipotetico.csv` (reemplaza a `curado_lotes_hipotetico.csv`). HSD = 2.86, contraste L = −20 (t = −8.16), Shapiro p = 0.500, Levene p = 0.888, bloques F = 173.3 y Tukey con bloques: verificados con R.
- Ejercicio 3: el contraste ahora compara coagulantes de aluminio contra los de hierro.

## Ampliación (2026-11-25)

- Secciones nuevas: comparaciones planeadas y a posteriori, cuadro de métodos (LSD, Tukey, Bonferroni, Holm, Dunnett, Scheffé), método de Holm (ejemplo a mano, `p.adjust()` y `pairwise.t.test()`), cómo se interpretan los valores p ajustados (cuadro de la misma pareja con cuatro métodos y cuatro situaciones confusas), η² parcial con bloques, variantes del diseño en bloques (Friedman, cuadrado latino, bloques incompletos y aleatorios), resumen "cuándo usar qué".
- Interactivo nuevo: distancia mínima según el método, las repeticiones y CM_E (`int-mc-distancia`; multiplicadores calculados en R con `qt()` y `qtukey()`).
- Cuatro ejercicios nuevos (pavimento permeable, formaletas con carpinteros como bloques, lectura del valor p ajustado).
- Verificado con R: valores p sin ajuste, Holm, Bonferroni y Tukey de las seis parejas; Friedman χ² = 15, p = 0.002; η²p = 0.977.
- Referencias nuevas: Holm (1979), Friedman (1937).

## Cambios (2026-11-25): Box-Cox en el ANOVA

- "Qué hacer si no se cumplen" agrega Box-Cox (`MASS::boxcox(y ~ tratamiento)`, con referencia a `@sec-diag-boxcox`) y el método empírico de la pendiente de ln s contra ln ȳ (λ = 1 − α), con cita a Montgomery (2017, sec. 3.4).
