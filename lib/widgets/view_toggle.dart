import 'package:flutter/material.dart';

class ViewToggle extends StatelessWidget {
  const ViewToggle({
    super.key,
    required this.isDiffView,
    required this.onToggle,
    required this.sky,
    required this.slate200,
    required this.slate600,
    required this.slate900,
  });

  final bool isDiffView;
  final Function(bool) onToggle;
  final Color sky;
  final Color slate200;
  final Color slate600;
  final Color slate900;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: slate200.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: slate200),
      ),
      child: Row(
        children: [
          Expanded(
            child: _toggleButton(
              icon: Icons.difference,
              label: 'Diff Viewer',
              selected: isDiffView,
              onTap: () => onToggle(true),
            ),
          ),
          Expanded(
            child: _toggleButton(
              icon: Icons.splitscreen,
              label: 'Komparasi',
              selected: !isDiffView,
              onTap: () => onToggle(false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          border: selected
              ? Border.all(color: slate200)
              : Border.all(color: Colors.transparent),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? sky : slate600,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? slate900 : slate600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
