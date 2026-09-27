import 'package:flutter/material.dart';

/// Model data untuk satu kartu modul pembelajaran di HomePage.
class LearningModule {
  final String code; // MOD-01
  final String idMateri; // MAT-01
  final String category; // html | css | js
  final String categoryLabel; // HTML DASAR
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Color iconBorder;
  final String level; // Pemula
  final String duration; // 15 mnt
  final String title;
  final String description;
  final IconData bugIcon;
  final Color bugIconColor;
  final Color bugTextColor;
  final String bugSnippet;
  final String caseCount; // 6 Kasus
  final String quizCount; // KUIS_TIK: 4 Soal
  final String labCount; // LAB_PRAKTIK: 2 Sesi

  const LearningModule({
    required this.code,
    required this.idMateri,
    required this.category,
    required this.categoryLabel,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.iconBorder,
    required this.level,
    required this.duration,
    required this.title,
    required this.description,
    required this.bugIcon,
    required this.bugIconColor,
    required this.bugTextColor,
    required this.bugSnippet,
    required this.caseCount,
    required this.quizCount,
    required this.labCount,
  });

  /// Dipakai oleh fitur pencarian di HomePage.
  String get searchHaystack =>
      '$title $description $categoryLabel $bugSnippet'.toLowerCase();
}

/// Model sederhana untuk pill kategori filter.
class CategoryPill {
  final String label;
  final String value;
  const CategoryPill({required this.label, required this.value});
}
