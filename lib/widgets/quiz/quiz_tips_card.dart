import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../glass_morphism_box.dart';

/// Kartu "Tips Mengerjakan Kuis TIK" bergaya Liquid Glass.
class QuizTipsCard extends StatelessWidget {
  const QuizTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;
    final innerSurface = isDark
        ? const Color(0xFF1E293B).withOpacity(0.65)
        : Colors.white.withOpacity(0.48);

    return GlassMorphismBox(
      borderRadius: 28,
      opacity: 0.46,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.sky50.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.sky200),
                ),
                child: Icon(
                  Icons.lightbulb_rounded,
                  color: AppColors.sky600,
                  size: 19,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tips Mengerjakan Kuis TIK',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Panduan teknis pengujian instan',
                      style: TextStyle(fontSize: 11.5, color: AppColors.slate600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: innerSurface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.slate200.withOpacity(0.85)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.terminal_rounded, size: 18, color: AppColors.sky600),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Setiap soal pilihan ganda & isian simbolik langsung diverifikasi otomatis. '
                    'Pastikan tidak ada spasi ilegal pada atribut tag HTML atau titik koma yang tertinggal pada blok script!',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.slate700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Container(
              decoration: BoxDecoration(
                color: innerSurface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.slate200.withOpacity(0.85)),
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                backgroundColor: Colors.transparent,
                collapsedBackgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                title: Row(
                  children: [
                    Icon(
                      Icons.help_outline_rounded,
                      size: 17,
                      color: AppColors.sky600,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cara kerja penilaian otomatis?',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate900,
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '1. Jawaban kuis dipadankan dengan kunci jawaban pada basis data evaluasi guru.\n\n'
                      '2. Umpan balik debugging langsung diulas jika ditemukan eror logika atau galat sintaks.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.slate600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}