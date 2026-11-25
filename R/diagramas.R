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
    "<filter id=\"dgs", id, "\" x=\"-10%\" y=\"-20%\" width=\"120%\" height=\"150%\"><feDropShadow dx=\"0\" dy=\"2\" stdDeviation=\"2.5\" flood-color=\"#062a30\" flood-opacity=\"0.16\"/></filter></defs>",
    gsub("SOMBRA", paste0("url(#dgs", id, ")"), gsub("FLECHA", paste0("url(#dgf", id, ")"), paste(contenido, collapse = ""), fixed = TRUE), fixed = TRUE),
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
