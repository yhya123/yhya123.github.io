import 'package:flutter/material.dart';

import '../domain/models/project_model.dart';

/// Add new showcases here — the UI reads this list only.
///
/// TODO: Add real screenshots to `assets/images/`:
/// - `movement_system.png` — **TODO**: Use a full-width dashboard screenshot showing
///   fleet map + KPIs (proves scale). Aspect **16:10**, min width **1600px**.
/// - `click_app.png` — **TODO**: Use checkout or live-tracking screen with payment
///   trust badges (converts B2C clients). Aspect **9:16 or 10:16** for mobile app
///   framing, exported at **~1200px** long edge.
/// - `yahya_profile.jpg` — **TODO**: Professional headshot **1:1**, **800–1200px**,
///   neutral background, soft light (builds trust for enterprise buyers).
const List<ProjectModel> kFeaturedProjects = [
  ProjectModel(
    id: 'movement',
    titleEn: 'Movement System',
    titleAr: 'نظام موفمنت',
    summaryEn:
        'Fleet and assets at institutional scale — traced, steady, built to outlast the roadmap.',
    summaryAr:
        'أساطيل وأصول على نطاق مؤسسي — مسار موثوق، ثبات، وعمر أطول من خارطة الطريق.',
    imageAsset: 'assets/images/movement_system.png',
    accent: Color(0xFF22C55E),
    tagsEn: ['System analysis', 'SQL Server', 'Operations'],
    tagsAr: ['تحليل نظم', 'SQL Server', 'العمليات'],
    highlight: true,
  ),
  ProjectModel(
    id: 'click',
    titleEn: 'Click Delivery',
    titleAr: 'تطبيق كليك',
    summaryEn:
        'First-mover delivery with global cards — calm UX when the network and the clock disagree.',
    summaryAr:
        'توصيل سبّاق وبطاقات عالمية — تجربة هادئة حين يتصارع الزمن مع الشبكة.',
    imageAsset: 'assets/images/click_app.png',
    accent: Color(0xFFF97316),
    tagsEn: ['Flutter', 'Mobile', 'FinTech UX'],
    tagsAr: ['Flutter', 'موبايل', 'تجربة مالية'],
    highlight: false,
  ),
];
