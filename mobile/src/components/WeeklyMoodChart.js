import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { COLORS, TYPOGRAPHY, RADIUS } from '../theme';
import { getMoodScoreColor } from '../utils/moodAnalytics';

export default function WeeklyMoodChart({ data }) {
  const maxScore = 10;

  return (
    <View style={styles.container}>
      {data.map((item, index) => (
        <View key={item.date} style={styles.col}>
          {/* Bar */}
          <View style={styles.barTrack}>
            {item.score !== null ? (
              <View
                style={[
                  styles.bar,
                  {
                    height: `${(item.score / maxScore) * 100}%`,
                    backgroundColor: getMoodScoreColor(item.score),
                    opacity: item.isToday ? 1 : 0.7,
                  },
                ]}
              />
            ) : (
              <View style={styles.barEmpty} />
            )}
          </View>

          {/* Score label */}
          <Text style={[styles.scoreLabel, { color: item.score ? getMoodScoreColor(item.score) : COLORS.borderLight }]}>
            {item.score !== null ? item.score : '·'}
          </Text>

          {/* Day label */}
          <Text
            style={[
              styles.dayLabel,
              item.isToday && styles.dayLabelToday,
            ]}
          >
            {item.day}
          </Text>

          {/* Today indicator */}
          {item.isToday && <View style={styles.todayDot} />}
        </View>
      ))}
    </View>
  );
}

const CHART_HEIGHT = 100;

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    justifyContent: 'space-between',
    paddingHorizontal: 4,
  },
  col: {
    flex: 1,
    alignItems: 'center',
  },
  barTrack: {
    width: 22,
    height: CHART_HEIGHT,
    backgroundColor: COLORS.surfaceAlt,
    borderRadius: RADIUS.xs,
    justifyContent: 'flex-end',
    overflow: 'hidden',
  },
  bar: {
    width: '100%',
    borderRadius: RADIUS.xs,
  },
  barEmpty: {
    width: '100%',
    height: '20%',
    backgroundColor: COLORS.borderLight,
    borderRadius: RADIUS.xs,
  },
  scoreLabel: {
    fontSize: TYPOGRAPHY.xs,
    fontWeight: TYPOGRAPHY.semibold,
    marginTop: 4,
  },
  dayLabel: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    fontWeight: TYPOGRAPHY.medium,
    marginTop: 2,
  },
  dayLabelToday: {
    color: COLORS.primary,
    fontWeight: TYPOGRAPHY.bold,
  },
  todayDot: {
    width: 4,
    height: 4,
    borderRadius: 2,
    backgroundColor: COLORS.primary,
    marginTop: 3,
  },
});
