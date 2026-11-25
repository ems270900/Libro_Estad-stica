# Crea imágenes provisionales para las capturas que todavía no existen.
# Uso: Rscript herramientas/marcador_captura.R ruta1.png ruta2.png ...
args <- commandArgs(trailingOnly = TRUE)
for (f in args) {
  if (file.exists(f)) next
  dir.create(dirname(f), showWarnings = FALSE, recursive = TRUE)
  png(f, width = 1400, height = 800, res = 150)
  par(mar = c(0, 0, 0, 0)); plot.new(); rect(0, 0, 1, 1, col = "#f5f7fa", border = "#1C6BA0", lwd = 3)
  text(0.5, 0.55, "Captura pendiente", cex = 2.2, col = "#1C6BA0", font = 2)
  text(0.5, 0.4, basename(f), cex = 1.3, col = "#555555")
  dev.off()
}
