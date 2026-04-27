import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalai_mobile/utils/theme.dart';

class ThemeText {
  static TextStyle get headline => GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: KalaiTheme.textDark,
  );

  static TextStyle get subhead => GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: KalaiTheme.textDark,
  );

  static TextStyle get bodyText => GoogleFonts.dmSans(
    fontSize: 14,
    color: KalaiTheme.textDark,
  );
  
  static TextStyle get caption => GoogleFonts.dmSans(
    fontSize: 12,
    color: Colors.grey,
  );
}
