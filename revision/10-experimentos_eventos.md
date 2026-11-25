# Capítulo 10. Experimentos, eventos y axiomas de la probabilidad

Fecha: 2026-11-25. Estado: borrador.

- Escrito: experimentos deterministas y aleatorios; espacio muestral y eventos; operaciones con eventos (unión, intersección, complemento, diferencia, eventos mutuamente excluyentes) y leyes de De Morgan; axiomas de Kolmogorov y propiedades (complemento, evento imposible, inclusión, regla de la suma para dos y tres eventos); probabilidad clásica, frecuentista y subjetiva; ley de los grandes números. La sigma-álgebra y las demostraciones van en recuadros "Para profundizar".
- Base: diapositivas de la Semana 1 del curso (Conceptos.Rmd), @bertsekas2008introduction cap. 1, @illowsky2018introductory cap. 3, @blitzstein2019introduction cap. 1, @kolmogorov1933grundbegriffe.
- Ejemplos (con Solución:, pseudocódigo y R): espacio muestral de tres cilindros (`expand.grid()`); operaciones con un dado (`union()`, `intersect()`, `setdiff()`); probabilidades a partir de otras conocidas; tarjetas del 1 al 20 (del curso); atrasos de obra con datos descargables (base R y `dplyr`); simulación de la ley de los grandes números con cuadro de frecuencias acumuladas a mano.
- Figuras propias generadas con R: diagramas de Venn de las seis operaciones y frecuencia relativa acumulada.
- Interactivos: diagrama de Venn con botones por operación (`#fig-eventos-int-venn`) y ley de los grandes números con cuatro experimentos y número de repeticiones variable (`#fig-eventos-int-lgn`).
- Corrección respecto a las diapositivas: el ejercicio con P(A) = 0.4, P(Aᶜ ∩ B) = 0.4 y P(A ∩ B) = 0.1 concluía que A y B no eran independientes "porque P(A ∩ B) ≠ 0". La prueba correcta es comparar P(A ∩ B) con P(A)P(B) (0.1 contra 0.2); el libro lo explica así en el capítulo 12.
- La frase atribuida a Morris Wilks en las diapositivas no se usó porque no se pudo verificar su fuente.

## Ampliación (2026-11-25)

A pedido del autor (contenido "muy al punto"), se amplió el capítulo sin cambiar los ejemplos existentes:

- Secciones nuevas: variabilidad natural y falta de conocimiento (incertidumbre aleatoria y epistémica, con recuadro "En la práctica" sobre factores de seguridad); espacios muestrales finitos, numerables y continuos (con figura y recuadro "Cuidado"); tres eventos e inclusión y exclusión; periodo de retorno con su cuadro; comparación de las tres interpretaciones; errores frecuentes.
- Ejemplos nuevos: número de escudos con dos monedas (por qué no todos los resultados son igual de probables) y muestras de agua de pozo que incumplen la norma por coliformes, nitratos o turbiedad (rama ambiental, tres eventos, con simulación).
- Figuras nuevas: clases de espacio muestral, diagrama de Venn de tres eventos con la probabilidad de cada región y embudo de 25 simulaciones de la ley de los grandes números.
- Interactivo nuevo: regla de la suma como longitudes sobre una barra, con aviso cuando los valores violan los axiomas (`#fig-eventos-int-suma`).
- Ecuación nueva: periodo de retorno (`eq-eventos-retorno`). Ejercicios nuevos 13 a 16 (ambiental, transportes, hidrología).
- Referencias nuevas: @ang2007probability, @benjamin1970probability y @chow1988applied.
