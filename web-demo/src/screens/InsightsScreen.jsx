import React, { useState, useEffect } from 'react';
import { C, shadow } from '../theme.js';
import { getEntries } from '../storage.js';
import { calcStreak, getWeeklyData, getAvg, generateInsights, getScoreColor, getQuadrantColor } from '../moodAnalytics.js';

function TrendChart({ data }) {
  const W = 300, H = 110, PX = 20, PY = 14;
  const iW = W - PX * 2, iH = H - PY * 2;
  const valid = data.filter(d => d.score !== null);
  if (valid.length < 2) return (
    <div style={{ height: H, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <span style={{ fontSize: 12, color: C.textLight }}>Registra más días para ver tu tendencia</span>
    </div>
  );

  const getX = (i) => PX + (i / (data.length - 1)) * iW;
  const getY = (s) => PY + iH - ((s - 1) / 9) * iH;

  let path = '', area = '', first = null, last = null;
  data.forEach((d, i) => {
    if (d.score === null) return;
    const x = getX(i), y = getY(d.score);
    if (!path) { path = `M${x},${y}`; area = `M${x},${H} L${x},${y}`; first = x; }
    else {
      const prev = data.slice(0, i).reverse().find(p => p.score !== null);
      if (prev) {
        const px = getX(data.indexOf(prev)), py = getY(prev.score);
        const cp1x = px + (x - px) * 0.5, cp2x = x - (x - px) * 0.5;
        path += ` C${cp1x},${py} ${cp2x},${y} ${x},${y}`;
        area += ` C${cp1x},${py} ${cp2x},${y} ${x},${y}`;
      }
    }
    last = x;
  });
  if (last) area += ` L${last},${H} Z`;

  return (
    <svg width="100%" viewBox={`0 0 ${W} ${H}`} style={{ overflow: 'visible' }}>
      <defs>
        <linearGradient id="g" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor={C.primary} stopOpacity="0.18" />
          <stop offset="1" stopColor={C.primary} stopOpacity="0" />
        </linearGradient>
      </defs>
      {[3,5,7,9].map(v => <line key={v} x1={PX} y1={getY(v)} x2={W-PX} y2={getY(v)} stroke={C.border} strokeWidth="0.5" strokeDasharray="3,3" />)}
      {area && <path d={area} fill="url(#g)" />}
      {path && <path d={path} stroke={C.primary} strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round" />}
      {data.map((d, i) => d.score !== null && (
        <circle key={i} cx={getX(i)} cy={getY(d.score)} r={d.isToday ? 5 : 3.5}
          fill={d.isToday ? C.primary : C.surface} stroke={C.primary} strokeWidth={d.isToday ? 0 : 1.5} />
      ))}
    </svg>
  );
}

function QuadrantDist({ entries }) {
  const counts = { excited: 0, content: 0, stressed: 0, sad: 0 };
  entries.slice(0, 30).forEach(e => { if (e.moodQuadrant in counts) counts[e.moodQuadrant]++; });
  const total = Object.values(counts).reduce((a,b) => a+b, 0);
  if (!total) return null;
  const labels = { excited: 'Activo', content: 'Sereno', stressed: 'Tenso', sad: 'Bajo' };
  return (
    <div style={{ display: 'flex', justifyContent: 'space-around', alignItems: 'flex-end', height: 90, paddingTop: 20 }}>
      {Object.entries(counts).map(([q, count]) => {
        const pct = Math.round((count / total) * 100);
        return (
          <div key={q} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 4, flex: 1 }}>
            <span style={{ fontSize: 10, fontWeight: 600, color: C.textSec }}>{pct}%</span>
            <div style={{ width: 26, height: 60, background: C.surfaceAlt, borderRadius: 6, display: 'flex', alignItems: 'flex-end', overflow: 'hidden' }}>
              <div style={{ width: '100%', height: `${pct}%`, background: getQuadrantColor(q), borderRadius: 6, transition: 'height 0.6s ease' }} />
            </div>
            <span style={{ fontSize: 9.5, color: C.textLight, fontWeight: 500 }}>{labels[q]}</span>
          </div>
        );
      })}
    </div>
  );
}

export default function InsightsScreen() {
  const [entries, setEntries] = useState([]);
  const [weekly, setWeekly] = useState([]);
  const [insights, setInsights] = useState([]);

  useEffect(() => {
    const e = getEntries();
    setEntries(e);
    setWeekly(getWeeklyData(e));
    setInsights(generateInsights(e));
  }, []);

  const streak = calcStreak(entries);
  const avg = getAvg(entries.slice(0, 30));
  const best = entries.length ? Math.max(...entries.slice(0, 30).map(e => e.moodScore)) : null;

  return (
    <div style={{ flex: 1, overflowY: 'auto', padding: '20px 16px 24px' }}>
      <div style={{ fontSize: 24, fontWeight: 700, color: C.text, letterSpacing: '-0.5px' }}>Análisis</div>
      <div style={{ fontSize: 13, color: C.textSec, marginTop: 3, marginBottom: 18 }}>Patrones en tu bienestar emocional</div>

      {/* Pills */}
      <div style={{ display: 'flex', gap: 8, overflowX: 'auto', paddingBottom: 16 }}>
        {[['Registros', entries.length], ['Promedio', avg ?? '—'], ['Racha', streak], ['Mejor (30d)', best ?? '—']].map(([label, val]) => (
          <div key={label} style={{ background: C.surface, borderRadius: 12, padding: '13px 14px', alignItems: 'center', textAlign: 'center', minWidth: 80, boxShadow: shadow(0), flexShrink: 0 }}>
            <div style={{ fontSize: 20, fontWeight: 700, color: C.text }}>{val}</div>
            <div style={{ fontSize: 10, color: C.textLight, marginTop: 2 }}>{label}</div>
          </div>
        ))}
      </div>

      {/* Trend chart */}
      <div style={{ background: C.surface, borderRadius: 14, padding: '16px 14px 10px', marginBottom: 14, boxShadow: shadow(0) }}>
        <div style={{ fontSize: 14, fontWeight: 600, color: C.text, marginBottom: 10 }}>Tendencia semanal</div>
        <TrendChart data={weekly} />
        <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 6, padding: '0 12px' }}>
          {weekly.map(d => (
            <span key={d.date} style={{ fontSize: 10, color: d.isToday ? C.primary : C.textLight, fontWeight: d.isToday ? 700 : 400, flex: 1, textAlign: 'center' }}>{d.day}</span>
          ))}
        </div>
      </div>

      {/* Quadrant distribution */}
      {entries.length >= 5 && (
        <div style={{ background: C.surface, borderRadius: 14, padding: '16px 14px', marginBottom: 14, boxShadow: shadow(0) }}>
          <div style={{ fontSize: 14, fontWeight: 600, color: C.text }}>Distribución emocional (30d)</div>
          <div style={{ fontSize: 12, color: C.textSec, marginTop: 3 }}>Qué tan seguido estás en cada estado emocional</div>
          <QuadrantDist entries={entries} />
        </div>
      )}

      {/* Insights */}
      <div style={{ fontSize: 16, fontWeight: 600, color: C.text, marginBottom: 10 }}>Perspectivas</div>
      {insights.map((ins, i) => (
        <div key={i} style={{ background: C.surface, borderRadius: 14, padding: '14px', display: 'flex', gap: 12, alignItems: 'flex-start', marginBottom: 10, boxShadow: shadow(0) }}>
          <div style={{ width: 40, height: 40, borderRadius: 20, background: ins.color + '22', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 20, flexShrink: 0 }}>{ins.icon}</div>
          <div>
            <div style={{ fontSize: 14, fontWeight: 600, color: C.text, marginBottom: 3 }}>{ins.title}</div>
            <div style={{ fontSize: 12, color: C.textSec, lineHeight: 1.5 }}>{ins.desc}</div>
          </div>
        </div>
      ))}

      {entries.length === 0 && (
        <div style={{ textAlign: 'center', padding: '30px 20px', color: C.textLight }}>
          <div style={{ fontSize: 36, marginBottom: 10 }}>📊</div>
          <div style={{ fontSize: 14 }}>Comienza registrando tu estado para ver análisis aquí</div>
        </div>
      )}
    </div>
  );
}
