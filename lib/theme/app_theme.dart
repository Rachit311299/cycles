import 'package:flutter/material.dart';

class AppTheme {
  // Light mode colors
  static const Color _lightBackgroundColor = Color(0xFFF0F0F0); // F0F0F0
  static const Color _lightTextColor = Color(0xFF333333);       // 333333
  static const Color _lightOverlayColor = Color(0xFFDEDEDE);    // DEDEDE

  // Dark mode colors
  static const Color _darkBackgroundColor = Color(0xFF20275C);  // 20275C
  static const Color _darkTextColor = Color(0xFFF6F6F6);        // F6F6F6
  static const Color _darkOverlayColor = Color(0xFF424DA3);     // 424DA3

  /// Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightBackgroundColor,
      // If you use Card, Dialog, or similar surfaces for overlays:
      cardColor: _lightOverlayColor, 
      // Define the color scheme
      colorScheme: const ColorScheme.light(
        primary: Colors.green,      
        onPrimary: Colors.white,
        surface: _lightOverlayColor,
        onSurface: _lightTextColor,
      ),
      // Define text styles
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: _lightTextColor),
        bodyMedium: TextStyle(color: _lightTextColor),
        bodySmall: TextStyle(color: _lightTextColor),
      ),
      // Customize any widgets further, if needed
      // e.g. elevatedButtonTheme, appBarTheme, etc.
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightOverlayColor,
        foregroundColor: _lightTextColor,
      ),
    );
  }

  /// Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkBackgroundColor,
      cardColor: _darkOverlayColor,
      colorScheme: const ColorScheme.dark(
        primary: Colors.green,
        onPrimary: Colors.white,
        surface: _darkOverlayColor,
        onSurface: _darkTextColor,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: _darkTextColor),
        bodyMedium: TextStyle(color: _darkTextColor),
        bodySmall: TextStyle(color: _darkTextColor),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkOverlayColor,
        foregroundColor: _darkTextColor,
      ),
    );
  }
}
