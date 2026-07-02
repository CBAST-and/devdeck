import 'package:flutter/material.dart';

/// Paleta de colores oficial de DevDeck.
/// Ningún widget debe declarar colores directamente: siempre referenciar
/// esta clase para mantener consistencia visual en toda la aplicación.
class AppColors {
  AppColors._();

  // Fondo
  static const Color background = Color(0xFF0B0F19);
  static const Color surface = Color(0xFF141A2A);
  static const Color surfaceVariant = Color(0xFF1C2438);

  // Azul principal (identidad DevDeck)
  static const Color darkBlue = Color(0xFF10162B);
  static const Color electricBlue = Color(0xFF2F6BFF);
  static const Color electricBlueLight = Color(0xFF5C8BFF);

  // Neutros
  static const Color white = Color(0xFFF5F6FA);
  static const Color grey = Color(0xFF8A93A6);
  static const Color greyDark = Color(0xFF4C5468);
  static const Color divider = Color(0xFF232B3E);

  // Estados semánticos
  static const Color success = Color(0xFF3DDC97);
  static const Color error = Color(0xFFFF5C5C);
  static const Color warning = Color(0xFFFFC658);

  // Identity: temas dinámicos según género
  static const Color identityMale = Color(0xFF2F6BFF);
  static const Color identityFemale = Color(0xFFFF6FA5);
  static const Color identityUnknown = Color(0xFF8A93A6);

  // Sombra de cartas
  static const Color cardShadow = Color(0x33000000);
}