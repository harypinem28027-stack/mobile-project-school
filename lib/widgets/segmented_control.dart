import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Satu opsi di dalam SegmentedControl.
class SegmentedOption {
  final IconData icon;
  final String label;
  const SegmentedOption({required this.icon, required this.label});
}

/// Toggle pill bersegmen, generic — bisa dipakai untuk 2 opsi
/// (Diff Viewer / Komparasi) maupun lebih (HTML / CSS / JS).
///
/// ```dart
/// SegmentedControl(
///   options: const [
///     SegmentedOption(icon: Icons.difference, label: 'Diff Viewer'),
///     SegmentedOption(icon: Icons.splitscreen, label: 'Komparasi'),
///   ],
///   selectedIndex: 0,
///   onChanged: (i) => setState(() => index = i),
/// )
/// ```
class SegmentedControl extends StatelessWidget {
  final List<SegmentedOption> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SegmentedControl({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.slate200.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          final option = options[index];
          final selected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  border: selected
                      ? Border.all(color: AppColors.slate200)
                      : Border.all(color: Colors.transparent),
                  boxShadow: selected
                      ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      option.icon,
                      size: 18,
                      color: selected ? AppColors.sky600 : AppColors.slate600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                        color: selected ? AppColors.slate900 : AppColors.slate600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
