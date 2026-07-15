const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error' && !m.text().includes('vibrate')) errors.push('CONSOLE: ' + m.text()); });
  const url = 'file://' + require('path').resolve(__dirname, '../index.html');
  await page.goto(url);
  await page.waitForTimeout(900);
  await page.click('nav button[data-view="learn"]');

  const total = parseInt(await page.textContent('#lrnTotal'));
  console.log('base ≥ 1000 tarjetas:', total >= 1000 ? 'OK (' + total + ')' : 'FALLO(' + total + ')');

  // Todas las categorías nuevas presentes
  const cats = await page.evaluate(() => [...new Set(JSON.parse(localStorage.getItem('zen:srs')).cards.map(c => c.cat))]);
  const need = ['🌍 Capitales', '💱 Monedas', '📜 Historia', '🇬🇧 Inglés', '🇫🇷 Francés', '🔬 Ciencia', '🏔️ Geografía', '🎨 Arte y cultura', '🔢 Matemáticas'];
  const missing = need.filter(n => !cats.includes(n));
  console.log('categorías de idiomas/historia/geo:', missing.length === 0 ? 'OK' : 'FALLO faltan ' + missing.join(','));

  // No hay preguntas ni respuestas vacías
  const bad = await page.evaluate(() => JSON.parse(localStorage.getItem('zen:srs')).cards.filter(c => !c.q || !c.a).length);
  console.log('sin tarjetas vacías:', bad === 0 ? 'OK' : 'FALLO(' + bad + ')');

  // Migración: usuario viejo con seedV 1 y una tarjeta ya estudiada
  await page.evaluate(() => {
    localStorage.setItem('zen:srs', JSON.stringify({
      seedV: 1, log: {},
      cards: [
        { id: 's0', cat: '🚑 Primeros auxilios', q: 'Vieja', a: 'Respuesta', reps: 4, int: 15, ease: 2.6, due: '2030-01-01', last: Date.now() },
        { id: 'u123', cat: '📝 Mías', q: 'Propia', a: 'Mi respuesta', reps: 2, int: 6, ease: 2.5, due: '2030-01-01' }
      ]
    }));
  });
  await page.reload();
  await page.waitForTimeout(700);
  const after = await page.evaluate(() => JSON.parse(localStorage.getItem('zen:srs')));
  console.log('migración añade tarjetas nuevas:', after.cards.length >= 1000 ? 'OK (' + after.cards.length + ')' : 'FALLO(' + after.cards.length + ')');
  const s0 = after.cards.find(c => c.id === 's0');
  console.log('progreso viejo conservado (s0 reps=4):', s0 && s0.reps === 4 && s0.int === 15 ? 'OK' : 'FALLO');
  const u = after.cards.find(c => c.id === 'u123');
  console.log('tarjeta propia conservada:', u && u.reps === 2 ? 'OK' : 'FALLO');
  console.log('seedV actualizado a 2:', after.seedV === 2 ? 'OK' : 'FALLO(' + after.seedV + ')');
  // no duplica al recargar otra vez
  await page.reload(); await page.waitForTimeout(500);
  const twice = await page.evaluate(() => JSON.parse(localStorage.getItem('zen:srs')).cards.length);
  console.log('migración idempotente (no duplica):', twice === after.cards.length ? 'OK' : 'FALLO(' + twice + ' vs ' + after.cards.length + ')');

  // Repaso funciona con la base grande (sesión limitada a 60)
  await page.click('nav button[data-view="learn"]');
  await page.click('#startRev');
  const left = parseInt(await page.textContent('#revLeft'));
  console.log('sesión limitada a 60:', left <= 60 ? 'OK (' + left + ')' : 'FALLO(' + left + ')');
  await page.click('#revShow');
  await page.click('#revGrades button[data-g="3"]');
  console.log('calificar en base grande:', await page.isVisible('#revBox') ? 'OK' : 'FALLO');
  await page.click('#revQuit');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
