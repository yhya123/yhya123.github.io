import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/locale/locale_scope.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/poetic_harmony.dart';
import '../../domain/localization/app_strings.dart';

/// Shared shell for long-form case studies (Movement, Click, …).
///
/// Optional [companionControl] + [artAura] + [poetryGlowAlignment] add symbolic
/// atmosphere without changing core navigation.
class CaseStudyLayout extends StatelessWidget {
  const CaseStudyLayout({
    super.key,
    required this.title,
    this.subtitle,
    required this.leadMedia,
    required this.sections,
    required this.onBackToPortfolio,
    this.companionControl,
    this.artAura = false,
    this.poetryGlowAlignment = const Alignment(0, -0.55),
    this.onAtmosphericMotion,
  });

  final String title;
  final String? subtitle;
  final Widget leadMedia;
  final List<Widget> sections;
  final VoidCallback onBackToPortfolio;

  /// “Logic / Art” companion (Movement only today).
  final Widget? companionControl;

  /// Warms radial veil when true.
  final bool artAura;

  /// Radial gradient focal point (nudged by pointer motion).
  final Alignment poetryGlowAlignment;

  /// Hover drift for atmospheric depth.
  final void Function(PointerHoverEvent event)? onAtmosphericMotion;

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleScope.of(context).isArabic;
    final topPad = MediaQuery.paddingOf(context).top;
    final gapSm = PoeticHarmony.gs(8);
    final gapMd = PoeticHarmony.gs(13);

    Widget body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(PoeticHarmony.gs(10), topPad + gapSm, PoeticHarmony.gs(10), 0),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: _CaseStudyTopBar(
                  isArabic: isArabic,
                  onBack: onBackToPortfolio,
                  companion: companionControl,
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(PoeticHarmony.gs(10), gapSm, PoeticHarmony.gs(10), gapMd),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.12,
                          ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: gapSm),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                      ),
                    ],
                    SizedBox(height: gapMd),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(PoeticHarmony.gs(12)),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: leadMedia,
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(
                      duration: const Duration(milliseconds: 520),
                      curve: PoeticHarmony.breathCurve,
                    )
                    .slideY(
                      begin: 0.026,
                      duration: const Duration(milliseconds: 520),
                      curve: PoeticHarmony.breathCurve,
                    ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: PoeticHarmony.gs(10), vertical: gapSm),
          sliver: SliverList.separated(
            itemCount: sections.length,
            separatorBuilder: (context, _) => SizedBox(height: PoeticHarmony.gs(17)),
            itemBuilder: (context, index) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: sections[index]
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: (PoeticHarmony.phi * 42 * index).round()),
                        duration: const Duration(milliseconds: 560),
                        curve: PoeticHarmony.breathCurve,
                      )
                      .slideY(
                        begin: 0.028,
                        duration: const Duration(milliseconds: 560),
                        curve: PoeticHarmony.breathCurve,
                      ),
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: PoeticHarmony.gs(30))),
      ],
    );

    if (onAtmosphericMotion != null) {
      body = Listener(
        behavior: HitTestBehavior.translucent,
        onPointerHover: onAtmosphericMotion,
        child: body,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 900),
                curve: PoeticHarmony.breathCurve,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: poetryGlowAlignment,
                    radius: 1.15,
                    colors: [
                      (artAura ? AppColors.humanWarm : AppColors.humanCyan)
                          .withValues(alpha: artAura ? 0.085 : 0.045),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}

class _CaseStudyTopBar extends StatelessWidget {
  const _CaseStudyTopBar({
    required this.isArabic,
    required this.onBack,
    this.companion,
  });

  final bool isArabic;
  final VoidCallback onBack;
  final Widget? companion;

  @override
  Widget build(BuildContext context) {
    final scope = LocaleScope.of(context);
    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: onBack,
          icon: Icon(
            isArabic ? Icons.arrow_forward : Icons.arrow_back,
            size: 20,
          ),
          label: Text(
            AppStrings.t(isArabic: isArabic, key: 'case_study_back'),
          ),
        ),
        const Spacer(),
        if (companion != null) ...[
          companion!,
          SizedBox(width: PoeticHarmony.gs(8)),
        ],
        TextButton.icon(
          onPressed: scope.onToggleLanguage,
          icon: const Icon(Icons.language_outlined, size: 20, color: AppColors.accent),
          label: Text(
            AppStrings.t(isArabic: isArabic, key: 'lang_toggle'),
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 460),
          curve: PoeticHarmony.breathCurve,
        )
        .slideY(
          begin: -0.018,
          duration: const Duration(milliseconds: 460),
          curve: PoeticHarmony.breathCurve,
        );
  }
}
