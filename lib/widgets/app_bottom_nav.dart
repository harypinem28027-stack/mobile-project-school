import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/home_page.dart';
import '../pages/lab_test_page.dart';
import '../pages/progres_page.dart';
import '../pages/test_page.dart';
import '../theme/app_colors.dart';

const List<_NavItem> _kNavItems = [
  _NavItem(
    icon: Icons.menu_book_outlined,
    activeIcon: Icons.menu_book_rounded,
    label: 'Modul',
  ),
  _NavItem(
    icon: Icons.quiz_outlined,
    activeIcon: Icons.quiz_rounded,
    label: 'Kuis',
  ),
  _NavItem(
    icon: Icons.science_outlined,
    activeIcon: Icons.science_rounded,
    label: 'Lab Test',
  ),
  _NavItem(
    icon: Icons.insights_outlined,
    activeIcon: Icons.insights_rounded,
    label: 'Progres',
  ),
];

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

int _lastTabIndex = 0;

class AppBottomNav extends StatefulWidget {
  final int currentIndex;
  final int? previousIndex;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    this.previousIndex,
  });

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  late double _fromIndex;
  double? _dragIndex;

  @override
  void initState() {
    super.initState();
    _fromIndex = (widget.previousIndex ?? _lastTabIndex).toDouble();
    _lastTabIndex = widget.currentIndex;
  }

  void _navigateTo(int index) {
    final clamped = index.clamp(0, _kNavItems.length - 1);
    if (clamped == widget.currentIndex) {
      setState(() => _dragIndex = null);
      return;
    }

    HapticFeedback.selectionClick();
    final isMovingForward = clamped > widget.currentIndex;
    _lastTabIndex = widget.currentIndex;

    final pages = <Widget>[
      HomePage(),
      TestPage(),
      const LabTestPage(),
      ProgresPage(),
    ];

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => pages[clamped],
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
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final count = _kNavItems.length;
    final isDark = AppColors.isDark;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        18,
        0,
        18,
        bottomInset > 0 ? bottomInset + 6 : 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.30 : 0.10),
              blurRadius: 22,
              spreadRadius: -4,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.sky600.withOpacity(isDark ? 0.12 : 0.08),
              blurRadius: 16,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: isDark ? 10 : 18,
              sigmaY: isDark ? 10 : 18,
            ),
            child: Container(
              height: 68,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          Colors.white.withOpacity(0.10),
                          const Color(0xFF0F172A).withOpacity(0.24),
                          const Color(0xFF312E81).withOpacity(0.20),
                        ]
                      : [
                          const Color(0xFFEAEFF7).withOpacity(0.76),
                          const Color(0xFFDCE3F0).withOpacity(0.64),
                          const Color(0xFFD2DCF2).withOpacity(0.72),
                        ],
                ),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.24)
                      : Colors.white.withOpacity(0.62),
                  width: 1.3,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / count;

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragUpdate: (details) {
                      final localX = details.localPosition.dx
                          .clamp(0.0, constraints.maxWidth - 1);
                      setState(() {
                        _dragIndex = (localX / itemWidth) - 0.5;
                      });
                    },
                    onHorizontalDragEnd: (details) {
                      if (_dragIndex != null) {
                        final target = _dragIndex!.round().clamp(0, count - 1);
                        _navigateTo(target);
                      }
                    },
                    onHorizontalDragCancel: () {
                      setState(() => _dragIndex = null);
                    },
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: _fromIndex,
                        end: _dragIndex ?? widget.currentIndex.toDouble(),
                      ),
                      duration: _dragIndex != null
                          ? Duration.zero
                          : const Duration(milliseconds: 340),
                      curve: Curves.easeOutBack,
                      builder: (context, animatedPos, _) {
                        final clampedPos =
                            animatedPos.clamp(0.0, (count - 1).toDouble());
                        final highlightedIndex = clampedPos.round();

                        return Stack(
                          children: [
                            Positioned(
                              left: clampedPos * itemWidth,
                              top: 0,
                              bottom: 0,
                              width: itemWidth,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: isDark
                                        ? [
                                            Colors.white.withOpacity(0.16),
                                            AppColors.sky600.withOpacity(0.22),
                                          ]
                                        : [
                                            AppColors.sky600.withOpacity(0.18),
                                            AppColors.sky600.withOpacity(0.10),
                                          ],
                                  ),
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.32)
                                        : Colors.white.withOpacity(0.68),
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColors.sky600.withOpacity(0.12),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Row(
                                children: List.generate(count, (index) {
                                  final isHighlighted =
                                      highlightedIndex == index;
                                  final item = _kNavItems[index];

                                  return Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => _navigateTo(index),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedScale(
                                            scale: isHighlighted ? 1.12 : 1.0,
                                            duration: const Duration(
                                                milliseconds: 220),
                                            curve: Curves.easeOutBack,
                                            child: Icon(
                                              isHighlighted
                                                  ? item.activeIcon
                                                  : item.icon,
                                              size: 21,
                                              color: isHighlighted
                                                  ? AppColors.sky600
                                                  : AppColors.slate700,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          AnimatedDefaultTextStyle(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            style: TextStyle(
                                              fontSize: 10.5,
                                              height: 1.1,
                                              letterSpacing: 0.2,
                                              color: isHighlighted
                                                  ? AppColors.sky600
                                                  : AppColors.slate700,
                                              fontWeight: isHighlighted
                                                  ? FontWeight.w700
                                                  : FontWeight.w600,
                                            ),
                                            child: Text(
                                              item.label,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}