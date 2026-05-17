import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Full Material 3 (2025) theme configuration.
///
/// Uses [AppColors.lightScheme] / [AppColors.darkScheme] as the color
/// foundation. All component themes are configured here so widgets can
/// rely on defaults instead of manual `isDark` checks.
class AppTheme {
  AppTheme._();

  // ═══════════════════════════════════════════════════════════════════════
  // LIGHT THEME
  // ═══════════════════════════════════════════════════════════════════════
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Inter',
    colorScheme: AppColors.lightScheme,
    textTheme: AppTypography.textTheme,
    scaffoldBackgroundColor: AppColors.lightBackground,

    // ── App Bar ──────────────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightOnSurface,
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

    // ── Navigation Bar (M3 pill indicator) ───────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      elevation: 3,
      height: 80,
      indicatorColor: AppColors.lightSecondaryContainer,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: AppColors.lightOnSecondaryContainer,
            size: 24,
          );
        }
        return const IconThemeData(
          color: AppColors.lightOnSurfaceVariant,
          size: 24,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelMedium.copyWith(
            color: AppColors.lightOnSurface,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTypography.labelMedium.copyWith(
          color: AppColors.lightOnSurfaceVariant,
        );
      }),
      surfaceTintColor: Colors.transparent,
    ),

    // ── Card (M3 Elevated — shadow, no border) ──────────────────────
    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 1,
      shadowColor: AppColors.lightScrim.withValues(alpha: 0.15),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      margin: EdgeInsets.zero,
    ),

    // ── Divider ─────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.lightOutlineVariant,
      thickness: 1,
      space: 1,
    ),

    // ── Input Decoration ────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(
          color: AppColors.lightOnSurfaceVariant,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(
          color: AppColors.lightPrimary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: AppColors.lightError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: AppColors.lightError, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      hintStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.lightOnSurfaceVariant,
      ),
      labelStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.lightOnSurfaceVariant,
      ),
      floatingLabelStyle: AppTypography.labelSmall.copyWith(
        color: AppColors.lightPrimary,
      ),
    ),

    // ── Elevated Button (Filled — highest emphasis) ─────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.lightOnPrimary,
        disabledBackgroundColor: AppColors.lightOnSurface.withValues(
          alpha: 0.12,
        ),
        disabledForegroundColor: AppColors.lightOnSurface.withValues(
          alpha: 0.38,
        ),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        elevation: 0,
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // ── Filled Tonal Button ─────────────────────────────────────────
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.lightSecondaryContainer,
        foregroundColor: AppColors.lightOnSecondaryContainer,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // ── Outlined Button ─────────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        side: const BorderSide(color: AppColors.lightOutline),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // ── Text Button ─────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // ── FAB ─────────────────────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimaryContainer,
      foregroundColor: AppColors.lightOnPrimaryContainer,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
    ),

    // ── Chip ────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: Colors.transparent,
      selectedColor: AppColors.lightSecondaryContainer,
      side: const BorderSide(color: AppColors.lightOutline),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      labelStyle: AppTypography.labelMedium,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),

    // ── Bottom Sheet ────────────────────────────────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.lightSurface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusSheet,
      ),
      dragHandleColor: AppColors.lightOutline,
      dragHandleSize: const Size(32, 4),
    ),

    // ── Dialog ──────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.lightSurface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
      ),
    ),

    // ── Snack Bar ───────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightInverseSurface,
      contentTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.lightInverseOnSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    // ── Progress Indicator ──────────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.lightSecondary,
      linearTrackColor: AppColors.lightSurfaceContainerHigh,
    ),

    // ── Switch ──────────────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.lightOnPrimary;
        }
        return AppColors.lightOutline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.lightPrimary;
        }
        return AppColors.lightSurfaceContainerHighest;
      }),
    ),

    // ── List Tile ───────────────────────────────────────────────────
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      minLeadingWidth: 24,
      iconColor: AppColors.lightOnSurfaceVariant,
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════
  // DARK THEME
  // ═══════════════════════════════════════════════════════════════════════
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    colorScheme: AppColors.darkScheme,
    textTheme: AppTypography.textTheme,
    scaffoldBackgroundColor: AppColors.darkBackground,

    // ── App Bar ──────────────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkOnSurface,
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    // ── Navigation Bar ──────────────────────────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: 3,
      height: 80,
      indicatorColor: AppColors.darkSecondaryContainer,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: AppColors.darkOnSecondaryContainer,
            size: 24,
          );
        }
        return const IconThemeData(
          color: AppColors.darkOnSurfaceVariant,
          size: 24,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelMedium.copyWith(
            color: AppColors.darkOnSurface,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTypography.labelMedium.copyWith(
          color: AppColors.darkOnSurfaceVariant,
        );
      }),
      surfaceTintColor: Colors.transparent,
    ),

    // ── Card ────────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.darkSurfaceContainer,
      elevation: 1,
      shadowColor: Colors.black26,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      margin: EdgeInsets.zero,
    ),

    // ── Divider ─────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.darkOutlineVariant,
      thickness: 1,
      space: 1,
    ),

    // ── Input Decoration ────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceContainerHigh,
      border: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(
          color: AppColors.darkOnSurfaceVariant,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(
          color: AppColors.darkPrimary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: AppColors.darkError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: AppColors.darkError, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      hintStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.darkOnSurfaceVariant,
      ),
      labelStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.darkOnSurfaceVariant,
      ),
      floatingLabelStyle: AppTypography.labelSmall.copyWith(
        color: AppColors.darkPrimary,
      ),
    ),

    // ── Elevated Button ─────────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkOnPrimary,
        disabledBackgroundColor: AppColors.darkOnSurface.withValues(
          alpha: 0.12,
        ),
        disabledForegroundColor: AppColors.darkOnSurface.withValues(
          alpha: 0.38,
        ),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        elevation: 0,
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // ── Filled Tonal Button ─────────────────────────────────────────
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.darkSecondaryContainer,
        foregroundColor: AppColors.darkOnSecondaryContainer,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // ── Outlined Button ─────────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        side: const BorderSide(color: AppColors.darkOutline),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // ── Text Button ─────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // ── FAB ─────────────────────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimaryContainer,
      foregroundColor: AppColors.darkOnPrimaryContainer,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
    ),

    // ── Chip ────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: Colors.transparent,
      selectedColor: AppColors.darkSecondaryContainer,
      side: const BorderSide(color: AppColors.darkOutline),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      labelStyle: AppTypography.labelMedium,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),

    // ── Bottom Sheet ────────────────────────────────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.darkSurfaceContainer,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusSheet,
      ),
      dragHandleColor: AppColors.darkOutline,
      dragHandleSize: const Size(32, 4),
    ),

    // ── Dialog ──────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurfaceContainer,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
      ),
    ),

    // ── Snack Bar ───────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkInverseSurface,
      contentTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.darkInverseOnSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    // ── Progress Indicator ──────────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.darkSecondary,
      linearTrackColor: AppColors.darkSurfaceContainerHigh,
    ),

    // ── Switch ──────────────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.darkOnPrimary;
        }
        return AppColors.darkOutline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.darkPrimary;
        }
        return AppColors.darkSurfaceContainerHighest;
      }),
    ),

    // ── List Tile ───────────────────────────────────────────────────
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      minLeadingWidth: 24,
      iconColor: AppColors.darkOnSurfaceVariant,
    ),
  );
}
