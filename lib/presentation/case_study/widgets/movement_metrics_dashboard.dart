import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/poetic_harmony.dart';

/// Experimental telemetry anchor — dummy bench values (Movement System).
class MovementMetricsDashboard extends StatelessWidget {
  const MovementMetricsDashboard({super.key, required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final tiles = <_MetricTile>[
      _MetricTile(
        icon: Icons.shield_outlined,
        label: isArabic ? 'تشغيل النظام' : 'System uptime',
        value: '99.98%',
        caption: isArabic ? 'ثبات في المناطق البعيدة' : 'Reliability in remote zones',
      ),
      _MetricTile(
        icon: Icons.merge_type_outlined,
        label: isArabic ? 'تعارض المزامنة' : 'Sync conflict rate',
        value: '< 0.01%',
        caption: isArabic ? 'دقة رياضية في المنطق' : 'Mathematical precision in logic',
      ),
      _MetricTile(
        icon: Icons.speed_outlined,
        label: isArabic ? 'عبء المعالجة' : 'Processing overhead',
        value: isArabic ? 'تخفيض ٤٥٪' : 'Reduced 45%',
        caption: isArabic ? 'أداء أنيق' : 'Performance elegance',
      ),
      _MetricTile(
        icon: Icons.verified_outlined,
        label: isArabic ? 'سلامة البيانات' : 'Data integrity',
        value: '100%',
        caption: isArabic ? 'تحقق زماني-مكاني' : 'Spatio-temporal validation',
      ),
      _MetricTile(
        icon: Icons.eco_outlined,
        label: isArabic ? 'تحسين الموارد' : 'Resource optimization',
        value: isArabic ? '+٣٥٪' : '+35%',
        caption: isArabic ? 'استخدام أهدأ للبنية التحتية' : 'Leaner footprint on the same stack',
      ),
      _MetricTile(
        icon: Icons.account_tree_outlined,
        label: isArabic ? 'قابلية التوسع المعمارية' : 'Architectural scalability',
        value: '10×',
        caption: isArabic ? 'مسار نمو دون إعادة بناء جذرية' : 'Room to grow without a ground-up rewrite',
      ),
      _MetricTile(
        icon: Icons.touch_app_outlined,
        label: isArabic ? 'احتكاك المستخدم' : 'User friction',
        value: isArabic ? '~صفر' : 'Near-zero',
        caption: isArabic ? 'مسارات مختصرة، أخطاء نادرة' : 'Fewer steps, fewer dead ends',
      ),
    ];

    return LayoutBuilder(
      builder: (context, c) {
        final narrow = c.maxWidth < 640;
        if (narrow) {
          return Column(
            children: [
              for (var i = 0; i < tiles.length; i++) ...[
                if (i > 0) SizedBox(height: PoeticHarmony.gs(9)),
                SizedBox(height: 132, child: tiles[i]),
              ],
            ],
          );
        }
        final cols = c.maxWidth >= 960 ? 3 : 2;
        final ratio = cols == 3 ? 1.78 : 2.05;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: cols,
          mainAxisSpacing: PoeticHarmony.gs(10),
          crossAxisSpacing: PoeticHarmony.gs(10),
          childAspectRatio: ratio,
          children: tiles,
        );
      },
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.caption,
  });

  final IconData icon;
  final String label;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PoeticHarmony.gs(12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PoeticHarmony.gs(11)),
        color: AppColors.surfaceElevated.withValues(alpha: 0.72),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: PoeticHarmony.gs(14),
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.humanWarm.withValues(alpha: 0.04),
            blurRadius: PoeticHarmony.gs(20),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: AppColors.accent.withValues(alpha: 0.9)),
          SizedBox(height: PoeticHarmony.gs(8)),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
          ),
          SizedBox(height: PoeticHarmony.gs(4)),
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: PoeticHarmony.gs(6)),
          Text(
            caption,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }
}
