import { C } from './theme.js';

export const getMoodLabel = (v, a) => {
  if (v >= 0 && a >= 0) {
    if (v > 0.6 && a > 0.6) return 'Eufórico';
    if (v > 0.4) return 'Entusiasmado';
    return 'Activo';
  }
  if (v >= 0 && a < 0) {
    if (v > 0.6) return 'Sereno';
    if (v > 0.4) return 'Contento';
    return 'Relajado';
  }
  if (v < 0 && a >= 0) {
    if (a > 0.6) return 'Agitado';
    if (a > 0.4) return 'Tenso';
    return 'Irritable';
  }
  if (v < -0.5) return 'Angustiado';
  if (v < -0.3) return 'Triste';
  return 'Apagado';
};

export const getQuadrant = (v, a) => {
  if (v >= 0 && a >= 0) return 'excited';
  if (v >= 0 && a < 0) return 'content';
  if (v < 0 && a >= 0) return 'stressed';
  return 'sad';
};

export const getQuadrantColor = (q) =>
  ({ excited: C.cExcited, content: C.cContent, stressed: C.cStressed, sad: C.cSad }[q] || C.textLight);

export const getQuadrantTint = (q) =>
  ({ excited: C.qExcited, content: C.qContent, stressed: C.qStressed, sad: C.qSad }[q] || C.surfaceAlt);

export const getMoodScore = (v, a) => {
  const raw = Math.max(0, Math.min(1, (v + 1) / 2 + (v >= 0 ? a * 0.15 : -a * 0.1)));
  return Math.max(1, Math.min(10, Math.round(raw * 9 + 1)));
};

export const getScoreColor = (s) => {
  if (s <= 3) return C.cStressed;
  if (s <= 5) return '#B8A87C';
  if (s <= 7) return C.cContent;
  return '#5A9E7B';
};

export const calcStreak = (entries) => {
  if (!entries.length) return 0;
  const dates = [...new Set(entries.map((e) => e.date))].sort().reverse();
  const today = new Date().toISOString().split('T')[0];
  const yesterday = new Date(Date.now() - 86400000).toISOString().split('T')[0];
  if (dates[0] !== today && dates[0] !== yesterday) return 0;
  let streak = 1;
  for (let i = 1; i < dates.length; i++) {
    const diff = (new Date(dates[i - 1]) - new Date(dates[i])) / 86400000;
    if (diff === 1) streak++;
    else break;
  }
  return streak;
};

export const getWeeklyData = (entries) => {
  const days = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];
  return Array.from({ length: 7 }, (_, i) => {
    const d = new Date();
    d.setDate(d.getDate() - (6 - i));
    const dateStr = d.toISOString().split('T')[0];
    const entry = entries.find((e) => e.date === dateStr);
    return { date: dateStr, day: days[d.getDay()], score: entry?.moodScore ?? null, quadrant: entry?.moodQuadrant ?? null, isToday: i === 6 };
  });
};

export const getMonthCalendar = (entries, year, month) => {
  const first = new Date(year, month, 1);
  const last = new Date(year, month + 1, 0);
  const days = [];
  for (let d = 1; d <= last.getDate(); d++) {
    const date = new Date(year, month, d).toISOString().split('T')[0];
    const entry = entries.find((e) => e.date === date);
    days.push({ date, day: d, score: entry?.moodScore ?? null, quadrant: entry?.moodQuadrant ?? null });
  }
  return { days, startPad: first.getDay() };
};

export const getAvg = (entries) => {
  const scores = entries.filter((e) => e.moodScore).map((e) => e.moodScore);
  if (!scores.length) return null;
  return +(scores.reduce((a, b) => a + b, 0) / scores.length).toFixed(1);
};

export const generateInsights = (entries) => {
  if (entries.length < 3) return [{ icon: '✦', title: 'Sigue registrando', desc: 'Con 3 o más registros, Cápsula comenzará a detectar patrones en tu bienestar.', color: '#7B9E9E' }];
  const insights = [];
  const streak = calcStreak(entries);
  if (streak >= 3) insights.push({ icon: '🔥', title: `${streak} días seguidos`, desc: 'La constancia es el primer paso para entenderte mejor.', color: '#C9A87C' });

  if (entries.length >= 7) {
    const DAY_NAMES = ['Domingos', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábados'];
    const acc = {};
    entries.forEach((e) => { const d = new Date(e.date + 'T00:00:00').getDay(); (acc[d] = acc[d] || []).push(e.moodScore); });
    const avgs = Object.entries(acc).filter(([, s]) => s.length >= 2).map(([d, s]) => ({ d: +d, avg: s.reduce((a,b)=>a+b,0)/s.length }));
    if (avgs.length >= 3) {
      const best = avgs.reduce((a, b) => a.avg > b.avg ? a : b);
      insights.push({ icon: '📅', title: `Mejor los ${DAY_NAMES[best.d]}`, desc: `Tu bienestar tiende a ser más alto los ${DAY_NAMES[best.d]} (promedio ${best.avg.toFixed(1)}/10).`, color: '#7BAF7B' });
    }
  }

  const recent = entries.slice(0, 7), prior = entries.slice(7, 14);
  if (recent.length >= 3 && prior.length >= 3) {
    const rAvg = recent.reduce((a,b)=>a+b.moodScore,0)/recent.length;
    const pAvg = prior.reduce((a,b)=>a+b.moodScore,0)/prior.length;
    const diff = rAvg - pAvg;
    if (Math.abs(diff) >= 1) insights.push({ icon: diff > 0 ? '📈' : '📉', title: diff > 0 ? 'Tendencia positiva' : 'Semana más difícil', desc: diff > 0 ? `Tu bienestar mejoró ${diff.toFixed(1)} punto esta semana.` : `Tu bienestar bajó ${Math.abs(diff).toFixed(1)} punto. Considera hablar con tu médico si persiste.`, color: diff > 0 ? '#7BAF7B' : '#B07070' });
  }

  return insights.length ? insights : [{ icon: '✦', title: '¡Vas bien!', desc: 'Continúa registrando para obtener más perspectivas personalizadas.', color: '#7B9E9E' }];
};
