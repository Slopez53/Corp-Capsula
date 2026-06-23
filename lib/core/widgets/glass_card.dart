import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Superficie translúcida tipo cristal esmerilado: desenfoca lo que hay detrás,
/// añade un borde sutil y un brillo especular ligero. Base del lenguaje visual
/// "liquid glass". Se refinará (capas de profundidad, specular) en la Fase 3.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final double blur;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppTokens.space4),
    this.borderRadius,
    this.onTap,
    this.blur = 18,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = borderRadius ?? AppTokens.brLg;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: AnimatedContainer(
          duration: AppTokens.durFast,
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Colors.white.withValues(alpha: 0.08),
                      Colors.white.withValues(alpha: 0.02),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.65),
                      Colors.white.withValues(alpha: 0.35),
                    ],
            ),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              borderRadius: radius,
              child: Padding(padding: padding, child: child),
            ),
          ),
        ),
      ),
    );
  }
}

/// Fondo con manchas de color difuminadas, sobre el que las superficies de
/// cristal cobran sentido (se ve el blur).
class GlassBackground extends StatelessWidget {
  final Widget child;
  const GlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(color: scheme.surface),
        ),
        Positioned(
          top: -80,
          left: -60,
          child: _blob(scheme.primary.withValues(alpha: 0.25), 260),
        ),
        Positioned(
          bottom: -100,
          right: -80,
          child: _blob(scheme.tertiary.withValues(alpha: 0.22), 320),
        ),
        Positioned(
          top: 200,
          right: -40,
          child: _blob(scheme.secondary.withValues(alpha: 0.18), 200),
        ),
        Positioned.fill(child: child),
      ],
    );
  }

  Widget _blob(Color color, double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      );
}
