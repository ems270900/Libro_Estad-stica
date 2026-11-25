# Capítulo 30. Diseños factoriales

## Qué se escribió (2026-11-25)

- Por qué estudiar varios factores a la vez; efectos principales e interacción, con interactivo del gráfico de interacción (efectos A, B y AB).
- Factorial de dos factores: modelo, sumas de cuadrados, cuadro ANOVA, hipótesis y orden de interpretación.
- Ejemplo de adherencia de pinturas (2 × 3, r = 3): a mano, base R y `aov()`, gráfico de interacción, efectos simples con Bonferroni.
- Factorial 2^k: notación, matriz de signos, contrastes, efectos y sumas de cuadrados. Ejemplo 2² de película de asfalto (a mano, base R, `aov()` y `lm()` codificado).
- Diseño 2³ y experimentos sin repetición: matriz de signos, ejemplo de mortero con gráfico normal de efectos (Daniel, 1959) y modelo reducido; principio de jerarquía.
- Qué puede concluirse de un experimento. Seis ejercicios sin solucionario y lecturas recomendadas.

## Fuentes

- Montgomery (2017), cap. 5 y 6. Daniel (1959). Lane, cap. 15.
- Diapositivas de la Semana 8: datos de los ejemplos de pinturas y asfalto. El ejemplo 2³ de mortero es nuevo (hipotético).

## Pendiente para el autor

- El ejemplo de pinturas se basa en el planteamiento de Montgomery (sec. 5.3) con datos propios hipotéticos; no reproduce sus datos.

## Cambios (2026-11-24, noche)

- Sin epígrafe, por decisión del autor.
- Referencias cruzadas a las Partes IV a VI y al Apéndice A.

## Cambios (2026-11-25): ejemplos de otras ramas

- Ejercicio 1: el factorial cemento × temperatura de curado pasa a inóculo × temperatura en reactores anaerobios (producción de metano, mL/d), con los mismos números. Los ejemplos resueltos no cambian.

## Ampliación (2026-11-25)

- Secciones nuevas: vocabulario del factorial, variar un factor a la vez (interactivo), cuántos ensayos ahorra un factorial, efectos con cuatro medias, patrones de interacción (figura de cuatro paneles), modelo como receta y grados de libertad, cuadrados medios esperados, cómo se leen los tres valores p, η² parcial de cada efecto, gráfico de efectos principales, revisión de supuestos, reparto de la variación (interactivo), factorial con r = 1, cuadrado del 2², modelo de regresión codificado y superficie, cubo del 2³ (interactivo), gráfico seminormal y método de Lenth, puntos centrales y curvatura (ejemplo nuevo de estabilidad de mezcla asfáltica), fraccionados y alias, cómo planear un factorial, errores frecuentes, resumen.
- Datos nuevos: `datos/estabilidad_centro_hipotetica.csv` (hipotéticos).
- Cinco ejercicios nuevos (hidráulica, gestión, geotecnia, transporte).
- Verificado con R: curvatura SC = 2.88, F = 43.2, p = 0.007; Lenth PSE = 4.875, ME = 18.35; η²p de pinturas 0.915, 0.727 y 0.520.
- Referencias nuevas: Box, Hunter y Hunter (2005); Lenth (1989).
- Los valores del interactivo de un factor a la vez son hipotéticos y se eligieron para mostrar la interacción.
