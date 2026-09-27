import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Badge kecil monospace, dipakai untuk info kuis/lab di ModuleCard.
class MetaBadge extends StatelessWidget {
  final String text;
  const MetaBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration:
          BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.slate700),
      ),
    );
  }
}
