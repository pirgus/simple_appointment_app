// theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF039FF3);
  static const Color secondaryColor = Color(0xFF0288D1);
  static const Color errorColor = Color(0xFFF14E4E);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onSecondaryColor = Color(0xFFFFFFFF);
  static const Color onErrorColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF000000);
  static const Color onBackgroundColor = Color(0xFF000000);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      error: errorColor,
      onPrimary: onPrimaryColor,
      onSecondary: onSecondaryColor,
      onSurface: onSurfaceColor,
      onError: onErrorColor,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: onSurfaceColor),
      displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: onSurfaceColor),
      displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: onSurfaceColor),
      headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: onSurfaceColor),
      headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: onSurfaceColor),
      titleLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: onSurfaceColor),
      bodyLarge: TextStyle(fontSize: 16, color: onSurfaceColor),
      bodyMedium: TextStyle(fontSize: 14, color: onSurfaceColor),
    ),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: Color(0xFF121212),
      error: errorColor,
      onPrimary: onPrimaryColor,
      onSecondary: onSecondaryColor,
      onSurface: Color(0xFFFFFFFF),
      onError: onErrorColor,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      titleLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
    ),
    useMaterial3: true,
  );
}