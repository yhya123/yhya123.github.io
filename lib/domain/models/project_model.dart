import 'package:flutter/material.dart';

/// Single source of truth for portfolio case studies.
///
/// Content tips when adding a project:
/// - [summaryEn]/[summaryAr]: aim for **~120–180 characters** (2 lines on desktop).
///   Longer copy belongs in a case-study page, not the grid tile.
/// - [imageAsset]: prefer **16:10 or 3:2** screenshots at **1600–2400px** wide
///   (WebP/PNG). Hero tiles in bento: **~1200×750** minimum for crisp retina.
/// - [accent]: pick a color sampled from the product UI for cohesive cards.
class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.summaryEn,
    required this.summaryAr,
    this.imageAsset,
    required this.accent,
    this.tagsEn = const [],
    this.tagsAr = const [],
    this.highlight = false,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String summaryEn;
  final String summaryAr;

  /// Path under `assets/images/`. Null => show branded placeholder.
  final String? imageAsset;
  final Color accent;
  final List<String> tagsEn;
  final List<String> tagsAr;

  /// Larger bento cell on desktop when true (first flagship project).
  final bool highlight;

  String title(bool isArabic) => isArabic ? titleAr : titleEn;
  String summary(bool isArabic) => isArabic ? summaryAr : summaryEn;
  List<String> tags(bool isArabic) => isArabic ? tagsAr : tagsEn;
}
