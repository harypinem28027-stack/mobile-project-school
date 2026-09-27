import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Baris sapaan "Halo, {nama}" + badge Live Sync + info kelas.
class GreetingSection extends StatelessWidget {
  final String userName;
  final String className;

  const GreetingSection({
    super.key,
    this.userName = 'Alifia',
    this.className = 'Kelas XI TIK 2 • Pemrograman Web & Logika',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: 'Halo, $userName ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.slate900,
                  letterSpacing: -0.3,
                ),
                children: const [TextSpan(text: '👋')],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.emerald200.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: AppColors.emerald500, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Live Sync',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.emerald700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.school, size: 16, color: AppColors.sky600),
            const SizedBox(width: 6),
            Text(
              className,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.slate600),
            ),
          ],
        ),
      ],
    );
  }
}
