# Apéndices A, B y C

Fecha: 2026-11-25. Estado: borrador.

## Apéndice A. Tablas estadísticas (`A-tablas_estadisticas.qmd`)

- Cuadros generados con R al compilar (no se copiaron de ningún libro): normal estándar $P(Z \le z)$ de −3.49 a 3.49; $t$ con $\alpha$ de 0.10 a 0.0005 y $\nu$ de 1 a 30, 40, 50, 60, 80, 100, 120 e ∞; $\chi^2$ con $\alpha$ de 0.995 a 0.005 y $\nu$ de 1 a 30 y 40 a 100; $F$ para $\alpha$ = 0.10, 0.05, 0.025 y 0.01 (en pestañas); binomial acumulada para $n$ de 1 a 20 y 15 valores de $p$.
- Convención: las tablas $t$, $\chi^2$ y $F$ dan el valor con área $\alpha$ a la derecha; la $Z$ y la binomial dan el área a la izquierda.
- Un ejemplo de lectura por tabla (Solución: a mano y línea de R equivalente), con datos hipotéticos de ingeniería civil. Valores verificados con R 4.3.3.
- Relación $F_{1-\alpha,\nu_1,\nu_2} = 1/F_{\alpha,\nu_2,\nu_1}$ (Ecuación A.1), comprobada numéricamente con `qf()`.
- Calculadora interactiva (HTML y JavaScript propios, sin bibliotecas): Z, t, χ², F y binomial; da probabilidades, valores críticos y la línea de R. Las funciones de JavaScript (gamma y beta incompletas) se compararon con R: coinciden en 10 decimales.
- Figuras propias generadas con R base. Sin figuras de terceros.

## Apéndice B. Funciones de R (`B-funciones_r.qmd`)

- Cuadros por tema con función, qué hace, ejemplo y capítulo. Las funciones de la Parte I (capítulos 1 a 6) se tomaron de los capítulos ya escritos.
- Las de las partes II a VII se anotaron con el capítulo previsto; se ajustan cuando se escriban esas partes.
- Cuadro de las letras `d`, `p`, `q`, `r` y de los nombres de 15 distribuciones en R.
- Buscador interactivo que filtra las filas de los cuadros.

## Apéndice C. Glosario (`C-glosario.qmd`)

- 106 términos en orden alfabético del español, con el inglés y una definición sencilla.
- Cuadro con las palabras en inglés de las salidas de `summary()`, `t.test()`, `lm()`, `anova()`, `aov()`, `TukeyHSD()` y otras pruebas; textos copiados de salidas reales de R 4.3.3.
- Cuadro de mensajes de error y advertencia frecuentes, comprobados en R 4.3.3.
- Buscador interactivo.

## Cambios en archivos comunes

- `_quarto.yml`: sección `appendices:` con los tres archivos.
- `herramientas/publicar.R`: el HTML de un solo archivo incluye ahora los apéndices, en una parte "Apéndices", y cambia sus números por letras (Apéndice A, Cuadro A.1, Figura A.1, Ecuación A.1), igual que el libro de varias páginas.

## Tiempos de compilación (en la nube)

- Un apéndice solo (`quarto render A-tablas_estadisticas.qmd`): unos 12 s.
- Libro completo de varias páginas con la Parte I y los apéndices: unos 30 s.
- HTML de un solo archivo: unos 25 s.
