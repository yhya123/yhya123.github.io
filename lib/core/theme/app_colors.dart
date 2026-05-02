import 'package:flutter/material.dart';

/// High-tech, minimal palette. Content Tip: keep accent use sparse (CTAs, links,
/// one highlight per section) so the page feels premium rather than noisy.
abstract final class AppColors {
  static const Color background = Color(0xFF0B0F14);
  static const Color surface = Color(0xFF121922);
  static const Color surfaceElevated = Color(0xFF1A2330);
  static const Color border = Color(0xFF2A3544);
  static const Color accent = Color(0xFF3D9EFF);
  static const Color accentDim = Color(0xFF2563B8);
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color glow = Color(0x334D9EFF);

  /// Faint warm gold — “human spark” behind technical surfaces (use at ≤12% opacity layers).
  static const Color humanWarm = Color(0xFFC9A227);

  /// Deep cyan veil — complements cold tech without candy colors.
  static const Color humanCyan = Color(0xFF0E7490);
}
