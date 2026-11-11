import 'package:flutter/material.dart';

import 'package:mobile_project/data/user_profile.dart';
import '../theme/app_colors.dart';
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
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: const Border(bottom: BorderSide(color: AppColors.slate200)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.sky600,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: AppColors.sky600.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2))],
            ),
            child: const Icon(Icons.terminal, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.slate900, letterSpacing: -0.3)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.sky100, borderRadius: BorderRadius.circular(999)),
                    child: Text(badgeText, style: const TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.sky700)),
                  ),
                ],
              ),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.slate500, fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onSearchTap ?? () {},
            icon: const Icon(Icons.search, color: AppColors.slate600),
          ),
          ListenableBuilder(
            listenable: UserProfile.instance,
            builder: (context, _) {
              final avatar = UserProfile.instance.avatar;
              return GestureDetector(
                onTap: () => showProfileSettingsSheet(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: avatar.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: Icon(avatar.icon, color: Colors.white, size: 18),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}