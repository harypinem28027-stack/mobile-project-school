import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_project/data/user_profile.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import 'eclipse_theme_toggle.dart';
import 'glass_morphism_box.dart';
import 'profile/profile_settings_sheet.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String badgeText;
  final String subtitle;
  final VoidCallback? onSearchTap;

  const AppHeader({
    super.key,
    this.title = 'DebugTIK',
    this.badgeText = 'EduTIK',
    this.subtitle = 'Modul Pembelajaran',
    this.onSearchTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withOpacity(isDark ? 0.25 : 0.65),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withOpacity(0.28),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.terminal_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: AppColors.slate900,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GlassMorphismBox(
                      borderRadius: 999,
                      opacity: 0.55,
                      blurSigma: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      boxShadow: const [],
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.sky700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: AppColors.slate500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          EclipseThemeToggle(
            width: 68,
            height: 34,
            isDark: ThemeController.instance.isDark,
            onToggle: ThemeController.instance.toggleTheme,
          ),
          const SizedBox(width: 10),
          ListenableBuilder(
            listenable: UserProfile.instance,
            builder: (context, _) {
              final profile = UserProfile.instance;
              final avatar = profile.avatar;

              return Tooltip(
                message: 'Kartu Pelajar • ${profile.name}',
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    showProfileSettingsSheet(context);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Cincin gradasi luar yang menyala sesuai warna avatar
                      Container(
                        padding: const EdgeInsets.all(2.4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              avatar.gradient.first.withOpacity(0.9),
                              Colors.white.withOpacity(isDark ? 0.28 : 0.85),
                              avatar.gradient.last.withOpacity(0.9),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: avatar.gradient.first
                                  .withOpacity(isDark ? 0.34 : 0.22),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: avatar.gradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF090D16)
                                  : const Color(0xFFDCE2EC),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            avatar.icon,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ),
                      // Lencana mini panah bawah sebagai penanda tombol interaktif
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFF1F5FB),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withOpacity(0.28)
                                  : AppColors.slate300,
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.18),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.expand_more_rounded,
                            size: 11,
                            color: AppColors.sky600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}