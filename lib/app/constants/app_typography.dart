import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// M3 Type Scale for Adisu Serategna.
///
/// Typography strategy:
/// - Headings/titles: Plus Jakarta Sans (brand character, modern)
/// - Body/labels: Inter (high readability, professional)
/// - Amharic fallback: Noto Sans Ethiopic
class AppTypography {
  AppTypography._();

  static const _fallbacks = <String>[
    'Noto Sans Ethiopic',
    'Noto Sans',
    'sans-serif',
  ];

  static TextStyle _heading(TextStyle style) {
    return GoogleFonts.plusJakartaSans(textStyle: style).copyWith(
      fontFamilyFallback: _fallbacks,
    );
  }

  static TextStyle _body(TextStyle style) {
    return GoogleFonts.inter(textStyle: style).copyWith(
      fontFamilyFallback: _fallbacks,
    );
  }

  static TextTheme get textTheme {
    final base = ThemeData.light().textTheme;

    return base.copyWith(
      // ── Display ──────────────────────────────────────────────────────
      displayLarge: _heading(
        const TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          height: 1.12,
          letterSpacing: -0.25,
        ),
      ),
      displayMedium: _heading(
        const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          height: 1.16,
          letterSpacing: 0,
        ),
      ),
      displaySmall: _heading(
        const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w500,
          height: 1.22,
          letterSpacing: 0,
        ),
      ),

      // ── Headline ─────────────────────────────────────────────────────
      headlineLarge: _heading(
        const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.25,
          letterSpacing: -0.3,
        ),
      ),
      headlineMedium: _heading(
        const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          height: 1.29,
          letterSpacing: 0,
        ),
      ),
      headlineSmall: _heading(
        const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.33,
          letterSpacing: 0,
        ),
      ),

      // ── Title ────────────────────────────────────────────────────────
      titleLarge: _heading(
        const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 1.27,
          letterSpacing: 0,
        ),
      ),
      titleMedium: _heading(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.45,
          letterSpacing: 0.1,
        ),
      ),
      titleSmall: _heading(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.43,
          letterSpacing: 0.1,
        ),
      ),

      // ── Body ─────────────────────────────────────────────────────────
      bodyLarge: _body(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          letterSpacing: 0,
        ),
      ),
      bodyMedium: _body(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.43,
          letterSpacing: 0.2,
        ),
      ),
      bodySmall: _body(
        const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.33,
          letterSpacing: 0.3,
        ),
      ),

      // ── Label ────────────────────────────────────────────────────────
      labelLarge: _body(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.43,
          letterSpacing: 0.1,
        ),
      ),
      labelMedium: _body(
        const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.33,
          letterSpacing: 0.4,
        ),
      ),
      labelSmall: _body(
        const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.45,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ── Convenience getters ───────────────────────────────────────────
  static TextStyle get displayLarge => textTheme.displayLarge!;
  static TextStyle get displayMedium => textTheme.displayMedium!;
  static TextStyle get displaySmall => textTheme.displaySmall!;
  static TextStyle get headlineLarge => textTheme.headlineLarge!;
  static TextStyle get headlineMedium => textTheme.headlineMedium!;
  static TextStyle get headlineSmall => textTheme.headlineSmall!;
  static TextStyle get titleLarge => textTheme.titleLarge!;
  static TextStyle get titleMedium => textTheme.titleMedium!;
  static TextStyle get titleSmall => textTheme.titleSmall!;
  static TextStyle get bodyLarge => textTheme.bodyLarge!;
  static TextStyle get bodyMedium => textTheme.bodyMedium!;
  static TextStyle get bodySmall => textTheme.bodySmall!;
  static TextStyle get labelLarge => textTheme.labelLarge!;
  static TextStyle get labelMedium => textTheme.labelMedium!;
  static TextStyle get labelSmall => textTheme.labelSmall!;
}
