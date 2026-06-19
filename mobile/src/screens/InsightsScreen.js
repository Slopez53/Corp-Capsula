import React, { useState, useCallback } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  Dimensions,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useFocusEffect } from '@react-navigation/native';
import Svg, { Path, Circle, Line, Defs, LinearGradient, Stop, Rect } from 'react-native-svg';
import { getMoodEntries } from '../services/storage';
import {
  getWeeklyData,
  generateInsights,
  calculateStreak,
  getAverageScore,
  getMoodScoreColor,
  getQuadrantColor,
} from '../utils/moodAnalytics';
import InsightCard from '../components/InsightCard';
import { COLORS, TYPOGRAPHY, SPACING, RADIUS, SHADOWS } from '../theme';

const { width: SCREEN_WIDTH } = Dimensions.get('window');
const CHART_WIDTH = SCREEN_WIDTH - SPACING.lg * 2 - SPACING.md * 2;
const CHART_HEIGHT = 120;
const CHART_PAD_X = 20;
const CHART_PAD_Y = 16;

function TrendChart({ data }) {
  const validPoints = data.map((d, i) => ({ ...d, index: i })).filter((d) => d.score !== null);
  if (validPoints.length < 2) {
    return (
      <View style={chartStyles.empty}>
        <Text style={chartStyles.emptyText}>Registra más días para ver tu tendencia</Text>
      </View>
    );
  }

  const innerW = CHART_WIDTH - CHART_PAD_X * 2;
  const innerH = CHART_HEIGHT - CHART_PAD_Y * 2;
  const minScore = 1;
  const maxScore = 10;

  const getX = (index) => CHART_PAD_X + (index / (data.length - 1)) * innerW;
  const getY = (score) =>
    CHART_PAD_Y + innerH - ((score - minScore) / (maxScore - minScore)) * innerH;

  // Build smooth path
  const points = data.map((d, i) => ({
    x: getX(i),
    y: d.score !== null ? getY(d.score) : null,
  }));

  let pathD = '';
  let areaD = '';
  let firstX = null;
  let lastX = null;

  points.forEach((p, i) => {
    if (p.y === null) return;
    if (firstX === null) firstX = p.x;
    lastX = p.x;

    if (pathD === '') {
      pathD = `M ${p.x} ${p.y}`;
      areaD = `M ${p.x} ${CHART_HEIGHT} L ${p.x} ${p.y}`;
    } else {
      // Curved line using cubic bezier
      const prev = points.slice(0, i).reverse().find((pp) => pp.y !== null);
      if (prev) {
        const cpx1 = prev.x + (p.x - prev.x) * 0.5;
        const cpx2 = p.x - (p.x - prev.x) * 0.5;
        pathD += ` C ${cpx1} ${prev.y} ${cpx2} ${p.y} ${p.x} ${p.y}`;
        areaD += ` C ${cpx1} ${prev.y} ${cpx2} ${p.y} ${p.x} ${p.y}`;
      }
    }
  });

  if (lastX !== null) {
    areaD += ` L ${lastX} ${CHART_HEIGHT} Z`;
  }

  return (
    <Svg width={CHART_WIDTH} height={CHART_HEIGHT}>
      <Defs>
        <LinearGradient id="areaGrad" x1="0" y1="0" x2="0" y2="1">
          <Stop offset="0" stopColor={COLORS.primary} stopOpacity="0.18" />
          <Stop offset="1" stopColor={COLORS.primary} stopOpacity="0" />
        </LinearGradient>
      </Defs>

      {/* Grid lines */}
      {[3, 5, 7, 9].map((v) => (
        <Line
          key={v}
          x1={CHART_PAD_X}
          y1={getY(v)}
          x2={CHART_WIDTH - CHART_PAD_X}
          y2={getY(v)}
          stroke={COLORS.border}
          strokeWidth={0.5}
          strokeDasharray="3,3"
        />
      ))}

      {/* Area fill */}
      {areaD !== '' && <Path d={areaD} fill="url(#areaGrad)" />}

      {/* Line */}
      {pathD !== '' && (
        <Path d={pathD} stroke={COLORS.primary} strokeWidth={2} fill="none" strokeLinecap="round" />
      )}

      {/* Data points */}
      {points.map(
        (p, i) =>
          p.y !== null && (
            <Circle
              key={i}
              cx={p.x}
              cy={p.y}
              r={data[i].isToday ? 5 : 3.5}
              fill={data[i].isToday ? COLORS.primary : COLORS.surface}
              stroke={COLORS.primary}
              strokeWidth={data[i].isToday ? 0 : 1.5}
            />
          )
      )}
    </Svg>
  );
}

const chartStyles = StyleSheet.create({
  empty: {
    height: CHART_HEIGHT,
    alignItems: 'center',
    justifyContent: 'center',
  },
  emptyText: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textLight,
    textAlign: 'center',
  },
});

function QuadrantDistribution({ entries }) {
  const counts = { excited: 0, content: 0, stressed: 0, sad: 0 };
  entries.slice(0, 30).forEach((e) => {
    if (e.moodQuadrant in counts) counts[e.moodQuadrant]++;
  });

  const total = Object.values(counts).reduce((a, b) => a + b, 0);
  if (total === 0) return null;

  const labels = {
    excited: 'Activo',
    content: 'Sereno',
    stressed: 'Tenso',
    sad: 'Bajo',
  };

  return (
    <View style={distStyles.container}>
      {Object.entries(counts).map(([q, count]) => {
        const pct = total > 0 ? Math.round((count / total) * 100) : 0;
        return (
          <View key={q} style={distStyles.bar}>
            <Text style={distStyles.pct}>{pct}%</Text>
            <View style={distStyles.track}>
              <View
                style={[
                  distStyles.fill,
                  { height: `${pct}%`, backgroundColor: getQuadrantColor(q) },
                ]}
              />
            </View>
            <Text style={distStyles.label}>{labels[q]}</Text>
          </View>
        );
      })}
    </View>
  );
}

const distStyles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'flex-end',
    height: 100,
    paddingTop: 20,
  },
  bar: {
    alignItems: 'center',
    gap: 4,
    flex: 1,
  },
  pct: {
    fontSize: TYPOGRAPHY.xs,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.textSecondary,
  },
  track: {
    width: 28,
    height: 60,
    backgroundColor: COLORS.surfaceAlt,
    borderRadius: RADIUS.xs,
    justifyContent: 'flex-end',
    overflow: 'hidden',
  },
  fill: {
    width: '100%',
    borderRadius: RADIUS.xs,
  },
  label: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    fontWeight: TYPOGRAPHY.medium,
  },
});

export default function InsightsScreen() {
  const [entries, setEntries] = useState([]);
  const [weeklyData, setWeeklyData] = useState([]);
  const [insights, setInsights] = useState([]);
  const [streak, setStreak] = useState(0);
  const [avgScore, setAvgScore] = useState(null);

  useFocusEffect(
    useCallback(() => {
      (async () => {
        const data = await getMoodEntries();
        setEntries(data);
        setWeeklyData(getWeeklyData(data));
        setInsights(generateInsights(data));
        setStreak(calculateStreak(data));
        setAvgScore(getAverageScore(data.slice(0, 30)));
      })();
    }, [])
  );

  const totalEntries = entries.length;

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      <ScrollView
        style={styles.scroll}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <Text style={styles.pageTitle}>Análisis</Text>
        <Text style={styles.pageSubtitle}>Patrones en tu bienestar emocional</Text>

        {/* Summary pills */}
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.pillsRow}
        >
          <View style={styles.pill}>
            <Text style={styles.pillValue}>{totalEntries}</Text>
            <Text style={styles.pillLabel}>Registros</Text>
          </View>
          <View style={styles.pill}>
            <Text style={[styles.pillValue, avgScore && { color: getMoodScoreColor(avgScore) }]}>
              {avgScore ?? '—'}
            </Text>
            <Text style={styles.pillLabel}>Promedio</Text>
          </View>
          <View style={styles.pill}>
            <Text style={styles.pillValue}>{streak}</Text>
            <Text style={styles.pillLabel}>Racha actual</Text>
          </View>
          <View style={styles.pill}>
            <Text style={styles.pillValue}>
              {entries.length > 0
                ? Math.max(...entries.slice(0, 30).map((e) => e.moodScore))
                : '—'}
            </Text>
            <Text style={styles.pillLabel}>Mejor (30d)</Text>
          </View>
        </ScrollView>

        {/* Trend chart */}
        <View style={styles.card}>
          <Text style={styles.cardTitle}>Tendencia semanal</Text>
          <View style={styles.chartWrap}>
            <TrendChart data={weeklyData} />
          </View>
          {/* Day labels */}
          <View style={styles.chartDayLabels}>
            {weeklyData.map((d) => (
              <Text
                key={d.date}
                style={[styles.chartDay, d.isToday && { color: COLORS.primary, fontWeight: TYPOGRAPHY.bold }]}
              >
                {d.day}
              </Text>
            ))}
          </View>
        </View>

        {/* Quadrant distribution */}
        {totalEntries >= 5 && (
          <View style={styles.card}>
            <Text style={styles.cardTitle}>Distribución emocional (30 días)</Text>
            <Text style={styles.cardSubtitle}>
              Qué tan seguido estás en cada estado emocional
            </Text>
            <QuadrantDistribution entries={entries} />
          </View>
        )}

        {/* Insights */}
        <Text style={styles.sectionTitle}>Perspectivas</Text>
        {insights.map((insight, i) => (
          <InsightCard key={i} insight={insight} delay={i * 80} />
        ))}

        <View style={{ height: SPACING.xl }} />
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: COLORS.background },
  scroll: { flex: 1 },
  content: {
    paddingHorizontal: SPACING.lg,
    paddingTop: SPACING.md,
  },

  pageTitle: {
    fontSize: TYPOGRAPHY['2xl'],
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.text,
    letterSpacing: -0.5,
  },
  pageSubtitle: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textSecondary,
    marginTop: 3,
    marginBottom: SPACING.lg,
  },

  pillsRow: {
    gap: SPACING.sm,
    paddingBottom: SPACING.md,
  },
  pill: {
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.md,
    paddingHorizontal: SPACING.md,
    paddingVertical: SPACING.md,
    alignItems: 'center',
    minWidth: 80,
    ...SHADOWS.sm,
  },
  pillValue: {
    fontSize: TYPOGRAPHY.xl,
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.text,
  },
  pillLabel: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    marginTop: 2,
    textAlign: 'center',
  },

  card: {
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.lg,
    padding: SPACING.md,
    marginBottom: SPACING.md,
    ...SHADOWS.sm,
  },
  cardTitle: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
    marginBottom: 4,
  },
  cardSubtitle: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textSecondary,
    marginBottom: SPACING.sm,
  },
  chartWrap: { marginTop: SPACING.sm },
  chartDayLabels: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 6,
    paddingHorizontal: CHART_PAD_X - 8,
  },
  chartDay: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    textAlign: 'center',
    flex: 1,
  },

  sectionTitle: {
    fontSize: TYPOGRAPHY.lg,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
    marginBottom: SPACING.sm,
    marginTop: SPACING.xs,
  },
});
