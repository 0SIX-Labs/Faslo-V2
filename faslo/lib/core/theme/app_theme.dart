import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

// ignore_for_file: prefer_const_constructors

enum AppThemeMode { sageMint, kineticObsidian, minimalMono, minimalOled }

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

  // ── Minimal Mono (Monochrome Line Style) ────────────────────────────────────
  static ThemeData minimalMono() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: MinimalMonoColors.accent,
        onPrimary: MinimalMonoColors.onAccent,
        surface: MinimalMonoColors.surface,
        onSurface: MinimalMonoColors.ink,
        onSurfaceVariant: MinimalMonoColors.inkSecondary,
        outlineVariant: MinimalMonoColors.outlineLight,
        error: MinimalMonoColors.error,
        surfaceContainerLowest: MinimalMonoColors.background,
        surfaceContainerLow: MinimalMonoColors.surface,
        surfaceContainer: MinimalMonoColors.surfaceCard,
        surfaceContainerHigh: MinimalMonoColors.surfaceSunken,
        surfaceContainerHighest: MinimalMonoColors.surfaceSunken,
      ),
      textTheme: _minimalMonoTextTheme(),
      scaffoldBackgroundColor: MinimalMonoColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: MinimalMonoColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: MinimalMonoColors.outline, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
              color: MinimalMonoColors.outlineLight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: MinimalMonoColors.outline, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: MinimalMonoColors.ink,
          elevation: 0,
          shadowColor: Colors.transparent,
          side: const BorderSide(color: MinimalMonoColors.outline, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MinimalMonoColors.ink,
          side: const BorderSide(color: MinimalMonoColors.outline, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  static TextTheme _minimalMonoTextTheme() => TextTheme(
        displayLarge: GoogleFonts.spaceMono(
          fontSize: 56,
          fontWeight: FontWeight.w400,
          color: MinimalMonoColors.ink,
        ),
        displayMedium: GoogleFonts.spaceMono(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: MinimalMonoColors.ink,
        ),
        displaySmall: GoogleFonts.spaceMono(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: MinimalMonoColors.ink,
        ),
        headlineLarge: GoogleFonts.spaceMono(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: MinimalMonoColors.ink,
        ),
        headlineMedium: GoogleFonts.spaceMono(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: MinimalMonoColors.ink,
        ),
        headlineSmall: GoogleFonts.spaceMono(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: MinimalMonoColors.ink,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: MinimalMonoColors.ink,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: MinimalMonoColors.inkSecondary,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: MinimalMonoColors.inkSecondary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: MinimalMonoColors.inkSecondary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: MinimalMonoColors.inkSecondary,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: MinimalMonoColors.inkMuted,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: MinimalMonoColors.inkMuted,
          letterSpacing: 0.5,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: MinimalMonoColors.inkMuted,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: MinimalMonoColors.inkMuted,
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
