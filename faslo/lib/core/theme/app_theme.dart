import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

// ignore_for_file: prefer_const_constructors

enum AppThemeMode { sageMint, kineticObsidian, zenPaper, minimalOled }

class AppTheme {
  // ── Sage Mint ──────────────────────────────────────────────────────────────
  static ThemeData sageMint() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: SageMintColors.primary,
        onPrimary: SageMintColors.onPrimary,
        primaryContainer: SageMintColors.primaryContainer,
        secondary: SageMintColors.secondary,
        surface: SageMintColors.surface,
        onSurface: SageMintColors.onSurface,
        onSurfaceVariant: SageMintColors.onSurfaceVariant,
        error: SageMintColors.error,
        outlineVariant: SageMintColors.outlineVariant,
        surfaceContainerLowest: SageMintColors.surfaceLowest,
        surfaceContainerLow: SageMintColors.surfaceLow,
        surfaceContainer: SageMintColors.surfaceContainer,
        surfaceContainerHigh: SageMintColors.surfaceHigh,
        surfaceContainerHighest: SageMintColors.surfaceHighest,
      ),
      textTheme: _mintTextTheme(),
      scaffoldBackgroundColor: SageMintColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: SageMintColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SageMintColors.surfaceLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: SageMintColors.outlineVariant,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  static TextTheme _mintTextTheme() => TextTheme(
        displayLarge: GoogleFonts.lexend(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.5,
        ),
        displayMedium: GoogleFonts.lexend(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
        ),
        displaySmall: GoogleFonts.lexend(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.lexend(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: GoogleFonts.lexend(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.lexend(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge:
            GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600),
        titleMedium:
            GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        titleSmall:
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge:
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      );

  // ── Kinetic Obsidian ───────────────────────────────────────────────────────
  static ThemeData kineticObsidian() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: ObsidianColors.primaryDim,
        onPrimary: ObsidianColors.onPrimary,
        primaryContainer: ObsidianColors.primaryContainer,
        secondary: ObsidianColors.secondary,
        surface: ObsidianColors.surface,
        onSurface: ObsidianColors.onSurface,
        onSurfaceVariant: ObsidianColors.onSurfaceVariant,
        error: ObsidianColors.error,
        outlineVariant: ObsidianColors.outlineVariant,
        surfaceContainerLowest: ObsidianColors.surfaceLowest,
        surfaceContainerLow: ObsidianColors.surfaceLow,
        surfaceContainer: ObsidianColors.surfaceContainer,
        surfaceContainerHigh: ObsidianColors.surfaceHigh,
        surfaceContainerHighest: ObsidianColors.surfaceHighest,
      ),
      textTheme: _obsidianTextTheme(),
      scaffoldBackgroundColor: ObsidianColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static TextTheme _obsidianTextTheme() => TextTheme(
        displayLarge: GoogleFonts.lexend(
          fontSize: 72,
          fontWeight: FontWeight.w900,
          letterSpacing: -2.0,
        ),
        displayMedium: GoogleFonts.lexend(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.5,
        ),
        displaySmall:
            GoogleFonts.lexend(fontSize: 36, fontWeight: FontWeight.w800),
        headlineLarge: GoogleFonts.lexend(
          fontSize: 32,
          fontWeight: FontWeight.w800,
        ),
        headlineMedium: GoogleFonts.lexend(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleLarge:
            GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w700),
        titleMedium:
            GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600),
        titleSmall: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
        bodyLarge:
            GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium:
            GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall:
            GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
        ),
        labelMedium: GoogleFonts.manrope(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
        ),
        labelSmall: GoogleFonts.manrope(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
        ),
      );

  // ── Zen Paper ──────────────────────────────────────────────────────────────
  static ThemeData zenPaper() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: ZenPaperColors.accent,
        onPrimary: ZenPaperColors.onAccent,
        surface: ZenPaperColors.surface,
        onSurface: ZenPaperColors.ink,
        onSurfaceVariant: ZenPaperColors.inkSecondary,
        outlineVariant: ZenPaperColors.outline,
        error: ZenPaperColors.error,
        surfaceContainerLowest: ZenPaperColors.background,
        surfaceContainerLow: ZenPaperColors.surface,
        surfaceContainer: ZenPaperColors.surfaceCard,
        surfaceContainerHigh: ZenPaperColors.surfaceSunken,
        surfaceContainerHighest: ZenPaperColors.surfaceSunken,
      ),
      textTheme: _zenTextTheme(),
      scaffoldBackgroundColor: ZenPaperColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: ZenPaperColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ZenPaperColors.surfaceSunken,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ZenPaperColors.outline, width: 2),
        ),
      ),
    );
  }

  static TextTheme _zenTextTheme() => TextTheme(
        displayLarge: GoogleFonts.nunito(
          fontSize: 56,
          fontWeight: FontWeight.w800,
          color: ZenPaperColors.ink,
        ),
        displayMedium: GoogleFonts.nunito(
          fontSize: 45,
          fontWeight: FontWeight.w800,
          color: ZenPaperColors.ink,
        ),
        displaySmall: GoogleFonts.nunito(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: ZenPaperColors.ink,
        ),
        headlineLarge: GoogleFonts.nunito(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: ZenPaperColors.ink,
        ),
        headlineMedium: GoogleFonts.nunito(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: ZenPaperColors.ink,
        ),
        headlineSmall: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: ZenPaperColors.ink,
        ),
        titleLarge: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ZenPaperColors.ink,
        ),
        titleMedium: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ZenPaperColors.inkSecondary,
        ),
        titleSmall: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ZenPaperColors.inkSecondary,
        ),
        bodyLarge: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.7,
          color: ZenPaperColors.inkSecondary,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.7,
          color: ZenPaperColors.inkSecondary,
        ),
        bodySmall: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ZenPaperColors.inkMuted,
        ),
        labelLarge: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: ZenPaperColors.inkMuted,
          letterSpacing: 0.5,
        ),
        labelMedium: GoogleFonts.nunito(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: ZenPaperColors.inkMuted,
        ),
        labelSmall: GoogleFonts.nunito(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: ZenPaperColors.inkMuted,
        ),
      );

  // ── Minimal OLED ───────────────────────────────────────────────────────────
  static ThemeData minimalOled() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        onPrimary: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lexend(
          fontSize: 64,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodyMedium: const TextStyle(fontSize: 14, color: Colors.white70),
      ),
    );
  }
}
