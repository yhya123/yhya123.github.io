import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/localization/app_strings.dart';

/// **Content Tip:** This section sells *how you think*. Use crisp verbs, avoid
/// abstract adjectives. Keep lead paragraph **≤ 260 chars** per language so the
/// diagram stays above the fold on 1366×768.
class PhilosophySection extends StatelessWidget {
  const PhilosophySection({super.key, required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.t(isArabic: isArabic, key: 'philosophy_title'),
          textAlign: TextAlign.center,
          style: title,
        ),
        const SizedBox(height: 14),
        Text(
          AppStrings.t(isArabic: isArabic, key: 'philosophy_lead'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
        ),
        const SizedBox(height: 40),
        LayoutBuilder(
          builder: (context, c) {
            if (c.maxWidth < 720) {
              return Column(
                children: [
                  _StepCard(
                    index: 1,
                    title: AppStrings.t(isArabic: isArabic, key: 'philosophy_step1_title'),
                    body: AppStrings.t(isArabic: isArabic, key: 'philosophy_step1_body'),
                    icon: Icons.manage_search_rounded,
                  ),
                  const SizedBox(height: 16),
                  _StepCard(
                    index: 2,
                    title: AppStrings.t(isArabic: isArabic, key: 'philosophy_step2_title'),
                    body: AppStrings.t(isArabic: isArabic, key: 'philosophy_step2_body'),
                    icon: Icons.architecture_rounded,
                  ),
                  const SizedBox(height: 16),
                  _StepCard(
                    index: 3,
                    title: AppStrings.t(isArabic: isArabic, key: 'philosophy_step3_title'),
                    body: AppStrings.t(isArabic: isArabic, key: 'philosophy_step3_body'),
                    icon: Icons.fact_check_rounded,
                  ),
                ],
              );
            }
            return CustomPaint(
              painter: _PipelinePainter(isRtl: isArabic),
              child: Row(
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _StepCard(
                      index: 1,
                      title: AppStrings.t(isArabic: isArabic, key: 'philosophy_step1_title'),
                      body: AppStrings.t(isArabic: isArabic, key: 'philosophy_step1_body'),
                      icon: Icons.manage_search_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StepCard(
                      index: 2,
                      title: AppStrings.t(isArabic: isArabic, key: 'philosophy_step2_title'),
                      body: AppStrings.t(isArabic: isArabic, key: 'philosophy_step2_body'),
                      icon: Icons.architecture_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StepCard(
                      index: 3,
                      title: AppStrings.t(isArabic: isArabic, key: 'philosophy_step3_title'),
                      body: AppStrings.t(isArabic: isArabic, key: 'philosophy_step3_body'),
                      icon: Icons.fact_check_rounded,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.index,
    required this.title,
    required this.body,
    required this.icon,
  });

  final int index;
  final String title;
  final String body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(icon, color: AppColors.accent, size: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  '0$index',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Subtle “systems diagram” line across the three cards (desktop).
class _PipelinePainter extends CustomPainter {
  _PipelinePainter({required this.isRtl});

  final bool isRtl;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final y = 28.0;
    final startX = isRtl ? size.width * 0.88 : size.width * 0.12;
    final endX = isRtl ? size.width * 0.12 : size.width * 0.88;

    final path = Path()
      ..moveTo(startX, y)
      ..quadraticBezierTo(size.width / 2, y - 18, endX, y);
    canvas.drawPath(path, paint);

    for (final x in [size.width * 0.2, size.width * 0.5, size.width * 0.8]) {
      canvas.drawCircle(Offset(x, y), 5, Paint()..color = AppColors.accent);
    }
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter oldDelegate) =>
      oldDelegate.isRtl != isRtl;
}
