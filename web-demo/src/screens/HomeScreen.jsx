import React, { useState, useEffect } from 'react';
import { C, shadow } from '../theme.js';
import { getEntries, getTodayEntry, getName } from '../storage.js';
import { calcStreak, getWeeklyData, getScoreColor, getQuadrantColor, getQuadrantTint, getAvg } from '../moodAnalytics.js';

const greet = (name) => {
  const h = new Date().getHours();
  const s = name ? `, ${name}` : '';
  if (h < 12) return `Buenos días${s}`;
  if (h < 20) return `Buenas tardes${s}`;
  return `Buenas noches${s}`;
};

function Bar({ item }) {
  const color = item.score ? getScoreColor(item.score) : C.surfaceAlt;
  const h = item.score ? `${(item.score / 10) * 88}px` : '12px';
  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 3, flex: 1 }}>
      <span style={{ fontSize: 10, fontWeight: 600, color: item.score ? color : C.borderLight }}>
        {item.score ?? '·'}
      </span>
      <div style={{ width: 20, height: 92, background: C.surfaceAlt, borderRadius: 6, display: 'flex', alignItems: 'flex-end', overflow: 'hidden' }}>
        <div style={{ width: '100%', height: h, background: color, borderRadius: 6, opacity: item.isToday ? 1 : 0.75, transition: 'height 0.5s ease' }} />
      </div>
      <span style={{ fontSize: 10, color: item.isToday ? C.primary : C.textLight, fontWeight: item.isToday ? 700 : 500 }}>{item.day}</span>
      {item.isToday && <div style={{ width: 4, height: 4, borderRadius: 2, background: C.primary }} />}
    </div>
  );
}

export default function HomeScreen({ onCheckIn }) {
  const [entries, setEntries] = useState([]);
  const [today, setToday] = useState(null);
  const [name, setName] = useState('');
  const [weekly, setWeekly] = useState([]);

  useEffect(() => {
    const e = getEntries();
    setEntries(e);
    setToday(getTodayEntry());
    setName(getName());
    setWeekly(getWeeklyData(e));
  }, []);

  const streak = calcStreak(entries);
  const avg = getAvg(entries.slice(0, 30));

  return (
    <div style={{ flex: 1, overflowY: 'auto', padding: '20px 16px 24px' }}>
      {/* Header */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 20 }}>
        <div>
          <div style={{ fontSize: 24, fontWeight: 700, color: C.text, letterSpacing: '-0.5px' }}>{greet(name)}</div>
          <div style={{ fontSize: 13, color: C.textSec, marginTop: 3 }}>
            {today ? 'Ya registraste tu estado de hoy' : '¿Cómo estás hoy?'}
          </div>
        </div>
        {streak >= 2 && (
          <div style={{ display: 'flex', alignItems: 'center', gap: 4, padding: '6px 12px', borderRadius: 20, background: C.accent + '22' }}>
            <span>🔥</span>
            <span style={{ fontSize: 15, fontWeight: 700, color: C.accent }}>{streak}</span>
          </div>
        )}
      </div>

      {/* Check-in CTA or Today's card */}
      {!today ? (
        <button
          onClick={onCheckIn}
          style={{ width: '100%', background: C.primary, borderRadius: 16, padding: '16px', display: 'flex', alignItems: 'center', gap: 14, border: 'none', cursor: 'pointer', boxShadow: shadow(1), marginBottom: 14, textAlign: 'left' }}
        >
          <div style={{ width: 48, height: 48, borderRadius: 24, background: 'rgba(255,255,255,0.2)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 22, flexShrink: 0 }}>+</div>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 16, fontWeight: 600, color: '#fff' }}>Registrar mi estado</div>
            <div style={{ fontSize: 13, color: 'rgba(255,255,255,0.75)', marginTop: 2 }}>Toma menos de 2 minutos</div>
          </div>
          <span style={{ color: 'rgba(255,255,255,0.6)', fontSize: 18 }}>›</span>
        </button>
      ) : (
        <div
          onClick={onCheckIn}
          style={{ borderRadius: 16, padding: '16px', background: getQuadrantTint(today.moodQuadrant), marginBottom: 14, cursor: 'pointer', boxShadow: shadow(0) }}
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
            <div>
              <div style={{ fontSize: 12, color: C.textSec, fontWeight: 500 }}>Tu estado hoy</div>
              <div style={{ fontSize: 22, fontWeight: 700, color: getQuadrantColor(today.moodQuadrant), marginTop: 2 }}>{today.moodLabel}</div>
            </div>
            <div style={{ display: 'flex', alignItems: 'baseline', gap: 1 }}>
              <span style={{ fontSize: 38, fontWeight: 700, color: getScoreColor(today.moodScore) }}>{today.moodScore}</span>
              <span style={{ fontSize: 13, color: C.textLight }}>/10</span>
            </div>
          </div>
          {today.tags?.length > 0 && (
            <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap', marginTop: 10 }}>
              {today.tags.map((t) => (
                <div key={t} style={{ background: 'rgba(255,255,255,0.55)', padding: '3px 10px', borderRadius: 20, fontSize: 11, color: C.textSec, fontWeight: 500 }}>{t}</div>
              ))}
            </div>
          )}
          <div style={{ fontSize: 11, color: C.textLight, marginTop: 10 }}>Toca para editar</div>
        </div>
      )}

      {/* Stats row */}
      <div style={{ display: 'flex', gap: 8, marginBottom: 16 }}>
        {[['Racha', streak], ['Promedio (30d)', avg ?? '—'], ['Registros', entries.length]].map(([label, val]) => (
          <div key={label} style={{ flex: 1, background: C.surface, borderRadius: 12, padding: '14px 10px', textAlign: 'center', boxShadow: shadow(0) }}>
            <div style={{ fontSize: 20, fontWeight: 700, color: C.text }}>{val}</div>
            <div style={{ fontSize: 10, color: C.textLight, marginTop: 2, lineHeight: 1.3 }}>{label}</div>
          </div>
        ))}
      </div>

      {/* Weekly chart */}
      {weekly.some((d) => d.score !== null) && (
        <div style={{ background: C.surface, borderRadius: 14, padding: '16px 14px', marginBottom: 14, boxShadow: shadow(0) }}>
          <div style={{ fontSize: 14, fontWeight: 600, color: C.text, marginBottom: 12 }}>Esta semana</div>
          <div style={{ display: 'flex', alignItems: 'flex-end', gap: 2 }}>
            {weekly.map((item) => <Bar key={item.date} item={item} />)}
          </div>
        </div>
      )}

      {/* Recent entries */}
      {entries.length > 0 && (
        <div>
          <div style={{ fontSize: 14, fontWeight: 600, color: C.text, marginBottom: 10 }}>Registros recientes</div>
          {entries.slice(0, 5).map((entry) => (
            <div key={entry.date} style={{ background: C.surface, borderRadius: 12, padding: '13px 14px', display: 'flex', alignItems: 'center', gap: 10, marginBottom: 7, boxShadow: shadow(0) }}>
              <div style={{ width: 10, height: 10, borderRadius: 5, background: getQuadrantColor(entry.moodQuadrant), flexShrink: 0 }} />
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 12, color: C.textSec }}>{new Date(entry.date + 'T00:00:00').toLocaleDateString('es-ES', { weekday: 'short', day: 'numeric', month: 'short' })}</div>
                <div style={{ fontSize: 14, fontWeight: 600, color: C.text }}>{entry.moodLabel}</div>
              </div>
              <div style={{ fontSize: 14, fontWeight: 700, color: getScoreColor(entry.moodScore) }}>{entry.moodScore}/10</div>
            </div>
          ))}
        </div>
      )}

      {entries.length === 0 && (
        <div style={{ textAlign: 'center', padding: '40px 20px', color: C.textLight }}>
          <div style={{ fontSize: 36, marginBottom: 12 }}>🌱</div>
          <div style={{ fontSize: 16, fontWeight: 600, marginBottom: 6 }}>Tu historia comienza aquí</div>
          <div style={{ fontSize: 13, lineHeight: 1.5 }}>Cada registro es un paso hacia el autoconocimiento emocional.</div>
        </div>
      )}
    </div>
  );
}
