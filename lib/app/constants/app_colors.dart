import 'package:flutter/material.dart';

/// M3 Color Role System for Adisu Serategna.
///
/// Colors are assigned by **role** (what they do), not value (what they look
/// like). This enables automatic dark-mode adaptation via [ColorScheme].
///
/// Usage: Prefer `Theme.of(context).colorScheme.<role>` in widgets.
/// Direct access to these constants is intended for AppTheme setup and
/// the occasional edge case (e.g. gradient definitions).
class AppColors {
  AppColors._();

  // ═══════════════════════════════════════════════════════════════════════
  // RAW PALETTE — Slate scale (blue-tinted neutrals)
  // ═══════════════════════════════════════════════════════════════════════
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // ═══════════════════════════════════════════════════════════════════════
  // LIGHT THEME — M3 Color Roles
  // ═══════════════════════════════════════════════════════════════════════

  // ── Primary — Slate 800 (Professional, trust, authority) ─────────────
  static const Color lightPrimary = Color(0xFF1E293B);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryContainer = Color(0xFFE2E8F0); // Slate 200
  static const Color lightOnPrimaryContainer = Color(0xFF0F172A); // Slate 900

  // ── Secondary — Emerald 500 (Growth, progress, success) ──────────────
  static const Color lightSecondary = Color(0xFF10B981);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightSecondaryContainer = Color(0xFFD1FAE5); // Emerald 100
  static const Color lightOnSecondaryContainer = Color(
    0xFF065F46,
  ); // Emerald 800

  // ── Tertiary — Amber 500 (Warmth, highlights, Ethiopian resonance) ───
  static const Color lightTertiary = Color(0xFFF59E0B);
  static const Color lightOnTertiary = Color(0xFFFFFFFF);
  static const Color lightTertiaryContainer = Color(0xFFFEF3C7); // Amber 100
  static const Color lightOnTertiaryContainer = Color(0xFF92400E); // Amber 800

  // ── Error ────────────────────────────────────────────────────────────
  static const Color lightError = Color(0xFFEF4444);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightErrorContainer = Color(0xFFFEE2E2);
  static const Color lightOnErrorContainer = Color(0xFF7F1D1D);

  // ── Surface container hierarchy ──────────────────────────────────────
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceDim = Color(0xFFF1F5F9);
  static const Color lightSurfaceBright = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLow = Color(0xFFF8FAFC);
  static const Color lightSurfaceContainer = Color(0xFFF1F5F9);
  static const Color lightSurfaceContainerHigh = Color(0xFFE2E8F0);
  static const Color lightSurfaceContainerHighest = Color(0xFFCBD5E1);

  // ── Text & outline ──────────────────────────────────────────────────
  static const Color lightOnSurface = Color(0xFF0F172A);
  static const Color lightOnSurfaceVariant = Color(0xFF64748B);
  static const Color lightOutline = Color(0xFFCBD5E1);
  static const Color lightOutlineVariant = Color(0xFFE2E8F0);

  // ── Background & scrim ──────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightOnBackground = Color(0xFF0F172A);
  static const Color lightScrim = Color(0xFF000000);

  // ── Inverse ─────────────────────────────────────────────────────────
  static const Color lightInverseSurface = Color(0xFF1E293B);
  static const Color lightInverseOnSurface = Color(0xFFF1F5F9);
  static const Color lightInversePrimary = Color(0xFF94A3B8);

  // ═══════════════════════════════════════════════════════════════════════
  // DARK THEME — M3 Color Roles
  // ═══════════════════════════════════════════════════════════════════════

  // ── Primary ─────────────────────────────────────────────────────────
  static const Color darkPrimary = Color(0xFF94A3B8);
  static const Color darkOnPrimary = Color(0xFF0F172A);
  static const Color darkPrimaryContainer = Color(0xFF334155); // Slate 700
  static const Color darkOnPrimaryContainer = Color(0xFFE2E8F0);

  // ── Secondary ───────────────────────────────────────────────────────
  static const Color darkSecondary = Color(0xFF6EE7B7);
  static const Color darkOnSecondary = Color(0xFF065F46);
  static const Color darkSecondaryContainer = Color(0xFF064E3B); // Emerald 900
  static const Color darkOnSecondaryContainer = Color(0xFFD1FAE5);

  // ── Tertiary ────────────────────────────────────────────────────────
  static const Color darkTertiary = Color(0xFFFCD34D);
  static const Color darkOnTertiary = Color(0xFF78350F);
  static const Color darkTertiaryContainer = Color(0xFF92400E); // Amber 800
  static const Color darkOnTertiaryContainer = Color(0xFFFEF3C7);

  // ── Error ───────────────────────────────────────────────────────────
  static const Color darkError = Color(0xFFFCA5A5);
  static const Color darkOnError = Color(0xFF7F1D1D);
  static const Color darkErrorContainer = Color(0xFF7F1D1D);
  static const Color darkOnErrorContainer = Color(0xFFFEE2E2);

  // ── Surface container hierarchy ─────────────────────────────────────
  static const Color darkSurface = Color(0xFF121921);
  static const Color darkSurfaceDim = Color(0xFF0C1220);
  static const Color darkSurfaceBright = Color(0xFF2D3B4E);
  static const Color darkSurfaceContainerLowest = Color(0xFF0C1220);
  static const Color darkSurfaceContainerLow = Color(0xFF1A2332);
  static const Color darkSurfaceContainer = Color(0xFF1E293B);
  static const Color darkSurfaceContainerHigh = Color(0xFF243044);
  static const Color darkSurfaceContainerHighest = Color(0xFF334155);

  // ── Text & outline ──────────────────────────────────────────────────
  static const Color darkOnSurface = Color(0xFFF1F5F9);
  static const Color darkOnSurfaceVariant = Color(0xFF94A3B8);
  static const Color darkOutline = Color(0xFF475569);
  static const Color darkOutlineVariant = Color(0xFF334155);

  // ── Background & scrim ──────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0C1220);
  static const Color darkOnBackground = Color(0xFFF1F5F9);
  static const Color darkScrim = Color(0xFF000000);

  // ── Inverse ─────────────────────────────────────────────────────────
  static const Color darkInverseSurface = Color(0xFFE2E8F0);
  static const Color darkInverseOnSurface = Color(0xFF1E293B);
  static const Color darkInversePrimary = Color(0xFF1E293B);

  // ═══════════════════════════════════════════════════════════════════════
  // SEMANTIC STATUS COLORS (theme-independent — use via AppColors.success*)
  // ═══════════════════════════════════════════════════════════════════════
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color onSuccessContainer = Color(0xFF065F46);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color onWarningContainer = Color(0xFF92400E);

  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color onErrorContainer = Color(0xFF7F1D1D);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoContainer = Color(0xFFDBEAFE);
  static const Color onInfoContainer = Color(0xFF1E3A8A);

  // ═══════════════════════════════════════════════════════════════════════
  // GRADIENTS
  // ═══════════════════════════════════════════════════════════════════════
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F172A), Color(0xFF1E3A5F)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );

  // ═══════════════════════════════════════════════════════════════════════
  // BUILT COLOR SCHEMES
  // ═══════════════════════════════════════════════════════════════════════

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: lightPrimary,
    onPrimary: lightOnPrimary,
    primaryContainer: lightPrimaryContainer,
    onPrimaryContainer: lightOnPrimaryContainer,
    secondary: lightSecondary,
    onSecondary: lightOnSecondary,
    secondaryContainer: lightSecondaryContainer,
    onSecondaryContainer: lightOnSecondaryContainer,
    tertiary: lightTertiary,
    onTertiary: lightOnTertiary,
    tertiaryContainer: lightTertiaryContainer,
    onTertiaryContainer: lightOnTertiaryContainer,
    error: lightError,
    onError: lightOnError,
    errorContainer: lightErrorContainer,
    onErrorContainer: lightOnErrorContainer,
    surface: lightSurface,
    onSurface: lightOnSurface,
    onSurfaceVariant: lightOnSurfaceVariant,
    outline: lightOutline,
    outlineVariant: lightOutlineVariant,
    surfaceDim: lightSurfaceDim,
    surfaceBright: lightSurfaceBright,
    surfaceContainerLowest: lightSurfaceContainerLowest,
    surfaceContainerLow: lightSurfaceContainerLow,
    surfaceContainer: lightSurfaceContainer,
    surfaceContainerHigh: lightSurfaceContainerHigh,
    surfaceContainerHighest: lightSurfaceContainerHighest,
    inverseSurface: lightInverseSurface,
    onInverseSurface: lightInverseOnSurface,
    inversePrimary: lightInversePrimary,
    scrim: lightScrim,
    shadow: Color(0xFF000000),
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    primaryContainer: darkPrimaryContainer,
    onPrimaryContainer: darkOnPrimaryContainer,
    secondary: darkSecondary,
    onSecondary: darkOnSecondary,
    secondaryContainer: darkSecondaryContainer,
    onSecondaryContainer: darkOnSecondaryContainer,
    tertiary: darkTertiary,
    onTertiary: darkOnTertiary,
    tertiaryContainer: darkTertiaryContainer,
    onTertiaryContainer: darkOnTertiaryContainer,
    error: darkError,
    onError: darkOnError,
    errorContainer: darkErrorContainer,
    onErrorContainer: darkOnErrorContainer,
    surface: darkSurface,
    onSurface: darkOnSurface,
    onSurfaceVariant: darkOnSurfaceVariant,
    outline: darkOutline,
    outlineVariant: darkOutlineVariant,
    surfaceDim: darkSurfaceDim,
    surfaceBright: darkSurfaceBright,
    surfaceContainerLowest: darkSurfaceContainerLowest,
    surfaceContainerLow: darkSurfaceContainerLow,
    surfaceContainer: darkSurfaceContainer,
    surfaceContainerHigh: darkSurfaceContainerHigh,
    surfaceContainerHighest: darkSurfaceContainerHighest,
    inverseSurface: darkInverseSurface,
    onInverseSurface: darkInverseOnSurface,
    inversePrimary: darkInversePrimary,
    scrim: darkScrim,
    shadow: Color(0xFF000000),
  );

  // ═══════════════════════════════════════════════════════════════════════
  // DEPRECATED ALIASES — Keep until all screens are migrated
  // ═══════════════════════════════════════════════════════════════════════

  @Deprecated('Use theme.colorScheme.primary')
  static const Color primary = lightPrimary;
  @Deprecated('Use theme.colorScheme.primary')
  static const Color primaryLight = slate700;
  @Deprecated('Use theme.colorScheme.primary')
  static const Color primaryDark = slate900;

  @Deprecated('Use theme.colorScheme.secondary')
  static const Color accent = Color(0xFF3B82F6); // old blue accent
  @Deprecated('Use theme.colorScheme.secondary')
  static const Color accentLight = Color(0xFF60A5FA);
  @Deprecated('Use theme.colorScheme.secondary')
  static const Color accentDark = Color(0xFF2563EB);

  // Blue scale (kept for old references)
  @Deprecated('Use theme.colorScheme.tertiary or info')
  static const Color blue400 = Color(0xFF60A5FA);
  @Deprecated('Use theme.colorScheme.tertiary or info')
  static const Color blue500 = Color(0xFF3B82F6);
  @Deprecated('Use theme.colorScheme.tertiary or info')
  static const Color blue600 = Color(0xFF2563EB);

  @Deprecated('Use theme.scaffoldBackgroundColor')
  static const Color backgroundLight = lightBackground;
  @Deprecated('Use theme.scaffoldBackgroundColor')
  static const Color backgroundDark = darkBackground;

  @Deprecated('Use theme.colorScheme.surface')
  static const Color surfaceLight = lightSurface;
  @Deprecated('Use theme.colorScheme.surface')
  static const Color surfaceDark = darkSurface;

  @Deprecated('Use theme.inputDecorationTheme')
  static const Color inputFillLight = lightSurfaceContainer;
  @Deprecated('Use theme.inputDecorationTheme')
  static const Color inputFillDark = darkSurfaceContainerHigh;

  @Deprecated('Use theme.colorScheme.onSurface')
  static const Color textPrimaryLight = lightOnSurface;
  @Deprecated('Use theme.colorScheme.onSurfaceVariant')
  static const Color textSecondaryLight = lightOnSurfaceVariant;
  @Deprecated('Use theme.colorScheme.onSurface')
  static const Color textPrimaryDark = darkOnSurface;
  @Deprecated('Use theme.colorScheme.onSurfaceVariant')
  static const Color textSecondaryDark = darkOnSurfaceVariant;
  @Deprecated('Use theme.colorScheme.onSurfaceVariant')
  static const Color textHintLight = slate400;
  @Deprecated('Use theme.colorScheme.onSurfaceVariant')
  static const Color textHintDark = slate500;
  @Deprecated('Use theme.colorScheme.onSurface')
  static const Color textLabelLight = slate800;
  @Deprecated('Use theme.colorScheme.onSurface')
  static const Color textLabelDark = slate200;

  @Deprecated('Use theme.colorScheme.outlineVariant')
  static const Color borderLight = lightOutlineVariant;
  @Deprecated('Use theme.colorScheme.outline')
  static const Color borderDark = darkOutline;
}
