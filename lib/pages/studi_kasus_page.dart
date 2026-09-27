import 'package:flutter/material.dart';

import '../data/case_study_data.dart';
import '../widgets/case_study/case_action_buttons.dart';
import '../widgets/case_study/case_info_card.dart';
import '../widgets/case_study/code_comparison_view.dart';
import '../widgets/case_study/code_diff_view.dart';
import '../widgets/case_study/teacher_explanation_card.dart';
import '../widgets/main_scaffold.dart';
import '../widgets/notice_card.dart';
import '../widgets/segmented_control.dart';
import 'lab_test_page.dart';

/// Halaman Studi Kasus (tab index 1). Sekarang cuma "menyusun" widget
/// yang sudah dipecah di widgets/case_study/ — semua styling detail
/// hidup di widget masing-masing, halaman ini fokus ke state & alur.
class StudiKasusPage extends StatefulWidget {
  const StudiKasusPage({super.key});

  @override
  State<StudiKasusPage> createState() => _StudiKasusPageState();
}

class _StudiKasusPageState extends State<StudiKasusPage> {
  bool _isSaved = false;
  bool _isDiffView = true;

  final _caseStudy = kCssTypoCaseStudy;

  void _openLabTest() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LabTestPage(
          initialCss: _caseStudy.correctSnippet,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 1,
      headerSubtitle: 'Studi Kasus',
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                CaseInfoCard(caseStudy: _caseStudy),
                const SizedBox(height: 16),
                NoticeCard(
                  icon: Icons.assignment_late,
                  iconColor: const Color(0xFFD97706),
                  title: 'Skenario Masalah',
                  message: _caseStudy.problemScenario,
                ),
                const SizedBox(height: 16),
                SegmentedControl(
                  options: const [
                    SegmentedOption(icon: Icons.difference, label: 'Diff Viewer'),
                    SegmentedOption(icon: Icons.splitscreen, label: 'Komparasi'),
                  ],
                  selectedIndex: _isDiffView ? 0 : 1,
                  onChanged: (i) => setState(() => _isDiffView = i == 0),
                ),
                const SizedBox(height: 12),
                _isDiffView
                    ? CodeDiffView(caseStudy: _caseStudy)
                    : CodeComparisonView(caseStudy: _caseStudy),
                const SizedBox(height: 18),
                TeacherExplanationCard(caseStudy: _caseStudy),
                const SizedBox(height: 16),
                CaseActionButtons(
                  isSaved: _isSaved,
                  onOpenLab: _openLabTest,
                  onToggleSave: () {
                    setState(() => _isSaved = !_isSaved);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_isSaved
                            ? 'Bug berhasil disimpan ke catatan!'
                            : 'Bug dihapus dari catatan.'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
