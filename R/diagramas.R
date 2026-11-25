# =============================================================================
# diagramas.R
# Diagramas del libro (árboles, flujos, diagramas de Venn y esquemas) como SVG
# dentro de la página. Tienen un estilo común (petróleo y ámbar), cajas que se
# ajustan al texto y colores que cambian solos en el modo oscuro.
#
# Uso en un capítulo (bloque con #| echo: false y una etiqueta fig-):
#   source("R/diagramas.R")
#   dg_jerarquia(...), dg_flujo(...), dg_arbol(...), dg_venn(...), dg_paneles(...)
# Cada función devuelve el SVG listo para knitr. Sin dependencias externas.
# =============================================================================

# ---------------------------------------------------------------- estilo común
dg_css <- "
.dg{display:block;margin:0 auto;height:auto;font-family:Roboto,'Segoe UI',system-ui,-apple-system,sans-serif}
.dg text{dominant-baseline:central}
.dg .c0{fill:#0f5560;stroke:#0f5560}
.dg .c1{fill:#e4f0f1;stroke:#0f5560}
.dg .c2{fill:#ffffff;stroke:#a9cdd1}
.dg .c3{fill:#fbf3e3;stroke:#d9b56a}
.dg .t0{fill:#ffffff;font-weight:600}
.dg .t1{fill:#1d2327;font-weight:600}
.dg .t2{fill:#58626c}
.dg .te{fill:#8a5a00;font-style:italic}
.dg .tv{fill:#8a5a00;font-weight:600}
.dg .tm{fill:#1d2327;font-style:italic;font-family:'STIX Two Text','Cambria Math','Times New Roman',serif}
.dg .enc{fill:#58626c;font-weight:600;letter-spacing:.08em}
.dg .ln{fill:none;stroke:#7d8a94;stroke-width:1.6;stroke-linecap:round;stroke-linejoin:round}
.dg .fl{fill:#7d8a94}
.dg .gr{fill:none;stroke:#a26800;stroke-width:1.5;stroke-dasharray:7 5}
.dg .num{fill:#a26800}
.dg .tn{fill:#ffffff;font-weight:700}
.dg .nd{fill:#0f5560}
.dg .pi{fill:#ffffff;stroke:#e3c98f}
.dg .vs{fill:#f6f8f9;stroke:#3b3f45;stroke-width:1.4}
.dg .vz{fill:#4a9ea8}
.dg .vz2{fill:#cfe3e6}
.dg .vc{fill:none;stroke:#1d2327;stroke-width:1.6}
.dg .vd{fill:none;stroke:#1d2327;stroke-width:1.6;stroke-dasharray:6 5}
.dg .bar{fill:#0f5560}
.dg .tb{fill:#ffffff;font-weight:600}
body.quarto-dark .dg .c0{fill:#7fd0da;stroke:#7fd0da}
body.quarto-dark .dg .c1{fill:#173a40;stroke:#7fd0da}
body.quarto-dark .dg .c2{fill:#1f2429;stroke:#3f7178}
body.quarto-dark .dg .c3{fill:#2b2414;stroke:#8f6a1c}
body.quarto-dark .dg .t0{fill:#062a30}
body.quarto-dark .dg .t1{fill:#e8eaed}
body.quarto-dark .dg .t2{fill:#aab2bb}
body.quarto-dark .dg .te,body.quarto-dark .dg .tv{fill:#ffc357}
body.quarto-dark .dg .tm{fill:#e8eaed}
body.quarto-dark .dg .enc{fill:#aab2bb}
body.quarto-dark .dg .ln{stroke:#8d98a3}
body.quarto-dark .dg .fl{fill:#8d98a3}
body.quarto-dark .dg .gr{stroke:#ffc357}
body.quarto-dark .dg .num{fill:#ffc357}
body.quarto-dark .dg .tn{fill:#1d1606}
body.quarto-dark .dg .nd{fill:#7fd0da}
body.quarto-dark .dg .pi{fill:#24211a;stroke:#806020}
body.quarto-dark .dg .vs{fill:#1f2429;stroke:#aab2bb}
body.quarto-dark .dg .vz{fill:#4f8f97}
body.quarto-dark .dg .vz2{fill:#2c4a4f}
body.quarto-dark .dg .vc,body.quarto-dark .dg .vd{stroke:#e8eaed}
body.quarto-dark .dg .bar{fill:#2b8a96}
"

# ---------------------------------------------------------------- utilidades
.dg_n <- local({ k <- 0; function() { k <<- k + 1; k } })
.dg_esc <- function(x) {
  x <- gsub("&", "&amp;", x, fixed = TRUE)
  x <- gsub("<", "&lt;", x, fixed = TRUE)
  gsub(">", "&gt;", x, fixed = TRUE)
}
# Ancho estimado de un texto (conservador para Roboto): así el texto nunca se sale de la caja
.dg_ancho <- function(txt, tam, negrita = FALSE) nchar(txt, type = "chars") * tam * if (negrita) 0.58 else 0.54
.dg_f <- function(v) formatC(v, format = "f", digits = 1)

.dg_svg <- function(ancho, alto, contenido, titulo) {
  id <- .dg_n()
  out <- paste0(
    '<svg class="dg" id="dg', id, '" viewBox="0 0 ', .dg_f(ancho), " ", .dg_f(alto),
    '" width="100%" style="max-width:', round(ancho), 'px" role="img" aria-label="', .dg_esc(titulo),
    '" xmlns="http://www.w3.org/2000/svg">',
    "<title>", .dg_esc(titulo), "</title>",
    "<style>", dg_css, "</style>",
    "<defs><marker id=\"dgf", id, "\" viewBox=\"0 0 10 10\" refX=\"8.5\" refY=\"5\" markerWidth=\"7\" markerHeight=\"7\" orient=\"auto-start-reverse\">",
    "<path class=\"fl\" d=\"M0,0.8L9.5,5L0,9.2Z\"/></marker>",
    "<marker id=\"dga", id, "\" viewBox=\"0 0 10 10\" refX=\"8.5\" refY=\"5\" markerWidth=\"7\" markerHeight=\"7\" orient=\"auto-start-reverse\">",
    "<path class=\"flA\" d=\"M0,0.8L9.5,5L0,9.2Z\"/></marker>",
    "<filter id=\"dgs", id, "\" x=\"-10%\" y=\"-20%\" width=\"120%\" height=\"150%\"><feDropShadow dx=\"0\" dy=\"2\" stdDeviation=\"2.5\" flood-color=\"#062a30\" flood-opacity=\"0.16\"/></filter></defs>",
    gsub("SOMBRA", paste0("url(#dgs", id, ")"), gsub("FLECHA", paste0("url(#dgf", id, ")"), gsub("FLECHAA", paste0("url(#dga", id, ")"), paste(contenido, collapse = ""), fixed = TRUE), fixed = TRUE), fixed = TRUE),
    "</svg>")
  knitr::asis_output(paste0("\n```{=html}\n", out, "\n```\n"))
}

.dg_texto <- function(x, y, txt, clase, tam, anchor = "middle") {
  paste0('<text x="', .dg_f(x), '" y="', .dg_f(y), '" class="', clase, '" font-size="', tam,
         '" text-anchor="', anchor, '">', .dg_esc(txt), "</text>")
}

# Caja con varias líneas. lineas: lista de c(texto, clase). Devuelve medidas y dibujo.
.dg_caja_medir <- function(lineas, tam = 15, pad_x = 18, pad_y = 12, inter = 1.35) {
  anchos <- vapply(lineas, function(l) .dg_ancho(l[1], tam, l[2] %in% c("t0", "t1", "tv")), 0)
  list(w = max(anchos) + 2 * pad_x, h = length(lineas) * tam * inter + 2 * pad_y - tam * (inter - 1),
       lineas = lineas, tam = tam, inter = inter, pad_y = pad_y)
}
.dg_caja_dibujar <- function(m, cx, cy, clase, w = m$w, h = m$h, rx = 10) {
  x <- cx - w / 2; y <- cy - h / 2
  s <- paste0('<rect x="', .dg_f(x), '" y="', .dg_f(y), '" width="', .dg_f(w), '" height="', .dg_f(h),
              '" rx="', rx, '" class="', clase, '" stroke-width="1.5" filter="SOMBRA"/>')
  if (clase == "c2") s <- c(s, paste0('<rect class="num" x="', .dg_f(x + 7), '" y="', .dg_f(y + 9), '" width="4" height="',
                                      .dg_f(h - 18), '" rx="2"/>'))
  n <- length(m$lineas); paso <- m$tam * m$inter
  y0 <- cy - (n - 1) * paso / 2
  for (i in seq_len(n)) {
    tam_i <- if (m$lineas[[i]][2] %in% c("t2", "te")) m$tam - 1.5 else m$tam
    s <- c(s, .dg_texto(cx, y0 + (i - 1) * paso, m$lineas[[i]][1], m$lineas[[i]][2], tam_i))
  }
  paste(s, collapse = "")
}

# ---------------------------------------------------------------- árbol jerárquico (arriba hacia abajo)
# raiz: lista de líneas; ramas: lista de list(caja = líneas, hojas = lista de líneas)
dg_jerarquia <- function(raiz, ramas, titulo = "Diagrama jerárquico", tam = 16) {
  hojas <- unlist(lapply(ramas, `[[`, "hojas"), recursive = FALSE)
  mh <- lapply(hojas, .dg_caja_medir, tam = tam)
  wh <- max(vapply(mh, `[[`, 0, "w")); hh <- max(vapply(mh, `[[`, 0, "h"))
  mr <- lapply(ramas, function(r) .dg_caja_medir(r$caja, tam = tam))
  wr <- max(vapply(mr, `[[`, 0, "w"), wh * 0.9); hr <- max(vapply(mr, `[[`, 0, "h"))
  m0 <- .dg_caja_medir(raiz, tam = tam + 1)
  w0 <- max(m0$w, 170); h0 <- m0$h
  gap <- 24; marg <- 16; nv <- 48
  n <- length(hojas)
  ancho <- 2 * marg + n * wh + (n - 1) * gap
  xh <- marg + wh / 2 + (seq_len(n) - 1) * (wh + gap)
  y0 <- marg + h0 / 2; y1 <- y0 + h0 / 2 + nv + hr / 2; y2 <- y1 + hr / 2 + nv + hh / 2
  alto <- y2 + hh / 2 + marg
  k <- 0; xr <- numeric(length(ramas)); hijos <- list()
  for (i in seq_along(ramas)) {
    idx <- k + seq_along(ramas[[i]]$hojas); k <- max(idx)
    xr[i] <- mean(xh[idx]); hijos[[i]] <- idx
  }
  x0 <- mean(xr)
  codo <- function(xa, ya, xb, yb) { # conector ortogonal con esquinas redondeadas
    ym <- (ya + yb) / 2; r <- min(10, abs(xb - xa) / 2)
    if (abs(xb - xa) < 1) return(paste0('<path class="ln" d="M', .dg_f(xa), ",", .dg_f(ya), "V", .dg_f(yb), '"/>'))
    sg <- sign(xb - xa)
    paste0('<path class="ln" d="M', .dg_f(xa), ",", .dg_f(ya), "V", .dg_f(ym - r),
           "Q", .dg_f(xa), ",", .dg_f(ym), " ", .dg_f(xa + sg * r), ",", .dg_f(ym),
           "H", .dg_f(xb - sg * r), "Q", .dg_f(xb), ",", .dg_f(ym), " ", .dg_f(xb), ",", .dg_f(ym + r),
           "V", .dg_f(yb), '"/>')
  }
  s <- character()
  for (i in seq_along(ramas)) {
    s <- c(s, codo(x0, y0 + h0 / 2, xr[i], y1 - hr / 2))
    for (j in hijos[[i]]) s <- c(s, codo(xr[i], y1 + hr / 2, xh[j], y2 - hh / 2))
  }
  s <- c(s, .dg_caja_dibujar(m0, x0, y0, "c0", w = w0, h = h0))
  for (i in seq_along(ramas)) s <- c(s, .dg_caja_dibujar(mr[[i]], xr[i], y1, "c1", w = wr, h = hr))
  for (j in seq_len(n)) s <- c(s, .dg_caja_dibujar(mh[[j]], xh[j], y2, "c2", w = wh, h = hh))
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- flujo de pasos (izquierda a derecha)
# pasos: lista de líneas por paso; grupo: c(primero, último) dentro de un recuadro discontinuo;
# regreso: lista de pares c(desde, hasta) dibujados como flechas curvas por encima;
# notas: texto opcional debajo de cada caja
dg_flujo <- function(pasos, grupo = NULL, regreso = list(), notas = NULL, numerar = TRUE,
                     titulo = "Diagrama de flujo", tam = 15, clase = "c1", por_fila = NULL) {
  m <- lapply(pasos, .dg_caja_medir, tam = tam, pad_x = 14)
  w <- max(vapply(m, `[[`, 0, "w")); h <- max(vapply(m, `[[`, 0, "h"))
  n <- length(pasos); k <- if (is.null(por_fila)) n else por_fila
  gap <- 38; marg <- 18; vgap <- 54 + (if (!is.null(notas)) 26 else 0)
  arriba <- if (length(regreso)) 62 else if (numerar) 26 else 14
  fila <- (seq_len(n) - 1) %/% k; col <- (seq_len(n) - 1) %% k
  ancho <- 2 * marg + min(n, k) * w + (min(n, k) - 1) * gap
  xc <- marg + w / 2 + col * (w + gap)
  yc <- marg + arriba + h / 2 + fila * (h + vgap)
  alto <- max(yc) + h / 2 + marg + (if (!is.null(notas)) 30 else 0) + (if (!is.null(grupo)) 8 else 0)
  s <- character()
  if (!is.null(grupo)) {
    xa <- xc[grupo[1]] - w / 2 - 12; xb <- xc[grupo[2]] + w / 2 + 12; y0 <- yc[grupo[1]]
    s <- c(s, paste0('<rect class="gr" x="', .dg_f(xa), '" y="', .dg_f(y0 - h / 2 - arriba + 8), '" width="',
                     .dg_f(xb - xa), '" height="', .dg_f(h + arriba + 4), '" rx="14"/>'))
  }
  for (i in seq_len(n - 1)) {
    if (fila[i] == fila[i + 1]) {
      s <- c(s, paste0('<path class="ln" d="M', .dg_f(xc[i] + w / 2 + 3), ",", .dg_f(yc[i]), "H",
                       .dg_f(xc[i + 1] - w / 2 - 4), '" marker-end="FLECHA"/>'))
    } else { # salto de fila: baja, cruza hacia la izquierda y entra por arriba
      ya <- yc[i] + h / 2 + (if (!is.null(notas)) 30 else 4); yb <- yc[i + 1] - h / 2 - 4; ym <- (ya + yb) / 2 + 4; r <- 12
      s <- c(s, paste0('<path class="ln" d="M', .dg_f(xc[i]), ",", .dg_f(ya), "V", .dg_f(ym - r),
                       "Q", .dg_f(xc[i]), ",", .dg_f(ym), " ", .dg_f(xc[i] - r), ",", .dg_f(ym),
                       "H", .dg_f(xc[i + 1] + r), "Q", .dg_f(xc[i + 1]), ",", .dg_f(ym), " ", .dg_f(xc[i + 1]), ",", .dg_f(ym + r),
                       "V", .dg_f(yb), '" marker-end="FLECHA"/>'))
    }
  }
  for (r in regreso) {
    xa <- xc[r[1]]; xb <- xc[r[2]]; ya <- yc[r[1]] - h / 2 - 3; yt <- ya - 40
    s <- c(s, paste0('<path class="ln" d="M', .dg_f(xa - 14), ",", .dg_f(ya), "C", .dg_f(xa - 14), ",", .dg_f(yt), " ",
                     .dg_f(xb + 14), ",", .dg_f(yt), " ", .dg_f(xb + 14), ",", .dg_f(ya - 1), '" marker-end="FLECHA"/>'))
  }
  for (i in seq_len(n)) {
    s <- c(s, .dg_caja_dibujar(m[[i]], xc[i], yc[i], clase, w = w, h = h))
    if (numerar) {
      cxn <- xc[i] - w / 2 + 2; cyn <- yc[i] - h / 2 + 2
      s <- c(s, paste0('<circle class="num" cx="', .dg_f(cxn), '" cy="', .dg_f(cyn), '" r="12"/>'),
             .dg_texto(cxn, cyn, as.character(i), "tn", 13))
    }
    if (!is.null(notas)) s <- c(s, .dg_texto(xc[i], yc[i] + h / 2 + 20, notas[i], "t2", tam - 1))
  }
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- árbol de izquierda a derecha
# nivel1, nivel2: rótulos de los nodos; p1, p2: probabilidades de las ramas (texto), opcionales;
# resultados: texto a la derecha de cada hoja; valores: segunda columna opcional (por ejemplo,
# la probabilidad del camino); encabezados: títulos de las columnas
dg_arbol <- function(nivel1, nivel2, p1 = NULL, p2 = NULL, resultados = NULL, valores = NULL,
                     encabezados = NULL, titulo = "Diagrama de árbol", tam = 15) {
  k1 <- length(nivel1); k2 <- length(nivel2)
  paso <- 46; marg <- 18; sup <- if (is.null(encabezados)) 10 else 40
  nh <- k1 * k2
  y2 <- marg + sup + paso / 2 + (seq_len(nh) - 1) * paso
  y1 <- vapply(seq_len(k1), function(i) mean(y2[(i - 1) * k2 + seq_len(k2)]), 0)
  yr <- mean(y2)
  rot2 <- rep(nivel2, k1)
  w1 <- max(46, .dg_ancho(nivel1, tam, TRUE) + 26); w2 <- max(46, .dg_ancho(nivel2, tam, TRUE) + 26)
  hn <- 30
  xr <- marg + 8; x1 <- xr + 190; x2 <- x1 + w1 / 2 + 170 + w2 / 2
  xres <- x2 + w2 / 2 + 56
  wres <- if (is.null(resultados)) 0 else max(.dg_ancho(resultados, tam))
  enc_w <- function(i) if (is.null(encabezados) || length(encabezados) < i) 0 else .dg_ancho(encabezados[i], 12, TRUE) * 1.25
  wres <- max(wres, enc_w(3))
  xval <- xres + wres + 56
  wval <- if (is.null(valores)) 0 else max(.dg_ancho(valores, tam, TRUE), enc_w(4))
  ancho <- (if (is.null(valores)) xres + wres else xval + wval) + marg
  alto <- max(y2) + paso / 2 + marg
  curva <- function(xa, ya, xb, yb) {
    xm <- (xa + xb) / 2
    paste0('<path class="ln" d="M', .dg_f(xa), ",", .dg_f(ya), "C", .dg_f(xm), ",", .dg_f(ya), " ",
           .dg_f(xm), ",", .dg_f(yb), " ", .dg_f(xb), ",", .dg_f(yb), '"/>')
  }
  pastilla <- function(x, y, txt) {
    wp <- .dg_ancho(txt, tam - 2, TRUE) + 14
    paste0('<rect class="pi" x="', .dg_f(x - wp / 2), '" y="', .dg_f(y - 11), '" width="', .dg_f(wp),
           '" height="22" rx="11" stroke-width="1.2"/>', .dg_texto(x, y, txt, "tv", tam - 2))
  }
  nodo <- function(x, y, txt, w, clase) {
    paste0('<rect class="', clase, '" x="', .dg_f(x - w / 2), '" y="', .dg_f(y - hn / 2), '" width="', .dg_f(w),
           '" height="', hn, '" rx="', hn / 2, '" stroke-width="1.5" filter="SOMBRA"/>', .dg_texto(x, y, txt, "t1", tam))
  }
  s <- character()
  for (i in seq_len(k1)) s <- c(s, curva(xr, yr, x1 - w1 / 2, y1[i]))
  for (j in seq_len(nh)) s <- c(s, curva(x1 + w1 / 2, y1[(j - 1) %/% k2 + 1], x2 - w2 / 2, y2[j]))
  if (!is.null(p1)) for (i in seq_len(k1)) s <- c(s, pastilla((xr + x1 - w1 / 2) / 2, (yr + y1[i]) / 2, p1[i]))
  if (!is.null(p2)) for (j in seq_len(nh)) {
    ya <- y1[(j - 1) %/% k2 + 1]; s <- c(s, pastilla((x1 + w1 / 2 + x2 - w2 / 2) / 2, (ya + y2[j]) / 2, p2[j]))
  }
  s <- c(s, paste0('<circle class="nd" cx="', .dg_f(xr), '" cy="', .dg_f(yr), '" r="6"/>'))
  for (i in seq_len(k1)) s <- c(s, nodo(x1, y1[i], nivel1[i], w1, "c1"))
  for (j in seq_len(nh)) s <- c(s, nodo(x2, y2[j], rot2[j], w2, "c2"))
  if (!is.null(resultados)) for (j in seq_len(nh)) s <- c(s, .dg_texto(xres, y2[j], resultados[j], "t2", tam, "start"))
  if (!is.null(valores)) for (j in seq_len(nh)) s <- c(s, .dg_texto(xval + wval, y2[j], valores[j], "tv", tam, "end"))
  if (!is.null(encabezados)) {
    xs <- c(x1, x2, if (!is.null(resultados)) xres, if (!is.null(valores)) xval + wval)
    an <- c("middle", "middle", if (!is.null(resultados)) "start", if (!is.null(valores)) "end")
    for (i in seq_along(encabezados)) s <- c(s, .dg_texto(xs[i], marg + 10, toupper(encabezados[i]), "enc", 12, an[i]))
  }
  .dg_svg(ancho, alto, s, titulo)
}

# Árbol de probabilidad de dos niveles: calcula las probabilidades de los caminos
# p1: vector; p2: matriz (una fila por rama del primer nivel). et_p1, et_p2: cómo mostrarlas
dg_arbol_prob <- function(nivel1, p1, nivel2, p2, unir = " y ", et_p1 = format(p1), et_p2 = format(as.vector(t(p2))),
                          titulo = "Árbol de probabilidad") {
  k2 <- length(nivel2)
  caminos <- paste0(rep(nivel1, each = k2), unir, rep(nivel2, length(nivel1)))
  conj <- sprintf("%.3f", rep(p1, each = k2) * as.vector(t(p2)))
  dg_arbol(nivel1, nivel2, p1 = et_p1, p2 = et_p2, resultados = caminos, valores = conj,
           encabezados = c("Etapa 1", "Etapa 2", "Camino", "Probabilidad"), titulo = titulo)
}

# ---------------------------------------------------------------- diagramas de Venn
# paneles: lista de list(titulo, region, secundaria = NULL, punteado = NULL, marco = TRUE)
# region y secundaria: "A", "B", "AuB", "AnB", "Ac", "A-B", "B-A", "ninguno"
dg_venn <- function(paneles, ncol = length(paneles), titulo = "Diagramas de Venn", tam = 15) {
  pw <- 250; ph <- 170; tit <- 34; gap <- 26; marg <- 14
  nf <- ceiling(length(paneles) / ncol)
  ancho <- 2 * marg + ncol * pw + (ncol - 1) * gap
  alto <- 2 * marg + nf * (ph + tit) + (nf - 1) * gap
  id <- .dg_n(); r <- 58; d <- 40
  s <- character()
  for (k in seq_along(paneles)) {
    p <- paneles[[k]]; fi <- (k - 1) %/% ncol; co <- (k - 1) %% ncol
    x0 <- marg + co * (pw + gap); y0 <- marg + fi * (ph + tit + gap)
    cx <- x0 + pw / 2; cy <- y0 + tit + ph / 2; xa <- cx - d; xb <- cx + d
    pre <- paste0("v", id, "_", k)
    circ <- function(x, extra = "") paste0('<circle cx="', .dg_f(x), '" cy="', .dg_f(cy), '" r="', r, '"', extra, "/>")
    rectS <- function(extra = "") paste0('<rect x="', .dg_f(x0 + 6), '" y="', .dg_f(y0 + tit + 4), '" width="', pw - 12,
                                         '" height="', ph - 8, '" rx="8"', extra, "/>")
    s <- c(s, paste0("<defs>",
      '<clipPath id="', pre, 'cb">', circ(xb), "</clipPath>",
      '<mask id="', pre, 'ma" maskUnits="userSpaceOnUse">', rectS(' fill="#fff"'), circ(xa, ' fill="#000"'), "</mask>",
      '<mask id="', pre, 'mb" maskUnits="userSpaceOnUse">', rectS(' fill="#fff"'), circ(xb, ' fill="#000"'), "</mask>",
      '<mask id="', pre, 'mab" maskUnits="userSpaceOnUse">', rectS(' fill="#fff"'), circ(xa, ' fill="#000"'), circ(xb, ' fill="#000"'), "</mask>",
      "</defs>"))
    region <- function(reg, clase) switch(reg,
      "A" = circ(xa, paste0(' class="', clase, '"')),
      "B" = circ(xb, paste0(' class="', clase, '"')),
      "AuB" = paste0(circ(xa, paste0(' class="', clase, '"')), circ(xb, paste0(' class="', clase, '"'))),
      "AnB" = circ(xa, paste0(' class="', clase, '" clip-path="url(#', pre, 'cb)"')),
      "Ac" = rectS(paste0(' class="', clase, '" mask="url(#', pre, 'ma)"')),
      "A-B" = circ(xa, paste0(' class="', clase, '" mask="url(#', pre, 'mb)"')),
      "B-A" = circ(xb, paste0(' class="', clase, '" mask="url(#', pre, 'ma)"')),
      "ninguno" = rectS(paste0(' class="', clase, '" mask="url(#', pre, 'mab)"')))
    marco <- if (is.null(p$marco)) TRUE else p$marco
    if (marco) s <- c(s, rectS(' class="vs"'))
    if (!is.null(p$secundaria)) s <- c(s, region(p$secundaria, "vz2"))
    if (marco && p$region == "AuB") s <- s # la unión no necesita fondo extra
    s <- c(s, region(p$region, "vz"))
    pa <- if (!is.null(p$punteado) && "A" %in% p$punteado) "vd" else "vc"
    pb <- if (!is.null(p$punteado) && "B" %in% p$punteado) "vd" else "vc"
    s <- c(s, circ(xa, paste0(' class="', pa, '"')), circ(xb, paste0(' class="', pb, '"')))
    s <- c(s, .dg_texto(xa - r * 0.92, cy - r * 0.92, "A", "tm", tam + 3), .dg_texto(xb + r * 0.92, cy - r * 0.92, "B", "tm", tam + 3))
    if (marco) s <- c(s, .dg_texto(x0 + pw - 20, y0 + tit + ph - 20, "S", "tm", tam + 2))
    s <- c(s, .dg_texto(cx, y0 + tit / 2, p$titulo, "t1", tam))
  }
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- esquema de ventanas (paneles de RStudio)
# paneles: lista de list(titulo, detalle = líneas) en orden: arriba izq., abajo izq., arriba der., abajo der.
dg_paneles <- function(paneles, barra = "RStudio", titulo = "Esquema de paneles", tam = 15) {
  ancho <- 900; marg <- 12; hb <- 34; gap <- 12
  wcol <- (ancho - 2 * marg - gap) / 2; hfila <- 175; htit <- 36
  alto <- marg + hb + gap + 2 * hfila + gap + marg
  s <- c(paste0('<rect class="bar" x="', marg, '" y="', marg, '" width="', ancho - 2 * marg, '" height="', hb, '" rx="8"/>'),
         .dg_texto(marg + 16, marg + hb / 2, barra, "tb", tam, "start"))
  for (k in seq_along(paneles)) {
    co <- (k - 1) %/% 2; fi <- (k - 1) %% 2
    x <- marg + co * (wcol + gap); y <- marg + hb + gap + fi * (hfila + gap)
    p <- paneles[[k]]
    s <- c(s, paste0('<rect class="c2" x="', .dg_f(x), '" y="', .dg_f(y), '" width="', .dg_f(wcol), '" height="', hfila,
                     '" rx="10" stroke-width="1.5"/>'),
           paste0('<path class="c0" d="M', .dg_f(x), ",", .dg_f(y + htit), "V", .dg_f(y + 10), "Q", .dg_f(x), ",", .dg_f(y), " ",
                  .dg_f(x + 10), ",", .dg_f(y), "H", .dg_f(x + wcol - 10), "Q", .dg_f(x + wcol), ",", .dg_f(y), " ",
                  .dg_f(x + wcol), ",", .dg_f(y + 10), "V", .dg_f(y + htit), 'Z"/>'),
           '<circle class="num" cx="', .dg_f(x + 20), '" cy="', .dg_f(y + htit / 2), '" r="11"/>',
           .dg_texto(x + 20, y + htit / 2, as.character(k), "tn", 12),
           .dg_texto(x + 40, y + htit / 2, p$titulo, "t0", tam, "start"))
    nl <- length(p$detalle); yc <- y + htit + (hfila - htit) / 2
    for (i in seq_len(nl)) s <- c(s, .dg_texto(x + wcol / 2, yc + (i - (nl + 1) / 2) * tam * 1.45, p$detalle[i], "t2", tam))
  }
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- clases adicionales
dg_css <- paste0(dg_css, "
.dg .c4{fill:#a26800;stroke:#a26800}
.dg .pt{fill:#a3abb4}
.dg .ptsel{fill:#0f5560}
.dg .anillo{fill:none;stroke:#b8c0c8;stroke-width:1.4}
.dg .cruz{stroke:#3b3f45;stroke-width:2}
.dg .lnA{fill:none;stroke:#a26800;stroke-width:2.2}
.dg .flA{fill:#a26800}
.dg .seg{fill:none;stroke:#0f5560;stroke-width:3;stroke-linecap:round}
.dg .segA{fill:none;stroke:#e09a1a;stroke-width:9;stroke-linecap:round;stroke-opacity:.75}
.dg .v1{fill:#0f5560;fill-opacity:.16;stroke:#0f5560;stroke-width:1.8}
.dg .v2{fill:#a26800;fill-opacity:.16;stroke:#a26800;stroke-width:1.8}
.dg .v3{fill:#b5533c;fill-opacity:.14;stroke:#b5533c;stroke-width:1.8}
body.quarto-dark .dg .c4{fill:#ffc357;stroke:#ffc357}
body.quarto-dark .dg .pt{fill:#5d6670}
body.quarto-dark .dg .ptsel{fill:#7fd0da}
body.quarto-dark .dg .anillo{stroke:#4b545e}
body.quarto-dark .dg .cruz{stroke:#e8eaed}
body.quarto-dark .dg .lnA{stroke:#ffc357}
body.quarto-dark .dg .flA{fill:#ffc357}
body.quarto-dark .dg .seg{stroke:#7fd0da}
body.quarto-dark .dg .segA{stroke:#ffc357}
body.quarto-dark .dg .v1{fill:#7fd0da;stroke:#7fd0da;fill-opacity:.16}
body.quarto-dark .dg .v2{fill:#ffc357;stroke:#ffc357;fill-opacity:.14}
body.quarto-dark .dg .v3{fill:#f0a596;stroke:#f0a596;fill-opacity:.14}
")

.dg_rect <- function(x, y, w, h, clase, rx = 10, sombra = TRUE) {
  paste0('<rect x="', .dg_f(x), '" y="', .dg_f(y), '" width="', .dg_f(w), '" height="', .dg_f(h), '" rx="', rx,
         '" class="', clase, '" stroke-width="1.5"', if (sombra) ' filter="SOMBRA"' else "", "/>")
}
.dg_pastilla <- function(x, y, txt, tam = 13) {
  wp <- .dg_ancho(txt, tam, TRUE) + 16
  paste0('<rect class="pi" x="', .dg_f(x - wp / 2), '" y="', .dg_f(y - 11), '" width="', .dg_f(wp),
         '" height="22" rx="11" stroke-width="1.2"/>', .dg_texto(x, y, txt, "tv", tam))
}
.dg_flecha <- function(d, clase = "ln") paste0('<path class="', clase, '" d="', d, '" marker-end="FLECHA"/>')

# ---------------------------------------------------------------- árbol de decisión (cualquier profundidad)
# nodo: list(lineas = lista de c(texto, clase), clase = "c1" | "c3" | ..., hijos = list(list(etiqueta, nodo), ...))
# nota: líneas de texto opcionales debajo del árbol
dg_decision <- function(raiz, nota = NULL, titulo = "Diagrama de decisión", tam = 15) {
  hojas <- list(); prof <- 0
  recorrer <- function(n, d) {
    n$m <- .dg_caja_medir(n$lineas, tam = tam); n$d <- d; prof <<- max(prof, d)
    if (length(n$hijos)) for (i in seq_along(n$hijos)) n$hijos[[i]]$nodo <- recorrer(n$hijos[[i]]$nodo, d + 1)
    n
  }
  raiz <- recorrer(raiz, 0)
  todos <- list(); juntar <- function(n) { todos[[length(todos) + 1]] <<- n; for (h in n$hijos) juntar(h$nodo) }
  juntar(raiz)
  esh <- vapply(todos, function(n) length(n$hijos) == 0, TRUE)
  wh <- max(vapply(todos[esh], function(n) n$m$w, 0))
  hniv <- vapply(0:prof, function(d) max(vapply(Filter(function(n) n$d == d, todos), function(n) n$m$h, 0)), 0)
  gap <- 22; marg <- 16; nv <- 64
  yniv <- marg + hniv[1] / 2 + c(0, cumsum((hniv[-1] + hniv[-length(hniv)]) / 2 + nv))
  k <- 0
  colocar <- function(n) {
    if (!length(n$hijos)) { k <<- k + 1; n$x <- marg + wh / 2 + (k - 1) * (wh + gap); return(n) }
    for (i in seq_along(n$hijos)) n$hijos[[i]]$nodo <- colocar(n$hijos[[i]]$nodo)
    n$x <- mean(vapply(n$hijos, function(h) h$nodo$x, 0)); n
  }
  raiz <- colocar(raiz)
  ancho <- 2 * marg + k * wh + (k - 1) * gap
  alto <- max(yniv) + hniv[prof + 1] / 2 + marg + if (!is.null(nota)) 16 + length(nota) * tam * 1.4 else 0
  lineas <- character(); cajas <- character()
  dibujar <- function(n) {
    y <- yniv[n$d + 1]; h <- hniv[n$d + 1]; w <- if (length(n$hijos)) n$m$w else wh
    for (hj in n$hijos) {
      c <- hj$nodo; yc <- yniv[c$d + 1] - hniv[c$d + 1] / 2; ya <- y + h / 2; ym <- ya + (yc - ya) * 0.42; r <- 10
      sg <- sign(c$x - n$x)
      d <- if (abs(c$x - n$x) < 1) paste0("M", .dg_f(n$x), ",", .dg_f(ya), "V", .dg_f(yc - 2)) else
        paste0("M", .dg_f(n$x), ",", .dg_f(ya), "V", .dg_f(ym - r), "Q", .dg_f(n$x), ",", .dg_f(ym), " ", .dg_f(n$x + sg * r), ",", .dg_f(ym),
               "H", .dg_f(c$x - sg * r), "Q", .dg_f(c$x), ",", .dg_f(ym), " ", .dg_f(c$x), ",", .dg_f(ym + r), "V", .dg_f(yc - 2))
      lineas <<- c(lineas, .dg_flecha(d))
      if (!is.null(hj$etiqueta)) lineas <<- c(lineas, .dg_pastilla(c$x, (ym + yc) / 2 + 2, hj$etiqueta))
      dibujar(c)
    }
    cajas <<- c(cajas, .dg_caja_dibujar(n$m, n$x, y, if (is.null(n$clase)) "c1" else n$clase, w = w, h = if (length(n$hijos)) n$m$h else h))
  }
  dibujar(raiz)
  s <- c(lineas, cajas)
  if (!is.null(nota)) {
    y0 <- max(yniv) + hniv[prof + 1] / 2 + 16 + tam
    for (i in seq_along(nota)) s <- c(s, .dg_texto(ancho / 2, y0 + (i - 1) * tam * 1.4, nota[i], "t2", tam - 1))
  }
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- sistemas en serie y en paralelo
dg_sistemas <- function(n = 3, titulos = c("En serie: funciona si funcionan todos", "En paralelo: funciona si funciona al menos uno"),
                        titulo = "Sistemas en serie y en paralelo", tam = 15) {
  ancho <- 760; marg <- 16; lb <- 54; hb <- 44; ent <- 92
  x0 <- marg + ent; x1 <- ancho - marg - ent
  s <- character()
  # serie
  ys <- marg + 30 + hb / 2 + 8
  s <- c(s, .dg_texto(ancho / 2, marg + 12, titulos[1], "t1", tam))
  s <- c(s, paste0('<path class="ln" d="M', x0, ",", .dg_f(ys), "H", x1, '"/>'))
  xs <- seq(x0, x1, length.out = n + 2)[-c(1, n + 2)]
  for (i in seq_len(n)) s <- c(s, .dg_rect(xs[i] - lb / 2, ys - hb / 2, lb, hb, "c1"), .dg_texto(xs[i], ys, i, "t1", tam + 1))
  s <- c(s, .dg_texto(x0 - 10, ys, "Entrada", "t2", tam - 1, "end"), .dg_texto(x1 + 10, ys, "Salida", "t2", tam - 1, "start"))
  # paralelo
  yt <- ys + hb / 2 + 50
  s <- c(s, .dg_texto(ancho / 2, yt, titulos[2], "t1", tam))
  yp <- yt + 26 + hb / 2 + (seq_len(n) - 1) * (hb + 14)
  ym <- mean(yp); xa <- ancho / 2 - 120; xb <- ancho / 2 + 120
  s <- c(s, paste0('<path class="ln" d="M', x0, ",", .dg_f(ym), "H", xa, "M", xb, ",", .dg_f(ym), "H", x1,
                   "M", xa, ",", .dg_f(min(yp)), "V", .dg_f(max(yp)), "M", xb, ",", .dg_f(min(yp)), "V", .dg_f(max(yp)), '"/>'))
  for (i in seq_len(n)) s <- c(s, paste0('<path class="ln" d="M', xa, ",", .dg_f(yp[i]), "H", xb, '"/>'),
                               .dg_rect(ancho / 2 - lb / 2, yp[i] - hb / 2 + 4, lb, hb - 8, "c3"), .dg_texto(ancho / 2, yp[i], i, "t1", tam + 1))
  s <- c(s, .dg_texto(x0 - 10, ym, "Entrada", "t2", tam - 1, "end"), .dg_texto(x1 + 10, ym, "Salida", "t2", tam - 1, "start"))
  alto <- max(yp) + hb / 2 + marg
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- Venn de tres eventos con el valor de cada región
# valores: c(solo A, solo B, solo C, A y B sin C, A y C sin B, B y C sin A, los tres, fuera)
dg_venn3 <- function(nombres, valores, titulo = "Diagrama de Venn de tres eventos", tam = 15) {
  esc <- 92; ancho <- 520; alto <- 470; cx <- ancho / 2; cy <- 232
  P <- function(x, y) c(cx + x * esc, cy - y * esc)
  cen <- list(P(-0.55, 0.35), P(0.55, 0.35), P(0, -0.55))
  s <- .dg_rect(14, 14, ancho - 28, alto - 28, "vs", rx = 12, sombra = FALSE)
  for (i in 1:3) s <- c(s, paste0('<circle class="v', i, '" cx="', .dg_f(cen[[i]][1]), '" cy="', .dg_f(cen[[i]][2]), '" r="', esc, '"/>'))
  pos <- list(c(-1.02, 0.62), c(1.02, 0.62), c(0, -1.12), c(0, 0.82), c(-0.62, -0.32), c(0.62, -0.32), c(0, 0.04))
  for (i in 1:7) { p <- P(pos[[i]][1], pos[[i]][2]); s <- c(s, .dg_texto(p[1], p[2], valores[i], "t1", tam)) }
  s <- c(s, .dg_texto(ancho - 40, alto - 40, valores[8], "tv", tam, "end"))
  rot <- list(P(-1.62, 1.6), P(1.62, 1.6), P(0, -1.8))
  an <- c("start", "end", "middle")
  for (i in 1:3) s <- c(s, .dg_texto(rot[[i]][1], rot[[i]][2], nombres[i], "t1", tam, an[i]))
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- partición del espacio muestral y un evento B
dg_particion <- function(cortes = c(0.45, 0.8), titulo = "Partición del espacio muestral", tam = 16) {
  ancho <- 640; alto <- 330; x0 <- 20; y0 <- 20; w <- ancho - 40; h <- alto - 40
  bx <- x0 + w * 0.5; by <- y0 + h * 0.52; rx <- w * 0.4; ry <- h * 0.3
  lim <- c(0, cortes, 1); k <- length(lim) - 1; id <- .dg_n()
  clases <- c("v1", "v2", "v3", "v1", "v2")
  s <- .dg_rect(x0, y0, w, h, "vs", rx = 10, sombra = FALSE)
  for (i in seq_len(k)) {
    xa <- x0 + lim[i] * w; xb <- x0 + lim[i + 1] * w
    s <- c(s, paste0('<clipPath id="p', id, "_", i, '"><rect x="', .dg_f(xa), '" y="', y0, '" width="', .dg_f(xb - xa), '" height="', h, '"/></clipPath>'),
           paste0('<ellipse class="', clases[i], '" cx="', .dg_f(bx), '" cy="', .dg_f(by), '" rx="', .dg_f(rx), '" ry="', .dg_f(ry),
                  '" clip-path="url(#p', id, "_", i, ')" stroke="none"/>'))
    xm <- (max(xa, bx - rx) + min(xb, bx + rx)) / 2
    s <- c(s, .dg_texto((xa + xb) / 2, y0 + 30, paste0("A", c("₁", "₂", "₃", "₄", "₅")[i]), "tm", tam + 4),
           .dg_texto(xm, by, paste0("B ∩ A", c("₁", "₂", "₃", "₄", "₅")[i]), "tm", tam))
  }
  for (cc in cortes) s <- c(s, paste0('<path class="vc" d="M', .dg_f(x0 + cc * w), ",", y0, "V", y0 + h, '"/>'))
  s <- c(s, paste0('<ellipse class="vc" cx="', .dg_f(bx), '" cy="', .dg_f(by), '" rx="', .dg_f(rx), '" ry="', .dg_f(ry), '"/>'),
         .dg_texto(bx - rx * 0.62, by + ry * 0.62, "B", "tm", tam + 4))
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- triángulo de Pascal
# suma: lista de c(n, k) resaltadas como sumandos; resultado: c(n, k)
dg_pascal <- function(n = 8, suma = list(), resultado = NULL, titulo = "Triángulo de Pascal", tam = 14) {
  dx <- 50; dy <- 40; wb <- 44; hb <- 28; marg <- 16; izq <- 70
  ancho <- izq + (n + 1) * dx + marg; alto <- marg * 2 + n * dy + hb
  cx <- izq + (n + 1) * dx / 2
  s <- character()
  for (i in 0:n) {
    y <- marg + hb / 2 + i * dy
    s <- c(s, .dg_texto(marg, y, paste0("n = ", i), "t2", tam - 1, "start"))
    for (k in 0:i) {
      x <- cx + (k - i / 2) * dx
      cl <- "c2"; tc <- "t1"
      if (any(vapply(suma, function(p) p[1] == i && p[2] == k, TRUE))) cl <- "c3"
      if (!is.null(resultado) && resultado[1] == i && resultado[2] == k) { cl <- "c4"; tc <- "t0" }
      s <- c(s, .dg_rect(x - wb / 2, y - hb / 2, wb, hb, cl, rx = 8), .dg_texto(x, y, choose(i, k), tc, tam))
    }
  }
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- tres clases de espacio muestral
dg_espacios <- function(titulo = "Tres clases de espacio muestral", tam = 15) {
  ancho <- 820; marg <- 16; xi <- 250; fila <- 92; alto <- marg * 2 + 3 * fila
  rot <- list(c("Finito", "cara de un dado"), c("Infinito numerable", "vehículos por minuto"), c("Continuo", "lluvia de un día"))
  s <- character()
  for (i in 1:3) {
    y <- marg + fila / 2 + (i - 1) * fila
    s <- c(s, .dg_texto(marg, y - 10, rot[[i]][1], "t1", tam, "start"), .dg_texto(marg, y + 12, rot[[i]][2], "te", tam - 1, "start"))
    if (i > 1) s <- c(s, paste0('<path class="anillo" d="M', marg, ",", .dg_f(y - fila / 2), "H", ancho - marg, '"/>'))
  }
  y1 <- marg + fila / 2
  for (j in 1:6) { x <- xi + (j - 1) * 64; s <- c(s, paste0('<circle class="nd" cx="', x, '" cy="', y1 + 8, '" r="7"/>'), .dg_texto(x, y1 - 14, j, "t2", tam)) }
  y2 <- y1 + fila
  for (j in 0:8) { x <- xi + j * 56; s <- c(s, paste0('<circle class="nd" cx="', x, '" cy="', y2 + 8, '" r="7"/>'), .dg_texto(x, y2 - 14, j, "t2", tam)) }
  s <- c(s, .dg_texto(xi + 9 * 56, y2 + 6, "…", "t1", tam + 6))
  y3 <- y2 + fila + 6; x50 <- xi + 230; xf <- ancho - marg - 10
  s <- c(s, paste0('<path class="segA" d="M', x50, ",", y3, "H", xf - 14, '"/>'),
         paste0('<path class="seg" d="M', xi, ",", y3, "H", xf, '" marker-end="FLECHA"/>'),
         paste0('<circle class="nd" cx="', xi, '" cy="', y3, '" r="6"/>'),
         .dg_texto(xi, y3 + 22, "0 mm", "t2", tam - 1), .dg_texto(x50, y3 + 22, "50 mm", "t2", tam - 1),
         .dg_texto((x50 + xf) / 2, y3 - 22, "Evento: llueve más de 50 mm", "tv", tam - 1))
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- población, muestra e inferencia
dg_poblacion_muestra <- function(titulo = "Población, muestra e inferencia", tam = 15, semilla = 11) {
  set.seed(semilla)
  ancho <- 860; alto <- 380
  px <- 220; py <- 190; prx <- 190; pry <- 120
  mx <- 690; my <- 190; mrx <- 95; mry <- 64
  r <- sqrt(runif(240)); t <- runif(240, 0, 2 * pi)
  pts <- cbind(px + 0.88 * prx * r * cos(t), py + 0.85 * pry * r * sin(t))
  sel <- sample(nrow(pts), 12)
  r2 <- sqrt(runif(12)); t2 <- runif(12, 0, 2 * pi)
  mp <- cbind(mx + 0.75 * mrx * r2 * cos(t2), my + 0.7 * mry * r2 * sin(t2))
  s <- c(paste0('<ellipse class="c2" cx="', px, '" cy="', py, '" rx="', prx, '" ry="', pry, '" stroke-width="1.6" filter="SOMBRA"/>'),
         paste0('<ellipse class="c1" cx="', mx, '" cy="', my, '" rx="', mrx, '" ry="', mry, '" stroke-width="1.8" filter="SOMBRA"/>'))
  for (i in seq_len(nrow(pts))) s <- c(s, paste0('<circle class="', if (i %in% sel) "ptsel" else "pt", '" cx="', .dg_f(pts[i, 1]), '" cy="', .dg_f(pts[i, 2]), '" r="', if (i %in% sel) 4.2 else 3, '"/>'))
  for (i in 1:12) s <- c(s, paste0('<circle class="ptsel" cx="', .dg_f(mp[i, 1]), '" cy="', .dg_f(mp[i, 2]), '" r="5"/>'))
  s <- c(s, .dg_texto(px, py - pry - 20, "Población (N unidades)", "t1", tam), .dg_texto(px, py + pry + 22, "parámetros: μ, σ, p (desconocidos)", "t2", tam - 1),
         .dg_texto(mx, my - mry - 20, "Muestra (n unidades)", "t1", tam), .dg_texto(mx, my + mry + 22, "estadísticos: x̄, s, p̂", "tv", tam - 1),
         .dg_texto(mx, my + mry + 44, "estadística descriptiva", "te", tam - 1))
  s <- c(s, .dg_flecha(paste0("M", px + prx * 0.8, ",", py - pry * 0.62, "C", 470, ",", 40, " ", 560, ",", 80, " ", mx - mrx * 0.85, ",", my - mry * 0.55)),
         .dg_texto(475, 58, "muestreo", "t2", tam),
         paste0('<path class="lnA" d="M', mx - mrx * 0.85, ",", my + mry * 0.55, "C", 560, ",", 300, " ", 470, ",", 340, " ", px + prx * 0.8, ",", py + pry * 0.62,
                '" marker-end="FLECHAA"/>'),
         .dg_texto(475, 336, "inferencia (con probabilidad)", "tv", tam))
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- estructura de datos ordenados
dg_matriz <- function(encabezado, ids, valores, fila_res = 2, col_res = 4, titulo = "Estructura de datos ordenados", tam = 14) {
  nf <- length(ids); nc <- length(encabezado)
  wc <- max(.dg_ancho(c(encabezado, valores), tam, TRUE)) + 26; hc <- 34; x0 <- 70; y0 <- 70
  ancho <- x0 + nc * wc + 300; alto <- y0 + (nf + 1) * hc + 70
  s <- character()
  for (j in seq_len(nc)) s <- c(s, .dg_rect(x0 + (j - 1) * wc + 2, y0, wc - 4, hc - 4, "c0", rx = 6, sombra = FALSE),
                                .dg_texto(x0 + (j - 0.5) * wc, y0 + (hc - 4) / 2, encabezado[j], "t0", tam))
  for (i in seq_len(nf)) {
    y <- y0 + i * hc
    s <- c(s, .dg_texto(x0 - 12, y + (hc - 4) / 2, ids[i], "t2", tam - 1, "end"))
    for (j in seq_len(nc)) {
      cl <- if (i == fila_res && j == col_res) "c4" else if (i == fila_res || j == col_res) "c1" else "c2"
      s <- c(s, .dg_rect(x0 + (j - 1) * wc + 2, y, wc - 4, hc - 4, cl, rx = 6, sombra = FALSE),
             .dg_texto(x0 + (j - 0.5) * wc, y + (hc - 4) / 2, valores[(i - 1) * nc + j], if (cl == "c4") "t0" else "t1", tam))
    }
  }
  xd <- x0 + nc * wc; yf <- y0 + fila_res * hc + (hc - 4) / 2
  s <- c(s, .dg_flecha(paste0("M", xd + 120, ",", .dg_f(yf), "H", xd + 10)),
         .dg_texto(xd + 128, yf - 9, "unidad estadística", "t1", tam, "start"), .dg_texto(xd + 128, yf + 11, "(una fila por puente)", "t2", tam - 1, "start"))
  xcol <- x0 + (col_res - 0.5) * wc; yb <- y0 + (nf + 1) * hc
  s <- c(s, .dg_flecha(paste0("M", .dg_f(xcol), ",", yb + 34, "V", yb + 4)),
         .dg_texto(xcol + 12, yb + 46, "variable (una columna)", "t1", tam, "start"))
  xc <- xcol + wc / 2 - 6; yc <- y0 + fila_res * hc
  s <- c(s, paste0('<path class="lnA" d="M', xd + 120, ",", y0 - 22, "C", xd + 40, ",", y0 - 22, " ", .dg_f(xc + 10), ",", y0 - 10, " ", .dg_f(xc - 4), ",", .dg_f(yc - 2), '" marker-end="FLECHAA"/>'),
         .dg_texto(xd + 128, y0 - 32, "observación: el valor de una", "tv", tam - 1, "start"),
         .dg_texto(xd + 128, y0 - 12, "variable en una unidad", "tv", tam - 1, "start"))
  .dg_svg(ancho, alto, s, titulo)
}

# ---------------------------------------------------------------- dianas: sesgo y precisión
dg_dianas <- function(casos, titulo = "Sesgo y precisión", tam = 15, semilla = 21) {
  set.seed(semilla)
  pw <- 270; ph <- 270; gap <- 30; tit <- 34; marg <- 14; esc <- 30
  ancho <- 2 * marg + 2 * pw + gap; alto <- 2 * marg + 2 * (ph + tit) + gap
  s <- character()
  for (i in seq_len(nrow(casos))) {
    co <- (i - 1) %% 2; fi <- (i - 1) %/% 2
    cx <- marg + co * (pw + gap) + pw / 2; cy <- marg + fi * (ph + tit + gap) + tit + ph / 2
    s <- c(s, .dg_texto(cx, cy - ph / 2 - tit / 2, casos$caso[i], "t1", tam))
    for (r in 1:4) s <- c(s, paste0('<circle class="anillo" cx="', cx, '" cy="', cy, '" r="', r * esc, '"/>'))
    s <- c(s, paste0('<path class="cruz" d="M', cx - 9, ",", cy, "H", cx + 9, "M", cx, ",", cy - 9, "V", cy + 9, '"/>'))
    x <- rnorm(12, casos$dx[i], casos$sd[i]); y <- rnorm(12, casos$dy[i], casos$sd[i])
    for (j in 1:12) s <- c(s, paste0('<circle class="ptsel" cx="', .dg_f(cx + x[j] * esc), '" cy="', .dg_f(cy - y[j] * esc), '" r="5.5" fill-opacity=".85"/>'))
  }
  .dg_svg(ancho, alto, s, titulo)
}
