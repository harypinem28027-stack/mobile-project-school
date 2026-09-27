import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Kartu info guru pengampu kelas.
class TeacherBannerCard extends StatelessWidget {
  final String name;
  final String idGuru;
  final String email;
  final String infoText;

  const TeacherBannerCard({
    super.key,
    this.name = 'Bpk. Hendra Pratama, S.Kom',
    this.idGuru = 'id_guru: GRU-01',
    this.email = 'hendra.guru@sekolah.sch.id',
    this.infoText = 'GURU mengelola 6 MATERI_BELAJAR',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200.withOpacity(0.8)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.sky50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.sky100),
            ),
            child: const Icon(Icons.badge_outlined, color: AppColors.sky600, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate900),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.slate100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        idGuru,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.slate600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(fontSize: 11, color: AppColors.slate500),
                    children: [
                      TextSpan(text: '$email • '),
                      TextSpan(
                        text: infoText,
                        style: const TextStyle(
                            color: AppColors.sky700, fontWeight: FontWeight.w500),
                      ),
                    ],
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
