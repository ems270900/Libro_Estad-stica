// Convierte un SVG de portada a PNG de 3700 × 2000 px con Chromium (Playwright).
// Uso: node herramientas/portada_png.js entrada.svg salida.png
const { chromium } = require("playwright");
const fs = require("fs");
(async () => {
  const [, , ent, sal] = process.argv;
  const svg = fs.readFileSync(ent, "utf8");
  const nav = await chromium.launch();
  const pag = await nav.newPage({ viewport: { width: 3700, height: 2000 }, deviceScaleFactor: 1 });
  await pag.setContent(`<html><body style="margin:0;background:#fff">${svg}</body></html>`);
  await pag.screenshot({ path: sal, clip: { x: 0, y: 0, width: 3700, height: 2000 } });
  await nav.close();
  console.log("Escrito " + sal);
})();
