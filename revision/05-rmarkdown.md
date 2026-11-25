# Capítulo 5. Documentos reproducibles con R Markdown

Fecha: 2026-11-25. Estado: borrador.

- Escrito: partes de un archivo Rmd, creación y compilación con Knit, Markdown, opciones de los bloques, resultados en línea, cuadros con `kable()`, ecuaciones en LaTeX y paso a Quarto.
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).
- Interactivo: vista previa de Markdown (`#fig-rmd-interactivo`).
- Ejemplo: informe del edificio a 28 días con números calculados en línea, comparado con el cálculo a mano.
- Capturas: `cap05/rstudio_nuevo_rmd.png` y `cap05/rstudio_knit.png`.

## Ampliación (2026-11-25, rama `claude/ampliar-parte-1`)

- Agregado: El cuadro 5.1 se reemplazó por uno que muestra lo que se escribe y el resultado real. Encabezado YAML; listas y cuadros en Markdown lado a lado; opciones de bloque con interactivo (`int-opciones`); bloque setup; números en el texto con `format()`; cuadros con kableExtra y LaTeX; plantilla descargable `assets/archivos/informe_laboratorio.Rmd`; formatos de salida; errores frecuentes; ejercicios hasta el 10.
- Pendiente: revisión del autor.

## Segunda ampliación (2026-11-25, rama `claude/parte-1-didactica`)

- Agregado: YAML completo: reglas con ejemplo de errores, opciones generales, todas las opciones de `html_document` (toc, toc_float, number_sections, theme, highlight, code_folding, df_print...), constructor interactivo (`int-yaml`), opciones de Word y PDF y encabezado recomendado para tareas. Bloques: partes con figura, opciones con `#|`, cuadro de todas las opciones de uso frecuente, simulador ampliado (warning, error, results, collapse, comment), `results = "asis"`, tamaño de figuras (`fig.width` y `out.width`). Más Markdown (notas al pie, tachado, pestañas `.tabset`, títulos sin número). kableExtra completo con `airquality` (estilos, temas, `column_spec`, `row_spec`, `add_header_above`, `pack_rows`, `footnote`, `scroll_box`, colores condicionales) [@zhu2024kableextra] y `DT::datatable()`. Ecuaciones alineadas. Referencias cruzadas con bookdown y `_bookdown.yml` en español [@xie2016bookdown]; citas con `.bib` y `.csl`. Plantilla de tarea descargable (`assets/archivos/plantilla_tarea.Rmd`, probada con rmarkdown). Más errores frecuentes y ejercicios 11 a 17.
- Pies de figura y títulos de cuadro acortados. Pendiente: revisión del autor.
