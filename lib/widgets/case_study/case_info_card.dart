import 'package:flutter/material.dart';

import '../../models/case_study.dart';
import '../../theme/app_colors.dart';

/// Kartu putih berisi badge nomor kasus, judul, dan info chip
/// (mapel, tingkat, kelas target).
class CaseInfoCard extends StatelessWidget {
  final CaseStudy caseStudy;
  const CaseInfoCard({super.key, required this.caseStudy});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.035), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _badge(caseStudy.caseNumber,
                  bg: const Color(0xFFF0F9FF), fg: AppColors.sky700, border: AppColors.sky200),
              _codeBadge(caseStudy.materialId),
              _codeBadge(caseStudy.labId),
              _badge('●  ${caseStudy.errorTag}',
                  bg: const Color(0xFFFFF1F2), fg: const Color(0xFFBE123C), border: const Color(0xFFFECDD3)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            caseStudy.title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.slate900, height: 1.25),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _infoChip(Icons.css, caseStudy.subject, AppColors.sky600),
              _infoChip(Icons.signal_cellular_alt, caseStudy.level, const Color(0xFF059669)),
              _infoChip(Icons.person_outline, caseStudy.targetClass, AppColors.sky600),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, {required Color bg, required Color fg, required Color border}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(30), border: Border.all(color: border)),
      child: Text(text,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg, letterSpacing: 0.3)),
    );
  }

  Widget _codeBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: AppColors.slate100, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.slate200)),
      child: Text(text,
          style: const TextStyle(fontSize: 10, color: AppColors.slate600, fontFamily: 'monospace')),
    );
  }

  Widget _infoChip(IconData icon, String text, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
          color: AppColors.slate100, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.slate200)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.slate700)),
        ],
      ),
    );
  }
}
