import 'package:flutter/material.dart';

import '../../models/case_study.dart';
import '../../theme/app_colors.dart';

/// Kartu "Akar Masalah & Penjelasan Guru TIK" + kotak tips.
class TeacherExplanationCard extends StatelessWidget {
  final CaseStudy caseStudy;
  const TeacherExplanationCard({super.key, required this.caseStudy});

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.psychology, color: AppColors.sky600, size: 24),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Akar Masalah & Penjelasan Guru TIK',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.slate900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Text(
                '${caseStudy.teacherId} | ${caseStudy.teacherName}',
                style: const TextStyle(
                    fontSize: 10, fontFamily: 'monospace', fontWeight: FontWeight.w600, color: AppColors.slate600),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.slate200.withOpacity(0.8)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb, color: Color(0xFFF59E0B), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(caseStudy.teacherTipsTitle,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.slate900)),
                      const SizedBox(height: 5),
                      Text(caseStudy.teacherTipsText,
                          style: const TextStyle(fontSize: 11, height: 1.5, color: AppColors.slate600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
