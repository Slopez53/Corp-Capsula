import React, { useState, useCallback } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  Modal,
  StyleSheet,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useFocusEffect } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import * as Haptics from 'expo-haptics';
import { getMoodEntries } from '../services/storage';
import { getMonthCalendarData, getQuadrantColor, getMoodScoreColor } from '../utils/moodAnalytics';
import MoodCalendar from '../components/MoodCalendar';
import { getMonthName, formatDateLong } from '../utils/dateHelpers';
import { COLORS, TYPOGRAPHY, SPACING, RADIUS, SHADOWS } from '../theme';

function EntryDetailModal({ entry, onClose }) {
  if (!entry) return null;

  const color = getQuadrantColor(entry.moodQuadrant);

  return (
    <Modal visible={!!entry} transparent animationType="fade" onRequestClose={onClose}>
      <TouchableOpacity style={modal.backdrop} activeOpacity={1} onPress={onClose}>
        <TouchableOpacity activeOpacity={1} style={modal.card}>
          {/* Header */}
          <View style={modal.header}>
            <View>
              <Text style={modal.date}>{formatDateLong(entry.date)}</Text>
              <Text style={[modal.mood, { color }]}>{entry.moodLabel}</Text>
            </View>
            <View style={[modal.scoreCircle, { borderColor: getMoodScoreColor(entry.moodScore) }]}>
              <Text style={[modal.score, { color: getMoodScoreColor(entry.moodScore) }]}>
                {entry.moodScore}
              </Text>
              <Text style={modal.scoreMax}>/10</Text>
            </View>
          </View>

          <View style={modal.divider} />

          {/* Metrics */}
          <View style={modal.metrics}>
            {entry.sleepQuality && (
              <View style={modal.metric}>
                <Ionicons name="moon-outline" size={16} color={COLORS.colorSad} />
                <Text style={modal.metricLabel}>Sueño</Text>
                <Text style={modal.metricValue}>{entry.sleepQuality}/5</Text>
              </View>
            )}
            {entry.energyLevel && (
              <View style={modal.metric}>
                <Ionicons name="flash-outline" size={16} color={COLORS.colorExcited} />
                <Text style={modal.metricLabel}>Energía</Text>
                <Text style={modal.metricValue}>{entry.energyLevel}/5</Text>
              </View>
            )}
            <View style={modal.metric}>
              <Ionicons name="time-outline" size={16} color={COLORS.textLight} />
              <Text style={modal.metricLabel}>Hora</Text>
              <Text style={modal.metricValue}>{entry.time || '—'}</Text>
            </View>
          </View>

          {/* Tags */}
          {entry.tags && entry.tags.length > 0 && (
            <View style={modal.tagsSection}>
              <Text style={modal.sectionLabel}>Contexto</Text>
              <View style={modal.tags}>
                {entry.tags.map((t) => (
                  <View key={t} style={modal.tag}>
                    <Text style={modal.tagText}>{t}</Text>
                  </View>
                ))}
              </View>
            </View>
          )}

          {/* Note */}
          {entry.note ? (
            <View style={modal.noteSection}>
              <Text style={modal.sectionLabel}>Nota</Text>
              <Text style={modal.noteText}>{entry.note}</Text>
            </View>
          ) : null}

          <TouchableOpacity style={modal.closeBtn} onPress={onClose}>
            <Text style={modal.closeBtnText}>Cerrar</Text>
          </TouchableOpacity>
        </TouchableOpacity>
      </TouchableOpacity>
    </Modal>
  );
}

const modal = StyleSheet.create({
  backdrop: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.4)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: SPACING.lg,
  },
  card: {
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.xl,
    padding: SPACING.lg,
    width: '100%',
    maxWidth: 380,
    ...SHADOWS.lg,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: SPACING.md,
  },
  date: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textSecondary,
    textTransform: 'capitalize',
  },
  mood: {
    fontSize: TYPOGRAPHY.xl,
    fontWeight: TYPOGRAPHY.bold,
    marginTop: 2,
  },
  scoreCircle: {
    width: 56,
    height: 56,
    borderRadius: 28,
    borderWidth: 2.5,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
  },
  score: {
    fontSize: TYPOGRAPHY.lg,
    fontWeight: TYPOGRAPHY.bold,
  },
  scoreMax: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    marginTop: 4,
  },
  divider: {
    height: 1,
    backgroundColor: COLORS.borderLight,
    marginBottom: SPACING.md,
  },
  metrics: {
    flexDirection: 'row',
    gap: SPACING.lg,
    marginBottom: SPACING.md,
  },
  metric: {
    alignItems: 'center',
    gap: 3,
  },
  metricLabel: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
  },
  metricValue: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
  },
  sectionLabel: {
    fontSize: TYPOGRAPHY.sm,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.textSecondary,
    marginBottom: SPACING.xs,
  },
  tagsSection: { marginBottom: SPACING.md },
  tags: { flexDirection: 'row', flexWrap: 'wrap', gap: 6 },
  tag: {
    backgroundColor: COLORS.surfaceAlt,
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: RADIUS.full,
  },
  tagText: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textSecondary,
    fontWeight: TYPOGRAPHY.medium,
  },
  noteSection: { marginBottom: SPACING.md },
  noteText: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.text,
    lineHeight: 20,
    fontStyle: 'italic',
  },
  closeBtn: {
    backgroundColor: COLORS.surfaceAlt,
    borderRadius: RADIUS.full,
    paddingVertical: 12,
    alignItems: 'center',
    marginTop: SPACING.sm,
  },
  closeBtnText: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.textSecondary,
  },
});

export default function HistoryScreen() {
  const now = new Date();
  const [year, setYear] = useState(now.getFullYear());
  const [month, setMonth] = useState(now.getMonth());
  const [calendarData, setCalendarData] = useState({ days: [], startPad: 0 });
  const [monthEntries, setMonthEntries] = useState([]);
  const [selectedEntry, setSelectedEntry] = useState(null);
  const [allEntries, setAllEntries] = useState([]);

  const loadData = useCallback(async () => {
    const entries = await getMoodEntries();
    setAllEntries(entries);
    const calData = getMonthCalendarData(entries, year, month);
    setCalendarData(calData);
    setMonthEntries(
      entries
        .filter((e) => {
          const d = new Date(e.date + 'T00:00:00');
          return d.getFullYear() === year && d.getMonth() === month;
        })
        .sort((a, b) => b.date.localeCompare(a.date))
    );
  }, [year, month]);

  useFocusEffect(
    useCallback(() => {
      loadData();
    }, [loadData])
  );

  const prevMonth = () => {
    Haptics.selectionAsync();
    if (month === 0) {
      setMonth(11);
      setYear((y) => y - 1);
    } else {
      setMonth((m) => m - 1);
    }
  };

  const nextMonth = () => {
    const nowDate = new Date();
    if (year === nowDate.getFullYear() && month === nowDate.getMonth()) return;
    Haptics.selectionAsync();
    if (month === 11) {
      setMonth(0);
      setYear((y) => y + 1);
    } else {
      setMonth((m) => m + 1);
    }
  };

  const isCurrentMonth =
    year === now.getFullYear() && month === now.getMonth();

  const handleDayPress = (item) => {
    if (!item.score) return;
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    const entry = allEntries.find((e) => e.date === item.date);
    if (entry) setSelectedEntry(entry);
  };

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      <ScrollView
        style={styles.scroll}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <Text style={styles.pageTitle}>Historial</Text>
        <Text style={styles.pageSubtitle}>
          {allEntries.length > 0
            ? `${allEntries.length} registros en total`
            : 'Tus registros aparecerán aquí'}
        </Text>

        {/* Month navigator */}
        <View style={styles.monthNav}>
          <TouchableOpacity onPress={prevMonth} style={styles.navBtn}>
            <Ionicons name="chevron-back" size={20} color={COLORS.textSecondary} />
          </TouchableOpacity>

          <Text style={styles.monthTitle}>
            {getMonthName(month)} {year}
          </Text>

          <TouchableOpacity
            onPress={nextMonth}
            style={[styles.navBtn, isCurrentMonth && styles.navBtnDisabled]}
            disabled={isCurrentMonth}
          >
            <Ionicons
              name="chevron-forward"
              size={20}
              color={isCurrentMonth ? COLORS.border : COLORS.textSecondary}
            />
          </TouchableOpacity>
        </View>

        {/* Calendar */}
        <View style={styles.calendarCard}>
          <MoodCalendar data={calendarData} onDayPress={handleDayPress} />
        </View>

        {/* Legend */}
        <View style={styles.legend}>
          <View style={styles.legendItem}>
            <View style={[styles.legendDot, { backgroundColor: COLORS.colorContent }]} />
            <Text style={styles.legendText}>Bien</Text>
          </View>
          <View style={styles.legendItem}>
            <View style={[styles.legendDot, { backgroundColor: '#B8A87C' }]} />
            <Text style={styles.legendText}>Regular</Text>
          </View>
          <View style={styles.legendItem}>
            <View style={[styles.legendDot, { backgroundColor: COLORS.colorStressed }]} />
            <Text style={styles.legendText}>Difícil</Text>
          </View>
          <View style={styles.legendItem}>
            <View style={[styles.legendDot, { backgroundColor: COLORS.surfaceAlt, borderWidth: 1, borderColor: COLORS.border }]} />
            <Text style={styles.legendText}>Sin registro</Text>
          </View>
        </View>

        {/* Entries list for this month */}
        {monthEntries.length > 0 ? (
          <View style={styles.section}>
            <Text style={styles.sectionTitle}>
              Registros de {getMonthName(month)}
            </Text>
            {monthEntries.map((entry) => (
              <TouchableOpacity
                key={entry.date}
                style={styles.entryCard}
                onPress={() => {
                  Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
                  setSelectedEntry(entry);
                }}
                activeOpacity={0.8}
              >
                <View
                  style={[
                    styles.entryColorBar,
                    { backgroundColor: getQuadrantColor(entry.moodQuadrant) },
                  ]}
                />
                <View style={styles.entryInfo}>
                  <Text style={styles.entryDate}>
                    {new Date(entry.date + 'T00:00:00').toLocaleDateString('es-ES', {
                      weekday: 'short',
                      day: 'numeric',
                      month: 'short',
                    })}
                  </Text>
                  <Text style={styles.entryMood}>{entry.moodLabel}</Text>
                  {entry.tags && entry.tags.length > 0 && (
                    <Text style={styles.entryTags} numberOfLines={1}>
                      {entry.tags.slice(0, 3).join(' · ')}
                    </Text>
                  )}
                </View>
                <View style={styles.entryRight}>
                  <Text
                    style={[
                      styles.entryScore,
                      { color: getMoodScoreColor(entry.moodScore) },
                    ]}
                  >
                    {entry.moodScore}
                  </Text>
                  <Text style={styles.entryScoreMax}>/10</Text>
                  <Ionicons name="chevron-forward" size={14} color={COLORS.border} style={{ marginTop: 2 }} />
                </View>
              </TouchableOpacity>
            ))}
          </View>
        ) : (
          <View style={styles.emptyMonth}>
            <Ionicons name="calendar-outline" size={36} color={COLORS.border} />
            <Text style={styles.emptyText}>
              No hay registros en {getMonthName(month)}
            </Text>
          </View>
        )}

        <View style={{ height: SPACING.xl }} />
      </ScrollView>

      <EntryDetailModal entry={selectedEntry} onClose={() => setSelectedEntry(null)} />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: COLORS.background },
  scroll: { flex: 1 },
  content: { paddingHorizontal: SPACING.lg, paddingTop: SPACING.md },

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

  monthNav: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: SPACING.sm,
  },
  navBtn: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: COLORS.surface,
    alignItems: 'center',
    justifyContent: 'center',
    ...SHADOWS.sm,
  },
  navBtnDisabled: { opacity: 0.4 },
  monthTitle: {
    fontSize: TYPOGRAPHY.lg,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
    textTransform: 'capitalize',
  },

  calendarCard: {
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.lg,
    padding: SPACING.md,
    marginBottom: SPACING.sm,
    ...SHADOWS.sm,
  },

  legend: {
    flexDirection: 'row',
    justifyContent: 'center',
    gap: SPACING.md,
    marginBottom: SPACING.lg,
  },
  legendItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 5,
  },
  legendDot: {
    width: 10,
    height: 10,
    borderRadius: 5,
  },
  legendText: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    fontWeight: TYPOGRAPHY.medium,
  },

  section: { marginBottom: SPACING.md },
  sectionTitle: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
    marginBottom: SPACING.sm,
    textTransform: 'capitalize',
  },

  entryCard: {
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.md,
    marginBottom: SPACING.xs,
    flexDirection: 'row',
    alignItems: 'center',
    overflow: 'hidden',
    ...SHADOWS.sm,
  },
  entryColorBar: {
    width: 4,
    alignSelf: 'stretch',
  },
  entryInfo: {
    flex: 1,
    padding: SPACING.md,
  },
  entryDate: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    textTransform: 'capitalize',
  },
  entryMood: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
    marginTop: 1,
  },
  entryTags: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    marginTop: 2,
  },
  entryRight: {
    flexDirection: 'row',
    alignItems: 'baseline',
    paddingRight: SPACING.sm,
    gap: 1,
  },
  entryScore: {
    fontSize: TYPOGRAPHY.lg,
    fontWeight: TYPOGRAPHY.bold,
  },
  entryScoreMax: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
  },

  emptyMonth: {
    alignItems: 'center',
    paddingVertical: SPACING.xl,
    gap: SPACING.sm,
  },
  emptyText: {
    fontSize: TYPOGRAPHY.base,
    color: COLORS.textLight,
    textAlign: 'center',
  },
});
