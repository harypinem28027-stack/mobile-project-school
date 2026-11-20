import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'glass_morphism_box.dart';

class ActiveModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String remainingTime;
  final double progress;
  final VoidCallback? onContinue;
  final VoidCallback? onBookmark;

  ActiveModuleCard({
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
    return GlassMorphismBox(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.sky600, const Color(0xFF6366F1)],
                  ),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.sky600.withOpacity(0.28),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'MODUL AKTIF',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.amber50.withOpacity(0.80),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.amber200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_outlined,
                        size: 14, color: AppColors.amber700),
                    SizedBox(width: 4),
                    Text(
                      remainingTime,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.amber700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15.5,
              color: AppColors.slate900,
              height: 1.3,
            ),
          ),
          SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.slate600,
              height: 1.45,
            ),
          ),
          SizedBox(height: 14),
          GlassMorphismBox(
            borderRadius: 20,
            opacity: 0.35,
            blurSigma: 12,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            boxShadow: [],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Penyelesaian Modul',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate600,
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.sky600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: AppColors.slate200.withOpacity(0.75),
                    valueColor: AlwaysStoppedAnimation(AppColors.sky600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.sky600, const Color(0xFF6366F1)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.sky600.withOpacity(0.32),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: onContinue ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    icon: Icon(Icons.play_arrow_rounded, size: 20),
                    label: Text(
                      'Lanjut Belajar',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: onBookmark,
                child: GlassMorphismBox(
                  borderRadius: 999,
                  opacity: 0.55,
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.bookmark_rounded,
                    color: AppColors.sky600,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}