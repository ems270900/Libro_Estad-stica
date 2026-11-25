# Probabilidad e Inferencia Estadística Aplicada a la Ingeniería Civil

*Fundamentos, métodos y aplicaciones con R*

Ing. Edwin Matarrita Segura. Escuela de Ingeniería Civil, Universidad de Costa Rica.

Libro escrito en [Quarto](https://quarto.org/) con ejemplos en R, para estudiantes que aprenden estadística y para profesionales que la consultan. Cada método se explica, se resuelve paso a paso a mano y se repite con código R que se puede copiar y usar, primero con la fórmula en base R y después con la función del paquete.

El libro está en preparación. El estado de cada capítulo se lleva en [`revision/README.md`](revision/README.md).

## Contenido

Por definir. El orden oficial de los capítulos está en `_quarto.yml`.

## Estructura del repositorio

| Ruta | Contenido |
|:--|:--|
| `NN-tema.qmd` | Capítulos del libro, numerados en el orden de `_quarto.yml`. |
| `index.qmd`, `welcome.qmd`, `intro.qmd` | Portada, prefacio e introducción. |
| `epilogo.qmd`, `99-Referencias.qmd` | Palabras finales y referencias. |
| `references.bib` | Bibliografía en orden alfabético (APA 7, `assets/csl/apa.csl`). |
| `_quarto.yml` | Configuración del libro: capítulos, formato y numeración. |
| `assets/` | Imágenes (`img/`), estilos (`css/`), estilo de citas (`csl/`) y scripts de la página (`js/`). |
| `datos/` | Archivos de datos de los ejemplos, descritos en [`datos/LEEME.md`](datos/LEEME.md). |
| `R/` | Funciones de R que usan los capítulos (vista paginada y descarga de los datos). |
| `herramientas/` | Scripts de apoyo: `publicar.R` (libro en un solo archivo HTML), `revisar_estilo.sh` (revisión de estilo) y `partir_html.py`. |
| `_plantillas/` | Plantilla para capítulos nuevos. |
| `revision/` | Bitácora por capítulo, trabajo pendiente e inventario de figuras de terceros. |
| `GUIA_ESTILO.md` | Guía de estilo del libro. |

## Requisitos

- [Quarto](https://quarto.org/docs/get-started/) 1.6 o posterior.
- [R](https://cran.r-project.org/) 4.3 o posterior. RStudio es opcional.
- Paquetes de R (la lista crece con los capítulos):

  ```r
  install.packages(c(
    "tidyverse", "knitr", "rmarkdown", "kableExtra", "DT", "patchwork", "scales",
    "yaml", "magick", "htmltools", "xfun"
  ))
  ```

## Generar el libro

```bash
quarto render                 # libro de varias páginas, en _book/
quarto preview                # vista previa con recarga automática
```

Libro en un solo archivo HTML, que se abre sin internet (queda en `salidas/Estadistica_Aplicada.html`):

```r
source("herramientas/publicar.R")
libro_un_archivo()
```

En Windows basta con hacer doble clic en `generar_libro.bat`.

## Licencia

- **Texto, figuras y contenido del libro**: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.es).
- **Código R** (bloques de código del libro y scripts de `herramientas/` y `R/`): [MIT](LICENSE-CODE).

Los detalles están en [LICENSE](LICENSE) y [LICENSE-CODE](LICENSE-CODE). Las imágenes y datos de terceros conservan la licencia de su fuente, que se cita en el libro.

## Cómo citar

Matarrita Segura, E. (2026). *Probabilidad e inferencia estadística aplicada a la ingeniería civil: fundamentos, métodos y aplicaciones con R*. Escuela de Ingeniería Civil, Universidad de Costa Rica.
