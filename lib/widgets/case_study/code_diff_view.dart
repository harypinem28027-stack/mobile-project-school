import 'package:flutter/material.dart';

import '../../models/case_study.dart';
import '../../theme/app_colors.dart';
import '../code_terminal_card.dart';

/// Tampilan "Diff Viewer": kode bermasalah di atas, panah, kode
/// perbaikan di bawah — masing-masing pakai CodeTerminalCard.
class CodeDiffView extends StatelessWidget {
  final CaseStudy caseStudy;
  const CodeDiffView({super.key, required this.caseStudy});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CodeTerminalCard(
          title: 'KODE BERMASALAH',
          filename: caseStudy.brokenFilename,
          accent: const Color(0xFFF43F5E),
          codeLines: caseStudy.brokenCode,
          footer: CodeFeedbackFooter(
            icon: Icons.warning_amber_rounded,
            color: const Color(0xFFFDA4AF),
            background: const Color(0x331E293B),
            title: caseStudy.errorDiagnosisTitle,
            message: caseStudy.errorDiagnosisText,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.slate200),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4)],
          ),
          child: const Icon(Icons.arrow_downward, size: 18, color: AppColors.sky600),
        ),
        const SizedBox(height: 10),
        CodeTerminalCard(
          title: 'KODE PERBAIKAN',
          filename: caseStudy.fixedFilename,
          accent: const Color(0xFF10B981),
          codeLines: caseStudy.fixedCode,
          footer: CodeFeedbackFooter(
            icon: Icons.verified,
            color: const Color(0xFF34D399),
            background: const Color(0x2210B981),
            message: caseStudy.successText,
            trailing: '0 Error',
          ),
        ),
      ],
    );
  }
}
