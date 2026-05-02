import 'package:flutter/material.dart';

import '../../core/responsive/breakpoints.dart';
import '../../core/theme/app_colors.dart';
import '../../data/project_catalog.dart';
import '../../domain/localization/app_strings.dart';
import '../../domain/models/project_model.dart';
import '../case_study/case_study_hero_tags.dart';
import '../widgets/project_lead_media.dart';

/// **Content Tip:** Project titles on tiles: **28–40 chars**. Summaries: **120–180**.
/// Always show *one* measurable outcome (time saved, risk removed, scale supported).
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({
    super.key,
    required this.isArabic,
    this.onProjectTap,
  });

  final bool isArabic;
  final ValueChanged<ProjectModel>? onProjectTap;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late final PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.88);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final useBento = AppBreakpoints.useBentoGallery(w);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.t(isArabic: widget.isArabic, key: 'projects_title'),
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.t(isArabic: widget.isArabic, key: 'projects_subtitle'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 32),
        if (useBento)
          _BentoGallery(
            isArabic: widget.isArabic,
            onProjectTap: widget.onProjectTap,
          )
        else
          _CarouselGallery(
            isArabic: widget.isArabic,
            onProjectTap: widget.onProjectTap,
            controller: _pageController,
            page: _page,
            onPageChanged: (i) => setState(() => _page = i),
          ),
        if (kFeaturedProjects.length > 2) ...[
          const SizedBox(height: 24),
          _ExtraProjectsGrid(
            isArabic: widget.isArabic,
            onProjectTap: widget.onProjectTap,
            projects: kFeaturedProjects.sublist(2),
          ),
        ],
      ],
    );
  }
}

class _BentoGallery extends StatelessWidget {
  const _BentoGallery({
    required this.isArabic,
    this.onProjectTap,
  });

  final bool isArabic;
  final ValueChanged<ProjectModel>? onProjectTap;

  @override
  Widget build(BuildContext context) {
    if (kFeaturedProjects.isEmpty) {
      return const SizedBox.shrink();
    }
    if (kFeaturedProjects.length == 1) {
      final only = kFeaturedProjects.first;
      return SizedBox(
        height: 460,
        child: _ProjectFeatureCard(
          project: only,
          isArabic: isArabic,
          tall: true,
          onProjectTap: onProjectTap,
        ),
      );
    }

    final primary = kFeaturedProjects.firstWhere(
      (p) => p.highlight,
      orElse: () => kFeaturedProjects.first,
    );
    final secondary = kFeaturedProjects.firstWhere(
      (p) => p.id != primary.id,
      orElse: () => kFeaturedProjects[1],
    );

    return SizedBox(
      height: 460,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Expanded(
            flex: 58,
            child: _ProjectFeatureCard(
              project: primary,
              isArabic: isArabic,
              tall: true,
              onProjectTap: onProjectTap,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            flex: 42,
            child: Column(
              children: [
                Expanded(
                  child: _ProjectFeatureCard(
                    project: secondary,
                    isArabic: isArabic,
                    tall: false,
                    onProjectTap: onProjectTap,
                  ),
                ),
                const SizedBox(height: 16),
                const Expanded(child: _MoreWorkSlot()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CarouselGallery extends StatelessWidget {
  const _CarouselGallery({
    required this.isArabic,
    this.onProjectTap,
    required this.controller,
    required this.page,
    required this.onPageChanged,
  });

  final bool isArabic;
  final ValueChanged<ProjectModel>? onProjectTap;
  final PageController controller;
  final int page;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 420,
          child: PageView.builder(
            controller: controller,
            itemCount: kFeaturedProjects.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final project = kFeaturedProjects[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _ProjectFeatureCard(
                  project: project,
                  isArabic: isArabic,
                  tall: true,
                  onProjectTap: onProjectTap,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(kFeaturedProjects.length, (i) {
            final active = i == page;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: active ? AppColors.accent : AppColors.border,
                borderRadius: BorderRadius.circular(22),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ProjectFeatureCard extends StatelessWidget {
  const _ProjectFeatureCard({
    required this.project,
    required this.isArabic,
    required this.tall,
    this.onProjectTap,
  });

  final ProjectModel project;
  final bool isArabic;
  final bool tall;
  final ValueChanged<ProjectModel>? onProjectTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onProjectTap != null ? () => onProjectTap!(project) : null,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: tall ? 3 : 2,
                child: ProjectLeadMedia(
                  project: project,
                  isArabic: isArabic,
                  tall: tall,
                  heroTag: project.id == 'movement'
                      ? CaseStudyHeroTags.projectLeadImage(project.id)
                      : null,
                ),
              ),
              Expanded(
                flex: tall ? 2 : 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title(isArabic),
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.summary(isArabic),
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        maxLines: tall ? 4 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                      const Spacer(),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: isArabic
                            ? WrapAlignment.end
                            : WrapAlignment.start,
                        textDirection: isArabic
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        children: project
                            .tags(isArabic)
                            .map(
                              (t) => Chip(
                                label: Text(
                                  t,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                backgroundColor: project.accent.withValues(
                                  alpha: 0.12,
                                ),
                                side: BorderSide(
                                  color: project.accent.withValues(alpha: 0.35),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreWorkSlot extends StatelessWidget {
  const _MoreWorkSlot();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border, style: BorderStyle.solid),
        gradient: LinearGradient(
          colors: [
            AppColors.surfaceElevated,
            AppColors.accent.withValues(alpha: 0.06),
          ],
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Center(
        child: Text(
          // Keep this slot intentionally bilingual-neutral; swap to AppStrings if you localize it.
          'Next case study slot\n'
          'TODO: Add a third flagship project to [kFeaturedProjects] or replace with testimonial quote '
          '(max ~180 chars) + client logo row (SVG, ~120px wide each).',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _ExtraProjectsGrid extends StatelessWidget {
  const _ExtraProjectsGrid({
    required this.isArabic,
    required this.projects,
    this.onProjectTap,
  });

  final bool isArabic;
  final List<ProjectModel> projects;
  final ValueChanged<ProjectModel>? onProjectTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: projects
          .map(
            (p) => SizedBox(
              width: 320,
              child: _ProjectFeatureCard(
                project: p,
                isArabic: isArabic,
                tall: false,
                onProjectTap: onProjectTap,
              ),
            ),
          )
          .toList(),
    );
  }
}
