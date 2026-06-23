import 'package:flutter/material.dart';

/// Sistema de diseño centralizado. Toda pantalla consume estos tokens, así un
/// cambio de acento/espaciado/radio se hace en un solo lugar (sección 3).
class AppTokens {
  AppTokens._();

  // Color de acento (personalizable a futuro sin tocar pantallas).
  static const Color seed = Color(0xFFB5651D); // caramelo de pan horneado

  // Espaciado (escala de 4).
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 24;
  static const double space6 = 32;
  static const double space7 = 48;

  // Radios — todo completamente redondeado (liquid glass).
  static const double radiusSm = 12;
  static const double radiusMd = 20;
  static const double radiusLg = 28;
  static const double radiusXl = 36;

  static BorderRadius get brSm => BorderRadius.circular(radiusSm);
  static BorderRadius get brMd => BorderRadius.circular(radiusMd);
  static BorderRadius get brLg => BorderRadius.circular(radiusLg);
  static BorderRadius get brXl => BorderRadius.circular(radiusXl);

  // Puntos de quiebre de layout adaptativo real.
  static const double breakpointTablet = 640;
  static const double breakpointDesktop = 1024;

  // Duraciones de animación (transiciones suaves, sin cortes abruptos).
  static const Duration durFast = Duration(milliseconds: 180);
  static const Duration durMed = Duration(milliseconds: 320);
}
