import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../glass_morphism_box.dart';

/// 2 kartu statistik utama bergaya Liquid Glass: Modul Selesai dan Bug Diperbaiki.
class ProgressStatGrid extends StatelessWidget {
  final String onTrackValue; // "18/24"
  final String fixCount; // "14"
  final String progressId;

  ProgressStatGrid({
    super.key,
    this.onTrackValue = '18/24',
    this.fixCount = '14',
    this.progressId = '409',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.check_circle_rounded,
            value: onTrackValue,
            title: 'Modul Selesai',
            color: AppColors.emerald700,
            bg: AppColors.emerald50,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.bug_report_rounded,
            value: '$fixCount Bug',
            title: 'Berhasil Diperbaiki',
            color: AppColors.sky600,
            bg: AppColors.sky50,
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String title,
    required Color color,
    required Color bg,
  }) {
    return GlassMorphismBox(
      borderRadius: 24,
      opacity: 0.48,
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: bg.withOpacity(0.88),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withOpacity(0.9),
                width: 1.1,
              ),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.slate900,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}