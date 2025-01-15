import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData darkAppTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.accent,
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
        color: Colors.transparent, // We'll use a gradient decoration instead
        elevation: 0, // We'll handle shadows manually
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
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
        displayLarge: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 34,
          fontWeight: FontWeight.bold, // Bold
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 28,
          fontWeight: FontWeight.w600, // SemiBold
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 24,
          fontWeight: FontWeight.w500, // Medium
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 20,
          fontWeight: FontWeight.w600, // SemiBold
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 18,
          fontWeight: FontWeight.w500, // Medium
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 14,
          fontWeight: FontWeight.w400, // Regular
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 12,
          fontWeight: FontWeight.w300, // Light
          color: Colors.black,
        ),
        labelLarge: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 12,
          fontWeight: FontWeight.w500, // Medium
          color: Colors.black,
        ),
      ));
}
