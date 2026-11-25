# Instrucciones para trabajar en este repositorio

Libro *Estadística Aplicada a la Ingeniería* (Edwin Matarrita Segura). Es un libro de Quarto con ejemplos en R, con la misma forma, estructura y estética que *Hidrología Aplicada a la Ingeniería Civil* (github.com/ems270900/libro_hidrologia). Lectores: estudiantes que aprenden el tema y profesionales que lo consultan como referencia; no es un libro de curso.

## Reglas

- Todo en español: texto, comentarios de código, mensajes de commit y PR.
- **Antes de escribir o revisar un capítulo, leer `GUIA_ESTILO.md` completa.**
- No se escribe contenido de capítulos hasta que el autor entregue referencias, nivel y lista de capítulos.
- Los capítulos nuevos parten de `_plantillas/plantilla_capitulo.qmd`.
- Después de editar un capítulo, correr `bash herramientas/revisar_estilo.sh <archivo>.qmd` y revisar los avisos.
- No inventar referencias, cifras ni datos. Si falta una fuente, dejar `<!-- CITA PENDIENTE: ... -->`. Verificar cada fórmula contra libros de referencia sólidos.
- No renombrar claves existentes de `references.bib` ni etiquetas `fig-`, `tbl-`, `eq-` ya citadas.
- Nunca usar datos personales de estudiantes (notas, exámenes, nombres) en el libro.
- Una rama por tarea y un PR descriptivo. Solo se une un PR con autorización escrita del autor.
- Cada entrega actualiza `revision/README.md` (bitácora por capítulo), `revision/pendientes.md` y, si hay figuras de terceros, `revision/figuras_terceros.md`.
- No publicar en la web sin permiso del autor. Licencia: texto CC BY-NC-SA 4.0, código MIT.
- Salida solo HTML por ahora (sin PDF).

## Estructura

- `NN-tema.qmd`: capítulos, en el orden de `_quarto.yml`.
- `references.bib`: bibliografía en orden alfabético. Estilo APA 7 en `assets/csl/apa.csl`.
- `datos/`: CSV de los ejemplos, descritos en `datos/LEEME.md`. `R/ver_datos.R` los muestra con descarga.
- `assets/img/capNN/`: imágenes. `assets/css/styles.css`: estilos. `assets/js/`: accesibilidad y navegación del HTML de un archivo.
- `herramientas/`: `publicar.R` (HTML de un solo archivo), `revisar_estilo.sh`, `partir_html.py`, `figura_portada.R`.
- `_plantillas/`: plantilla de capítulo (Quarto no la renderiza por empezar con `_`).

## Renderizar

```bash
quarto render                 # libro completo
quarto render 03-tema.qmd     # un capítulo
```

El autor no compila en su PC (Smart App Control bloquea DLL de algunos paquetes): se compila en la nube y el HTML se copia a la carpeta de su PC que indique.
