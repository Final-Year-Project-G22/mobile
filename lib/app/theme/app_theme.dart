import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Full Material 3 (2025) theme configuration - PREMIUM EDITION.
///
/// Fully rounded components, soft dropshadows, modern input fields,
/// and rich vibrant color palettes for a highly eye-catching aesthetic.
class AppTheme {
  AppTheme._();

  // ═══════════════════════════════════════════════════════════════════════
  // LIGHT THEME
  // ═══════════════════════════════════════════════════════════════════════
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: AppColors.lightScheme,
    textTheme: AppTypography.textTheme,
    scaffoldBackgroundColor: AppColors.lightBackground,

    // ── App Bar ──────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent, // Glassy look base
      foregroundColor: AppColors.lightOnSurface,
      elevation: 0,
      scrolledUnderElevation: 0, // Keep clean
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: AppTypography.titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.lightOnSurface,
      ),
    ),

    // ── Navigation Bar (M3 pill indicator) ───────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      elevation: 20,
      shadowColor: AppColors.lightScrim.withValues(alpha: 0.1),
      height: 80,
      indicatorColor: AppColors.lightPrimaryContainer,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: AppColors.lightPrimary,
            size: 26,
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
            color: AppColors.lightPrimary,
            fontWeight: FontWeight.w700,
          );
        }
        return AppTypography.labelMedium.copyWith(
          color: AppColors.lightOnSurfaceVariant,
        );
      }),
      surfaceTintColor: Colors.transparent,
    ),

    // ── Card (Premium elevated look) ──────────────────────
    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation:
          0, // Using manual shadow via containers usually, but set 0 here
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      margin: EdgeInsets.zero,
    ),

    // ── Divider ─────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.lightOutlineVariant,
      thickness: 1,
      space: 1,
    ),

    // ── Input Decoration (Sleek, rounded, borderless until focus) ───
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceContainer,
      border: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: BorderSide.none, // Clean look
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: const BorderSide(
          color: AppColors.lightPrimary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: const BorderSide(color: AppColors.lightError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: const BorderSide(color: AppColors.lightError, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      hintStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.lightOnSurfaceVariant.withValues(alpha: 0.7),
      ),
      labelStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.lightOnSurfaceVariant,
      ),
      floatingLabelStyle: AppTypography.labelSmall.copyWith(
        color: AppColors.lightPrimary,
        fontWeight: FontWeight.w700,
      ),
    ),

    // ── Elevated Button (Filled, fully rounded, pill) ─────────────────
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
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        elevation: 0,
        textStyle: AppTypography.labelLarge.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // ── Filled Tonal Button ─────────────────────────────────────────
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.lightSecondaryContainer,
        foregroundColor: AppColors.lightOnSecondaryContainer,
        minimumSize: const Size(0, 56),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // ── Outlined Button ─────────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        minimumSize: const Size(0, 56),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        side: const BorderSide(color: AppColors.lightOutline, width: 2),
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // ── Text Button ─────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // ── FAB ─────────────────────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: AppColors.lightOnPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
    ),

    // ── Chip ────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: Colors.transparent,
      selectedColor: AppColors.lightPrimaryContainer,
      side: const BorderSide(color: AppColors.lightOutline),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      labelStyle: AppTypography.labelMedium.copyWith(
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // ── Bottom Sheet ────────────────────────────────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.lightSurface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusSheet,
      ),
      dragHandleColor: AppColors.lightOutline,
      dragHandleSize: const Size(40, 4),
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
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    // ── Progress Indicator ──────────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.lightPrimary,
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
    colorScheme: AppColors.darkScheme,
    textTheme: AppTypography.textTheme,
    scaffoldBackgroundColor: AppColors.darkBackground,

    // ── App Bar ──────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.darkOnSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: AppTypography.titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.darkOnSurface,
      ),
    ),

    // ── Navigation Bar ──────────────────────────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: 0,
      height: 80,
      indicatorColor: AppColors.darkPrimaryContainer,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: AppColors.darkOnPrimaryContainer,
            size: 26,
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
            color: AppColors.darkOnPrimaryContainer,
            fontWeight: FontWeight.w700,
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
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusLg,
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
      fillColor: AppColors.darkSurfaceContainer,
      border: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: const BorderSide(
          color: AppColors.darkPrimary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: const BorderSide(color: AppColors.darkError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusLg,
        borderSide: const BorderSide(color: AppColors.darkError, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      hintStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.darkOnSurfaceVariant.withValues(alpha: 0.7),
      ),
      labelStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.darkOnSurfaceVariant,
      ),
      floatingLabelStyle: AppTypography.labelSmall.copyWith(
        color: AppColors.darkPrimary,
        fontWeight: FontWeight.w700,
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
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        elevation: 0,
        textStyle: AppTypography.labelLarge.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // ── Filled Tonal Button ─────────────────────────────────────────
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.darkSecondaryContainer,
        foregroundColor: AppColors.darkOnSecondaryContainer,
        minimumSize: const Size(0, 56),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // ── Outlined Button ─────────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        minimumSize: const Size(0, 56),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        side: const BorderSide(color: AppColors.darkOutline, width: 2),
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // ── Text Button ─────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // ── FAB ─────────────────────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.darkOnPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
    ),

    // ── Chip ────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: Colors.transparent,
      selectedColor: AppColors.darkPrimaryContainer,
      side: const BorderSide(color: AppColors.darkOutline),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      labelStyle: AppTypography.labelMedium.copyWith(
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // ── Bottom Sheet ────────────────────────────────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.darkSurfaceContainer,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusSheet,
      ),
      dragHandleColor: AppColors.darkOutline,
      dragHandleSize: const Size(40, 4),
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
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    // ── Progress Indicator ──────────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.darkPrimary,
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
