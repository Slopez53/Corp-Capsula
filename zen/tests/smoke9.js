const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error' && !m.text().includes('vibrate')) errors.push('CONSOLE: ' + m.text()); });
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html') + '');
  await page.waitForTimeout(800);

  // 1) Borrar datos NO resucita los pasos al recargar (bug de pagehide)
  await page.click('nav button[data-view="steps"]');
  await page.evaluate(() => {
    const t = new Date(), k = t.getFullYear() + '-' + String(t.getMonth()+1).padStart(2,'0') + '-' + String(t.getDate()).padStart(2,'0');
    localStorage.setItem('zen:steps', JSON.stringify({ day: k, today: 4321, total: 9999, hist: {} }));
    pedLoad();
  });
  console.log('pasos inyectados:', (await page.textContent('#stepCount')).replace(/\D/g,'') === '4321' ? 'OK' : 'FALLO');
  await page.click('nav button[data-view="cfg"]');
  await page.click('#wipeBtn'); await page.click('#wipeBtn');
  await page.waitForTimeout(900);
  const stepsKey = await page.evaluate(() => localStorage.getItem('zen:steps'));
  await page.click('nav button[data-view="steps"]');
  const cnt = (await page.textContent('#stepCount')).replace(/\D/g,'');
  console.log('borrado sin resurrección:', stepsKey === null && cnt === '0' ? 'OK' : 'FALLO(key=' + stepsKey + ', count=' + cnt + ')');

  // 2) Importar restaura pasos y no se sobrescriben al recargar
  await page.evaluate(() => {
    const t = new Date(), k = t.getFullYear() + '-' + String(t.getMonth()+1).padStart(2,'0') + '-' + String(t.getDate()).padStart(2,'0');
    localStorage.setItem('zen:steps', JSON.stringify({ day: k, today: 7777, total: 8888, hist: {} }));
    pedLoad();
  });
  await page.click('nav button[data-view="cfg"]');
  const dl = page.waitForEvent('download', { timeout: 5000 });
  await page.click('#expBtn');
  const download = await dl;
  const fs = require('fs');
  const bak = '/tmp/zen-bak9.json';
  fs.copyFileSync(await download.path(), bak);
  // borrar y luego importar
  await page.click('#wipeBtn'); await page.click('#wipeBtn');
  await page.waitForTimeout(900);
  await page.click('nav button[data-view="cfg"]');
  const [chooser] = await Promise.all([page.waitForEvent('filechooser'), page.click('#impBtn')]);
  await chooser.setFiles(bak);
  await page.waitForTimeout(1600);
  await page.click('nav button[data-view="steps"]');
  const cnt2 = (await page.textContent('#stepCount')).replace(/\D/g,'');
  console.log('importación restaura pasos (7777):', cnt2 === '7777' ? 'OK' : 'FALLO(' + cnt2 + ')');

  // 3) Toques rápidos consecutivos en Cálculo registran todos
  await page.click('nav button[data-view="mind"]');
  await page.click('.gameCard[data-game="calc"]');
  await page.click('#calcStart');
  await page.waitForSelector('#calcOpts button', { timeout: 6000 });
  let changed = 0, lastQ = await page.textContent('#calcQ');
  for (let i = 0; i < 4; i++) {
    await page.tap('#calcOpts button:nth-child(1)');
    await page.waitForFunction((prev) => document.getElementById('calcQ').textContent !== prev, lastQ, { timeout: 2000 }).catch(() => {});
    const q = await page.textContent('#calcQ');
    if (q !== lastQ) changed++;
    lastQ = q;
  }
  console.log('4 toques rápidos → 4 preguntas nuevas:', changed === 4 ? 'OK' : 'FALLO(' + changed + ')');
  await page.click('#game-calc [data-back]');

  // 4) touch-action aplicado globalmente
  const ta = await page.evaluate(() => getComputedStyle(document.querySelector('.chip')).touchAction);
  console.log('touch-action manipulation:', ta === 'manipulation' ? 'OK' : 'FALLO(' + ta + ')');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
