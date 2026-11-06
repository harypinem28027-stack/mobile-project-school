import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

import '../../theme/app_colors.dart';

/// Kartu profil siswa + level & XP bar di bagian atas halaman Progres.
/// Nama, email, dan avatar dibaca dari profil saat halaman diperbarui.
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
    this.tagLabel = 'Dasar Web Pemula (HTML, CSS, JS)',
    this.levelTitle = 'Junior Code Medic',
    this.levelCode = 'Lv. 4',
    this.xpProgress = 0.78,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: avatar.gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(avatar.icon, color: Colors.white, size: 32),
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.military_tech,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            studentName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.slate900,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.slate100,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.slate200),
                          ),
                          child: Text(
                            studentId,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: AppColors.slate600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      studentEmail,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.slate500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.sky50,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.sky100),
                      ),
                      child: Text(
                        tagLabel,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.sky700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.slate100)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Color(0xFFD97706),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          levelTitle,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate800,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.amber50,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.amber200),
                          ),
                          child: Text(
                            levelCode,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: AppColors.amber700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${(xpProgress * 100).round()}% XP',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: xpProgress,
                    minHeight: 8,
                    backgroundColor: AppColors.slate100,
                    valueColor: const AlwaysStoppedAnimation(AppColors.sky600),
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
