const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 1280, height: 900 } })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html') + '');
  await page.waitForTimeout(800);

  // Escritorio: contenido centrado con ancho de móvil
  const w = await page.evaluate(() => document.querySelector('main').clientWidth);
  console.log('ancho máximo en escritorio:', w, w <= 560 ? 'OK' : 'FALLO');

  // Doble confirmación de Terminar
  await page.click('#medStart');
  await page.waitForTimeout(800);
  await page.click('#medStop');
  console.log('primer toque pide confirmar:', (await page.textContent('#medStop')).includes('¿Terminar?') ? 'OK' : 'FALLO');
  await page.waitForTimeout(2700);
  console.log('sin segundo toque, vuelve a Terminar:', (await page.textContent('#medStop')).trim() === 'Terminar' ? 'OK' : 'FALLO');
  await page.click('#medStop'); await page.waitForTimeout(150); await page.click('#medStop');
  console.log('doble toque termina:', await page.isVisible('#medSetup') ? 'OK' : 'FALLO');

  // Dígitos con teclado físico
  await page.click('nav button[data-view="mind"]');
  await page.click('.gameCard[data-game="digits"]');
  await page.click('#digitStart');
  await page.waitForSelector('#digitPad', { state: 'visible', timeout: 10000 });
  await page.keyboard.press('1'); await page.keyboard.press('2');
  console.log('teclado físico escribe:', (await page.textContent('#digitShow')).trim() === '12' ? 'OK' : 'FALLO(' + await page.textContent('#digitShow') + ')');
  await page.keyboard.press('Backspace');
  console.log('backspace borra:', (await page.textContent('#digitShow')).trim() === '1' ? 'OK' : 'FALLO');
  await page.click('#game-digits [data-back]');

  // Tarjeta de instalación en Ajustes
  await page.click('nav button[data-view="cfg"]');
  console.log('tarjeta instalar:', (await page.textContent('#view-cfg')).includes('Instalar como app') ? 'OK' : 'FALLO');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
