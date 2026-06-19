import React, { useState, useEffect } from 'react';
import { C, shadow } from '../theme.js';
import { getEntries } from '../storage.js';
import { getMonthCalendar, getScoreColor, getQuadrantColor, getQuadrantTint } from '../moodAnalytics.js';

const MONTHS = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
const DAYS = ['D','L','M','X','J','V','S'];
const today = new Date().toISOString().split('T')[0];

function EntryModal({ entry, onClose }) {
  if (!entry) return null;
  const color = getQuadrantColor(entry.moodQuadrant);
  const d = new Date(entry.date + 'T00:00:00');
  return (
    <div onClick={onClose} style={{ position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 100, padding: 20 }}>
      <div onClick={e => e.stopPropagation()} style={{ background: C.surface, borderRadius: 24, padding: 22, width: '100%', boxShadow: '0 8px 32px rgba(0,0,0,0.15)' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 16 }}>
          <div>
            <div style={{ fontSize: 12, color: C.textSec, textTransform: 'capitalize' }}>{d.toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long' })}</div>
            <div style={{ fontSize: 22, fontWeight: 700, color, marginTop: 2 }}>{entry.moodLabel}</div>
          </div>
          <div style={{ display: 'flex', alignItems: 'baseline', border: `2.5px solid ${getScoreColor(entry.moodScore)}`, borderRadius: 32, padding: '6px 10px', gap: 1 }}>
            <span style={{ fontSize: 18, fontWeight: 700, color: getScoreColor(entry.moodScore) }}>{entry.moodScore}</span>
            <span style={{ fontSize: 11, color: C.textLight }}>/10</span>
          </div>
        </div>
        <div style={{ height: 1, background: C.borderLight, marginBottom: 14 }} />
        <div style={{ display: 'flex', gap: 20, marginBottom: 14 }}>
          {entry.sleepQuality && <div style={{ textAlign: 'center' }}><div style={{ fontSize: 11, color: C.textLight }}>Sueño</div><div style={{ fontSize: 15, fontWeight: 600, color: C.text }}>{entry.sleepQuality}/5</div></div>}
          {entry.energyLevel && <div style={{ textAlign: 'center' }}><div style={{ fontSize: 11, color: C.textLight }}>Energía</div><div style={{ fontSize: 15, fontWeight: 600, color: C.text }}>{entry.energyLevel}/5</div></div>}
          {entry.time && <div style={{ textAlign: 'center' }}><div style={{ fontSize: 11, color: C.textLight }}>Hora</div><div style={{ fontSize: 15, fontWeight: 600, color: C.text }}>{entry.time}</div></div>}
        </div>
        {entry.tags?.length > 0 && (
          <div style={{ marginBottom: 14 }}>
            <div style={{ fontSize: 12, fontWeight: 600, color: C.textSec, marginBottom: 8 }}>Contexto</div>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
              {entry.tags.map(t => <div key={t} style={{ background: C.surfaceAlt, padding: '4px 10px', borderRadius: 20, fontSize: 12, color: C.textSec, fontWeight: 500 }}>{t}</div>)}
            </div>
          </div>
        )}
        {entry.note ? <div style={{ marginBottom: 16 }}><div style={{ fontSize: 12, fontWeight: 600, color: C.textSec, marginBottom: 4 }}>Nota</div><div style={{ fontSize: 13, color: C.text, lineHeight: 1.5, fontStyle: 'italic' }}>{entry.note}</div></div> : null}
        <button onClick={onClose} style={{ width: '100%', padding: '12px', borderRadius: 20, border: 'none', background: C.surfaceAlt, cursor: 'pointer', fontSize: 15, fontWeight: 600, color: C.textSec }}>Cerrar</button>
      </div>
    </div>
  );
}

export default function HistoryScreen() {
  const now = new Date();
  const [year, setYear] = useState(now.getFullYear());
  const [month, setMonth] = useState(now.getMonth());
  const [entries, setEntries] = useState([]);
  const [calData, setCalData] = useState({ days: [], startPad: 0 });
  const [selected, setSelected] = useState(null);

  useEffect(() => {
    const e = getEntries();
    setEntries(e);
    setCalData(getMonthCalendar(e, year, month));
  }, [year, month]);

  const prevMonth = () => { if (month === 0) { setMonth(11); setYear(y => y-1); } else setMonth(m => m-1); };
  const nextMonth = () => {
    const isNow = year === now.getFullYear() && month === now.getMonth();
    if (isNow) return;
    if (month === 11) { setMonth(0); setYear(y => y+1); } else setMonth(m => m+1);
  };
  const isCurrentMonth = year === now.getFullYear() && month === now.getMonth();

  const monthEntries = entries.filter(e => { const d = new Date(e.date + 'T00:00:00'); return d.getFullYear() === year && d.getMonth() === month; }).sort((a,b) => b.date.localeCompare(a.date));

  const handleDayClick = (item) => {
    if (!item.score) return;
    const entry = entries.find(e => e.date === item.date);
    if (entry) setSelected(entry);
  };

  return (
    <div style={{ flex: 1, overflowY: 'auto', padding: '20px 16px 24px', position: 'relative' }}>
      <div style={{ fontSize: 24, fontWeight: 700, color: C.text, letterSpacing: '-0.5px' }}>Historial</div>
      <div style={{ fontSize: 13, color: C.textSec, marginTop: 3, marginBottom: 18 }}>{entries.length > 0 ? `${entries.length} registros en total` : 'Tus registros aparecerán aquí'}</div>

      {/* Month nav */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
        <button onClick={prevMonth} style={{ width: 34, height: 34, borderRadius: 17, background: C.surface, border: 'none', cursor: 'pointer', fontSize: 16, color: C.textSec, boxShadow: shadow(0) }}>‹</button>
        <span style={{ fontSize: 16, fontWeight: 600, color: C.text, textTransform: 'capitalize' }}>{MONTHS[month]} {year}</span>
        <button onClick={nextMonth} disabled={isCurrentMonth} style={{ width: 34, height: 34, borderRadius: 17, background: C.surface, border: 'none', cursor: isCurrentMonth ? 'default' : 'pointer', fontSize: 16, color: isCurrentMonth ? C.border : C.textSec, boxShadow: shadow(0), opacity: isCurrentMonth ? 0.5 : 1 }}>›</button>
      </div>

      {/* Calendar */}
      <div style={{ background: C.surface, borderRadius: 14, padding: '14px 10px', marginBottom: 10, boxShadow: shadow(0) }}>
        <div style={{ display: 'flex', marginBottom: 6 }}>
          {DAYS.map(d => <div key={d} style={{ flex: 1, textAlign: 'center', fontSize: 11, fontWeight: 600, color: C.textLight }}>{d}</div>)}
        </div>
        <div style={{ display: 'flex', flexWrap: 'wrap' }}>
          {Array.from({ length: calData.startPad }).map((_, i) => <div key={`p${i}`} style={{ width: `${100/7}%` }} />)}
          {calData.days.map(item => {
            const isFuture = item.date > today;
            const hasEntry = item.score !== null;
            return (
              <div key={item.date} style={{ width: `${100/7}%`, display: 'flex', justifyContent: 'center', padding: '3px 0' }}>
                <div
                  onClick={() => !isFuture && handleDayClick(item)}
                  style={{
                    width: 34, height: 34, borderRadius: 8, display: 'flex', alignItems: 'center', justifyContent: 'center', position: 'relative', cursor: hasEntry ? 'pointer' : 'default',
                    background: hasEntry ? getQuadrantTint(item.quadrant) : isFuture ? 'transparent' : C.surfaceAlt,
                    border: hasEntry ? `1.5px solid ${getScoreColor(item.score)}80` : '1.5px solid transparent',
                  }}
                >
                  {hasEntry && <div style={{ position: 'absolute', top: 4, right: 4, width: 5, height: 5, borderRadius: 2.5, background: getScoreColor(item.score) }} />}
                  <span style={{ fontSize: 12, fontWeight: hasEntry ? 600 : 400, color: isFuture ? C.borderLight : hasEntry ? C.text : C.textLight }}>{item.day}</span>
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* Legend */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: 14, marginBottom: 18 }}>
        {[['#5A9E7B','Bien'], ['#B8A87C','Regular'], ['#B07070','Difícil']].map(([color, label]) => (
          <div key={label} style={{ display: 'flex', alignItems: 'center', gap: 5 }}>
            <div style={{ width: 8, height: 8, borderRadius: 4, background: color }} />
            <span style={{ fontSize: 11, color: C.textLight, fontWeight: 500 }}>{label}</span>
          </div>
        ))}
      </div>

      {/* Month list */}
      {monthEntries.length > 0 ? (
        <div>
          <div style={{ fontSize: 14, fontWeight: 600, color: C.text, marginBottom: 10 }}>Registros de {MONTHS[month]}</div>
          {monthEntries.map(entry => (
            <div key={entry.date} onClick={() => setSelected(entry)} style={{ background: C.surface, borderRadius: 12, marginBottom: 8, display: 'flex', overflow: 'hidden', cursor: 'pointer', boxShadow: shadow(0) }}>
              <div style={{ width: 4, background: getQuadrantColor(entry.moodQuadrant), flexShrink: 0 }} />
              <div style={{ flex: 1, padding: '12px 14px' }}>
                <div style={{ fontSize: 11, color: C.textLight, textTransform: 'capitalize' }}>{new Date(entry.date + 'T00:00:00').toLocaleDateString('es-ES', { weekday: 'short', day: 'numeric', month: 'short' })}</div>
                <div style={{ fontSize: 14, fontWeight: 600, color: C.text, marginTop: 1 }}>{entry.moodLabel}</div>
                {entry.tags?.length > 0 && <div style={{ fontSize: 11, color: C.textLight, marginTop: 2 }}>{entry.tags.slice(0,3).join(' · ')}</div>}
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 2, paddingRight: 12 }}>
                <span style={{ fontSize: 16, fontWeight: 700, color: getScoreColor(entry.moodScore) }}>{entry.moodScore}</span>
                <span style={{ fontSize: 11, color: C.textLight }}>/10</span>
                <span style={{ color: C.border, marginLeft: 4 }}>›</span>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div style={{ textAlign: 'center', padding: '30px', color: C.textLight }}>
          <div style={{ fontSize: 32, marginBottom: 8 }}>📅</div>
          <div style={{ fontSize: 14 }}>No hay registros en {MONTHS[month]}</div>
        </div>
      )}

      {selected && <EntryModal entry={selected} onClose={() => setSelected(null)} />}
    </div>
  );
}
