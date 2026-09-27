import 'package:flutter/material.dart';

import '../../models/case_study.dart';
import '../../theme/app_colors.dart';

/// Tampilan "Komparasi": dua kartu kode kecil berdampingan (Salah/Benar)
/// plus catatan singkat di bawahnya.
class CodeComparisonView extends StatelessWidget {
  final CaseStudy caseStudy;
  const CodeComparisonView({super.key, required this.caseStudy});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _MiniCodeCard(title: 'SALAH', code: caseStudy.wrongSnippet, color: const Color(0xFFF43F5E)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _MiniCodeCard(title: 'BENAR', code: caseStudy.correctSnippet, color: const Color(0xFF10B981)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.emerald50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.emerald200),
          ),
          child: Row(
            children: [
              const Icon(Icons.verified, color: Color(0xFF059669), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  caseStudy.comparisonTip,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.emerald700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniCodeCard extends StatelessWidget {
  final String title;
  final String code;
  final Color color;
  const _MiniCodeCard({required this.title, required this.code, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.slate900,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(code,
              style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.6, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
