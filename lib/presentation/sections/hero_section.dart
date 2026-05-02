import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive/breakpoints.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/poetic_harmony.dart';
import '../../domain/localization/app_strings.dart';
import '../widgets/intellectual_mark_graphic.dart';

/// Intellectual presence: geometry, metered motion, whispered literature—no portrait.
class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.isArabic,
    required this.onScrollToWork,
  });

  final bool isArabic;
  final VoidCallback onScrollToWork;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  );

  /// Normalized pointer bias for parallax (−1…1).
  Offset _parallax = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerHover(PointerHoverEvent e) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final local = box.globalToLocal(e.position);
    final w = box.size.width;
    final h = box.size.height;
    if (w <= 0 || h <= 0) return;
    setState(() {
      _parallax = Offset(
        ((local.dx / w) * 2 - 1).clamp(-1.0, 1.0).toDouble(),
        ((local.dy / h) * 2 - 1).clamp(-1.0, 1.0).toDouble(),
      );
    });
  }

  Animation<double> _tween(double begin, double end) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: PoeticHarmony.breathCurve),
    );
  }

  Widget _fadeSlide({
    required double intervalBegin,
    required double intervalEnd,
    required Widget child,
    Offset slideBegin = const Offset(0, 0.045),
  }) {
    final anim = _tween(intervalBegin, intervalEnd);
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(begin: slideBegin, end: Offset.zero).animate(anim),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = widget.isArabic;
    final w = MediaQuery.sizeOf(context).width;
    final pad = w >= AppBreakpoints.desktop ? 64.0 : 24.0;
    final headline = Theme.of(context).textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w700,
          height: 1.08,
          letterSpacing: isArabic ? 0 : -0.6,
        );

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerHover: _onPointerHover,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF070B10),
              Color(0xFF0B1220),
              Color(0xFF0E1A2A),
            ],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: isArabic ? null : -80,
              left: isArabic ? -80 : null,
              top: -40,
              child: Transform.translate(
                offset: Offset(_parallax.dx * 18, _parallax.dy * 11.7),
                child: _GlowBlob(color: AppColors.accent.withValues(alpha: 0.2)),
              ),
            ),
            Positioned(
              left: isArabic ? null : -120,
              right: isArabic ? -120 : null,
              bottom: -80,
              child: Transform.translate(
                offset: Offset(_parallax.dx * 12, _parallax.dy * 7.8),
                child: _GlowBlob(color: AppColors.accentDim.withValues(alpha: 0.16)),
              ),
            ),
            Positioned(
              left: isArabic ? -100 : null,
              right: isArabic ? null : -100,
              top: 120,
              child: Transform.translate(
                offset: Offset(_parallax.dx * 10, _parallax.dy * 6.5),
                child: _GlowBlob(color: AppColors.humanWarm.withValues(alpha: 0.07)),
              ),
            ),
            Positioned(
              left: pad,
              right: pad,
              bottom: 20,
              child: IgnorePointer(
                child: _LiteraryGlassWhisper(isArabic: isArabic),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(pad, 48, pad, 72),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final stackVertical = c.maxWidth < 860;
                      final content = Column(
                        crossAxisAlignment: stackVertical
                            ? CrossAxisAlignment.center
                            : (isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start),
                        children: [
                          _fadeSlide(
                            intervalBegin: 0.0,
                            intervalEnd: 0.32,
                            slideBegin: const Offset(0, -0.04),
                            child: Text(
                              AppStrings.t(isArabic: isArabic, key: 'hero_kicker'),
                              textAlign: stackVertical
                                  ? TextAlign.center
                                  : (isArabic ? TextAlign.right : TextAlign.left),
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.accent,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _fadeSlide(
                            intervalBegin: 0.08,
                            intervalEnd: 0.45,
                            child: Text(
                              AppStrings.t(isArabic: isArabic, key: 'hero_headline'),
                              textAlign: stackVertical
                                  ? TextAlign.center
                                  : (isArabic ? TextAlign.right : TextAlign.left),
                              style: headline,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _fadeSlide(
                            intervalBegin: 0.14,
                            intervalEnd: 0.55,
                            child: Text(
                              AppStrings.t(isArabic: isArabic, key: 'hero_sub'),
                              textAlign: stackVertical
                                  ? TextAlign.center
                                  : (isArabic ? TextAlign.right : TextAlign.left),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.45,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          _fadeSlide(
                            intervalBegin: 0.22,
                            intervalEnd: 0.68,
                            child: Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                              alignment: stackVertical
                                  ? WrapAlignment.center
                                  : (isArabic ? WrapAlignment.end : WrapAlignment.start),
                              children: [
                                ElevatedButton(
                                  onPressed: () {/* TODO: mailto: or Calendly URL */},
                                  child: Text(AppStrings.t(isArabic: isArabic, key: 'hero_cta_primary')),
                                ),
                                OutlinedButton(
                                  onPressed: widget.onScrollToWork,
                                  child: Text(AppStrings.t(isArabic: isArabic, key: 'hero_cta_secondary')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );

                      final mark = _fadeSlide(
                        intervalBegin: 0.0,
                        intervalEnd: 0.4,
                        slideBegin: const Offset(0, 0.05),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.border.withValues(alpha: 0.65)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.45),
                                      blurRadius: 28,
                                      offset: const Offset(0, 18),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  fit: StackFit.passthrough,
                                  children: [
                                    Positioned.fill(
                                      child: ClipRRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  AppColors.surfaceElevated.withValues(alpha: 0.35),
                                                  AppColors.surface.withValues(alpha: 0.2),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(14),
                                      child: IntellectualMarkGraphic(size: 208),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              AppStrings.t(isArabic: isArabic, key: 'brand_name'),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.8,
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      );

                      if (stackVertical) {
                        return Column(
                          children: [
                            mark,
                            const SizedBox(height: 28),
                            content,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!isArabic) ...[
                            Expanded(flex: 5, child: mark),
                            const SizedBox(width: 36),
                          ],
                          Expanded(flex: 7, child: content),
                          if (isArabic) ...[
                            const SizedBox(width: 36),
                            Expanded(flex: 5, child: mark),
                          ],
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LiteraryGlassWhisper extends StatelessWidget {
  const _LiteraryGlassWhisper({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final quote = isArabic
        ? 'التفصيل ليس زينةً زائدة؛ إنه التصميم ذاته.'
        : 'The detail is not the detail. It is the design.';
    final attr = isArabic ? '— تشارلز إيمز' : '— Charles Eames';

    final base = Theme.of(context).brightness == Brightness.dark
        ? AppColors.textSecondary.withValues(alpha: 0.55)
        : AppColors.textSecondary;

    final style = isArabic
        ? GoogleFonts.cairo(
            fontSize: 13.5,
            height: 1.55,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: base,
            letterSpacing: 0.15,
          )
        : GoogleFonts.inter(
            fontSize: 13.5,
            height: 1.55,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: base,
            letterSpacing: 0.2,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.035),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: RichText(
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                text: TextSpan(
                  style: style,
                  children: [
                    TextSpan(text: quote),
                    TextSpan(
                      text: '\n$attr',
                      style: style.copyWith(
                        fontSize: 11.5,
                        color: base.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
