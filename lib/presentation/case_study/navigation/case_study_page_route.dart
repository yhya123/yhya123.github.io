import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/poetic_harmony.dart';

/// Smooth entry for case-study pages (fade + slight horizontal slide).
class CaseStudyPageRoute<T> extends PageRouteBuilder<T> {
  CaseStudyPageRoute({required WidgetBuilder pageBuilder})
    : super(
        opaque: true,
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
            pageBuilder(context),
        transitionDuration: const Duration(milliseconds: 460),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: PoeticHarmony.breathCurve,
            reverseCurve: PoeticHarmony.breathCurve,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.028, 0),
                end: Offset.zero,
              ).animate(curved),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.humanWarm.withValues(alpha: 0.08 * curved.value),
                      blurRadius: 56,
                      spreadRadius: 8,
                    ),
                    BoxShadow(
                      color: AppColors.humanCyan.withValues(alpha: 0.06 * curved.value),
                      blurRadius: 72,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          );
        },
      );
}
