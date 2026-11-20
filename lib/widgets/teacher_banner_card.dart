import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'glass_morphism_box.dart';

/// Kapsul kaca ramping info guru pengampu (menghilangkan teks teknis database).
class TeacherBannerCard extends StatelessWidget {
  final String name;
  final String idGuru;
  final String email;
  final String infoText;

  TeacherBannerCard({
    super.key,
    this.name = 'Bpk. Hendra Pratama, S.Kom',
    this.idGuru = 'id_guru: GRU-01',
    this.email = 'hendra.guru@sekolah.sch.id',
    this.infoText = 'GURU mengelola 6 MATERI_BELAJAR',
  });

  @override
  Widget build(BuildContext context) {
    return GlassMorphismBox(
      borderRadius: 999,
      opacity: 0.44,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.sky50.withOpacity(0.9),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.sky200),
            ),
            child: Icon(
              Icons.person_pin_rounded,
              color: AppColors.sky600,
              size: 16,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Pengampu: ',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: AppColors.slate500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: name,
                    style: TextStyle(
                      fontSize: 12,
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
    );
  }
}