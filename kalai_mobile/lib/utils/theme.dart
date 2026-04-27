import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KalaiTheme {
  // Deep Dark Backgrounds
  static const Color darkBg = Color(0xFF0F0F13);
  static const Color darkSurface = Color(0xFF1C1C24);
  
  // Neon / Vibrant Accents
  static const Color terracotta = Color(0xFFFF6B35); // brighter glowing terracotta
  static const Color brown = Color(0xFF8B4513);
  static const Color cream = Color(0xFFF9F6F0);
  static const Color gold = Color(0xFFFFD700);
  static const Color green = Color(0xFF00FF7F);
  static const Color textDark = Color(0xFFFFFFFF); // Text is now white

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: terracotta,
      scaffoldBackgroundColor: darkBg,
      textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme),
      colorScheme: const ColorScheme.dark(
        primary: terracotta,
        secondary: gold,
        surface: darkSurface,
        background: darkBg,
        error: Colors.redAccent,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: terracotta,
          foregroundColor: Colors.white,
          shadowColor: terracotta.withOpacity(0.5),
          elevation: 10, // Bouncy glowing elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          textStyle: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: terracotta, width: 2),
        ),
        labelStyle: GoogleFonts.dmSans(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
        hintStyle: GoogleFonts.dmSans(color: Colors.white30),
      ),
    );
  }
}
