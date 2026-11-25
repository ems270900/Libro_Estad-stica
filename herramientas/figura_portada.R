# =============================================================================
# figura_portada.R
# Imagen provisional de la portada (producción propia, sin derechos de terceros):
# densidades normales con distinta desviación estándar a la izquierda e
# intervalos de confianza del 95 % de 40 muestras simuladas a la derecha.
# Uso: Rscript herramientas/figura_portada.R
# =============================================================================

library(ggplot2)
library(patchwork)

set.seed(2026)
azul <- c("#081a40", "#10199e", "#1f6fb2", "#1C6BA0", "#8fb8ff")

# 1) Densidades normales
x <- seq(-5, 5, length.out = 400)
dens <- do.call(rbind, lapply(c(0.7, 1, 1.5, 2.2), function(s)
  data.frame(x = x, y = dnorm(x, 0, s), s = factor(s))))
g1 <- ggplot(dens, aes(x, y, group = s)) +
  geom_area(aes(fill = s), alpha = 0.18, position = "identity") +
  geom_line(aes(color = s), linewidth = 1.1) +
  scale_fill_manual(values = azul[1:4]) +
  scale_color_manual(values = azul[1:4]) +
  theme_void() + theme(legend.position = "none")

# 2) Intervalos de confianza del 95 % para la media (n = 15, mu = 0)
ic <- do.call(rbind, lapply(1:40, function(k) {
  m <- rnorm(15)
  e <- qt(0.975, 14) * sd(m) / sqrt(15)
  data.frame(k = k, media = mean(m), li = mean(m) - e, ls = mean(m) + e)
}))
ic$cubre <- ic$li <= 0 & ic$ls >= 0
g2 <- ggplot(ic, aes(y = k)) +
  geom_vline(xintercept = 0, color = azul[2], linewidth = 0.8) +
  geom_segment(aes(x = li, xend = ls, yend = k, color = cubre), linewidth = 1) +
  geom_point(aes(x = media, color = cubre), size = 1.8) +
  scale_color_manual(values = c(`TRUE` = azul[3], `FALSE` = "#c0392b")) +
  theme_void() + theme(legend.position = "none")

p <- (g1 | g2) + plot_layout(widths = c(1.4, 1)) &
  theme(plot.margin = margin(15, 25, 15, 25), plot.background = element_rect(fill = "white", color = NA))

ggsave("assets/img/portada.png", p, width = 11.1, height = 6, dpi = 150)
