import React, { useState, useRef, useCallback } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  Animated,
  ScrollView,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  StyleSheet,
  Dimensions,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import * as Haptics from 'expo-haptics';
import CircumplexSelector from '../components/CircumplexSelector';
import { saveMoodEntry } from '../services/storage';
import {
  getMoodLabel,
  getMoodQuadrant,
  getMoodScore,
  getQuadrantColor,
} from '../utils/moodAnalytics';
import { getTodayString, getTimeString } from '../utils/dateHelpers';
import { COLORS, TYPOGRAPHY, SPACING, RADIUS, SHADOWS } from '../theme';

const { width: SCREEN_WIDTH } = Dimensions.get('window');
const TOTAL_STEPS = 3;

const CONTEXT_TAGS = [
  'Trabajo', 'Familia', 'Pareja', 'Amigos', 'Salud',
  'Ejercicio', 'Sueño', 'Alimentación', 'Clima', 'Medicación',
  'Economía', 'Logros',
];

const SLEEP_LABELS = ['Muy malo', 'Malo', 'Regular', 'Bueno', 'Excelente'];
const ENERGY_LABELS = ['Agotado', 'Bajo', 'Normal', 'Activo', 'Lleno de energía'];

function RatingPicker({ value, onChange, labels, color }) {
  return (
    <View style={ratingStyles.container}>
      {labels.map((label, i) => {
        const n = i + 1;
        const selected = value === n;
        return (
          <TouchableOpacity
            key={n}
            style={[ratingStyles.btn, selected && { backgroundColor: color + '22', borderColor: color }]}
            onPress={() => {
              Haptics.selectionAsync();
              onChange(n);
            }}
            activeOpacity={0.7}
          >
            <Text style={[ratingStyles.num, selected && { color }]}>{n}</Text>
            <Text
              style={[ratingStyles.label, selected && { color }]}
              numberOfLines={2}
            >
              {label}
            </Text>
          </TouchableOpacity>
        );
      })}
    </View>
  );
}

const ratingStyles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    gap: 6,
  },
  btn: {
    flex: 1,
    paddingVertical: 10,
    paddingHorizontal: 4,
    borderRadius: RADIUS.sm,
    backgroundColor: COLORS.surfaceAlt,
    borderWidth: 1.5,
    borderColor: COLORS.border,
    alignItems: 'center',
    gap: 4,
  },
  num: {
    fontSize: TYPOGRAPHY.md,
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.textSecondary,
  },
  label: {
    fontSize: 9,
    color: COLORS.textLight,
    textAlign: 'center',
    fontWeight: TYPOGRAPHY.medium,
  },
});

export default function CheckInScreen({ navigation }) {
  const [step, setStep] = useState(0);

  // Mood values
  const [valence, setValence] = useState(0);
  const [arousal, setArousal] = useState(0);
  const [moodLabel, setMoodLabel] = useState(getMoodLabel(0, 0));
  const [moodQuadrant, setMoodQuadrant] = useState(getMoodQuadrant(0, 0));

  // Step 2
  const [sleepQuality, setSleepQuality] = useState(null);
  const [energyLevel, setEnergyLevel] = useState(null);

  // Step 3
  const [selectedTags, setSelectedTags] = useState([]);
  const [note, setNote] = useState('');
  const [saving, setSaving] = useState(false);

  // Animation between steps
  const slideX = useRef(new Animated.Value(0)).current;
  const fadeAnim = useRef(new Animated.Value(1)).current;

  // Completion animation
  const completionScale = useRef(new Animated.Value(0)).current;
  const completionOpacity = useRef(new Animated.Value(0)).current;
  const [saved, setSaved] = useState(false);

  const animateStep = (direction, onMidpoint) => {
    Animated.parallel([
      Animated.timing(fadeAnim, { toValue: 0, duration: 130, useNativeDriver: true }),
      Animated.timing(slideX, { toValue: -18 * direction, duration: 130, useNativeDriver: true }),
    ]).start(() => {
      onMidpoint?.();
      slideX.setValue(18 * direction);
      Animated.parallel([
        Animated.timing(fadeAnim, { toValue: 1, duration: 200, useNativeDriver: true }),
        Animated.timing(slideX, { toValue: 0, duration: 200, useNativeDriver: true }),
      ]).start();
    });
  };

  const goNext = () => {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    animateStep(1, () => setStep((s) => s + 1));
  };

  const goBack = () => {
    if (step === 0) {
      navigation.goBack();
      return;
    }
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    animateStep(-1, () => setStep((s) => s - 1));
  };

  const handleCircumplexChange = useCallback(({ valence: v, arousal: a, label, quadrant }) => {
    setValence(v);
    setArousal(a);
    setMoodLabel(label);
    setMoodQuadrant(quadrant);
  }, []);

  const toggleTag = (tag) => {
    Haptics.selectionAsync();
    setSelectedTags((prev) =>
      prev.includes(tag) ? prev.filter((t) => t !== tag) : [...prev, tag]
    );
  };

  const handleSave = async () => {
    setSaving(true);
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);

    const entry = {
      id: Date.now().toString(),
      date: getTodayString(),
      time: getTimeString(),
      timestamp: new Date().toISOString(),
      valence,
      arousal,
      moodLabel,
      moodQuadrant,
      moodScore: getMoodScore(valence, arousal),
      sleepQuality: sleepQuality,
      energyLevel: energyLevel,
      tags: selectedTags,
      note: note.trim(),
    };

    await saveMoodEntry(entry);

    // Completion animation
    setSaved(true);
    Animated.parallel([
      Animated.spring(completionScale, { toValue: 1, useNativeDriver: true, tension: 80, friction: 7 }),
      Animated.timing(completionOpacity, { toValue: 1, duration: 300, useNativeDriver: true }),
    ]).start();

    setTimeout(() => {
      navigation.goBack();
    }, 1500);
  };

  const quadrantColor = getQuadrantColor(moodQuadrant);

  // Progress
  const progressWidth = ((step + 1) / TOTAL_STEPS) * 100;

  if (saved) {
    return (
      <View style={styles.completionOverlay}>
        <Animated.View
          style={[
            styles.completionBubble,
            { backgroundColor: quadrantColor + '22', transform: [{ scale: completionScale }], opacity: completionOpacity },
          ]}
        >
          <View style={[styles.completionIcon, { backgroundColor: quadrantColor }]}>
            <Ionicons name="checkmark" size={32} color={COLORS.white} />
          </View>
          <Text style={styles.completionTitle}>¡Registrado!</Text>
          <Text style={[styles.completionMood, { color: quadrantColor }]}>{moodLabel}</Text>
        </Animated.View>
      </View>
    );
  }

  return (
    <SafeAreaView style={styles.safe} edges={['top', 'bottom']}>
      <KeyboardAvoidingView
        style={styles.flex}
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        keyboardVerticalOffset={10}
      >
        {/* Header */}
        <View style={styles.header}>
          <TouchableOpacity onPress={goBack} style={styles.backBtn}>
            <Ionicons name="chevron-down" size={24} color={COLORS.textSecondary} />
          </TouchableOpacity>

          <View style={styles.progressTrack}>
            <Animated.View
              style={[
                styles.progressBar,
                { width: `${progressWidth}%`, backgroundColor: quadrantColor },
              ]}
            />
          </View>

          <Text style={styles.stepIndicator}>{step + 1}/{TOTAL_STEPS}</Text>
        </View>

        <ScrollView
          style={styles.scroll}
          contentContainerStyle={styles.scrollContent}
          keyboardShouldPersistTaps="handled"
          showsVerticalScrollIndicator={false}
        >
          <Animated.View
            style={{
              opacity: fadeAnim,
              transform: [{ translateX: slideX }],
            }}
          >
            {/* ═══════════ STEP 1: Circumplex ═══════════ */}
            {step === 0 && (
              <View style={styles.stepContainer}>
                <Text style={styles.stepTitle}>¿Cómo te sientes ahora?</Text>
                <Text style={styles.stepSubtitle}>
                  Toca en el área que mejor describe tu estado emocional
                </Text>
                <View style={styles.circumplexWrap}>
                  <CircumplexSelector onValueChange={handleCircumplexChange} />
                </View>
                <View style={styles.scienceNote}>
                  <Ionicons name="information-circle-outline" size={13} color={COLORS.textLight} />
                  <Text style={styles.scienceText}>
                    Basado en el Modelo Circumplejo de Russell (1980)
                  </Text>
                </View>
              </View>
            )}

            {/* ═══════════ STEP 2: Sleep + Energy ═══════════ */}
            {step === 1 && (
              <View style={styles.stepContainer}>
                <Text style={styles.stepTitle}>Un poco más sobre hoy</Text>
                <Text style={styles.stepSubtitle}>
                  Esta información ayuda a detectar patrones en tu bienestar
                </Text>

                <View style={styles.metricBlock}>
                  <View style={styles.metricHeader}>
                    <Ionicons name="moon-outline" size={18} color={COLORS.colorSad} />
                    <Text style={styles.metricLabel}>Calidad del sueño anoche</Text>
                  </View>
                  <RatingPicker
                    value={sleepQuality}
                    onChange={setSleepQuality}
                    labels={SLEEP_LABELS}
                    color={COLORS.colorSad}
                  />
                </View>

                <View style={styles.metricBlock}>
                  <View style={styles.metricHeader}>
                    <Ionicons name="flash-outline" size={18} color={COLORS.colorExcited} />
                    <Text style={styles.metricLabel}>Nivel de energía ahora</Text>
                  </View>
                  <RatingPicker
                    value={energyLevel}
                    onChange={setEnergyLevel}
                    labels={ENERGY_LABELS}
                    color={COLORS.colorExcited}
                  />
                </View>
              </View>
            )}

            {/* ═══════════ STEP 3: Tags + Note ═══════════ */}
            {step === 2 && (
              <View style={styles.stepContainer}>
                <Text style={styles.stepTitle}>¿Qué influyó hoy?</Text>
                <Text style={styles.stepSubtitle}>
                  Selecciona todo lo que tuvo impacto en tu estado (opcional)
                </Text>

                <View style={styles.tagGrid}>
                  {CONTEXT_TAGS.map((tag) => {
                    const selected = selectedTags.includes(tag);
                    return (
                      <TouchableOpacity
                        key={tag}
                        style={[
                          styles.tagChip,
                          selected && { backgroundColor: quadrantColor + '22', borderColor: quadrantColor },
                        ]}
                        onPress={() => toggleTag(tag)}
                        activeOpacity={0.7}
                      >
                        <Text style={[styles.tagChipText, selected && { color: quadrantColor }]}>
                          {tag}
                        </Text>
                      </TouchableOpacity>
                    );
                  })}
                </View>

                <View style={styles.noteBlock}>
                  <Text style={styles.metricLabel}>Nota libre (opcional)</Text>
                  <TextInput
                    style={styles.noteInput}
                    placeholder="¿Algo que quieras recordar de hoy?"
                    placeholderTextColor={COLORS.textLight}
                    value={note}
                    onChangeText={setNote}
                    multiline
                    maxLength={300}
                    textAlignVertical="top"
                  />
                  <Text style={styles.charCount}>{note.length}/300</Text>
                </View>
              </View>
            )}
          </Animated.View>
        </ScrollView>

        {/* Bottom action */}
        <View style={styles.footer}>
          {step < TOTAL_STEPS - 1 ? (
            <TouchableOpacity style={styles.nextBtn} onPress={goNext} activeOpacity={0.88}>
              <Text style={styles.nextBtnText}>Continuar</Text>
              <Ionicons name="arrow-forward" size={20} color={COLORS.white} />
            </TouchableOpacity>
          ) : (
            <TouchableOpacity
              style={[styles.saveBtn, { backgroundColor: quadrantColor }]}
              onPress={handleSave}
              disabled={saving}
              activeOpacity={0.88}
            >
              <Ionicons name="checkmark" size={20} color={COLORS.white} />
              <Text style={styles.saveBtnText}>Guardar registro</Text>
            </TouchableOpacity>
          )}
        </View>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: COLORS.background },
  flex: { flex: 1 },

  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: SPACING.md,
    paddingVertical: SPACING.sm,
    gap: SPACING.sm,
  },
  backBtn: {
    width: 40,
    height: 40,
    alignItems: 'center',
    justifyContent: 'center',
  },
  progressTrack: {
    flex: 1,
    height: 4,
    backgroundColor: COLORS.border,
    borderRadius: 2,
    overflow: 'hidden',
  },
  progressBar: {
    height: '100%',
    borderRadius: 2,
  },
  stepIndicator: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textLight,
    fontWeight: TYPOGRAPHY.medium,
    minWidth: 28,
    textAlign: 'right',
  },

  scroll: { flex: 1 },
  scrollContent: {
    paddingHorizontal: SPACING.lg,
    paddingTop: SPACING.sm,
    paddingBottom: SPACING.xl,
  },

  stepContainer: { paddingBottom: SPACING.lg },
  stepTitle: {
    fontSize: TYPOGRAPHY.xl,
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.text,
    marginBottom: 6,
    letterSpacing: -0.3,
  },
  stepSubtitle: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textSecondary,
    lineHeight: 20,
    marginBottom: SPACING.lg,
  },

  circumplexWrap: {
    alignItems: 'center',
    marginVertical: SPACING.sm,
  },
  scienceNote: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    marginTop: SPACING.lg,
    justifyContent: 'center',
  },
  scienceText: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    fontStyle: 'italic',
  },

  metricBlock: {
    marginBottom: SPACING.xl,
  },
  metricHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    marginBottom: SPACING.sm,
  },
  metricLabel: {
    fontSize: TYPOGRAPHY.base,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.text,
  },

  tagGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
    marginBottom: SPACING.xl,
  },
  tagChip: {
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: RADIUS.full,
    backgroundColor: COLORS.surfaceAlt,
    borderWidth: 1.5,
    borderColor: COLORS.border,
  },
  tagChipText: {
    fontSize: TYPOGRAPHY.sm,
    fontWeight: TYPOGRAPHY.medium,
    color: COLORS.textSecondary,
  },

  noteBlock: {
    gap: SPACING.xs,
  },
  noteInput: {
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.md,
    padding: SPACING.md,
    fontSize: TYPOGRAPHY.base,
    color: COLORS.text,
    minHeight: 100,
    borderWidth: 1,
    borderColor: COLORS.border,
    lineHeight: 22,
  },
  charCount: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    alignSelf: 'flex-end',
  },

  footer: {
    paddingHorizontal: SPACING.lg,
    paddingBottom: SPACING.lg,
    paddingTop: SPACING.sm,
    backgroundColor: COLORS.background,
  },
  nextBtn: {
    backgroundColor: COLORS.primary,
    borderRadius: RADIUS.full,
    paddingVertical: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: SPACING.sm,
    ...SHADOWS.md,
  },
  nextBtnText: {
    fontSize: TYPOGRAPHY.md,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.white,
  },
  saveBtn: {
    borderRadius: RADIUS.full,
    paddingVertical: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: SPACING.sm,
    ...SHADOWS.md,
  },
  saveBtnText: {
    fontSize: TYPOGRAPHY.md,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.white,
  },

  // Completion overlay
  completionOverlay: {
    flex: 1,
    backgroundColor: COLORS.background,
    alignItems: 'center',
    justifyContent: 'center',
  },
  completionBubble: {
    alignItems: 'center',
    padding: SPACING['2xl'],
    borderRadius: RADIUS.xl,
    gap: SPACING.md,
    minWidth: 220,
  },
  completionIcon: {
    width: 72,
    height: 72,
    borderRadius: 36,
    alignItems: 'center',
    justifyContent: 'center',
  },
  completionTitle: {
    fontSize: TYPOGRAPHY.xl,
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.text,
  },
  completionMood: {
    fontSize: TYPOGRAPHY.lg,
    fontWeight: TYPOGRAPHY.semibold,
  },
});
