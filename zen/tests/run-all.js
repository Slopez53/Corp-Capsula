#!/usr/bin/env node
/*
 * Ejecuta la batería completa de pruebas de Zen contra zen/index.html.
 *
 * Requisitos:
 *   npm i playwright-core          (una vez, en cualquier carpeta padre)
 *   CHROME_PATH=/ruta/a/chrome     (opcional; por defecto usa el Chromium de Playwright)
 *
 * Uso:  node zen/tests/run-all.js
 *
 * Suites:
 *   smoke2  navegación, meditación, 5 juegos, pasos, tiempo, ajustes, borrado
 *   smoke3  podómetro: reposo sin falsos pasos, marcha Android/iOS, sensibilidad
 *   smoke4  reto 30 días, informe automático, nivel exponencial, gráfico
 *   smoke5  modo claro, temas, texto, reloj 12/24h, exportar/importar
 *   smoke6  racha, pausa de meditación, cronómetro persistente, Reiniciar/Repetir, meta
 *   smoke7  mejoras de Mente: encadenado, countdown, precisión, revelado, flujo guiado
 *   smoke8  escritorio, doble confirmación, teclado físico, tarjeta instalar
 *   smoke9  sin resurrección de datos al borrar/importar, toques rápidos, touch-action
 */
const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const suites = fs.readdirSync(__dirname).filter(f => /^smoke\d+\.js$/.test(f)).sort();
let failed = 0;
for (const s of suites) {
  process.stdout.write(`\n══ ${s} ══\n`);
  try {
    const out = execFileSync(process.execPath, [path.join(__dirname, s)], { encoding: "utf8" });
    process.stdout.write(out);
    if (/FALLO/.test(out)) failed++; // los asserts marcan FALLO en la salida
  } catch (e) {
    if (e.stdout) process.stdout.write(e.stdout);
    failed++;
  }
}
console.log(failed ? `\n✗ ${failed} suite(s) con fallos` : `\n✓ Las ${suites.length} suites pasaron`);
process.exit(failed ? 1 : 0);
