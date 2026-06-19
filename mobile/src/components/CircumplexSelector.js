import React, { useRef, useState, useCallback } from 'react';
import {
  View,
  Text,
  PanResponder,
  Animated,
  StyleSheet,
  Dimensions,
} from 'react-native';
import * as Haptics from 'expo-haptics';
import { COLORS, TYPOGRAPHY, SHADOWS } from '../theme';
import { getMoodLabel, getMoodQuadrant, getQuadrantColor } from '../utils/moodAnalytics';

const SCREEN_WIDTH = Dimensions.get('window').width;
export const SELECTOR_SIZE = Math.min(SCREEN_WIDTH - 64, 300);
const INDICATOR = 36;
const HALF = SELECTOR_SIZE / 2;

const toScreenPos = (valence, arousal) => ({
  x: ((valence + 1) / 2) * SELECTOR_SIZE,
  y: ((-arousal + 1) / 2) * SELECTOR_SIZE,
});

const toValues = (x, y) => ({
  valence: Math.max(-1, Math.min(1, (x / SELECTOR_SIZE) * 2 - 1)),
  arousal: Math.max(-1, Math.min(1, -((y / SELECTOR_SIZE) * 2 - 1))),
});

export default function CircumplexSelector({
  onValueChange,
  initialValence = 0,
  initialArousal = 0,
}) {
  const init = toScreenPos(initialValence, initialArousal);

  const leftAnim = useRef(new Animated.Value(init.x - INDICATOR / 2)).current;
  const topAnim = useRef(new Animated.Value(init.y - INDICATOR / 2)).current;
  const scaleAnim = useRef(new Animated.Value(1)).current;
  const pulseAnim = useRef(new Animated.Value(1)).current;

  const [label, setLabel] = useState(getMoodLabel(initialValence, initialArousal));
  const [quadrant, setQuadrant] = useState(getMoodQuadrant(initialValence, initialArousal));
  const [hasInteracted, setHasInteracted] = useState(false);

  const lastHapticQuadrant = useRef(getMoodQuadrant(initialValence, initialArousal));

  // Gentle pulse on the indicator when not interacted
  React.useEffect(() => {
    if (hasInteracted) return;
    const loop = Animated.loop(
      Animated.sequence([
        Animated.timing(pulseAnim, { toValue: 1.25, duration: 900, useNativeDriver: true }),
        Animated.timing(pulseAnim, { toValue: 1, duration: 900, useNativeDriver: true }),
      ])
    );
    loop.start();
    return () => loop.stop();
  }, [hasInteracted]);

  const update = useCallback(
    (rawX, rawY) => {
      const x = Math.max(0, Math.min(SELECTOR_SIZE, rawX));
      const y = Math.max(0, Math.min(SELECTOR_SIZE, rawY));

      leftAnim.setValue(x - INDICATOR / 2);
      topAnim.setValue(y - INDICATOR / 2);

      const { valence, arousal } = toValues(x, y);
      const newLabel = getMoodLabel(valence, arousal);
      const newQuadrant = getMoodQuadrant(valence, arousal);

      setLabel(newLabel);
      setQuadrant(newQuadrant);

      if (newQuadrant !== lastHapticQuadrant.current) {
        Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
        lastHapticQuadrant.current = newQuadrant;
      }

      if (onValueChange) {
        onValueChange({ valence, arousal, label: newLabel, quadrant: newQuadrant });
      }
    },
    [onValueChange]
  );

  const panResponder = useRef(
    PanResponder.create({
      onStartShouldSetPanResponder: () => true,
      onMoveShouldSetPanResponder: () => true,

      onPanResponderGrant: (evt) => {
        setHasInteracted(true);
        Animated.spring(scaleAnim, {
          toValue: 1.3,
          useNativeDriver: true,
          tension: 300,
          friction: 8,
        }).start();
        Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
        update(evt.nativeEvent.locationX, evt.nativeEvent.locationY);
      },

      onPanResponderMove: (evt) => {
        update(evt.nativeEvent.locationX, evt.nativeEvent.locationY);
      },

      onPanResponderRelease: () => {
        Animated.spring(scaleAnim, {
          toValue: 1,
          useNativeDriver: true,
          tension: 300,
          friction: 8,
        }).start();
        Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      },
    })
  ).current;

  const indicatorColor = getQuadrantColor(quadrant);

  return (
    <View style={styles.wrapper}>
      {/* Axis label top */}
      <Text style={styles.axisTop}>Energizado</Text>

      <View style={styles.row}>
        {/* Axis label left */}
        <View style={styles.axisLeft}>
          <Text style={styles.axisTextVertical}>Negativo</Text>
        </View>

        {/* The 2D selector */}
        <View style={styles.selector} {...panResponder.panHandlers}>
          {/* Quadrant tint backgrounds */}
          <View style={[styles.quadrant, styles.tl]} />
          <View style={[styles.quadrant, styles.tr]} />
          <View style={[styles.quadrant, styles.bl]} />
          <View style={[styles.quadrant, styles.br]} />

          {/* Subtle grid cross */}
          <View style={styles.gridH} />
          <View style={styles.gridV} />

          {/* Quadrant corner labels */}
          <Text style={[styles.cornerLabel, { top: 10, left: 10 }]}>Tenso</Text>
          <Text style={[styles.cornerLabel, { top: 10, right: 10 }]}>Eufórico</Text>
          <Text style={[styles.cornerLabel, { bottom: 10, left: 10 }]}>Triste</Text>
          <Text style={[styles.cornerLabel, { bottom: 10, right: 10 }]}>Sereno</Text>

          {/* Center cross dot */}
          <View style={styles.centerDot} />

          {/* Draggable indicator */}
          <Animated.View
            style={[
              styles.indicatorOuter,
              {
                left: leftAnim,
                top: topAnim,
                transform: [{ scale: hasInteracted ? scaleAnim : pulseAnim }],
              },
            ]}
          >
            <View style={[styles.indicatorInner, { backgroundColor: indicatorColor }]}>
              <View style={styles.indicatorDot} />
            </View>
          </Animated.View>
        </View>

        {/* Axis label right */}
        <View style={styles.axisRight}>
          <Text style={styles.axisTextVertical}>Positivo</Text>
        </View>
      </View>

      {/* Axis label bottom */}
      <Text style={styles.axisBottom}>Tranquilo</Text>

      {/* Current mood badge */}
      <View style={[styles.moodBadge, { backgroundColor: indicatorColor + '22' }]}>
        <View style={[styles.moodDot, { backgroundColor: indicatorColor }]} />
        <Text style={[styles.moodText, { color: indicatorColor }]}>{label}</Text>
      </View>

      {!hasInteracted && (
        <Text style={styles.hint}>Toca y arrastra para indicar cómo te sientes</Text>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  wrapper: {
    alignItems: 'center',
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  selector: {
    width: SELECTOR_SIZE,
    height: SELECTOR_SIZE,
    borderRadius: 20,
    overflow: 'hidden',
    position: 'relative',
    ...SHADOWS.md,
  },
  quadrant: {
    position: 'absolute',
    width: '50%',
    height: '50%',
  },
  tl: { top: 0, left: 0, backgroundColor: COLORS.quadrantStressed },
  tr: { top: 0, right: 0, backgroundColor: COLORS.quadrantExcited },
  bl: { bottom: 0, left: 0, backgroundColor: COLORS.quadrantSad },
  br: { bottom: 0, right: 0, backgroundColor: COLORS.quadrantContent },
  gridH: {
    position: 'absolute',
    top: '50%',
    left: 0,
    right: 0,
    height: 1,
    backgroundColor: 'rgba(255,255,255,0.5)',
  },
  gridV: {
    position: 'absolute',
    left: '50%',
    top: 0,
    bottom: 0,
    width: 1,
    backgroundColor: 'rgba(255,255,255,0.5)',
  },
  centerDot: {
    position: 'absolute',
    top: HALF - 3,
    left: HALF - 3,
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: 'rgba(255,255,255,0.7)',
  },
  cornerLabel: {
    position: 'absolute',
    fontSize: TYPOGRAPHY.xs,
    color: 'rgba(44,44,44,0.45)',
    fontWeight: TYPOGRAPHY.medium,
    letterSpacing: 0.2,
  },
  indicatorOuter: {
    position: 'absolute',
    width: INDICATOR,
    height: INDICATOR,
    borderRadius: INDICATOR / 2,
    backgroundColor: 'rgba(255,255,255,0.6)',
    alignItems: 'center',
    justifyContent: 'center',
    ...SHADOWS.md,
  },
  indicatorInner: {
    width: INDICATOR - 8,
    height: INDICATOR - 8,
    borderRadius: (INDICATOR - 8) / 2,
    alignItems: 'center',
    justifyContent: 'center',
  },
  indicatorDot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: 'rgba(255,255,255,0.8)',
  },
  axisTop: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    fontWeight: TYPOGRAPHY.medium,
    marginBottom: 6,
    letterSpacing: 0.5,
    textTransform: 'uppercase',
  },
  axisBottom: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    fontWeight: TYPOGRAPHY.medium,
    marginTop: 6,
    letterSpacing: 0.5,
    textTransform: 'uppercase',
  },
  axisLeft: {
    width: 32,
    alignItems: 'center',
    marginRight: 6,
  },
  axisRight: {
    width: 32,
    alignItems: 'center',
    marginLeft: 6,
  },
  axisTextVertical: {
    fontSize: TYPOGRAPHY.xs,
    color: COLORS.textLight,
    fontWeight: TYPOGRAPHY.medium,
    letterSpacing: 0.5,
    textTransform: 'uppercase',
    transform: [{ rotate: '-90deg' }],
    width: 70,
    textAlign: 'center',
  },
  moodBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    marginTop: 16,
    gap: 8,
  },
  moodDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  moodText: {
    fontSize: TYPOGRAPHY.md,
    fontWeight: TYPOGRAPHY.semibold,
    letterSpacing: 0.3,
  },
  hint: {
    fontSize: TYPOGRAPHY.sm,
    color: COLORS.textLight,
    marginTop: 8,
    textAlign: 'center',
  },
});
