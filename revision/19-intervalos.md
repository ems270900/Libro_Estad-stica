# Capítulo 19. Intervalos de confianza, de predicción y de tolerancia

Fecha: 2026-11-25. Estado: borrador.

- Escrito: forma general del intervalo; interpretación del nivel de confianza; convención de valores críticos (área a la derecha, igual que el apéndice A) y aviso sobre las funciones q de R; intervalos para la media con σ conocida y desconocida, para la proporción (Wald, Wilson y Clopper-Pearson) y para la varianza; intervalos de predicción y de tolerancia (factor k con la aproximación de Howe y el exacto); tamaño de muestra para media y proporción; cuadro resumen.
- Ejemplos: media con σ conocida (36 cilindros); esfuerzo de fluencia de 10 varillas con `t.test()`; proporción de cilindros bajo la resistencia mínima (10 de 85) con tres métodos; varianza de 25 cilindros; los tres intervalos para el mismo lote, con `tolerance::normtol.int()`; tamaño de muestra.
- Interactivos: 50 intervalos de confianza con controles de confianza y n y botón de nuevas muestras; calculadora de tamaño de muestra.
- Paquete nuevo: `tolerance` (R base no calcula factores de tolerancia).
- Figuras propias (R): t contra normal, chi-cuadrado con valores críticos, comparación de los tres intervalos.
- Datos: `varillas_fluencia_hipoteticas.csv` (valores del material del curso, Semana 6), `lote_cilindros_hipotetico.csv`.
- Fuentes: Montgomery y Runger (2014), Walpole et al. (2012), Illowsky y Dean (2018), Neyman (1937), Student (1908), Wilson (1927), Clopper y Pearson (1934), Agresti y Coull (1998), Howe (1969).
- Cambio respecto del material del curso: las varillas se presentan con esfuerzo de fluencia (objetivo 300 MPa) en lugar de resistencia a la tracción, que en acero de refuerzo es bastante mayor.
- Pendiente: epígrafe.
