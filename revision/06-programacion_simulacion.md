# Capítulo 6. Funciones, condiciones, ciclos y simulación

Fecha: 2026-11-25. Estado: borrador.

- Escrito: funciones propias (resistencia de un cilindro, @eq-prog-resistencia), `if`/`else`, `ifelse()`, ciclos `for` con `seq_along()`, `sample()`, `set.seed()` y simulación.
- Ejemplos: media acumulada con cuadro de iteraciones a mano y ciclo en R; probabilidad de que dos dados sumen 7 (6/36 a mano y 10 000 simulaciones en R).
- Interactivo: simulación de dos dados con número de lanzamientos variable (`#fig-prog-interactivo`).
- Nota: la clasificación "Muy bajo / Bajo / Cumple" es un ejercicio de programación, no un criterio normativo; los criterios de aceptación se tratan en capítulos posteriores.

## Ampliación (2026-11-25, rama `claude/ampliar-parte-1`)

- Agregado: Funciones que devuelven listas y validación con `stop()`; ciclo `while` con el ejemplo de los camiones (8 viajes); ciclo infinito; `sapply`; `runif`, `rnorm` y `replicate`; ejemplo de P(f < 28) con N(32, 3) (tabla 0.0918, `pnorm` 0.0912, simulación); interactivo de convergencia (`int-convergencia`); cómo encontrar errores; ejercicios 9 a 15.
- Pendiente: revisión del autor.
