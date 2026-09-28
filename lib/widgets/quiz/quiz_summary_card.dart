import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Banner "Terkoneksi Rapor Siswa" + kartu ringkasan kuis (semester,
/// live sync, judul, guru pengampu, 3 metrik cepat).
class QuizSummaryCard extends StatelessWidget {
  final String semesterLabel;
  final String teacherName;
  final double averageScore;
  final int completedCount;
  final int totalCount;
  final int streakDays;

  const QuizSummaryCard({
    super.key,
    this.semesterLabel = 'Semester Ganjil 2024/2025',
    this.teacherName = 'Bpk. Hendra Pratama, M.Kom',
    this.averageScore = 88.4,
    this.completedCount = 10,
    this.totalCount = 12,
    this.streakDays = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Banner sinkronisasi rapor
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.slate100,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: AppColors.sky600, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.verified, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kuis Terkoneksi Rapor Siswa',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.slate900),
                        overflow: TextOverflow.ellipsis),
                    const Text('Nilai otomatis dikonversi ke Nilai Formatif TIK',
                        style: TextStyle(fontSize: 11, color: AppColors.slate500), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const Icon(Icons.cloud_done, color: AppColors.slate500),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Ringkasan kuis formatif
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.sky100, borderRadius: BorderRadius.circular(999)),
                    child: Text(semesterLabel.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.sky700, letterSpacing: 0.4)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration:
                        BoxDecoration(color: AppColors.emerald50, borderRadius: BorderRadius.circular(999)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.sync, size: 13, color: AppColors.emerald700),
                        const SizedBox(width: 4),
                        const Text('LIVE SYNC',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.emerald700)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Kuis & Asesmen Mandiri',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.slate900)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.supervisor_account, size: 15, color: AppColors.slate500),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'Sinkron dengan Guru: ',
                        style: const TextStyle(fontSize: 12, color: AppColors.slate500),
                        children: [
                          TextSpan(text: teacherName, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.slate700)),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _metric(averageScore.toStringAsFixed(1), 'Skor Rerata', AppColors.sky600)),
                  Expanded(child: _metric('$completedCount/$totalCount', 'Tuntas Kuis', AppColors.emerald700, small: '/$totalCount')),
                  Expanded(child: _streakMetric()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _metric(String value, String label, Color color, {String? small}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: AppColors.slate50, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: AppColors.slate500)),
        ],
      ),
    );
  }

  Widget _streakMetric() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: AppColors.slate50, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_fire_department, size: 16, color: Color(0xFF39B8FD)),
              const SizedBox(width: 3),
              Text('$streakDays', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.slate900)),
            ],
          ),
          const SizedBox(height: 2),
          const Text('Hari Streak', style: TextStyle(fontSize: 10, color: AppColors.slate500)),
        ],
      ),
    );
  }
}
