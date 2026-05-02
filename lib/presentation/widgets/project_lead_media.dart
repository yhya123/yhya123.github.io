import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/models/project_model.dart';
import 'content_placeholder.dart';

/// Lead image / placeholder for gallery tiles and case-study headers.
/// When [heroTag] is set (e.g. [CaseStudyHeroTags.projectLeadImage] for Movement),
/// wraps the raster in a [Hero] flight shell ([Material] + clip).
class ProjectLeadMedia extends StatelessWidget {
  const ProjectLeadMedia({
    super.key,
    required this.project,
    required this.isArabic,
    this.tall = true,
    this.heroTag,
  });

  final ProjectModel project;
  final bool isArabic;
  final bool tall;

  /// If non-null, this widget participates in a hero transition.
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final path = project.imageAsset;
    final placeholder = ContentPlaceholder(
      aspectRatio: tall ? 16 / 10 : 16 / 9,
      label: _placeholderCopy(project.id, isArabic),
      icon: Icons.dashboard_customize_outlined,
    );

    final Widget base = path == null
        ? placeholder
        : Image.asset(
            path,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            filterQuality: FilterQuality.medium,
            errorBuilder: (context, error, stackTrace) => placeholder,
          );

    Widget layered = ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: base),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.12),
                    ],
                    stops: const [0.52, 1],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: tall ? 64 : 48,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.0),
                        AppColors.surface.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (heroTag != null) {
      layered = Hero(
        tag: heroTag!,
        child: Material(
          color: AppColors.surfaceElevated,
          child: layered,
        ),
      );
    }

    return layered;
  }

  String _placeholderCopy(String id, bool ar) {
    switch (id) {
      case 'movement':
        return ar
            ? 'TODO: لقطة 16:10 لخريطة الأساطيل + مؤشرات الأداء توضح التعقيد التشغيلي.'
            : 'TODO: 16:10 fleet map + KPI dashboard screenshot (proves operational depth).';
      case 'click':
        return ar
            ? 'TODO: لقطة تطبيق 9:16 لمسار الدفع/التتبع لرفع الثقة لدى العملاء.'
            : 'TODO: 9:16 mobile frame of checkout/live tracking (trust + conversion).';
      default:
        return ar
            ? 'TODO: لقطة منتج عالية الدقة للمشروع الجديد.'
            : 'TODO: crisp product screenshot for this case study.';
    }
  }
}
