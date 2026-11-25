# =============================================================================
# figuras_parte1.R
# Esquemas de producción propia de la Parte I.
# Uso: Rscript herramientas/figuras_parte1.R
# =============================================================================

library(ggplot2)
azul <- "#1C6BA0"; azul_osc <- "#10199e"; gris <- "#f5f7fa"

# 1) Paneles de RStudio (esquema, no captura de pantalla)
paneles <- data.frame(
  x0 = c(0, 0, 5.1, 5.1), x1 = c(5, 5, 10, 10),
  y0 = c(2.35, 0, 2.35, 0), y1 = c(4.6, 2.25, 4.6, 2.25),
  titulo = c("1. Editor de código (script)", "2. Consola",
             "3. Entorno e historial", "4. Archivos, gráficos, paquetes y ayuda"),
  detalle = c("Aquí se escribe y se guarda el código.\nCtrl + Enter envía la línea a la consola.",
              "Aquí R ejecuta las instrucciones\ny muestra los resultados.",
              "Lista los objetos creados\n(datos, vectores, resultados).",
              "Muestra los gráficos, la ayuda\ny las carpetas del proyecto.")
)
g <- ggplot(paneles) +
  geom_rect(aes(xmin = x0, xmax = x1, ymin = y0, ymax = y1), fill = gris,
            color = azul, linewidth = 1) +
  geom_rect(aes(xmin = x0, xmax = x1, ymin = y1 - 0.55, ymax = y1), fill = azul) +
  geom_text(aes(x = x0 + 0.15, y = y1 - 0.28, label = titulo), hjust = 0,
            color = "white", fontface = "bold", size = 4.2) +
  geom_text(aes(x = (x0 + x1) / 2, y = (y0 + y1 - 0.55) / 2, label = detalle),
            color = "#333333", size = 4, lineheight = 1.1) +
  annotate("rect", xmin = 0, xmax = 10, ymin = 4.7, ymax = 5.2, fill = azul_osc) +
  annotate("text", x = 0.15, y = 4.95, label = "RStudio   Archivo   Editar   Código   Ver   ...",
           hjust = 0, color = "white", size = 3.8) +
  coord_equal(xlim = c(0, 10), ylim = c(0, 5.2), expand = FALSE) +
  theme_void()
ggsave("assets/img/cap01/paneles_rstudio.png", g, width = 10, height = 5.2, dpi = 150, bg = "white")

# 2) Flujo de trabajo de un análisis de datos (con base en Wickham y Grolemund, 2017)
pasos <- data.frame(
  x = c(1, 3.4, 5.8, 8.2, 10.6),
  etiqueta = c("Importar", "Ordenar", "Transformar", "Visualizar", "Comunicar"),
  cap = c("Cap. 3", "Cap. 3", "Cap. 3", "Cap. 4", "Cap. 5")
)
g2 <- ggplot(pasos) +
  geom_segment(data = pasos[-5, ], aes(x = x + 0.95, xend = x + 1.45, y = 1, yend = 1),
               arrow = arrow(length = unit(0.25, "cm"), type = "closed"),
               color = "#555555", linewidth = 0.8) +
  geom_label(aes(x = x, y = 1, label = etiqueta), fill = azul, color = "white",
             size = 5, fontface = "bold", label.padding = unit(0.5, "lines")) +
  geom_text(aes(x = x, y = 0.55, label = cap), color = "#555555", size = 4) +
  coord_cartesian(xlim = c(0, 11.6), ylim = c(0.3, 1.4)) +
  theme_void()
ggsave("assets/img/cap01/flujo_analisis.png", g2, width = 10, height = 1.9, dpi = 150, bg = "white")
