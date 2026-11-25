# =============================================================================
# resultado_guardado.R
# -----------------------------------------------------------------------------
# Guarda en disco el resultado de un cálculo lento (una simulación grande, un
# ajuste iterativo, una descarga) y, en las compilaciones siguientes, lo lee
# del archivo en vez de recalcularlo.
#
# Uso en un capítulo (bloque oculto, antes de usar el resultado):
#   source("R/resultado_guardado.R")
#   medias <- resultado_guardado("cap17_medias_tlc", {
#     set.seed(2026)
#     replicate(100000, mean(rexp(30)))
#   })
#
# El archivo queda en resultados/cap17_medias_tlc.rds y va en git, así que una
# compilación en una máquina nueva tampoco lo recalcula. Para recalcularlo
# (porque cambió el código o los datos) se borra el .rds o se usa
# rehacer = TRUE una vez.
#
# El código que ve el lector en el libro va en un bloque aparte, con
# `#| eval: false`, para que el ejemplo siga siendo copiable y completo.
# =============================================================================

resultado_guardado <- function(nombre, expr, rehacer = FALSE, carpeta = "resultados") {
  archivo <- file.path(carpeta, paste0(nombre, ".rds"))
  if (!rehacer && file.exists(archivo)) return(readRDS(archivo))
  valor <- expr                       # aquí se ejecuta el cálculo lento
  dir.create(carpeta, showWarnings = FALSE)
  saveRDS(valor, archivo, compress = "xz")
  valor
}
