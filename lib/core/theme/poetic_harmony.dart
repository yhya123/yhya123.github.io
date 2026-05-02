import 'package:flutter/material.dart';

/// Layout rhythm (φ) and motion “breath” shared across portfolio surfaces.
abstract final class PoeticHarmony {
  static const double phi = 1.618033988749895;

  /// Golden-scaled spacing from a base unit (negative space / typographic meter).
  static double gs(double unit) => unit * phi;

  /// Material-standard “natural” easing — reads slower than linear, like exhale.
  static const Cubic breathCurve = Cubic(0.4, 0.0, 0.2, 1);
}
