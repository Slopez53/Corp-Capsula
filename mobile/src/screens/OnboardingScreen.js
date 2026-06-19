import React, { useRef, useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  Animated,
  Dimensions,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  StyleSheet,
  ScrollView,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import * as Haptics from 'expo-haptics';
import { setOnboardingComplete, setUserName } from '../services/storage';
import { COLORS, TYPOGRAPHY, SPACING, RADIUS, SHADOWS } from '../theme';

const { width: SCREEN_WIDTH } = Dimensions.get('window');

const SLIDES = [
  {
    icon: 'sparkles',
    title: 'Bienvenido a\nCápsula',
    subtitle:
      'Tu diario emocional inteligente. Registra cómo te sientes cada día y descubre los patrones de tu bienestar.',
    cta: 'Empezar',
  },
  {
    icon: 'grid',
    title: 'Tu estado\nemocional en 2D',
    subtitle:
      'Basado en el modelo científico Circumplejo de Russell, usamos dos dimensiones —valencia y energía— para capturar con precisión cómo te sientes.',
    cta: 'Entendido',
  },
  {
    icon: 'analytics',
    title: 'Patrones que\nhablan por ti',
    subtitle:
      'Con cada registro, Cápsula analiza tus tendencias, correlaciones con el sueño y los mejores días de tu semana.',
    cta: '¡Comenzar!',
  },
];

export default function OnboardingScreen({ navigation }) {
  const [step, setStep] = useState(0);
  const [name, setName] = useState('');
  const [showNameInput, setShowNameInput] = useState(false);

  const slideAnim = useRef(new Animated.Value(0)).current;
  const fadeAnim = useRef(new Animated.Value(1)).current;

  const animateTransition = (nextStep) => {
    Animated.sequence([
      Animated.timing(fadeAnim, { toValue: 0, duration: 150, useNativeDriver: true }),
      Animated.timing(fadeAnim, { toValue: 1, duration: 300, useNativeDriver: true }),
    ]).start();
    setStep(nextStep);
  };

  const handleNext = async () => {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);

    if (step < SLIDES.length - 1) {
      animateTransition(step + 1);
    } else if (!showNameInput) {
      setShowNameInput(true);
    } else {
      await setUserName(name || 'amigo');
      await setOnboardingComplete();
      navigation.replace('Main');
    }
  };

  const slide = SLIDES[step];

  return (
    <SafeAreaView style={styles.safe}>
      <KeyboardAvoidingView
        style={styles.flex}
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      >
        <View style={styles.container}>
          {/* Skip */}
          {!showNameInput && (
            <TouchableOpacity
              style={styles.skip}
              onPress={async () => {
                await setOnboardingComplete();
                navigation.replace('Main');
              }}
            >
              <Text style={styles.skipText}>Omitir</Text>
            </TouchableOpacity>
          )}

          <Animated.View style={[styles.content, { opacity: fadeAnim }]}>
            {!showNameInput ? (
              <>
                {/* Icon */}
                <View style={styles.iconCircle}>
                  <Ionicons name={slide.icon} size={40} color={COLORS.primary} />
                </View>

                {/* Text */}
                <Text style={styles.title}>{slide.title}</Text>
                <Text style={styles.subtitle}>{slide.subtitle}</Text>

                {/* Circumplex preview for slide 2 */}
                {step === 1 && (
                  <View style={styles.previewGrid}>
                    <View style={styles.previewRow}>
                      <View style={[styles.previewCell, { backgroundColor: COLORS.quadrantStressed }]}>
                        <Text style={styles.previewLabel}>Tenso</Text>
                      </View>
                      <View style={[styles.previewCell, { backgroundColor: COLORS.quadrantExcited }]}>
                        <Text style={styles.previewLabel}>Eufórico</Text>
                      </View>
                    </View>
                    <View style={styles.previewRow}>
                      <View style={[styles.previewCell, { backgroundColor: COLORS.quadrantSad }]}>
                        <Text style={styles.previewLabel}>Triste</Text>
                      </View>
                      <View style={[styles.previewCell, { backgroundColor: COLORS.quadrantContent }]}>
                        <Text style={styles.previewLabel}>Sereno</Text>
                      </View>
                    </View>
                  </View>
                )}
              </>
            ) : (
              <>
                {/* Name input step */}
                <View style={styles.iconCircle}>
                  <Ionicons name="person" size={40} color={COLORS.primary} />
                </View>
                <Text style={styles.title}>{'¿Cómo te\nllamamos?'}</Text>
                <Text style={styles.subtitle}>
                  Para hacer tu experiencia más personal, ¿cómo quieres que te llamemos?
                </Text>
                <TextInput
                  style={styles.nameInput}
                  placeholder="Tu nombre"
                  placeholderTextColor={COLORS.textLight}
                  value={name}
                  onChangeText={setName}
                  returnKeyType="done"
                  onSubmitEditing={handleNext}
                  autoFocus
                  maxLength={20}
                />
              </>
            )}
          </Animated.View>

          {/* Bottom area */}
          <View style={styles.bottom}>
            {/* Dots */}
            {!showNameInput && (
              <View style={styles.dots}>
                {SLIDES.map((_, i) => (
                  <View
                    key={i}
                    style={[styles.dot, i === step && styles.dotActive]}
                  />
                ))}
                <View style={[styles.dot, showNameInput && styles.dotActive]} />
              </View>
            )}

            {/* CTA Button */}
            <TouchableOpacity style={styles.btn} onPress={handleNext} activeOpacity={0.85}>
              <Text style={styles.btnText}>
                {showNameInput ? 'Comenzar →' : slide.cta}
              </Text>
            </TouchableOpacity>
          </View>
        </View>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: COLORS.background },
  flex: { flex: 1 },
  container: {
    flex: 1,
    paddingHorizontal: SPACING.lg,
    paddingTop: SPACING.lg,
    paddingBottom: SPACING.xl,
  },
  skip: {
    alignSelf: 'flex-end',
    padding: SPACING.sm,
  },
  skipText: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textLight,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: SPACING.md,
  },
  iconCircle: {
    width: 88,
    height: 88,
    borderRadius: 44,
    backgroundColor: COLORS.primary + '18',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: SPACING.xl,
  },
  title: {
    fontSize: TYPOGRAPHY['2xl'],
    fontWeight: TYPOGRAPHY.bold,
    color: COLORS.text,
    textAlign: 'center',
    lineHeight: 36,
    marginBottom: SPACING.md,
  },
  subtitle: {
    fontSize: TYPOGRAPHY.base,
    color: COLORS.textSecondary,
    textAlign: 'center',
    lineHeight: 23,
    maxWidth: 320,
  },
  previewGrid: {
    marginTop: SPACING.xl,
    borderRadius: RADIUS.md,
    overflow: 'hidden',
    ...SHADOWS.sm,
  },
  previewRow: {
    flexDirection: 'row',
  },
  previewCell: {
    width: 100,
    height: 60,
    alignItems: 'center',
    justifyContent: 'center',
  },
  previewLabel: {
    fontSize: TYPOGRAPHY.xs,
    fontWeight: TYPOGRAPHY.medium,
    color: 'rgba(44,44,44,0.6)',
  },
  nameInput: {
    marginTop: SPACING.xl,
    backgroundColor: COLORS.surface,
    borderRadius: RADIUS.md,
    paddingHorizontal: SPACING.md,
    paddingVertical: 14,
    fontSize: TYPOGRAPHY.lg,
    color: COLORS.text,
    width: '100%',
    textAlign: 'center',
    fontWeight: TYPOGRAPHY.medium,
    ...SHADOWS.sm,
  },
  bottom: {
    alignItems: 'center',
    gap: SPACING.md,
  },
  dots: {
    flexDirection: 'row',
    gap: 6,
  },
  dot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: COLORS.border,
  },
  dotActive: {
    width: 18,
    backgroundColor: COLORS.primary,
  },
  btn: {
    backgroundColor: COLORS.primary,
    paddingHorizontal: SPACING['2xl'],
    paddingVertical: 16,
    borderRadius: RADIUS.full,
    width: '100%',
    alignItems: 'center',
    ...SHADOWS.md,
  },
  btnText: {
    fontSize: TYPOGRAPHY.md,
    fontWeight: TYPOGRAPHY.semibold,
    color: COLORS.white,
    letterSpacing: 0.3,
  },
});
