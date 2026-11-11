  import 'package:flutter/material.dart';

  import '../data/quiz_data.dart';
  import '../models/quiz.dart';
  import '../widgets/main_scaffold.dart';
  import '../widgets/quiz/quiz_module_card.dart';
  import '../widgets/quiz/quiz_summary_card.dart';
  import '../widgets/quiz/quiz_tips_card.dart';
  import 'modal_test_page.dart';

  /// Halaman Kuis / Evaluasi (tab index 1) — menggantikan Studi Kasus.
  /// Diambil dari fixpls/Test_page.dart (HTML), dipecah jadi widget
  /// reusable di widgets/quiz/.
  class TestPage extends StatelessWidget {
    const TestPage({super.key});

    void _openQuiz(BuildContext context, QuizModule module, {bool review = false}) {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => ModalTestPage(module: module, reviewMode: review),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      final modules = kQuizModules;
      final activeCount = modules.length;

      return MainScaffold(
        currentIndex: 1,
        headerSubtitle: 'Kuis',
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            const QuizSummaryCard(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Evaluasi Berjalan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(999)),
                      child: Text('$activeCount MODUL AKTIF',
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                    ),
                  ],
                ),
                const Text('TABLE: kuis_TIK',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF94A3B8))),
              ],
            ),
            const SizedBox(height: 12),
            ...modules.map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: QuizModuleCard(
                  module: m,
                  onStart: () => _openQuiz(context, m),
                  onReview: () => _openQuiz(context, m, review: true),
                ),
              ),
            ),
            const QuizTipsCard(),
          ],
        ),
      );
    }
  }
