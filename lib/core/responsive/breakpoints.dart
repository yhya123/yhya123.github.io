/// Layout breakpoints for Flutter Web + mobile browsers.
abstract final class AppBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < desktop;
  static bool isDesktop(double width) => width >= desktop;

  /// Bento gallery vs horizontal carousel threshold.
  static bool useBentoGallery(double width) => width >= tablet;
}
