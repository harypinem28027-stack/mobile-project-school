import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Kartu "Aktivitas Mingguan": grid 7 hari (Sen-Min) menunjukkan hari
/// mana siswa aktif belajar, plus info streak.
class WeeklyActivityCard extends StatelessWidget {
  final List<bool> activeDays; // panjang 7, Senin..Minggu
  final int activeCount;
  final int totalTarget;
  final int streakDays;
  final String topPercentLabel;

  const WeeklyActivityCard({
    super.key,
    this.activeDays = const [true, true, true, true, true, false, false],
    this.activeCount = 5,
    this.totalTarget = 7,
    this.streakDays = 14,
    this.topPercentLabel = 'Top 5% Kelas',
  });

  static const _dayLabels = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.calendar_today, size: 18, color: AppColors.sky600),
                  SizedBox(width: 8),
                  Text('Aktivitas Mingguan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.slate900)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: AppColors.emerald50, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.emerald200)),
                child: Text('$activeCount/$totalTarget Hari Target',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.emerald700, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(7, (i) {
              final active = activeDays[i];
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    children: [
                      Text(_dayLabels[i], style: TextStyle(fontSize: 11, color: active ? AppColors.slate500 : AppColors.slate400)),
                      const SizedBox(height: 6),
                      Container(
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: active ? AppColors.emerald500 : AppColors.slate100,
                          borderRadius: BorderRadius.circular(8),
                          border: active ? null : Border.all(color: AppColors.slate200),
                        ),
                        child: active
                            ? const Icon(Icons.check, color: Colors.white, size: 15)
                            : Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.slate300, shape: BoxShape.circle)),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.slate100))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bolt, size: 15, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 4),
                    Text('Streak $streakDays hari berturut-turut', style: const TextStyle(fontSize: 12, color: AppColors.slate600)),
                  ],
                ),
                Text(topPercentLabel, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.sky600, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
