import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Kartu "modul yang sedang dikerjakan" lengkap dengan progress bar.
class ActiveModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String remainingTime;
  final double progress; // 0.0 - 1.0
  final VoidCallback? onContinue;
  final VoidCallback? onBookmark;

  const ActiveModuleCard({
    super.key,
    this.title = 'Modul 01: Mengenal Tag Dasar HTML & Kerangka Web',
    this.subtitle =
        'Unit 1: Mengenal Struktur Kerangka Web, Tag <h1>, <p>, <a>, dan <img>',
    this.remainingTime = 'Sisa ~25 Mnt',
    this.progress = 0.68,
    this.onContinue,
    this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.sky50, Colors.white, Color(0xFFEFF6FF)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.sky200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    color: AppColors.sky600, borderRadius: BorderRadius.circular(999)),
                child: const Text(
                  'MODUL AKTIF',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.amber100.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer_outlined, size: 15, color: AppColors.amber700),
                    const SizedBox(width: 4),
                    Text(
                      remainingTime,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.amber700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.slate900),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Penyelesaian Modul',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.slate600)),
              Text('${(progress * 100).round()}%',
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.sky700)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.slate200.withOpacity(0.8),
              valueColor: const AlwaysStoppedAnimation(AppColors.sky600),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: onContinue ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sky600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Lanjut Belajar',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onBookmark,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.slate200),
                  ),
                  child: const Icon(Icons.bookmark, color: AppColors.slate600, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
