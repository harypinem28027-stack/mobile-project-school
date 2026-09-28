import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// 3 kartu statistik ringkas: modul on-track, jumlah bug diperbaiki,
/// dan id progres siswa.
class ProgressStatGrid extends StatelessWidget {
  final String onTrackValue; // "18/24"
  final String fixCount; // "14"
  final String progressId; // "409" -> ditampilkan sbg PRG-409

  const ProgressStatGrid({
    super.key,
    this.onTrackValue = '18/24',
    this.fixCount = '14',
    this.progressId = '409',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _statCard(Icons.check_circle, onTrackValue, 'On-Track', 'Modul TIK', AppColors.emerald700, AppColors.emerald50)),
        const SizedBox(width: 10),
        Expanded(child: _statCard(Icons.build_circle, fixCount, '$fixCount Fix', 'Jml Kesalahan', AppColors.sky600, AppColors.sky50)),
        const SizedBox(width: 10),
        Expanded(child: _statCard(Icons.fingerprint, progressId, 'PRG-$progressId', 'ID Progress', const Color(0xFF4F46E5), const Color(0xFFEEF2FF), mono: true)),
      ],
    );
  }

  Widget _statCard(IconData icon, String value, String label, String sub, Color color, Color bg, {bool mono = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.slate200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color, fontFamily: mono ? 'monospace' : null)),
          const SizedBox(height: 2),
          Text(label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.3)),
          const SizedBox(height: 1),
          Text(sub, style: const TextStyle(fontSize: 9, color: AppColors.slate400)),
        ],
      ),
    );
  }
}
