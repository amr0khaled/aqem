import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF0D7E5E);
  static const secondary = Color(0xFF0A6349);
  static const gold = Color(0xFFD4AF37);

  static const bg = Color(0xFFF4F3EF);
  static const mint = Color(0xFFDFF1EA);
  static const beige = Color(0xFFF6F0DF);
}

class AppTheme {
  static ThemeData light = ThemeData(
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: AppColors.bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
    ),
  );
}