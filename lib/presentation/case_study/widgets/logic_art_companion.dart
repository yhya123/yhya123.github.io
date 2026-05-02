import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/poetic_harmony.dart';

/// Minimal dual-state control: meter (logic) vs breath (art). Symbolic, not decorative noise.
class LogicArtCompanion extends StatelessWidget {
  const LogicArtCompanion({
    super.key,
    required this.isArabic,
    required this.artAura,
    required this.onChanged,
  });

  final bool isArabic;
  final bool artAura;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final logic = isArabic ? 'منطق' : 'Logic';
    final art = isArabic ? 'إحساس' : 'Art';

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: PoeticHarmony.gs(12),
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Seg(
              label: logic,
              selected: !artAura,
              onTap: () => onChanged(false),
            ),
            _Seg(
              label: art,
              selected: artAura,
              onTap: () => onChanged(true),
            ),
          ],
        ),
      ),
    );
  }
}

class _Seg extends StatelessWidget {
  const _Seg({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.accent.withValues(alpha: 0.14)
          : AppColors.surfaceElevated.withValues(alpha: 0.4),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: PoeticHarmony.gs(10),
            vertical: 8,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                ),
          ),
        ),
      ),
    );
  }
}
