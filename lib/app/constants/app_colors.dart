import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Slate scale (blue-tinted neutrals from design) ──────────────────
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
  static const Color slate950 = Color(0xFF020617);

  // ── Accent – Blue ───────────────────────────────────────────────────
  static const Color blue400 = Color(0xFF60A5FA);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);

  // ── Primary (dark slate for buttons / key actions) ──────────────────
  static const Color primary = slate800; // #1E293B
  static const Color primaryLight = slate700; // #334155
  static const Color primaryDark = slate900; // #0F172A

  // ── Accent (blue for links / active indicators) ─────────────────────
  static const Color accent = blue500; // #3B82F6
  static const Color accentLight = blue400; // #60A5FA
  static const Color accentDark = blue600; // #2563EB

  // ── Semantic colors ─────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ── Background ──────────────────────────────────────────────────────
  static const Color backgroundLight = slate50; // #F8FAFC
  static const Color backgroundDark = slate900; // #0F172A

  // ── Surface (cards, elevated areas) ─────────────────────────────────
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = slate800; // #1E293B

  // ── Input fill ──────────────────────────────────────────────────────
  static const Color inputFillLight = slate100; // #F1F5F9
  static const Color inputFillDark = slate800; // #1E293B

  // ── Text ────────────────────────────────────────────────────────────
  static const Color textPrimaryLight = slate900; // #0F172A
  static const Color textSecondaryLight = slate500; // #64748B
  static const Color textPrimaryDark = slate50; // #F8FAFC
  static const Color textSecondaryDark = slate400; // #94A3B8
  static const Color textHintLight = slate400; // #94A3B8
  static const Color textHintDark = slate500; // #64748B
  static const Color textLabelLight = slate800; // #1E293B
  static const Color textLabelDark = slate200; // #E2E8F0

  // ── Borders / dividers ──────────────────────────────────────────────
  static const Color borderLight = slate200; // #E2E8F0
  static const Color borderDark = slate700; // #334155
}
