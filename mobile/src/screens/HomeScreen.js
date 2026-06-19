import React, { useState, useCallback, useRef } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  Animated,
  StyleSheet,
  RefreshControl,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useFocusEffect } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import * as Haptics from 'expo-haptics';
import { getMoodEntries, getUserName, getTodayEntry } from '../services/storage';
import {
  calculateStreak,
  getWeeklyData,
  getMoodScoreColor,
  getQuadrantColor,
  getQuadrantTint,
  getAverageScore,
} from '../utils/moodAnalytics';
import { getGreeting, formatRelative } from '../utils/dateHelpers';
import WeeklyMoodChart from '../components/WeeklyMoodChart';
import { COLORS, TYPOGRAPHY, SPACING, RADIUS, SHADOWS } from '../theme';

export default function HomeScreen({ navigation }) {
  const [userName, setUserName] = useState('');
  const [todayEntry, setTodayEntry] = useState(null);
  const [streak, setStreak] = useState(0);
  const [weeklyData, setWeeklyData] = useState([]);
  const [recentEntries, setRecentEntries] = useState([]);
  const [totalEntries, setTotalEntries] = useState(0);
  const [avgScore, setAvgScore] = useState(null);
  const [refreshing, setRefreshing] = useState(false);

  const pulseAnim = useRef(new Animated.Value(1)).current;
  const pulseRef = useRef(null);

  const loadData = useCallback(async () => {
    const [name, entries, todayE] = await Promise.all([
      getUserName(),
      getMoodEntries(),
      getTodayEntry(),
    ]);
    setUserName(name);
    setTodayEntry(todayE);
    setStreak(calculateStreak(entries));
    setWeeklyData(getWeeklyData(entries));
    setRecentEntries(entries.slice(0, 5));
    setTotalEntries(entries.length);
    setAvgScore(getAverageScore(entries.slice(0, 30)));
  }, []);

  useFocusEffect(
    useCallback(() => {
      loadData();
    }, [loadData])
  );

  // Pulse animation on the check-in button when not done today
  React.useEffect(() => {
    if (!todayEntry) {
      pulseRef.current = Animated.loop(
        Animated.sequence([
          Animated.timing(pulseAnim, { toValue: 1.04, duration: 1000, useNativeDriver: true }),
          Animated.timing(pulseAnim, { toValue: 1, duration: 1000, useNativeDriver: true }),
        ])
      );
      pulseRef.current.start();
    } else {
      if (pulseRef.current) pulseRef.current.stop();
      pulseAnim.setValue(1);
    }
    return () => {
      if (pulseRef.current) pulseRef.current.stop();
    };
  }, [todayEntry]);

  const onRefresh = async () => {
    setRefreshing(true);
    await loadData();
    setRefreshing(false);
  };

  const handleCheckIn = () => {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    navigation.navigate('CheckIn');
  };

  const greeting = getGreeting(userName);

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      <ScrollView
        style={styles.scroll}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={onRefresh} tintColor={COLORS.primary} />
        }
      >
        {/* Header */}
        <View style={styles.header}>
          <View>
            <Text style={styles.greeting}>{greeting}</Text>
            <Text style={styles.subGreeting}>
              {todayEntry ? 'Ya registraste tu estado de hoy' : '¿Cómo estás hoy?'}
            </Text>
          </View>
          {streak >= 2 && (
            <View style={styles.streakBadge}>
              <Ionicons name="flame" size={16} color={COLORS.accent} />
              <Text style={styles.streakNum}>{streak}</Text>
            </View>
          )}
        </View>

        {/* TODAY CARD */}
        {!todayEntry ? (
          // Pending check-in
          <Animated.View style={{ transform: [{ scale: pulseAnim }] }}>
            <TouchableOpacity
              style={styles.checkInCard}
              onPress={handleCheckIn}
              activeOpacity={0.88}
            >
              <View style={styles.checkInIcon}>
                <Ionicons name="add" size={28} color={COLORS.white} />
              </View>
              <View style={styles.checkInText}>
                <Text style={styles.checkInTitle}>Registrar mi estado</Text>
                <Text style={styles.checkInSubtitle}>Toma menos de 2 minutos</Text>
              </View>
              <Ionicons name="chevron-forward" size={20} color={COLORS.primaryLight} />
            </TouchableOpacity>
          </Animated.View>
        ) : (
          // Today's entry
          <TouchableOpacity
            style={[
              styles.todayCard,
              { backgroundColor: getQuadrantTint(todayEntry.moodQuadrant) },
            ]}
            onPress={handleCheckIn}
            activeOpacity={0.88}
          >
            <View style={styles.todayHeader}>
              <View>
                <Text style={styles.todayLabel}>Tu estado hoy</Text>
                <Text style={[styles.todayMood, { color: getQuadrantColor(todayEntry.moodQuadrant) }]}>
                  {todayEntry.moodLabel}
                </Text>
              </View>
              <View style={styles.todayScoreBubble}>
                <Text
                  style={[
                    styles.todayScore,
                    { color: getMoodScoreColor(todayEntry.moodScore) },
                  ]}
                >
                  {todayEntry.moodScore}
                </Text>
                <Text style={styles.todayScoreMax}>/10</Text>
              </View>
            </View>

            {todayEntry.tags && todayEntry.tags.length > 0 && (
              <View style={styles.tagRow}>
                {todayEntry.tags.map((t) => (
                  <View key={t} style={styles.tag}>
                    <Text style={styles.tagText}>{t}</Text>
                  </View>
                ))}
              </View>
            )}

            <Text style={styles.todayEditHint}>Toca para editar</Text>
          </TouchableOpacity>
        )}

        {/* Stats row */}
        <View style={styles.statsRow}>
          <View style={styles.statCard}>
            <Text style={styles.statValue}>{streak}</Text>
            <Text style={styles.statLabel}>Racha</Text>
          </View>
          <View style={styles.statCard}>
            <Text style={[styles.statValue, avgScore && { color: getMoodScoreColor(avgScore) }]}>
              {avgScore ?? '—'}
            </Text>
            <Text style={styles.statLabel}>Promedio (30d)</Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statValue}>{totalEntries}</Text>
            <Text style={styles.statLabel}>Registros</Text>
          </View>
        </View>

        {/* Weekly chart */}
        {weeklyData.some((d) => d.score !== null) && (
          <View style={styles.section}>
            <Text style={styles.sectionTitle}>Esta semana</Text>
            <View style={styles.chartCard}>
              <WeeklyMoodChart data={weeklyData} />
            </View>
          </View>
        )}

        {/* Recent entries */}
        {recentEntries.length > 0 && (
          <View style={styles.section}>
            <Text style={styles.sectionTitle}>Registros recientes</Text>
            {recentEntries.map((entry) => (
              <View key={entry.date} style={styles.entryRow}>
                <View
                  style={[
                    styles.entryDot,
                    { backgroundColor: getQuadrantColor(entry.moodQuadrant) },
                  ]}
                />
                <View style={styles.entryInfo}>
                  <Text style={styles.entryDate}>{formatRelative(entry.date)}</Text>
                  <Text style={styles.entryMood}>{entry.moodLabel}</Text>
                </View>
                <Text
                  style={[
                    styles.entryScore,
                    { color: getMoodScoreColor(entry.moodScore) },
                  ]}
                >
                  {entry.moodScore}/10
                </Text>
              </View>
            ))}
          </View>
        )}

        {/* Empty state */}
        {recentEntries.length === 0 && (
          <View style={styles.emptyState}>
            <Ionicons name="leaf-outline" size={40} color={COLORS.border} />
            <Text style={styles.emptyTitle}>Tu historia comienza aquí</Text>
            <Text style={styles.emptyText}>
              Cada registro es un paso hacia el autoconocimiento emocional.
            </Text>
          </View>
        )}

        <View style={{ height: SPACING.xl }} />
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: COLORS.background },
  scroll: { flex: 1 },
  content: { paddingHorizontal: SPACING.lg, paddingTop: SPACING.md },

  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: SPACING.lg,
  },
  greeting: {
    fontSize: TYPOGRAPHY['2xl'],
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.text,
    letterSpacing: -0.5,
  },
  subGreeting: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textSecondary,
    marginTop: 3,
  },
  streakBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    backgroundColor: COLORS.accent + '22',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: RADIUS.full,
  },
  streakNum: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.accent,
  },

  // Check-in pending card
  checkInCard: {
    backgroundColor: COLORS.primary,
    borderRadius: RADIUS.lg,
    padding: SPACING.md,
    flexDirection: 'row',
    alignItems: 'center',
    gap: SPACING.md,
    marginBottom: SPACING.md,
    ...SHADOWS.md,
  },
  checkInIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: 'rgba(255,255,255,0.2)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  checkInText: { flex: 1 },
  checkInTitle: {
    fontSize: TYPOGRAPHY.md,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.white,
  },
  checkInSubtitle: {
    fontSize: TYPOGRAPHY.sm,
    color: 'rgba(255,255,255,0.75)',
    marginTop: 2,
  },

  // Today's done card
  todayCard: {
    borderRadius: RADIUS.lg,
    padding: SPACING.md,
    marginBottom: SPACING.md,
    ...SHADOWS.sm,
  },
  todayHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
  },
  todayLabel: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textSecondary,
    fontWeight: TYPOGRAPHY.medium,
  },
  todayMood: {
    fontSize: TYPOGRAPHY.xl,
    fontWeight: TYPOGRAPHY.bold,
    marginTop: 2,
  },
  todayScoreBubble: {
    flexDirection: 'row',
    alignItems: 'baseline',
  },
  todayScore: {
    fontSize: TYPOGRAPHY['3xl'],
    fontWeight: TYPOGRAPHY.bold,
  },
  todayScoreMax: {
    fontSize: TYPOGRAPHY.base,
    color: COLORS.textLight,
    marginLeft: 2,
  },
  tagRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 6,
    marginTop: SPACING.sm,
  },
  tag: {
    backgroundColor: 'rgba(255,255,255,0.5)',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: RADIUS.full,
  },
  tagText: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textSecondary,
    fontWeight: TYPOGRAPHY.medium,
  },
  todayEditHint: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    marginTop: SPACING.sm,
  },

  // Stats
  statsRow: {
    flexDirection: 'row',
    gap: SPACING.sm,
    marginBottom: SPACING.md,
  },
  statCard: {
    flex: 1,
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.md,
    padding: SPACING.md,
    alignItems: 'center',
    ...SHADOWS.sm,
  },
  statValue: {
    fontSize: TYPOGRAPHY.xl,
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.text,
  },
  statLabel: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    marginTop: 2,
    textAlign: 'center',
  },

  // Section
  section: { marginBottom: SPACING.md },
  sectionTitle: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
    marginBottom: SPACING.sm,
  },
  chartCard: {
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.md,
    padding: SPACING.md,
    ...SHADOWS.sm,
  },

  // Recent entries
  entryRow: {
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.md,
    padding: SPACING.md,
    flexDirection: 'row',
    alignItems: 'center',
    gap: SPACING.sm,
    marginBottom: SPACING.xs,
    ...SHADOWS.sm,
  },
  entryDot: {
    width: 10,
    height: 10,
    borderRadius: 5,
  },
  entryInfo: { flex: 1 },
  entryDate: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textSecondary,
  },
  entryMood: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
  },
  entryScore: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
  },

  // Empty
  emptyState: {
    alignItems: 'center',
    paddingVertical: SPACING['2xl'],
    gap: SPACING.sm,
  },
  emptyTitle: {
    fontSize: TYPOGRAPHY.lg,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.textSecondary,
  },
  emptyText: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textLight,
    textAlign: 'center',
    maxWidth: 260,
    lineHeight: 20,
  },
});
