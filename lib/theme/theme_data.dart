import 'package:flutter/material.dart';
import 'package:scores_2_go/theme/app_colors.dart';

class AppTheme {
  static ThemeData light() {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.blue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFDCEEFD),
      onPrimaryContainer: AppColors.blue,
      secondary: AppColors.teal,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFCCF4F3),
      onSecondaryContainer: Color(0xFF005A59),
      error: Color(0xFFB3261E),
      onError: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      onSurfaceVariant: AppColors.lightTextSecondary,
      outline: AppColors.lightOutline,
      outlineVariant: AppColors.lightOutline,
      surfaceContainerHighest: AppColors.lightSurfaceElevated,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.lightBg,
      cardColor: AppColors.lightSurface,
      dividerColor: AppColors.lightOutline,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.lightTextMuted,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.lightOutline),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.lightTextSecondary),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.disabled)
                  ? AppColors.blue.withValues(alpha: 0.4)
                  : AppColors.blue),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          minimumSize: WidgetStateProperty.all(const Size.fromHeight(48)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.blue),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.blue : null),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? AppColors.blue.withValues(alpha: 0.3)
                : null),
      ),

      // Explicit (not left to ColorScheme.inverseSurface/inversePrimary
      // fallbacks, which default actionTextColor to onPrimary — white on
      // white in the dark theme, making the action invisible).
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightTextPrimary,
        contentTextStyle: const TextStyle(color: AppColors.lightSurface),
        actionTextColor: AppColors.teal,
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: AppColors.lightTextPrimary, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(color: AppColors.lightTextPrimary, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(color: AppColors.lightTextPrimary, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(color: AppColors.lightTextPrimary, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: AppColors.lightTextPrimary, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: AppColors.lightTextPrimary, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
        bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
        bodySmall: TextStyle(color: AppColors.lightTextSecondary),
        labelSmall: TextStyle(color: AppColors.lightTextMuted),
      ),
    );
  }

  static ThemeData dark() {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.blue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF0D2444),
      onPrimaryContainer: AppColors.blue,
      secondary: AppColors.teal,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF0D3333),
      onSecondaryContainer: AppColors.teal,
      error: Color(0xFFF2B8B5),
      onError: Color(0xFF601410),
      errorContainer: Color(0x33F2B8B5),
      onErrorContainer: Color(0xFFF2B8B5),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      onSurfaceVariant: AppColors.darkTextSecondary,
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutline,
      surfaceContainerHighest: AppColors.darkSurfaceElevated,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkBg,
      cardColor: AppColors.darkSurface,
      dividerColor: AppColors.darkOutline,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBg,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.teal,
        unselectedItemColor: AppColors.darkTextMuted,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.darkOutline),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.teal, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.darkTextSecondary),
        hintStyle: const TextStyle(color: AppColors.darkTextMuted),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.disabled)
                  ? AppColors.blue.withValues(alpha: 0.4)
                  : AppColors.blue),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          minimumSize: WidgetStateProperty.all(const Size.fromHeight(48)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.teal),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.teal : null),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? AppColors.teal.withValues(alpha: 0.3)
                : null),
      ),

      // Explicit (not left to ColorScheme.inverseSurface/inversePrimary
      // fallbacks, which default actionTextColor to onPrimary — white on
      // white in this dark theme, making the action invisible).
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkTextPrimary,
        contentTextStyle: const TextStyle(color: AppColors.darkSurface),
        actionTextColor: AppColors.blue,
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
        bodySmall: TextStyle(color: AppColors.darkTextSecondary),
        labelSmall: TextStyle(color: AppColors.darkTextMuted),
      ),
    );
  }
}
