import 'package:flutter/material.dart';

/// App-wide locale + toggle so pushed routes (case studies) rebuild with [isArabic].
class LocaleScope extends InheritedWidget {
  const LocaleScope({
    super.key,
    required this.isArabic,
    required this.onToggleLanguage,
    required super.child,
  });

  final bool isArabic;
  final VoidCallback onToggleLanguage;

  static LocaleScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LocaleScope>();
    assert(scope != null, 'LocaleScope not found above this context');
    return scope!;
  }

  @override
  bool updateShouldNotify(LocaleScope oldWidget) {
    return oldWidget.isArabic != isArabic ||
        oldWidget.onToggleLanguage != onToggleLanguage;
  }
}
