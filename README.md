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
| `R/` | Funciones de R que usan los capítulos: vista paginada y descarga de los datos (`ver_datos.R`) y resultados lentos guardados en disco (`resultado_guardado.R`). |
| `resultados/` | Resultados de cálculos lentos en `.rds`, descritos en [`resultados/LEEME.md`](resultados/LEEME.md). |
| `_freeze/` | Resultados congelados de cada capítulo (los crea Quarto; van en git). |
| `herramientas/` | Scripts de apoyo: `publicar.R` (libro en un solo archivo HTML), `revisar_estilo.sh` (revisión de estilo), `partir_html.py` y `portada.js` con `portada_png.js` (generan la imagen de portada: `node herramientas/portada.js B2 petroleo_ambar portada.svg` y luego `node herramientas/portada_png.js portada.svg assets/img/portada.png`). |
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

En Windows también se puede hacer doble clic en `generar_libro.bat`, aunque el libro se compila en la nube y a la computadora del autor solo se copia el HTML final.

## Compilación rápida

El libro está configurado para que cada compilación vuelva a hacer solo el trabajo necesario. Se compila siempre en la nube; a la computadora del autor se copia solo el HTML final, a `D:\Teoría Proba\Libro\salidas`.

### Cómo funciona

- Resultados congelados (`freeze: auto` en `_quarto.yml`). Al compilar el libro completo, Quarto vuelve a ejecutar el código R solo de los capítulos cuyo `.qmd` cambió. Los demás usan los resultados guardados en la carpeta `_freeze/`, que va en git para que una máquina nueva no tenga que recalcular nada.
- Un capítulo a la vez. Mientras se escribe o se revisa un capítulo, se compila solo ese: `quarto render 04-graficos.qmd`. Así compilado, el capítulo siempre se ejecuta de nuevo, aunque no haya cambiado. El libro completo se compila una vez, al final.
- Caché de knitr en los bloques pesados. Un bloque que tarda más de unos segundos, como una simulación grande o una figura con muchos puntos, lleva `#| cache: true`. Si el código del bloque no cambia, knitr reutiliza su resultado aunque el resto del capítulo se vuelva a ejecutar. La caché queda en carpetas `*_cache/`, que no van en git. El HTML de un solo archivo (`herramientas/publicar.R`) usa la caché en todos los bloques.
- Resultados lentos guardados en disco. Un cálculo muy lento, o uno que depende de una descarga de internet, se guarda una vez en `resultados/` como `.rds` con `R/resultado_guardado.R`, y las compilaciones siguientes lo leen del archivo. Para recalcularlo se borra el `.rds`. La plantilla de capítulo trae un ejemplo.

### Cuándo hay que forzar un recálculo

`freeze: auto` solo se fija en el `.qmd`. Si cambia un archivo de `datos/`, una función de `R/` o un resultado de `resultados/`, los capítulos que lo usan no se recalculan solos. En ese caso se compila cada uno de esos capítulos por separado (`quarto render NN-tema.qmd`) y después el libro completo.

### Cuánto tarda

Tiempos medidos el 2026-11-25 en la nube (4 núcleos), con la Parte I (portada, introducción y capítulos 1 a 6):

| Compilación | Tiempo |
|:--|--:|
| Libro completo, primera vez en una máquina sin `_freeze/` | 26 s |
| Libro completo sin cambios en los capítulos | 16 s |
| Libro completo con un capítulo modificado | 20 s |
| Un solo capítulo (`quarto render 04-graficos.qmd`) | 6 a 9 s |
| HTML de un solo archivo, primera vez | 19 s |
| HTML de un solo archivo, repetido (con caché) | 12 s |

Con las siete partes (30 capítulos y 3 apéndices) el libro completo tarda unos 3 minutos cuando ningún capítulo está congelado (medido el 2026-11-25 al unir la Parte IV). Compilar uno por uno 32 capítulos y apéndices (todos menos el 19), cada uno con su propia ejecución, tomó 325 s en total, es decir, unos 10 s por capítulo en promedio. Con `_freeze/` al día, una compilación completa solo vuelve a ejecutar los capítulos modificados.

Con todos los capítulos congelados, casi todo el tiempo de una compilación completa es el armado de las páginas HTML, no R. Cada capítulo nuevo agrega uno o dos segundos a esa parte, más el tiempo de su propio código solo cuando se modifica. Estos tiempos se actualizan cuando entran las partes siguientes.

## Licencia

- **Texto, figuras y contenido del libro**: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.es).
- **Código R** (bloques de código del libro y scripts de `herramientas/` y `R/`): [MIT](LICENSE-CODE).

Los detalles están en [LICENSE](LICENSE) y [LICENSE-CODE](LICENSE-CODE). Las imágenes y datos de terceros conservan la licencia de su fuente, que se cita en el libro.

## Cómo citar

Matarrita Segura, E. (2026). *Probabilidad e inferencia estadística aplicada a la ingeniería civil: fundamentos, métodos y aplicaciones con R*. Escuela de Ingeniería Civil, Universidad de Costa Rica.
