/// Central copy + guidance for character budgets (persuasion + layout stability).
///
/// **Hero headline**: target **42–62 characters** EN / **28–40** AR so it fits one
/// line on laptop without wrapping awkwardly.
/// **Hero subline**: **90–140 characters** — outcome-focused, not buzzwords.
/// **Section titles**: **22–34 characters** max for grid alignment.
abstract final class AppStrings {
  static const Map<String, Map<String, String>> _m = {
    'en': {
      'brand_name': 'Eng. Yahya Al-Washali',
      'app_title': 'Yahya Al-Washali · Engineer & Analyst',
      'nav_work': 'Work',
      'nav_method': 'Method',
      'nav_stack': 'Stack',
      'nav_contact': 'Contact',
      'lang_toggle': 'العربية',
      'hero_kicker': 'Software Engineer & System Analyst',
      'hero_headline': 'Systems engineered for clarity, scale, and years of service.',
      'hero_sub':
          'Structure you can trust, interfaces you can read — from Flutter craft to SQL-backed platforms.',
      'hero_cta_primary': 'Discuss your roadmap',
      'hero_cta_secondary': 'View selected work',
      'philosophy_title': 'The System Analyst lens',
      'philosophy_lead':
          'Quality and durability are not “nice-to-haves.” They are how you de-risk delivery, protect revenue, and keep teams fast.',
      'philosophy_step1_title': 'Discover truth',
      'philosophy_step1_body':
          'Stakeholders, constraints, and data flows — documented before pixels or schemas.',
      'philosophy_step2_title': 'Design for change',
      'philosophy_step2_body':
          'Modular boundaries and measurable requirements so the system can evolve safely.',
      'philosophy_step3_title': 'Prove with evidence',
      'philosophy_step3_body':
          'Traceability from requirement → implementation → verification — especially under audit pressure.',
      'stack_title': 'Technology footprint',
      'stack_subtitle':
          'Tap a tile — this is the stack I use to ship serious products, not demos.',
      'projects_title': 'Selected engagements',
      'projects_subtitle':
          'Where analysis, integrity, and product craft had to agree — without noise.',
      'contact_title': 'Ready when you are',
      'contact_body':
        'If you are planning a platform migration, a high-stakes product build, or a system that must not fail quietly — let’s talk.',
      'footer_github': 'github.com/yhya123',
      'footer_rights': '© 2026 Yahya Al-Washali',
      'case_study_back': 'Back to portfolio',
    },
    'ar': {
      'brand_name': 'م. يحيى الوشلي',
      'app_title': 'يحيى الوشلي · مهندس ومحلل نظم',
      'nav_work': 'الأعمال',
      'nav_method': 'المنهجية',
      'nav_stack': 'التقنيات',
      'nav_contact': 'تواصل',
      'lang_toggle': 'English',
      'hero_kicker': 'مهندس برمجيات ومحلل نظم',
      'hero_headline': 'أنظمة تُبنى للوضوح والتوسع وللسنوات الطويلة من الخدمة.',
      'hero_sub':
          'هيكل يُعتمد عليه، واجهات تُقرأ بسهولة — من حرفية Flutter إلى منصات مؤسسية بـ SQL.',
      'hero_cta_primary': 'ناقش خارطة طريقك',
      'hero_cta_secondary': 'شاهد أعمالًا مختارة',
      'philosophy_title': 'عدسة محلل النظم',
      'philosophy_lead':
          'الجودة والمتانة ليست رفاهية — بل طريقة لتقليل مخاطر التسليم وحماية الإيراد والحفاظ على سرعة الفريق.',
      'philosophy_step1_title': 'اكتشاف الحقيقة',
      'philosophy_step1_body':
          'أصحاب المصلحة والقيود وتدفقات البيانات — موثّقة قبل الواجهات أو المخططات.',
      'philosophy_step2_title': 'تصميم للتغيير',
      'philosophy_step2_body':
          'حدود وحدات ومتطلبات قابلة للقياس حتى يتطور النظام بأمان.',
      'philosophy_step3_title': 'الإثبات بالأدلة',
      'philosophy_step3_body':
          'تتبع من المتطلب إلى التنفيذ إلى التحقق — خصوصًا تحت ضغط التدقيق.',
      'stack_title': 'بصمة التقنية',
      'stack_subtitle': 'اضغط على بطاقة — هذا المكدس الذي أستخدمه لمنتجات جادة.',
      'projects_title': 'مشاريع مختارة',
      'projects_subtitle':
          'حيث يلتقي التحليل وتكامل البيانات وحرفية المنتج — بصمت مهني.',
      'contact_title': 'جاهز عندما تكون أنت جاهزًا',
      'contact_body':
          'إذا كنت تخطط لهجرة منصة أو بناء منتج عال المخاطر أو نظام لا يجب أن يفشل بصمت — لنتحدث.',
      'footer_github': 'github.com/yhya123',
      'footer_rights': '© 2026 يحيى الوشلي',
      'case_study_back': 'العودة إلى المعرض',
    },
  };

  static String t({required bool isArabic, required String key}) {
    final lang = isArabic ? 'ar' : 'en';
    return _m[lang]![key] ?? key;
  }
}
