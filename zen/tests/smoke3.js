const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html') + '');
  await page.waitForTimeout(800);
  await page.click('nav button[data-view="steps"]');
  await page.click('#stepBtn');
  await page.waitForTimeout(300);

  // Caminata realista: 60 Hz, componente de paso 2 Hz (amplitud 2.5 m/s²) sobre gravedad
  const walk = async (seconds, amp, freqHz) => page.evaluate(([s, a, f]) => new Promise(res => {
    let t = 0; const dt = 1 / 60;
    const iv = setInterval(() => {
      t += dt;
      const ev = new Event('devicemotion');
      const step = a * Math.sin(2 * Math.PI * f * t) + 0.3 * Math.sin(2 * Math.PI * 3.7 * t);
      ev.acceleration = null; // forzar la ruta accelerationIncludingGravity (caso Android común)
      ev.accelerationIncludingGravity = { x: 0.4 * step, y: 9.81 + step, z: 0.2 * step };
      window.dispatchEvent(ev);
      if (t >= s) { clearInterval(iv); res(); }
    }, 1000 / 60);
  }), [seconds, amp, freqHz]);

  // 1) Reposo con micro-ruido 5 s → no debe contar
  await walk(5, 0.12, 2);
  let c = parseInt((await page.textContent('#stepCount')).replace(/\D/g, '')) || 0;
  console.log('reposo (ruido leve):', c, c <= 1 ? 'OK' : 'FALLO');

  // 2) Caminata 10 s a 2 pasos/s → ~20 pasos esperados
  await walk(10, 2.5, 2);
  let c2 = parseInt((await page.textContent('#stepCount')).replace(/\D/g, '')) || 0;
  const walked = c2 - c;
  console.log('caminata 10 s (esperado ~20):', walked, walked >= 15 && walked <= 25 ? 'OK' : 'FALLO');
  console.log('estado sensor:', (await page.textContent('#sensorStatus')).trim());

  // 3) Ruta de aceleración lineal (caso iOS) también cuenta
  await page.evaluate(() => new Promise(res => {
    let t = 0; const dt = 1 / 60;
    const iv = setInterval(() => {
      t += dt;
      const ev = new Event('devicemotion');
      // Impacto asimétrico una vez por paso (forma real de la marcha, no seno puro)
      const step = 2.2 * Math.pow(Math.max(0, Math.sin(2 * Math.PI * 2 * t)), 3);
      ev.acceleration = { x: 0.3 * step, y: step, z: 0.2 * step };
      ev.accelerationIncludingGravity = { x: 0.3 * step, y: 9.81 + step, z: 0.2 * step };
      window.dispatchEvent(ev);
      if (t >= 5) { clearInterval(iv); res(); }
    }, 1000 / 60);
  }));
  let c3 = parseInt((await page.textContent('#stepCount')).replace(/\D/g, '')) || 0;
  console.log('caminata iOS 5 s (esperado ~10):', c3 - c2, (c3 - c2) >= 7 && (c3 - c2) <= 13 ? 'OK' : 'FALLO');

  // 4) Sensibilidad alta cuenta pasos suaves
  await page.click('nav button[data-view="cfg"]');
  await page.click('#cfgSens .chip[data-sens="alta"]');
  await page.click('nav button[data-view="steps"]');
  await walk(5, 0.8, 2);
  let c4 = parseInt((await page.textContent('#stepCount')).replace(/\D/g, '')) || 0;
  console.log('paso suave con sensibilidad alta (esperado ~10):', c4 - c3, (c4 - c3) >= 6 ? 'OK' : 'FALLO');

  await page.click('#stepBtn');
  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
