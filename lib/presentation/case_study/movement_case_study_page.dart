import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/locale/locale_scope.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/poetic_harmony.dart';
import '../../data/project_catalog.dart';
import '../../domain/models/project_model.dart';
import '../widgets/project_lead_media.dart';
import 'case_study_hero_tags.dart';
import 'case_study_layout.dart';
import 'widgets/logic_art_companion.dart';
import 'widgets/movement_metrics_dashboard.dart';

/// Deep-dive case study: Movement System / نظام الحركة.
class MovementCaseStudyPage extends StatefulWidget {
  const MovementCaseStudyPage({super.key});

  @override
  State<MovementCaseStudyPage> createState() => _MovementCaseStudyPageState();
}

class _MovementCaseStudyPageState extends State<MovementCaseStudyPage> {
  bool _artAura = false;
  Alignment _glowAlign = const Alignment(0, -0.55);

  ProjectModel get _project =>
      kFeaturedProjects.firstWhere((p) => p.id == 'movement');

  void _onHover(PointerHoverEvent e) {
    final size = MediaQuery.sizeOf(context);
    if (size.width <= 0 || size.height <= 0) return;
    setState(() {
      final nx = ((e.localPosition.dx / size.width) * 2 - 1).clamp(-0.92, 0.92).toDouble();
      final ny = ((e.localPosition.dy / size.height) * 2 - 1).clamp(-0.92, 0.92).toDouble();
      _glowAlign = Alignment(nx, ny);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleScope.of(context).isArabic;
    final p = _project;

    final pageTitle = isArabic
        ? 'نظام الحركة — دراسة حالة'
        : 'Movement System — Case Study';

    final subtitle = isArabic
        ? 'نسق تدفق الأصول فوق تضاريس منفصلة — دون أن يذوب التسلسل.'
        : 'Orchestrating asset flow across disconnected landscapes—sequence intact.';

    return CaseStudyLayout(
      title: pageTitle,
      subtitle: subtitle,
      onBackToPortfolio: () => Navigator.of(context).maybePop(),
      artAura: _artAura,
      poetryGlowAlignment: _glowAlign,
      onAtmosphericMotion: _onHover,
      companionControl: LogicArtCompanion(
        isArabic: isArabic,
        artAura: _artAura,
        onChanged: (v) => setState(() => _artAura = v),
      ),
      leadMedia: ProjectLeadMedia(
        project: p,
        isArabic: isArabic,
        tall: true,
        heroTag: CaseStudyHeroTags.projectLeadImage(p.id),
      ),
      sections: [
        MovementMetricsDashboard(isArabic: isArabic),
        _RemoteEnvironmentSection(isArabic: isArabic),
        _LogicalGordianSection(isArabic: isArabic),
        _OfflineFirstEngineSection(isArabic: isArabic),
      ],
    );
  }
}

class _RemoteEnvironmentSection extends StatelessWidget {
  const _RemoteEnvironmentSection({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? 'صمت الشبكة' : 'Network silence';
    final body = isArabic
        ? 'حافظ على الأوامر والختم والآلة متوافقة عندما يختفي الحبل.'
        : 'Hold orders, seals, and machine truth coherent when the cord vanishes.';

    return _NarrativeSectionCard(
      title: title,
      body: body,
      child: _DisconnectedNodesGraphic(isArabic: isArabic),
    );
  }
}

class _DisconnectedNodesGraphic extends StatelessWidget {
  const _DisconnectedNodesGraphic({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PoeticHarmony.gs(8)),
        child: CustomPaint(
          painter: _DisconnectedNodesPainter(isArabic: isArabic),
        ),
      ),
    );
  }
}

class _DisconnectedNodesPainter extends CustomPainter {
  _DisconnectedNodesPainter({required this.isArabic});

  final bool isArabic;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = AppColors.surface.withValues(alpha: 0.9);
    final r = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(PoeticHarmony.gs(8)),
    );
    canvas.drawRRect(r, bg);

    final grid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.35)
      ..strokeWidth = 1;
    final step = PoeticHarmony.gs(17);
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    void node(Offset c, Color fill, {bool ring = false}) {
      if (ring) {
        canvas.drawCircle(c, 14, Paint()..color = const Color(0xFFEF4444));
        canvas.drawCircle(c, 10, Paint()..color = AppColors.surfaceElevated);
      } else {
        canvas.drawCircle(c, 10, Paint()..color = fill);
      }
    }

    final hq = Offset(size.width * 0.18, size.height * 0.45);
    node(hq, AppColors.accent);

    final n1 = Offset(size.width * 0.42, size.height * 0.28);
    final n2 = Offset(size.width * 0.55, size.height * 0.62);
    final n3 = Offset(size.width * 0.78, size.height * 0.38);
    node(n1, AppColors.textSecondary, ring: true);
    node(n2, AppColors.textSecondary, ring: true);
    node(n3, AppColors.textSecondary, ring: true);

    final solid = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.55)
      ..strokeWidth = 2.2;
    final dashed = Paint()
      ..color = AppColors.textSecondary.withValues(alpha: 0.45)
      ..strokeWidth = 1.6;

    void drawDashed(Offset a, Offset b) {
      const dash = 6.0;
      final d = b - a;
      final len = d.distance;
      final dir = d / len;
      for (double t = 0; t < len; t += dash * 2) {
        final p0 = a + dir * t;
        final p1 = a + dir * (t + dash).clamp(0, len);
        canvas.drawLine(p0, p1, dashed);
      }
    }

    canvas.drawLine(hq, n1, solid);
    drawDashed(n1, n2);
    drawDashed(n2, n3);

    final legend = isArabic ? 'عُقد منفصلة · ربط المقر' : 'Disconnected nodes · HQ uplink';
    final label = TextPainter(
      text: TextSpan(
        text: legend,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    )..layout(maxWidth: size.width - 24);
    label.paint(canvas, Offset(14, size.height - label.height - 10));
  }

  @override
  bool shouldRepaint(covariant _DisconnectedNodesPainter oldDelegate) =>
      oldDelegate.isArabic != isArabic;
}

class _LogicalGordianSection extends StatelessWidget {
  const _LogicalGordianSection({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? 'عقدة التحويل' : 'Transfer knot';
    final body = isArabic
        ? 'انقل الأصل بين دفاتر متفرقة — نافذة واحدة، تسلسل واحد، صفر تناقض.'
        : 'Orchestrate asset flow across disconnected ledgers—one window, one sequence, zero contradiction.';

    return _NarrativeSectionCard(
      title: title,
      body: body,
      child: const _CrossProjectFlowDiagram(),
    );
  }
}

class _CrossProjectFlowDiagram extends StatelessWidget {
  const _CrossProjectFlowDiagram();

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleScope.of(context).isArabic;
    final dir = isArabic ? TextDirection.rtl : TextDirection.ltr;

    Widget box(String label, Color accent) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.all(PoeticHarmony.gs(9)),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(PoeticHarmony.gs(9)),
            border: Border.all(color: accent.withValues(alpha: 0.55)),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: dir,
      child: Column(
        children: [
          Row(
            children: [
              box('Project A', const Color(0xFF38BDF8)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PoeticHarmony.gs(5)),
                child: Icon(
                  Icons.arrow_right_alt_outlined,
                  color: AppColors.textSecondary.withValues(alpha: 0.9),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: PoeticHarmony.gs(11),
                    horizontal: PoeticHarmony.gs(6),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(PoeticHarmony.gs(9)),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.humanCyan.withValues(alpha: 0.06),
                        blurRadius: PoeticHarmony.gs(14),
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_tree_outlined,
                        color: AppColors.accent.withValues(alpha: 0.95),
                        size: PoeticHarmony.gs(22),
                      ),
                      SizedBox(height: PoeticHarmony.gs(6)),
                      Text(
                        isArabic ? 'نقل مؤقت' : 'Temporary transfer',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(height: PoeticHarmony.gs(3)),
                      Text(
                        isArabic ? 'بوابة التحقق' : 'Verification gate',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PoeticHarmony.gs(5)),
                child: Icon(
                  Icons.arrow_right_alt_outlined,
                  color: AppColors.textSecondary.withValues(alpha: 0.9),
                ),
              ),
              box('Project B', const Color(0xFFA78BFA)),
            ],
          ),
          SizedBox(height: PoeticHarmony.gs(10)),
          Text(
            isArabic
                ? 'ختم إصدار، متجه حالة، توقيع نقل — ثلاثي غير قابل للاجتزاء.'
                : 'Version seal, state vector, transfer signature—non-bypassable triad.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
          ),
        ],
      ),
    );
  }
}

class _OfflineFirstEngineSection extends StatelessWidget {
  const _OfflineFirstEngineSection({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _NarrativeSectionCard(
      title: isArabic ? 'محرك الأوفلاين' : 'Offline-first engine',
      body: isArabic
          ? 'طابق الزمان والمكان مع دفتر الأستاذ. ارفض الانحراف قبل أن يلامس التكلفة.'
          : 'Pair spacetime with ledger. Reject drift before it touches cost.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.offline_bolt_outlined, color: AppColors.accent, size: PoeticHarmony.gs(20)),
              SizedBox(width: PoeticHarmony.gs(6)),
              Expanded(
                child: Text(
                  isArabic ? 'مزامنة معتمدة على الخيط الزمني للآلة' : 'Sync gated on machine timeline',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: PoeticHarmony.gs(12)),
          _AlgorithmLadder(isArabic: isArabic),
        ],
      ),
    );
  }
}

class _AlgorithmLadder extends StatelessWidget {
  const _AlgorithmLadder({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final steps = isArabic
        ? [
            'التقاط محلي + إثبات الجهاز',
            'مطابقة التسلسل مع آخر حالة معتمدة',
            'دمج آمن أو رفض موثّق',
          ]
        : [
            'Local capture + device proof',
            'Match sequence to last certified state',
            'Merge cleanly—or reject with audit trail',
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          if (i > 0) SizedBox(height: PoeticHarmony.gs(8)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.horizontal_rule_outlined, size: 18, color: AppColors.accent.withValues(alpha: 0.85)),
              SizedBox(width: PoeticHarmony.gs(6)),
              Expanded(
                child: Text(
                  steps[i],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.45,
                      ),
                ),
              ),
            ],
          ),
        ],
        SizedBox(height: PoeticHarmony.gs(10)),
        Text(
          isArabic ? 'مقعد اختبار: بذرة + إعادة تشغيل عند الذوبان.' : 'Bench harness: seed + replay on thaw.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
                fontStyle: FontStyle.italic,
              ),
        ),
      ],
    );
  }
}

class _NarrativeSectionCard extends StatelessWidget {
  const _NarrativeSectionCard({
    required this.title,
    required this.body,
    required this.child,
  });

  final String title;
  final String body;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PoeticHarmony.gs(12)),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.55),
              blurRadius: PoeticHarmony.gs(18),
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: AppColors.humanWarm.withValues(alpha: 0.05),
              blurRadius: PoeticHarmony.gs(28),
              spreadRadius: -PoeticHarmony.gs(4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(PoeticHarmony.gs(12)),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated.withValues(alpha: 0.88),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.surfaceElevated,
                  AppColors.surfaceElevated.withValues(alpha: 0.92),
                  AppColors.humanCyan.withValues(alpha: 0.04),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(PoeticHarmony.gs(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  SizedBox(height: PoeticHarmony.gs(8)),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.55,
                        ),
                  ),
                  SizedBox(height: PoeticHarmony.gs(14)),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
