const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const ctx = await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true });
  const page = await ctx.newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error') errors.push('CONSOLE: ' + m.text()); });
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html') + '');
  await page.waitForTimeout(900);

  await page.click('nav button[data-view="cfg"]');

  // Modo claro
  await page.click('#cfgMode .chip[data-mode="light"]');
  const isLight = await page.evaluate(() => document.body.classList.contains('light'));
  console.log('modo claro aplicado:', isLight ? 'OK' : 'FALLO');
  const bgCol = await page.evaluate(() => getComputedStyle(document.body).backgroundColor);
  console.log('fondo claro:', bgCol.includes('238') ? 'OK' : 'FALLO(' + bgCol + ')');
  await page.click('#cfgMode .chip[data-mode="dark"]');
  console.log('vuelta a oscuro:', await page.evaluate(() => !document.body.classList.contains('light')) ? 'OK' : 'FALLO');

  // 6 temas
  console.log('6 temas:', (await page.locator('.themeDot').count()) === 6 ? 'OK' : 'FALLO');
  await page.click('.themeDot[data-t="sakura"]');
  console.log('tema sakura:', (await page.evaluate(() => document.documentElement.style.getPropertyValue('--accA').trim())) === '#ec4899' ? 'OK' : 'FALLO');

  // Tamaño de texto
  await page.click('#cfgFsize .chip[data-fs="l"]');
  console.log('zoom grande:', (await page.evaluate(() => document.body.style.zoom)) == '1.12' ? 'OK' : 'FALLO');
  await page.click('#cfgFsize .chip[data-fs="m"]');

  // Fondo animado off
  await page.click('#cfgOrbs');
  console.log('orbes ocultos:', (await page.evaluate(() => document.querySelector('.bg').style.display)) === 'none' ? 'OK' : 'FALLO');
  await page.click('#cfgOrbs');

  // Reloj 12h sin segundos
  await page.click('#cfgH24'); await page.click('#cfgSec');
  await page.click('nav button[data-view="time"]');
  await page.waitForTimeout(1200);
  const clk = await page.textContent('#clockBig');
  console.log('reloj 12h sin segundos:', /^\d{1,2}:\d{2}\s?(am|pm)$/.test(clk.trim()) ? 'OK' : 'FALLO(' + clk + ')');
  await page.click('nav button[data-view="cfg"]');
  await page.click('#cfgH24'); await page.click('#cfgSec');

  // Exportar copia (evento de descarga)
  const dl = page.waitForEvent('download', { timeout: 5000 });
  await page.click('#expBtn');
  const download = await dl;
  console.log('exportación descarga:', download.suggestedFilename().startsWith('zen-copia-') ? 'OK' : 'FALLO');
  const path = await download.path();
  const fs = require('fs');
  const backup = JSON.parse(fs.readFileSync(path, 'utf8'));
  console.log('copia contiene datos:', backup.app === 'zen' && Object.keys(backup.data).length > 0 ? 'OK' : 'FALLO');

  // Importar: borrar todo y restaurar desde la copia
  await page.click('#wipeBtn'); await page.click('#wipeBtn');
  await page.waitForTimeout(800);
  console.log('tras borrado, tema por defecto:', (await page.evaluate(() => document.documentElement.style.getPropertyValue('--accA').trim())) === '#5b6cff' ? 'OK' : 'FALLO');
  await page.click('nav button[data-view="cfg"]');
  const bak = '/tmp/zen-bak.json'; fs.copyFileSync(path, bak);
  const [chooser] = await Promise.all([page.waitForEvent('filechooser'), page.click('#impBtn')]);
  await chooser.setFiles(bak);
  await page.waitForTimeout(1500); // recarga tras importar
  console.log('importación restaura tema sakura:', (await page.evaluate(() => document.documentElement.style.getPropertyValue('--accA').trim())) === '#ec4899' ? 'OK' : 'FALLO');

  // Meditación Libre
  await page.click('nav button[data-view="med"]');
  await page.click('#medPat .chip[data-pat="free"]');
  await page.click('#medStart');
  await page.waitForTimeout(1300);
  console.log('meditación libre fase:', (await page.textContent('#breathPhase')).trim() === 'Respira' ? 'OK' : 'FALLO');
  console.log('círculo con pulso libre:', await page.evaluate(() => document.getElementById('breathCircle').classList.contains('freeFloat')) ? 'OK' : 'FALLO');
  await page.click('#medStop'); await page.waitForTimeout(150); await page.click('#medStop');
  console.log('libre termina limpio:', await page.evaluate(() => !document.getElementById('breathCircle').classList.contains('freeFloat')) ? 'OK' : 'FALLO');

  // Volumen ambiente persiste
  await page.click('nav button[data-view="cfg"]');
  await page.click('#cfgAmbVol .chip[data-vol="1.6"]');
  await page.reload(); await page.waitForTimeout(700);
  await page.click('nav button[data-view="cfg"]');
  console.log('volumen alto persistido:', await page.evaluate(() => document.querySelector('#cfgAmbVol .chip.sel').dataset.vol === '1.6') ? 'OK' : 'FALLO');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
