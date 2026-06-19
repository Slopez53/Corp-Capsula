import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { COLORS, TYPOGRAPHY, RADIUS } from '../theme';
import { getMoodScoreColor, getQuadrantTint } from '../utils/moodAnalytics';
import { isFuture } from '../utils/dateHelpers';

const WEEK_DAYS = ['D', 'L', 'M', 'X', 'J', 'V', 'S'];
const CELL_SIZE = 36;
const CELL_GAP = 6;

export default function MoodCalendar({ data, onDayPress }) {
  const { days, startPad } = data;

  return (
    <View style={styles.container}>
      {/* Weekday headers */}
      <View style={styles.row}>
        {WEEK_DAYS.map((d) => (
          <View key={d} style={styles.cell}>
            <Text style={styles.weekdayLabel}>{d}</Text>
          </View>
        ))}
      </View>

      {/* Calendar grid */}
      <View style={styles.grid}>
        {/* Leading empty cells */}
        {Array.from({ length: startPad }).map((_, i) => (
          <View key={`pad-${i}`} style={styles.cell} />
        ))}

        {days.map((item) => {
          const future = isFuture(item.date);
          const hasEntry = item.score !== null;

          return (
            <TouchableOpacity
              key={item.date}
              style={styles.cell}
              onPress={() => !future && onDayPress && onDayPress(item)}
              activeOpacity={hasEntry ? 0.7 : 1}
              disabled={future}
            >
              <View
                style={[
                  styles.dayCell,
                  hasEntry && {
                    backgroundColor: getQuadrantTint(item.quadrant),
                    borderColor: getMoodScoreColor(item.score) + '80',
                    borderWidth: 1.5,
                  },
                  future && styles.futureCell,
                ]}
              >
                {hasEntry && (
                  <View
                    style={[
                      styles.scoreDot,
                      { backgroundColor: getMoodScoreColor(item.score) },
                    ]}
                  />
                )}
                <Text
                  style={[
                    styles.dayNumber,
                    hasEntry && { color: COLORS.text, fontWeight: TYPOGRAPHY.semibold },
                    future && { color: COLORS.borderLight },
                  ]}
                >
                  {item.day}
                </Text>
              </View>
            </TouchableOpacity>
          );
        })}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {},
  row: {
    flexDirection: 'row',
    marginBottom: 4,
  },
  grid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  cell: {
    width: `${100 / 7}%`,
    alignItems: 'center',
    marginVertical: 3,
  },
  weekdayLabel: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    fontWeight: TYPOGRAPHY.semibold,
    textAlign: 'center',
  },
  dayCell: {
    width: CELL_SIZE,
    height: CELL_SIZE,
    borderRadius: RADIUS.sm,
    backgroundColor: COLORS.surfaceAlt,
    alignItems: 'center',
    justifyContent: 'center',
    position: 'relative',
  },
  futureCell: {
    backgroundColor: 'transparent',
  },
  dayNumber: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textLight,
  },
  scoreDot: {
    position: 'absolute',
    top: 5,
    right: 5,
    width: 5,
    height: 5,
    borderRadius: 2.5,
  },
});
