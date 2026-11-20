import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/lab_test_page.dart';
import '../pages/progres_page.dart';
import '../pages/test_page.dart';
import '../theme/app_colors.dart';
import 'app_bottom_nav.dart';
import 'app_header.dart';

/// Scaffold utama dengan kanvas ambient teduh (Eye-Care Light & Clear Dark)
/// agar efek Glassmorphism / Liquid Glass tampil kontras dan nyaman di mata.
class MainScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final int? previousIndex;
  final String headerTitle;
  final String headerSubtitle;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    this.previousIndex,
    this.headerTitle = 'DebugTIK',
    this.headerSubtitle = 'Modul Pembelajaran',
  });

  void _navigateToIndex(BuildContext context, int targetIndex) {
    if (targetIndex < 0 || targetIndex > 3 || targetIndex == currentIndex) {
      return;
    }

    final pages = <Widget>[
      HomePage(),
      TestPage(),
      const LabTestPage(),
      ProgresPage(),
    ];

    final isMovingForward = targetIndex > currentIndex;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => pages[targetIndex],
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 260),
        transitionsBuilder: (_, animation, __, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          final slideOffset = Tween<Offset>(
            begin: Offset(isMovingForward ? 0.18 : -0.18, 0.0),
            end: Offset.zero,
          ).animate(curved);

          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: slideOffset,
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return Scaffold(
      backgroundColor: AppColors.slate50,
      extendBody: true,
      body: Stack(
        children: [
          // Kanvas dasar gradasi lembut untuk meredam silau di Light Mode
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.5, 1.0],
                  colors: isDark
                      ? const [
                          Color(0xFF070B14),
                          Color(0xFF090D16),
                          Color(0xFF0E1428),
                        ]
                      : const [
                          Color(0xFFD2DCEB),
                          Color(0xFFDCE2EC),
                          Color(0xFFCED8EB),
                        ],
                ),
              ),
            ),
          ),
          // Pendaran cahaya ambient agar kartu glassmorphism tampak berdimensi
          Positioned(
            top: -60,
            right: -50,
            child: _AmbientGlowOrb(
              size: 250,
              color: isDark
                  ? AppColors.sky600.withOpacity(0.14)
                  : const Color(0xFF4338CA).withOpacity(0.14),
            ),
          ),
          Positioned(
            top: 230,
            left: -70,
            child: _AmbientGlowOrb(
              size: 230,
              color: isDark
                  ? const Color(0xFF38BDF8).withOpacity(0.11)
                  : const Color(0xFF0284C7).withOpacity(0.13),
            ),
          ),
          Positioned(
            bottom: 80,
            right: -40,
            child: _AmbientGlowOrb(
              size: 260,
              color: isDark
                  ? const Color(0xFF818CF8).withOpacity(0.14)
                  : const Color(0xFF4F46E5).withOpacity(0.14),
            ),
          ),
          // Konten utama halaman
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                AppHeader(title: headerTitle, subtitle: headerSubtitle),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onHorizontalDragEnd: (details) {
                      final velocity = details.primaryVelocity ?? 0;
                      if (velocity < -450) {
                        _navigateToIndex(context, currentIndex + 1);
                      } else if (velocity > 450) {
                        _navigateToIndex(context, currentIndex - 1);
                      }
                    },
                    child: body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        previousIndex: previousIndex,
      ),
    );
  }
}

class _AmbientGlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _AmbientGlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withOpacity(0.0)],
          ),
        ),
      ),
    );
  }
}