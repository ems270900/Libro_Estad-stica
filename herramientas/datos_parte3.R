# =============================================================================
# datos_parte3.R
# Genera los conjuntos de datos hipotéticos de la Parte III (capítulos 10 a 12).
# Uso: Rscript herramientas/datos_parte3.R
# =============================================================================

set.seed(20261125)

# 1) Atrasos diarios en una obra (hipotéticos), capítulo 10.
#    100 días: 25 solo con lluvia, 11 solo con falla de equipo, 7 con ambas
#    causas y 57 sin atraso. El orden de los días se mezcla al azar.
casos <- c(rep("lluvia", 25), rep("falla", 11), rep("ambos", 7), rep("ninguno", 57))
casos <- sample(casos)
atrasos <- data.frame(
  dia = 1:100,
  lluvia = ifelse(casos %in% c("lluvia", "ambos"), "si", "no"),
  falla_equipo = ifelse(casos %in% c("falla", "ambos"), "si", "no")
)
write.csv(atrasos, "datos/atrasos_obra_hipoteticos.csv", row.names = FALSE)

# 2) Inspección semanal de 1000 varillas de acero (hipotética), capítulo 12.
#    Corrugadas: 508 buenas y 92 defectuosas. Lisas: 315 buenas y 85 defectuosas.
tipo <- c(rep("corrugada", 600), rep("lisa", 400))
condicion <- c(rep("buena", 508), rep("defectuosa", 92),
               rep("buena", 315), rep("defectuosa", 85))
orden <- sample(1000)
varillas <- data.frame(
  varilla = sprintf("V%04d", 1:1000),
  tipo = tipo[orden],
  condicion = condicion[orden]
)
write.csv(varillas, "datos/inspeccion_varillas_hipotetica.csv", row.names = FALSE)
