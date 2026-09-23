import 'package:flutter/material.dart';
import '../widgets/top_navbar.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/case_info.dart';
import '../widgets/problem_scenario.dart';
import '../widgets/view_toggle.dart';
import '../widgets/diff_view.dart';
import '../widgets/comparison_view.dart';
import '../widgets/teacher_explanation.dart';
import '../widgets/action_buttons.dart';

class StudiKasusPage extends StatefulWidget {
  const StudiKasusPage({super.key});

  @override
  State<StudiKasusPage> createState() => _StudiKasusPageState();
}

class _StudiKasusPageState extends State<StudiKasusPage> {
  bool isDiffView = true;
  int selectedNav = 1;

  final Color sky = const Color(0xFF0EA5E9);
  final Color skyDark = const Color(0xFF0369A1);
  final Color background = const Color(0xFFF8FAFC);
  final Color slate900 = const Color(0xFF0F172A);
  final Color slate700 = const Color(0xFF334155);
  final Color slate600 = const Color(0xFF475569);
  final Color slate200 = const Color(0xFFE2E8F0);
  final Color slate100 = const Color(0xFFF1F5F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            TopNavbar(
              sky: sky,
              slate100: slate100,
              slate600: slate600,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 90,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: Column(
                      children: [
                        CaseInfo(
                          sky: sky,
                          skyDark: skyDark,
                        ),
                        const SizedBox(height: 16),
                        const ProblemScenario(),
                        const SizedBox(height: 16),
                        ViewToggle(
                          isDiffView: isDiffView,
                          onToggle: (value) {
                            setState(() {
                              isDiffView = value;
                            });
                          },
                          sky: sky,
                          slate200: slate200,
                          slate600: slate600,
                          slate900: slate900,
                        ),
                        const SizedBox(height: 12),
                        if (isDiffView)
                          DiffView(
                            sky: sky,
                            slate200: slate200,
                          )
                        else
                          const ComparisonView(),
                        const SizedBox(height: 18),
                        TeacherExplanation(sky: sky),
                        const SizedBox(height: 16),
                        ActionButtons(
                          sky: sky,
                          slate700: slate700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedNav: selectedNav,
        onNavTap: (index) {
          setState(() {
            selectedNav = index;
          });
        },
        slate200: slate200,
        slate600: slate600,
        skyDark: skyDark,
      ),
    );
  }
}
