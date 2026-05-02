import 'package:flutter/material.dart';

import '../domain/models/tech_stack_item.dart';

const List<TechStackItem> kTechStack = [
  TechStackItem(
    id: 'flutter',
    nameEn: 'Flutter & Dart',
    nameAr: 'Flutter و Dart',
    blurbEn: 'Web + mobile surfaces with consistent UX and fast iteration.',
    blurbAr: 'ويب وموبايل بتجربة موحّدة وتطوير أسرع.',
    icon: Icons.flutter_dash,
  ),
  TechStackItem(
    id: 'sql',
    nameEn: 'SQL Server & Data',
    nameAr: 'SQL Server والبيانات',
    blurbEn: 'Modeling, integrity, and performance paths for transactional systems.',
    blurbAr: 'نمذجة وتكامل وأداء للأنظمة المعاملاتية.',
    icon: Icons.storage_rounded,
  ),
  TechStackItem(
    id: 'analysis',
    nameEn: 'System Analysis',
    nameAr: 'تحليل النظم',
    blurbEn: 'Requirements, BPM, and ERP/EPM alignment with delivery reality.',
    blurbAr: 'متطلبات وعمليات ومحاذاة ERP/EPM مع واقع التنفيذ.',
    icon: Icons.hub_outlined,
  ),
  TechStackItem(
    id: 'architecture',
    nameEn: 'Architecture',
    nameAr: 'البنية',
    blurbEn: 'Boundaries, APIs, and maintainability for long-lived platforms.',
    blurbAr: 'حدود وواجهات وقابلية صيانة للمنصات طويلة العمر.',
    icon: Icons.account_tree_outlined,
  ),
];
