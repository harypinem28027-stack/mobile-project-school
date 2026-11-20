import 'package:flutter/material.dart';

import 'package:mobile_project/data/user_profile.dart';
import '../theme/app_colors.dart';
import 'glass_morphism_box.dart';

/// Baris sapaan "Halo, {nama}" + badge Live Sync kaca + info kelas.
class GreetingSection extends StatelessWidget {
  final String? userName;
  final String className;

  GreetingSection({
    super.key,
    this.userName,
    this.className = 'Kelas XI TIK 2 • Pemrograman Web & Logika',
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserProfile.instance,
      builder: (context, _) {
        final profileName = UserProfile.instance.name.trim();
        final displayName =
            userName ??
            (profileName.isEmpty
                ? 'Siswa'
                : profileName.split(RegExp(r'\s+')).first);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Halo, $displayName ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 21,
                      color: AppColors.slate900,
                      letterSpacing: -0.4,
                    ),
                    children: [TextSpan(text: '👋')],
                  ),
                ),
                GlassMorphismBox(
                  borderRadius: 999,
                  opacity: 0.52,
                  blurSigma: 14,
                  padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: AppColors.emerald500,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.emerald500.withOpacity(0.45),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Live Sync',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.emerald700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.school_rounded, size: 15, color: AppColors.sky600),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    className,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.slate600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}