import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/lab_test_page.dart';
import '../pages/leaderboard_page.dart';
import '../pages/progres_page.dart';
import '../pages/test_page.dart';
import '../theme/app_colors.dart';

/// Satu sumber data untuk semua tab bottom navigation.
/// Tambah/ubah menu cukup di sini, semua halaman ikut update.
const List<_NavItem> _kNavItems = [
  _NavItem(icon: Icons.menu_book, label: 'Modul'),
  _NavItem(icon: Icons.quiz_outlined, label: 'Kuis'),
  _NavItem(icon: Icons.science_outlined, label: 'Lab Test'),
  _NavItem(icon: Icons.insights_outlined, label: 'Progres'),
  _NavItem(icon: Icons.emoji_events_outlined, label: 'Peringkat'),
];

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

/// Bottom navigation bar reusable.
///
/// Cukup panggil `AppBottomNav(currentIndex: 0)` di [MainScaffold] mana pun,
/// widget ini sudah tahu sendiri cara pindah halaman (index 0-4).
class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    final pages = <Widget>[
      const HomePage(),
      const TestPage(),
      const LabTestPage(),
      const ProgresPage(),
      const LeaderboardPage(),
    ];
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => pages[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: const Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: List.generate(_kNavItems.length, (index) {
          final isActive = currentIndex == index;
          final item = _kNavItems[index];
          return Expanded(
            child: InkWell(
              onTap: () => _onTap(context, index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 24,
                    color: isActive ? AppColors.sky600 : AppColors.slate600,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: isActive ? AppColors.sky600 : AppColors.slate600,
                      fontWeight: isActive
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
