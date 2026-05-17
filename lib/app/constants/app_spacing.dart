import 'package:flutter/material.dart';

/// Design tokens for spacing, shape, elevation, and motion.
///
/// Based on a 4dp base unit. All values align with the M3 (2025) spec
/// documented in DESIGN.md.
class AppSpacing {
  AppSpacing._();

  // ═══════════════════════════════════════════════════════════════════════
  // SPACING (4dp base unit)
  // ═══════════════════════════════════════════════════════════════════════
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  // ── Screen & layout tokens ──────────────────────────────────────────
  static const double screenH = 24; // Generous horizontal screen edge insets
  static const double screenV = 24; // Vertical screen edge insets
  static const double sectionGap =
      32; // Vertical gap between dashboard sections
  static const double cardGap = 16; // Gap between cards in a list

  // ── Padding helpers ─────────────────────────────────────────────────
  static const EdgeInsets paddingXxs = EdgeInsets.all(xxs);
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(
    horizontal: md,
  );
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(
    horizontal: lg,
  );

  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(
    vertical: md,
  );
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(
    vertical: lg,
  );

  /// Standard screen edge padding.
  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(
    horizontal: screenH,
    vertical: screenV,
  );

  /// Horizontal screen edge padding only.
  static const EdgeInsets paddingScreenH = EdgeInsets.symmetric(
    horizontal: screenH,
  );

  // ═══════════════════════════════════════════════════════════════════════
  // SHAPE SCALE (M3)
  // Increased rounding for a more premium, modern, "bouncy" aesthetic
  // ═══════════════════════════════════════════════════════════════════════
  static const double radiusNone = 0;
  static const double radiusXs = 6;
  static const double radiusSm = 12; // Small chips
  static const double radiusMd = 16; // Medium — inputs, standard cards
  static const double radiusLg = 24; // Large — large cards, FABs, dialogs
  static const double radiusLgIncreased = 28; // Hero cards
  static const double radiusXl = 32; // ExtraLarge — bottom sheets
  static const double radiusXlIncreased = 40;
  static const double radiusFull = 9999; // Full — avatars, pills, main buttons

  static const BorderRadius borderRadiusNone = BorderRadius.zero;
  static final BorderRadius borderRadiusXs = BorderRadius.circular(radiusXs);
  static final BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static final BorderRadius borderRadiusLgIncreased = BorderRadius.circular(
    radiusLgIncreased,
  );
  static final BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static final BorderRadius borderRadiusFull = BorderRadius.circular(
    radiusFull,
  );

  /// Bottom-sheet top corners only (32dp).
  static const BorderRadius borderRadiusSheet = BorderRadius.only(
    topLeft: Radius.circular(radiusXl),
    topRight: Radius.circular(radiusXl),
  );

  // ═══════════════════════════════════════════════════════════════════════
  // ELEVATION / SHADOWS (M3 levels) - Custom softened for modern look
  // ═══════════════════════════════════════════════════════════════════════
  static const List<BoxShadow> shadowNone = [];

  /// Level 1 — Cards resting, NavigationBar, AppBar.
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0A000000), // ~4% opacity
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x05000000), // ~2% opacity
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  /// Level 2 — Cards hovered/pressed, dropdowns.
  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x0F000000), // ~6% opacity
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  /// Level 3 — FABs, navigation drawers.
  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x14000000), // ~8%
      blurRadius: 30,
      offset: Offset(0, 12),
    ),
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════
  // MOTION TOKENS (M3 durations & curves)
  // ═══════════════════════════════════════════════════════════════════════

  /// Micro-feedback (ripple start).
  static const Duration durationShort1 = Duration(milliseconds: 50);

  /// State layer appearance.
  static const Duration durationShort2 = Duration(milliseconds: 100);

  /// Button press, icon morph.
  static const Duration durationShort3 = Duration(milliseconds: 150);

  /// Tab switch, cross-fade.
  static const Duration durationMedium1 = Duration(milliseconds: 200);

  /// Page transitions, card expand.
  static const Duration durationMedium2 = Duration(milliseconds: 300);

  /// Bottom sheet, dialog entrance.
  static const Duration durationLong1 = Duration(milliseconds: 450);

  /// Progress fill, ring animation.
  static const Duration durationLong2 = Duration(milliseconds: 500);

  /// Primary curve — decelerating.
  static const Curve curveEaseOut = Curves.easeOutCubic;

  /// Symmetric transitions — tab switches.
  static const Curve curveEaseInOut = Curves.easeInOut;

  // ═══════════════════════════════════════════════════════════════════════
  // GAP HELPERS (for Column / Row)
  // ═══════════════════════════════════════════════════════════════════════
  static const SizedBox gapXxs = SizedBox(width: xxs, height: xxs);
  static const SizedBox gapXs = SizedBox(width: xs, height: xs);
  static const SizedBox gapSm = SizedBox(width: sm, height: sm);
  static const SizedBox gapMd = SizedBox(width: md, height: md);
  static const SizedBox gapLg = SizedBox(width: lg, height: lg);
  static const SizedBox gapXl = SizedBox(width: xl, height: xl);

  static const SizedBox gapHorizontalXxs = SizedBox(width: xxs);
  static const SizedBox gapHorizontalXs = SizedBox(width: xs);
  static const SizedBox gapHorizontalSm = SizedBox(width: sm);
  static const SizedBox gapHorizontalMd = SizedBox(width: md);
  static const SizedBox gapHorizontalLg = SizedBox(width: lg);

  static const SizedBox gapVerticalXxs = SizedBox(height: xxs);
  static const SizedBox gapVerticalXs = SizedBox(height: xs);
  static const SizedBox gapVerticalSm = SizedBox(height: sm);
  static const SizedBox gapVerticalMd = SizedBox(height: md);
  static const SizedBox gapVerticalLg = SizedBox(height: lg);
  static const SizedBox gapVerticalXl = SizedBox(height: xl);
  static const SizedBox gapVerticalXxl = SizedBox(height: xxl);
}
