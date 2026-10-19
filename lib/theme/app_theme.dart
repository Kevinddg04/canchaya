import 'package:flutter/material.dart';

/// Paleta de colores de CanchaYa, consistente con la propuesta de la Unidad 1.
class AppColors {
  static const Color primario = Color(0xFF2E7D4F);
  static const Color primarioClaro = Color(0xFFE8F2EC);
  static const Color fondo = Color(0xFFFAFAFA);
  static const Color texto = Color(0xFF222222);
  static const Color textoSuave = Color(0xFF5A5A5A);
}

ThemeData construirTema() {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primario,
    scaffoldBackgroundColor: AppColors.fondo,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primario,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primario,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
  );
}
