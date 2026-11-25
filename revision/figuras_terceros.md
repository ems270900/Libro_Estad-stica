# Inventario de figuras de terceros

Inventario de las figuras e imágenes del libro que no son de producción propia, para revisar permisos y atribuciones antes de publicar. Se actualiza cada vez que un capítulo agrega una figura ajena. Las figuras generadas con R a partir de datos o ecuaciones no se listan.

El texto se publica con CC BY-NC-SA 4.0 y el código con MIT. Esas licencias no alcanzan a las figuras de terceros: cada una conserva su licencia o necesita permiso. Este inventario no es una opinión legal.

## Criterios

- **Mantener con cita:** dominio público o licencia abierta compatible (CC BY, CC BY-SA).
- **Pedir permiso:** obra de una institución o persona que probablemente lo dé.
- **Redibujar:** figura de un libro con derechos reservados; se rehace con R y se cita como "con base en".
- **Sustituir o quitar:** imagen comercial que conviene reemplazar.
- **Propia:** hecha para el libro.

## Inventario

| Capítulo | Archivo | Fuente | Licencia | Recomendación |
|:--|:--|:--|:--|:--|
| Portada | `assets/img/logoucr.png`, `assets/img/logoeic.png` | UCR, Escuela de Ingeniería Civil | Uso institucional | Confirmar uso si cambia la institución |
| Portada | `assets/img/by-nc-sa.png` | Creative Commons | CC BY 4.0 | Mantener |
| Portada | `assets/img/ciclo_h.png` | USGS, igual que el libro de hidrología | Dominio público | Mantener con cita; provisional, el autor ajustará la estética |
| 1 | `assets/img/cap01/paneles_rstudio.png` | Esquema propio de la ventana de RStudio | Propia | Mantener |
| 1 | `assets/img/cap01/flujo_analisis.png` | Con base en Wickham y Grolemund (2017) | Propia (redibujada) | Mantener con cita "con base en" |
| 1 | `assets/img/cap01/rstudio_inicio.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; RStudio recién abierto | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 1 | `assets/img/cap01/rstudio_nuevo_script.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; menú File > New File > R Script | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 1 | `assets/img/cap01/rstudio_cuatro_paneles.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; script de tres líneas con datos hipotéticos | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 1 | `assets/img/cap01/rstudio_nuevo_proyecto.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; diálogo New Project | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 1 | `assets/img/cap01/rstudio_instalar_paquete.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; Tools > Install Packages con dplyr | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 1 | `assets/img/cap01/rstudio_ayuda.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; ayuda de `mean()` | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 1 | `assets/img/cap01/rstudio_error.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; error "object 'resistencia' not found" | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 3 | `assets/img/cap03/rstudio_importar.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; Import Dataset > From Text (readr) con `datos/ensayos_concreto_hipoteticos.csv` | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 3 | `assets/img/cap03/rstudio_view.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; `View(ensayos)` | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 5 | `assets/img/cap05/rstudio_nuevo_rmd.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; diálogo New R Markdown | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 5 | `assets/img/cap05/rstudio_knit.png` | Captura de RStudio Server 2026.11.1 con R 4.6.2 (Posit Software, PBC), tomada para el libro el 2026-11-25; plantilla .Rmd compilada con Knit | Software RStudio, AGPL v3; interfaz de Posit | Mantener con cita |
| 1 | `assets/img/cap01/cran_inicio.png` | Captura de <https://cran.r-project.org> (2026-11-25) | Página web de CRAN (R Foundation) | Mantener con cita |
| 1 | `assets/img/cap01/cran_windows.png` | Captura de <https://cran.r-project.org/bin/windows/> (2026-11-25) | Página web de CRAN (R Foundation) | Mantener con cita |
| 1 | `assets/img/cap01/posit_descarga.png` | Captura de <https://docs.posit.co/ide/user/download.html> (2026-11-25); la dirección posit.co/download/rstudio-desktop/ redirige ahora a la guía de usuario | Página web de Posit Software, PBC | Mantener con cita |
| 7 | `fig-est-metodo` (generada en R) | Con base en Montgomery y Runger (2014), fig. 1-1 | Propia (redibujada) | Mantener con cita "con base en" |
