import 'package:flutter/material.dart';

import '../../core/locale/locale_scope.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/poetic_harmony.dart';
import '../case_study/navigation/open_case_study.dart';
import '../sections/contact_section.dart';
import '../sections/hero_section.dart';
import '../sections/philosophy_section.dart';
import '../sections/projects_section.dart';
import '../sections/tech_stack_section.dart';
import '../widgets/portfolio_top_bar.dart';
import '../widgets/scroll_reveal.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollPixels = ValueNotifier<double>(0);

  late final Map<PortfolioSection, GlobalKey> _sectionKeys = {
    for (final s in PortfolioSection.values) s: GlobalKey(debugLabel: s.name),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final px = _scrollController.hasClients ? _scrollController.offset : 0.0;
      if (_scrollPixels.value != px) {
        _scrollPixels.value = px;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollPixels.dispose();
    super.dispose();
  }

  Future<void> _scrollTo(PortfolioSection section) async {
    final ctx = _sectionKeys[section]?.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 560),
      curve: PoeticHarmony.breathCurve,
      alignment: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = LocaleScope.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ValueListenableBuilder<double>(
          valueListenable: _scrollPixels,
          builder: (context, offset, _) {
            return PortfolioTopBar(
              isArabic: locale.isArabic,
              onToggleLanguage: locale.onToggleLanguage,
              onNavigate: (s) => _scrollTo(s),
              scrollPixels: offset,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(
              isArabic: locale.isArabic,
              onScrollToWork: () => _scrollTo(PortfolioSection.work),
            ),
            _sectionShell(
              key: _sectionKeys[PortfolioSection.work]!,
              child: ScrollReveal(
                scrollController: _scrollController,
                child: ProjectsSection(
                  isArabic: locale.isArabic,
                  onProjectTap: (project) => openProjectCaseStudy(context, project),
                ),
              ),
            ),
            _sectionShell(
              key: _sectionKeys[PortfolioSection.method]!,
              child: ScrollReveal(
                scrollController: _scrollController,
                child: PhilosophySection(isArabic: locale.isArabic),
              ),
            ),
            _sectionShell(
              key: _sectionKeys[PortfolioSection.stack]!,
              child: ScrollReveal(
                scrollController: _scrollController,
                child: TechStackSection(isArabic: locale.isArabic),
              ),
            ),
            _sectionShell(
              key: _sectionKeys[PortfolioSection.contact]!,
              child: ScrollReveal(
                scrollController: _scrollController,
                child: ContactSection(isArabic: locale.isArabic),
              ),
            ),
            const _FooterStrip(),
          ],
        ),
      ),
    );
  }

  Widget _sectionShell({required Key key, required Widget child}) {
    return KeyedSubtree(
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PoeticHarmony.gs(12),
          vertical: PoeticHarmony.gs(35),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _FooterStrip extends StatelessWidget {
  const _FooterStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
        color: Color(0xFF070A0F),
      ),
      child: Center(
        child: Text(
          '© 2026 · Built with Flutter Web · '
          'TODO: add privacy policy link if you run analytics.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ),
    );
  }
}
