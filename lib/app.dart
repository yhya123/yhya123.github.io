import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/locale/locale_scope.dart';
import 'core/theme/app_theme.dart';
import 'domain/localization/app_strings.dart';
import 'presentation/pages/portfolio_page.dart';

/// Application root: theme, locale, and localization delegates.
class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  /// English is primary; Arabic toggles full RTL via [MaterialApp.locale].
  bool _isArabic = false;

  void _toggleLanguage() => setState(() => _isArabic = !_isArabic);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.t(isArabic: _isArabic, key: 'app_title'),
      theme: AppTheme.lightTech(_isArabic),
      locale: _isArabic ? const Locale('ar') : const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return LocaleScope(
          isArabic: _isArabic,
          onToggleLanguage: _toggleLanguage,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const PortfolioPage(),
    );
  }
}
