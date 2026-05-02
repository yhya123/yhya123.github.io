import 'package:flutter/material.dart';

class TechStackItem {
  const TechStackItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.blurbEn,
    required this.blurbAr,
    required this.icon,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final String blurbEn;
  final String blurbAr;
  final IconData icon;

  String name(bool ar) => ar ? nameAr : nameEn;
  String blurb(bool ar) => ar ? blurbAr : blurbEn;
}
