import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/poetic_harmony.dart';
import '../../data/tech_stack_catalog.dart';
import '../../domain/localization/app_strings.dart';
import '../../domain/models/tech_stack_item.dart';

/// **Content Tip:** 3–6 tiles max. Each blurb **≤ 140 chars**; titles **≤ 22 chars**.
/// Logos (if you add Image assets later) should be **square SVG/PNG ~96–128px**.
class TechStackSection extends StatefulWidget {
  const TechStackSection({super.key, required this.isArabic});

  final bool isArabic;

  @override
  State<TechStackSection> createState() => _TechStackSectionState();
}

class _TechStackSectionState extends State<TechStackSection> {
  String? _activeId = kTechStack.first.id;

  @override
  Widget build(BuildContext context) {
    final active = kTechStack.firstWhere(
      (e) => e.id == _activeId,
      orElse: () => kTechStack.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.t(isArabic: widget.isArabic, key: 'stack_title'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.t(isArabic: widget.isArabic, key: 'stack_subtitle'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth >= 1000
                ? 4
                : c.maxWidth >= 700
                    ? 2
                    : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: kTechStack.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                mainAxisExtent: 132,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemBuilder: (context, index) {
                final item = kTechStack[index];
                final selected = item.id == _activeId;
                return _TechTile(
                  item: item,
                  isArabic: widget.isArabic,
                  selected: selected,
                  onTap: () => setState(() => _activeId = item.id),
                );
              },
            );
          },
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: PoeticHarmony.breathCurve,
          switchOutCurve: PoeticHarmony.breathCurve,
          child: KeyedSubtree(
            key: ValueKey(active.id),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
                color: AppColors.surfaceElevated,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(active.icon, color: AppColors.accent, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          active.name(widget.isArabic),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          active.blurb(widget.isArabic),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.45,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TechTile extends StatelessWidget {
  const _TechTile({
    required this.item,
    required this.isArabic,
    required this.selected,
    required this.onTap,
  });

  final TechStackItem item;
  final bool isArabic;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 220),
      curve: PoeticHarmony.breathCurve,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected ? AppColors.accent : AppColors.border,
                width: selected ? 1.6 : 1,
              ),
              color: selected
                  ? AppColors.accent.withValues(alpha: 0.08)
                  : AppColors.surfaceElevated,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(item.icon, color: AppColors.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.name(isArabic),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_circle, color: AppColors.accent, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
