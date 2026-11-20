import 'package:flutter/material.dart';

import '../data/quiz_data.dart';
import '../models/quiz.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_morphism_box.dart';
import '../widgets/main_scaffold.dart';
import '../widgets/quiz/quiz_module_card.dart';
import '../widgets/quiz/quiz_summary_card.dart';
import '../widgets/quiz/quiz_tips_card.dart';
import 'modal_test_page.dart';

/// Halaman Kuis / Evaluasi (tab index 1) bergaya Glassmorphism / Liquid Glass.
class TestPage extends StatefulWidget {
  TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 780),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  /// Animasi geser bergiliran ringan (GPU-friendly) senada dengan HomePage.
  Widget _staggerSlide({
    required double start,
    required double end,
    required Widget child,
    double slideDistance = 72.0,
  }) {
    final curve = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(
        start.clamp(0.0, 0.90),
        end.clamp(0.10, 1.0),
        curve: Curves.easeOutQuart,
      ),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: curve,
        child: child,
        builder: (context, cachedChild) {
          final offsetX = (1.0 - curve.value) * slideDistance;
          return Transform.translate(
            offset: Offset(offsetX, 0),
            child: cachedChild,
          );
        },
      ),
    );
  }

  void _openQuiz(BuildContext context, QuizModule module,
      {bool review = false}) {
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
    final bottomSpace = MediaQuery.of(context).padding.bottom + 104;

    return MainScaffold(
      currentIndex: 1,
      headerSubtitle: 'Kuis',
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomSpace),
        children: [
          _staggerSlide(
            start: 0.00,
            end: 0.44,
            slideDistance: 60,
            child: QuizSummaryCard(),
          ),
          SizedBox(height: 20),
          _staggerSlide(
            start: 0.08,
            end: 0.52,
            slideDistance: 72,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Evaluasi Berjalan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.slate900,
                        ),
                      ),
                      SizedBox(width: 8),
                      GlassMorphismBox(
                        borderRadius: 999,
                        opacity: 0.55,
                        blurSigma: 10,
                        padding: EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        boxShadow: [],
                        child: Text(
                          '$activeCount MODUL AKTIF',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.sky700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'kuis_TIK',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          ...List.generate(modules.length, (index) {
            final start = (0.16 + index * 0.09).clamp(0.0, 0.62);
            final end = (start + 0.38).clamp(0.38, 1.0);
            final m = modules[index];

            return _staggerSlide(
              start: start,
              end: end,
              slideDistance: 96,
              child: Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: QuizModuleCard(
                  module: m,
                  onStart: () => _openQuiz(context, m),
                  onReview: () => _openQuiz(context, m, review: true),
                ),
              ),
            );
          }),
          SizedBox(height: 4),
          _staggerSlide(
            start: 0.48,
            end: 1.00,
            slideDistance: 84,
            child: QuizTipsCard(),
          ),
        ],
      ),
    );
  }
}