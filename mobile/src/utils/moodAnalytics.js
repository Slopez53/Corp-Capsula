import { COLORS } from '../theme';

// Based on Russell's Circumplex Model of Affect (1980)
// valence: -1 (unpleasant) to 1 (pleasant)
// arousal: -1 (deactivated) to 1 (activated)

export const getMoodLabel = (valence, arousal) => {
  if (valence >= 0 && arousal >= 0) {
    if (valence > 0.6 && arousal > 0.6) return 'Eufórico';
    if (valence > 0.4 && arousal > 0.4) return 'Entusiasmado';
    if (valence > 0.2) return 'Activo';
    return 'Alerta';
  }
  if (valence >= 0 && arousal < 0) {
    if (valence > 0.6) return 'Sereno';
    if (valence > 0.4) return 'Contento';
    if (valence > 0.2) return 'Relajado';
    return 'Tranquilo';
  }
  if (valence < 0 && arousal >= 0) {
    if (arousal > 0.6) return 'Agitado';
    if (arousal > 0.4) return 'Tenso';
    if (arousal > 0.2) return 'Irritable';
    return 'Inquieto';
  }
  // low valence, low arousal
  if (valence < -0.6) return 'Angustiado';
  if (valence < -0.4) return 'Triste';
  if (valence < -0.2) return 'Melancólico';
  return 'Apagado';
};

export const getMoodQuadrant = (valence, arousal) => {
  if (valence >= 0 && arousal >= 0) return 'excited';
  if (valence >= 0 && arousal < 0) return 'content';
  if (valence < 0 && arousal >= 0) return 'stressed';
  return 'sad';
};

export const getQuadrantColor = (quadrant) => {
  const map = {
    excited: COLORS.colorExcited,
    content: COLORS.colorContent,
    stressed: COLORS.colorStressed,
    sad: COLORS.colorSad,
  };
  return map[quadrant] || COLORS.textLight;
};

export const getQuadrantTint = (quadrant) => {
  const map = {
    excited: COLORS.quadrantExcited,
    content: COLORS.quadrantContent,
    stressed: COLORS.quadrantStressed,
    sad: COLORS.quadrantSad,
  };
  return map[quadrant] || COLORS.surfaceAlt;
};

// Convert circumplex position to 1-10 score
// Valence drives the score; arousal in the positive direction adds a slight boost
export const getMoodScore = (valence, arousal) => {
  const valenceContrib = (valence + 1) / 2; // 0-1
  const arousalBoost = valence >= 0 ? arousal * 0.15 : -arousal * 0.1;
  const raw = Math.max(0, Math.min(1, valenceContrib + arousalBoost));
  const score = Math.round(raw * 9 + 1);
  return Math.max(1, Math.min(10, score));
};

export const getMoodScoreColor = (score) => {
  if (score <= 3) return COLORS.colorStressed;
  if (score <= 5) return '#B8A87C';
  if (score <= 7) return COLORS.colorContent;
  return '#5A9E7B';
};

export const calculateStreak = (entries) => {
  if (!entries || entries.length === 0) return 0;

  const uniqueDates = [...new Set(entries.map((e) => e.date))].sort().reverse();
  if (uniqueDates.length === 0) return 0;

  const today = new Date().toISOString().split('T')[0];
  const yesterday = new Date(Date.now() - 86400000).toISOString().split('T')[0];

  if (uniqueDates[0] !== today && uniqueDates[0] !== yesterday) return 0;

  let streak = 1;
  for (let i = 1; i < uniqueDates.length; i++) {
    const prev = new Date(uniqueDates[i - 1] + 'T00:00:00');
    const curr = new Date(uniqueDates[i] + 'T00:00:00');
    const diff = Math.round((prev - curr) / 86400000);
    if (diff === 1) {
      streak++;
    } else {
      break;
    }
  }
  return streak;
};

export const getWeeklyData = (entries) => {
  const DAY_NAMES = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];
  return Array.from({ length: 7 }, (_, i) => {
    const d = new Date();
    d.setDate(d.getDate() - (6 - i));
    const dateStr = d.toISOString().split('T')[0];
    const entry = entries.find((e) => e.date === dateStr);
    return {
      date: dateStr,
      day: DAY_NAMES[d.getDay()],
      score: entry ? entry.moodScore : null,
      quadrant: entry ? entry.moodQuadrant : null,
      isToday: i === 6,
    };
  });
};

export const getMonthCalendarData = (entries, year, month) => {
  const firstDay = new Date(year, month, 1);
  const lastDay = new Date(year, month + 1, 0);
  const days = [];

  for (let d = 1; d <= lastDay.getDate(); d++) {
    const date = new Date(year, month, d);
    const dateStr = date.toISOString().split('T')[0];
    const entry = entries.find((e) => e.date === dateStr);
    days.push({
      date: dateStr,
      day: d,
      weekday: date.getDay(),
      score: entry ? entry.moodScore : null,
      quadrant: entry ? entry.moodQuadrant : null,
    });
  }

  return { days, startPad: firstDay.getDay() };
};

export const getAverageScore = (entries) => {
  if (!entries || entries.length === 0) return null;
  const scores = entries.filter((e) => e.moodScore).map((e) => e.moodScore);
  if (scores.length === 0) return null;
  return +(scores.reduce((a, b) => a + b, 0) / scores.length).toFixed(1);
};

export const generateInsights = (entries) => {
  if (!entries || entries.length < 3) {
    return [
      {
        type: 'tip',
        icon: 'sparkles',
        title: 'Empieza tu historia',
        description:
          'Con 3 o más registros, Cápsula comenzará a detectar patrones en tu bienestar emocional.',
        color: COLORS.primary,
      },
    ];
  }

  const insights = [];

  // Streak insight
  const streak = calculateStreak(entries);
  if (streak >= 3) {
    insights.push({
      type: 'achievement',
      icon: 'flame',
      title: `${streak} días seguidos`,
      description:
        'La constancia es el primer paso para entenderte mejor. Cada registro cuenta.',
      color: COLORS.accent,
    });
  }

  // Best day of week
  if (entries.length >= 7) {
    const DAY_NAMES = ['Domingos', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábados'];
    const dayAcc = {};
    entries.forEach((e) => {
      const day = new Date(e.date + 'T00:00:00').getDay();
      if (!dayAcc[day]) dayAcc[day] = [];
      dayAcc[day].push(e.moodScore);
    });

    const dayAvgs = Object.entries(dayAcc)
      .filter(([, scores]) => scores.length >= 2)
      .map(([day, scores]) => ({
        day: parseInt(day),
        avg: scores.reduce((a, b) => a + b, 0) / scores.length,
      }));

    if (dayAvgs.length >= 3) {
      const best = dayAvgs.reduce((a, b) => (a.avg > b.avg ? a : b));
      const worst = dayAvgs.reduce((a, b) => (a.avg < b.avg ? a : b));
      if (best.avg - worst.avg > 1.5) {
        insights.push({
          type: 'pattern',
          icon: 'calendar',
          title: `Mejor los ${DAY_NAMES[best.day]}`,
          description: `Tu bienestar tiende a ser más alto los ${DAY_NAMES[best.day]} (promedio ${best.avg.toFixed(1)}/10).`,
          color: COLORS.colorContent,
        });
      }
    }
  }

  // Sleep correlation
  const sleepEntries = entries.filter((e) => e.sleepQuality != null);
  if (sleepEntries.length >= 5) {
    const goodSleep = sleepEntries.filter((e) => e.sleepQuality >= 4).map((e) => e.moodScore);
    const badSleep = sleepEntries.filter((e) => e.sleepQuality <= 2).map((e) => e.moodScore);

    if (goodSleep.length >= 2 && badSleep.length >= 2) {
      const gAvg = goodSleep.reduce((a, b) => a + b, 0) / goodSleep.length;
      const bAvg = badSleep.reduce((a, b) => a + b, 0) / badSleep.length;
      if (gAvg - bAvg > 1.2) {
        insights.push({
          type: 'correlation',
          icon: 'moon',
          title: 'El sueño importa',
          description: `Cuando duermes bien, tu ánimo mejora en promedio ${(gAvg - bAvg).toFixed(1)} puntos.`,
          color: COLORS.colorSad,
        });
      }
    }
  }

  // Recent trend (7-day vs prior 7-day)
  const recent = entries.slice(0, 7);
  const prior = entries.slice(7, 14);
  if (recent.length >= 3 && prior.length >= 3) {
    const rAvg = recent.reduce((a, b) => a + b.moodScore, 0) / recent.length;
    const pAvg = prior.reduce((a, b) => a + b.moodScore, 0) / prior.length;
    const diff = rAvg - pAvg;
    if (Math.abs(diff) >= 1) {
      insights.push({
        type: 'trend',
        icon: diff > 0 ? 'trending-up' : 'trending-down',
        title: diff > 0 ? 'Tendencia positiva' : 'Semana más difícil',
        description:
          diff > 0
            ? `Tu bienestar mejoró ${diff.toFixed(1)} punto esta semana. ¡Buen trabajo!`
            : `Tu bienestar bajó ${Math.abs(diff).toFixed(1)} punto esta semana. Considera hablar con tu médico si persiste.`,
        color: diff > 0 ? COLORS.colorContent : COLORS.colorStressed,
      });
    }
  }

  // Most common quadrant
  if (entries.length >= 5) {
    const quadrantCount = {};
    entries.slice(0, 14).forEach((e) => {
      quadrantCount[e.moodQuadrant] = (quadrantCount[e.moodQuadrant] || 0) + 1;
    });
    const dominant = Object.entries(quadrantCount).reduce((a, b) => (a[1] > b[1] ? a : b));
    const quadrantNames = {
      excited: 'Activo y positivo',
      content: 'Tranquilo y contento',
      stressed: 'Tenso o estresado',
      sad: 'Bajo y agotado',
    };
    if (dominant[1] >= 3) {
      insights.push({
        type: 'profile',
        icon: 'person',
        title: `Tu zona habitual: ${quadrantNames[dominant[0]]}`,
        description: `En las últimas 2 semanas, este ha sido tu estado emocional más frecuente.`,
        color: getQuadrantColor(dominant[0]),
      });
    }
  }

  return insights;
};
