import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/localization/app_strings.dart';

enum PortfolioSection { work, method, stack, contact }

class PortfolioTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PortfolioTopBar({
    super.key,
    required this.isArabic,
    required this.onToggleLanguage,
    required this.onNavigate,
    required this.scrollPixels,
  });

  final bool isArabic;
  final VoidCallback onToggleLanguage;
  final void Function(PortfolioSection section) onNavigate;
  final double scrollPixels;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final solid = scrollPixels > 12;
    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        );

    // Content Tip: keep the bar label under ~28 EN chars so it never collides with nav on 1024px.
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: solid ? 14 : 6, sigmaY: solid ? 14 : 6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: solid
                ? AppColors.surface.withValues(alpha: 0.92)
                : AppColors.background.withValues(alpha: 0.35),
            border: Border(
              bottom: BorderSide(
                color: solid ? AppColors.border : Colors.transparent,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, c) {
                final narrow = c.maxWidth < 900;
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.t(isArabic: isArabic, key: 'brand_name'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle,
                      ),
                    ),
                    if (!narrow) ...[
                      _link(context, 'nav_work', PortfolioSection.work),
                      _link(context, 'nav_method', PortfolioSection.method),
                      _link(context, 'nav_stack', PortfolioSection.stack),
                      _link(context, 'nav_contact', PortfolioSection.contact),
                      const SizedBox(width: 8),
                    ] else ...[
                      PopupMenuButton<PortfolioSection>(
                        tooltip: AppStrings.t(isArabic: isArabic, key: 'nav_work'),
                        icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
                        onSelected: onNavigate,
                        itemBuilder: (ctx) => [
                          _menuItem(ctx, 'nav_work', PortfolioSection.work),
                          _menuItem(ctx, 'nav_method', PortfolioSection.method),
                          _menuItem(ctx, 'nav_stack', PortfolioSection.stack),
                          _menuItem(ctx, 'nav_contact', PortfolioSection.contact),
                        ],
                      ),
                    ],
                    TextButton.icon(
                      onPressed: onToggleLanguage,
                      icon: const Icon(Icons.language, size: 20, color: AppColors.accent),
                      label: Text(
                        AppStrings.t(isArabic: isArabic, key: 'lang_toggle'),
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _link(BuildContext context, String key, PortfolioSection section) {
    return TextButton(
      onPressed: () => onNavigate(section),
      child: Text(
        AppStrings.t(isArabic: isArabic, key: key),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  PopupMenuEntry<PortfolioSection> _menuItem(
    BuildContext context,
    String key,
    PortfolioSection section,
  ) {
    return PopupMenuItem(
      value: section,
      child: Text(AppStrings.t(isArabic: isArabic, key: key)),
    );
  }
}
