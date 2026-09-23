import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.selectedNav,
    required this.onNavTap,
    required this.slate200,
    required this.slate600,
    required this.skyDark,
  });

  final int selectedNav;
  final Function(int) onNavTap;
  final Color slate200;
  final Color slate600;
  final Color skyDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.97),
        border: Border(
          top: BorderSide(color: slate200),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _navItem(
                index: 0,
                icon: Icons.menu_book,
                label: 'Modul',
              ),
              _navItem(
                index: 1,
                icon: Icons.bug_report,
                label: 'Studi Kasus',
              ),
              _navItem(
                index: 2,
                icon: Icons.terminal,
                label: 'Lab Fix',
              ),
              _navItem(
                index: 3,
                icon: Icons.insights,
                label: 'Progres',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final selected = selectedNav == index;

    return Expanded(
      child: InkWell(
        onTap: () => onNavTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? skyDark : slate600,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? skyDark : slate600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
