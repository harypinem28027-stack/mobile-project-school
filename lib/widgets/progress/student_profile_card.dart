import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

import '../../theme/app_colors.dart';
import '../glass_morphism_box.dart';

/// Kartu profil siswa bergaya Liquid Glass di bagian atas halaman Progres.
class StudentProfileCard extends StatelessWidget {
  final String studentName;
  final String studentEmail;
  final AvatarOption avatar;
  final String studentId;
  final String tagLabel;
  final String levelTitle;
  final String levelCode;
  final double xpProgress; // 0.0 - 1.0

  const StudentProfileCard({
    super.key,
    required this.studentName,
    required this.studentEmail,
    required this.avatar,
    this.studentId = 'SIS-2026-0891',
    this.tagLabel = 'Dasar Web (HTML, CSS, JS)',
    this.levelTitle = 'Junior Code Medic',
    this.levelCode = 'Lv. 4',
    this.xpProgress = 0.78,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return GlassMorphismBox(
      borderRadius: 28,
      opacity: 0.50,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: avatar.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.45)
                        : Colors.white.withOpacity(0.9),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: avatar.gradient.first.withOpacity(0.28),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(avatar.icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      studentEmail,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.slate600,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.sky50.withOpacity(isDark ? 0.75 : 0.85),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isDark
                              ? AppColors.sky600.withOpacity(0.35)
                              : Colors.white.withOpacity(0.9),
                        ),
                      ),
                      child: Text(
                        tagLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.sky700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF090D16).withOpacity(0.38)
                  : Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.16)
                    : Colors.white.withOpacity(0.85),
                width: 1.1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.workspace_premium_rounded,
                          size: 17,
                          color: AppColors.sky600,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$levelTitle ($levelCode)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate800,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${(xpProgress * 100).round()}% XP',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.sky600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.12)
                        : AppColors.slate200.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: xpProgress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        gradient: LinearGradient(
                          colors: [AppColors.sky600, const Color(0xFF6366F1)],
                        ),
                      ),
                    ),
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