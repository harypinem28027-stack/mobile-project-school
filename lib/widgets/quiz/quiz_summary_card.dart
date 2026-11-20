import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../glass_morphism_box.dart';

/// Banner "Terkoneksi Rapor Siswa" + kartu ringkasan kuis bergaya Liquid Glass.
class QuizSummaryCard extends StatelessWidget {
  final String semesterLabel;
  final String teacherName;
  final double averageScore;
  final int completedCount;
  final int totalCount;
  final int streakDays;

  QuizSummaryCard({
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
        // Banner sinkronisasi rapor kaca ramping
        GlassMorphismBox(
          borderRadius: 22,
          opacity: 0.44,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.sky600, const Color(0xFF6366F1)],
                  ),
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.sky600.withOpacity(0.25),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(Icons.verified_rounded,
                    color: Colors.white, size: 18),
              ),
              SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kuis Terkoneksi Rapor Siswa',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate900,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Nilai otomatis dikonversi ke Nilai Formatif TIK',
                      style: TextStyle(fontSize: 11, color: AppColors.slate600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.cloud_done_rounded,
                  color: AppColors.sky600, size: 20),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Kartu ringkasan kuis formatif
        GlassMorphismBox(
          borderRadius: 30,
          opacity: 0.48,
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.sky50.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.sky200),
                    ),
                    child: Text(
                      semesterLabel.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.sky700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.emerald50.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.emerald200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sync_rounded,
                            size: 13, color: AppColors.emerald700),
                        SizedBox(width: 4),
                        Text(
                          'LIVE SYNC',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.emerald700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Kuis & Asesmen Mandiri',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.supervisor_account_rounded,
                      size: 15, color: AppColors.sky600),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'Sinkron dengan Guru: ',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.slate600),
                        children: [
                          TextSpan(
                            text: teacherName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate800,
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _metric(averageScore.toStringAsFixed(1),
                        'Skor Rerata', AppColors.sky600),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _metric('$completedCount/$totalCount', 'Tuntas Kuis',
                        AppColors.emerald700),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: _streakMetric()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _metric(String value, String label, Color color) {
    return GlassMorphismBox(
      borderRadius: 18,
      opacity: 0.36,
      blurSigma: 12,
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 6),
      boxShadow: [],
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: color),
          ),
          SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.slate600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _streakMetric() {
    return GlassMorphismBox(
      borderRadius: 18,
      opacity: 0.36,
      blurSigma: 12,
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 6),
      boxShadow: [],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_fire_department_rounded,
                  size: 17, color: const Color(0xFF39B8FD)),
              SizedBox(width: 3),
              Text(
                '$streakDays',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(
            'Hari Streak',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.slate600,
            ),
          ),
        ],
      ),
    );
  }
}