import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Mark of excellence: geometric order emerging from quiet structure (no portrait).
class IntellectualMarkGraphic extends StatefulWidget {
  const IntellectualMarkGraphic({super.key, this.size = 220});

  final double size;

  @override
  State<IntellectualMarkGraphic> createState() => _IntellectualMarkGraphicState();
}

class _IntellectualMarkGraphicState extends State<IntellectualMarkGraphic>
    with SingleTickerProviderStateMixin {
  late final AnimationController _drift = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 22),
  )..repeat();

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _drift,
          builder: (context, _) {
            return CustomPaint(
              painter: _ConstellationBlueprintPainter(phase: _drift.value),
            );
          },
        ),
      ),
    );
  }
}

class _ConstellationBlueprintPainter extends CustomPainter {
  _ConstellationBlueprintPainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.42;
    final pulse = 0.55 + 0.45 * math.sin(phase * math.pi * 2);

    final grid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.22 * pulse)
      ..strokeWidth = 1;
    const step = 22.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Golden-ratio nodes on a ring + center (order within radial field).
    final nodes = <Offset>[
      Offset(cx, cy),
      for (var i = 0; i < 6; i++)
        Offset(
          cx + r * 0.72 * math.cos(i * math.pi / 3 + phase * 0.35),
          cy + r * 0.72 * math.sin(i * math.pi / 3 + phase * 0.35),
        ),
      Offset(
        cx + r * 0.38 * math.cos(phase * math.pi * 2),
        cy - r * 0.42 * math.sin(phase * math.pi * 2),
      ),
    ];

    final edge = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.14 * pulse)
      ..strokeWidth = 1.2;
    for (var i = 1; i < nodes.length; i++) {
      canvas.drawLine(nodes[0], nodes[i], edge);
    }
    for (var i = 1; i < nodes.length - 1; i++) {
      canvas.drawLine(nodes[i], nodes[i + 1], edge);
    }

    final nodePaint = Paint()..color = AppColors.textPrimary.withValues(alpha: 0.35 + 0.12 * pulse);
    for (final n in nodes) {
      canvas.drawCircle(n, n == nodes[0] ? 5 : 3.2, nodePaint);
    }

    final ring = Paint()
      ..color = AppColors.humanWarm.withValues(alpha: 0.08 * pulse)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(Offset(cx, cy), r * 0.88, ring);
  }

  @override
  bool shouldRepaint(covariant _ConstellationBlueprintPainter oldDelegate) =>
      oldDelegate.phase != phase;
}
