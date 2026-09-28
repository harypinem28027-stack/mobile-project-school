import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Kartu "Tips Mengerjakan Kuis TIK" + accordion FAQ singkat tentang
/// cara kerja penilaian otomatis.
class QuizTipsCard extends StatelessWidget {
  const QuizTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.lightbulb, color: AppColors.sky600, size: 18),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tips Mengerjakan Kuis TIK',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.slate900)),
                    Text('Panduan teknis pengujian instan',
                        style: TextStyle(fontSize: 11, color: AppColors.slate500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.slate50, borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.terminal, size: 18, color: AppColors.sky600),
                const SizedBox(width: 8),
                Expanded(
                  child: const Text(
                    'Setiap soal pilihan ganda & isian simbolik langsung diverifikasi otomatis. '
                    'Pastikan tidak ada spasi ilegal pada atribut tag HTML atau titik koma yang tertinggal pada blok script!',
                    style: TextStyle(fontSize: 12, color: AppColors.slate700, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 10),
              childrenPadding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
              backgroundColor: AppColors.slate50,
              collapsedBackgroundColor: AppColors.slate50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Row(
                children: const [
                  Icon(Icons.help_outline, size: 16, color: AppColors.sky600),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text('Cara kerja penilaian otomatis?',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.slate900)),
                  ),
                ],
              ),
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '1. Jawaban kuis dipadankan dengan kunci jawaban pada basis data evaluasi guru.\n\n'
                    '2. Umpan balik debugging langsung diulas jika ditemukan eror logika atau galat sintaks.',
                    style: TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.5),
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
