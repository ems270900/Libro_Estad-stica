# =============================================================================
# datos_parte5.R
# Genera los conjuntos de datos hipotéticos de la Parte V (capítulos 18 a 23).
# Uso, desde la carpeta del libro: Rscript herramientas/datos_parte5.R
# Todos los datos son inventados para los ejemplos; no vienen de ensayos reales.
# =============================================================================

set.seed(20261125)

# 1) Esfuerzo de fluencia de diez varillas de acero (capítulos 19 y 21).
#    Valores del material del curso IC-0516, usados como datos hipotéticos.
varillas <- data.frame(
  varilla = 1:10,
  fluencia_mpa = c(291.4, 296.8, 296.7, 294.3, 291.1, 301.2, 298.5, 299.9, 298.0, 295.6)
)
write.csv(varillas, "datos/varillas_fluencia_hipoteticas.csv", row.names = FALSE)

# 2) Resistencia a compresión a 28 días de 25 cilindros de un mismo concreto
#    (capítulos 18 y 19). Normal con media 31 MPa y desviación 2.6 MPa.
cilindros <- data.frame(
  cilindro = 1:25,
  resistencia_mpa = round(rnorm(25, mean = 31, sd = 2.6), 1)
)
write.csv(cilindros, "datos/lote_cilindros_hipotetico.csv", row.names = FALSE)

# 3) Tiempo entre fallas de 20 bombas de un sistema de agua potable, en horas
#    (capítulo 18). Exponencial con media de 400 h.
bombas <- data.frame(
  falla = 1:20,
  tiempo_h = round(rexp(20, rate = 1 / 400))
)
write.csv(bombas, "datos/tiempo_falla_bombas_hipotetico.csv", row.names = FALSE)

# 4) Espesor de la carpeta asfáltica medido en 12 núcleos de un tramo,
#    en mm (capítulo 21). Espesor de diseño: 50 mm.
nucleos <- data.frame(
  nucleo = 1:12,
  espesor_mm = round(rnorm(12, mean = 48.6, sd = 2.4), 1)
)
write.csv(nucleos, "datos/espesor_carpeta_hipotetico.csv", row.names = FALSE)

# 5) Resistencia a compresión de cilindros con y sin aditivo, en MPa
#    (capítulo 22). Dos muestras independientes de tamaño distinto.
aditivo <- data.frame(
  mezcla = rep(c("Sin aditivo", "Con aditivo"), times = c(12, 10)),
  resistencia_mpa = round(c(rnorm(12, 30.0, 2.0), rnorm(10, 32.4, 2.3)), 1)
)
write.csv(aditivo, "datos/concreto_aditivo_hipotetico.csv", row.names = FALSE)

# 6) Índice de regularidad internacional (IRI, m/km) de diez tramos de carretera,
#    antes y después de un mantenimiento (capítulo 22). Muestras pareadas.
iri_antes <- round(rnorm(10, 3.6, 0.7), 2)
iri <- data.frame(
  tramo = 1:10,
  iri_antes = iri_antes,
  iri_despues = round(iri_antes - rnorm(10, 0.45, 0.30), 2)
)
write.csv(iri, "datos/iri_mantenimiento_hipotetico.csv", row.names = FALSE)

# 7) Mecanismo de falla de 180 deslizamientos de un inventario vial, según el
#    material del talud (capítulo 23). Una fila por deslizamiento.
prob_falla <- list(
  "Suelo residual" = c(0.55, 0.30, 0.15),
  "Coluvio" = c(0.45, 0.30, 0.25),
  "Roca meteorizada" = c(0.35, 0.35, 0.30)
)
tipos <- c("Traslacional", "Rotacional", "Flujo")
materiales <- rep(names(prob_falla), times = c(70, 60, 50))
mecanismo <- unlist(lapply(names(prob_falla), function(p) {
  sample(tipos, size = sum(materiales == p), replace = TRUE, prob = prob_falla[[p]])
}))
fallas <- data.frame(deslizamiento = seq_along(materiales), material = materiales,
                     mecanismo = mecanismo)
write.csv(fallas, "datos/deslizamientos_material_hipotetico.csv", row.names = FALSE,
          fileEncoding = "UTF-8")

# 8) Camiones que llegan a una planta de concreto en 80 intervalos de 15 minutos
#    (capítulo 23). Poisson con media 2.2 camiones por intervalo.
camiones <- data.frame(
  intervalo = 1:80,
  camiones = rpois(80, lambda = 2.2)
)
write.csv(camiones, "datos/llegada_camiones_hipotetica.csv", row.names = FALSE)

# 9) Grado de compactación (%) de 25 ensayos de densidad de campo en una base
#    granular (capítulo 19). Semilla propia para no alterar los bloques anteriores.
set.seed(1925)
base <- data.frame(ensayo = 1:25, compactacion_pct = round(rnorm(25, 97.6, 1.4), 1))
write.csv(base, "datos/compactacion_campo_hipotetica.csv", row.names = FALSE)
