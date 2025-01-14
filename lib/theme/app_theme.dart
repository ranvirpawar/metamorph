import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData darkAppTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundGrey,
    primaryColor: AppColors.green,
    colorScheme: const ColorScheme.dark(
      background: AppColors.background,
      primary: AppColors.accent,
      secondary: AppColors.textSecondary,
      surface: AppColors.cardBackground,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.bottomNavBackground,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.textSecondary,
    ),

    // Text Theme
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        color: AppColors.textTertiary,
        fontSize: 12,
      ),
    ),
  );
}
