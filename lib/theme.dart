import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Color palettes
const Color studentOrange = Color(0xFFFF8A2B);
const Color studentOrangeDark = Color(0xFFFF7A1A);
const Color teacherGreen = Color(0xFF22C55E);
const Color teacherGreenDark = Color(0xFF16A34A);
const Color surfaceLight = Color(0xFFFAFAFA);
const Color surfaceDark = Color(0xFF1E293B);
const Color backgroundLight = Color(0xFFFFFFFF);
const Color backgroundDark = Color(0xFF0F172A);
const Color muted = Color(0xFF9CA3AF);
const Color errorRed = Color(0xFFDC2626);

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: studentOrange,
  onPrimary: Colors.white,
  secondary: teacherGreen,
  onSecondary: Colors.white,
  background: backgroundLight,
  onBackground: Colors.black,
  surface: surfaceLight,
  onSurface: Colors.black,
  error: errorRed,
  onError: Colors.white,
  tertiary: muted,
  onTertiary: Colors.white,
);

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: studentOrangeDark,
  onPrimary: Colors.white,
  secondary: teacherGreenDark,
  onSecondary: Colors.white,
  background: backgroundDark,
  onBackground: Colors.white,
  surface: surfaceDark,
  onSurface: Colors.white,
  error: errorRed,
  onError: Colors.white,
  tertiary: muted,
  onTertiary: Colors.white,
);

TextTheme buildTextTheme(Color color) => TextTheme(
  displayLarge: GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: color,
  ),
  displayMedium: GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: color,
  ),
  bodyLarge: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: color,
  ),
  bodyMedium: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: color,
  ),
  bodySmall: GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: color,
  ),
);

ThemeData buildLightTheme() => ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: backgroundLight,
  textTheme: buildTextTheme(Colors.black),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: surfaceLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: studentOrange, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  cardTheme: CardThemeData(
    color: surfaceLight,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.all(8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      elevation: MaterialStateProperty.all(2),
      overlayColor: MaterialStateProperty.all(studentOrange.withOpacity(0.1)),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: studentOrange,
    linearTrackColor: muted.withOpacity(0.2),
    circularTrackColor: muted.withOpacity(0.2),
  ),
);

ThemeData buildDarkTheme() => ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: backgroundDark,
  textTheme: buildTextTheme(Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: surfaceDark,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: studentOrangeDark, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  cardTheme: CardThemeData(
    color: surfaceDark,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.all(8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      elevation: MaterialStateProperty.all(2),
      overlayColor: MaterialStateProperty.all(studentOrangeDark.withOpacity(0.1)),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: studentOrangeDark,
    linearTrackColor: muted.withOpacity(0.2),
    circularTrackColor: muted.withOpacity(0.2),
  ),
);
