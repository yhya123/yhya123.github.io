import 'package:flutter/material.dart';

import '../../core/theme/poetic_harmony.dart';

/// Scroll-driven section reveal (no extra timers — stable on Flutter Web + tests).
///
/// Content Tip: keep reveal motion subtle (≤24px travel, ≤700ms) so it feels
/// premium—not “marketing flashy.”
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.scrollController,
    required this.child,
    this.fraction = 0.12,
  });

  final ScrollController scrollController;
  final Widget child;
  final double fraction;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 640),
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: PoeticHarmony.breathCurve,
  );

  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.05),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: PoeticHarmony.breathCurve));

  bool _done = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_evaluate);
    WidgetsBinding.instance.addPostFrameCallback((_) => _evaluate());
  }

  @override
  void didUpdateWidget(covariant ScrollReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_evaluate);
      widget.scrollController.addListener(_evaluate);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_evaluate);
    _controller.dispose();
    super.dispose();
  }

  void _evaluate() {
    if (!mounted || _done) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize || !box.attached) return;

    final media = MediaQuery.of(context);
    final viewTop = media.padding.top;
    final viewBottom = media.size.height;

    final topLeft = box.localToGlobal(Offset.zero);
    final bottomRight = topLeft.translate(box.size.width, box.size.height);

    final overlapTop = topLeft.dy.clamp(viewTop, viewBottom);
    final overlapBottom = bottomRight.dy.clamp(viewTop, viewBottom);
    final visibleHeight = (overlapBottom - overlapTop).clamp(0.0, box.size.height);
    final visibleFraction = box.size.height == 0 ? 0.0 : visibleHeight / box.size.height;

    if (visibleFraction >= widget.fraction) {
      _done = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
