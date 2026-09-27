import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Header/top-bar aplikasi yang reusable.
///
/// Dipakai lewat [MainScaffold], tapi juga bisa dipanggil langsung
/// di halaman manapun kalau butuh header custom:
/// ```dart
/// const AppHeader(
///   title: 'DebugTIK',
///   subtitle: 'Studi Kasus',
///   avatarUrl: 'https://...',
///   onSearchTap: myFunction,
/// )
/// ```
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String badgeText;
  final String subtitle;
  final String avatarUrl;
  final VoidCallback? onSearchTap;

  const AppHeader({
    super.key,
    this.title = 'DebugTIK',
    this.badgeText = 'EduTIK',
    this.subtitle = 'Modul Pembelajaran',
    this.avatarUrl =
        'https://lh3.googleusercontent.com/aida/AEtjO1UrPunaegfIutXi67dQ_V8EiUtXlmvw7asMO1r46nxFIA3vZVJa1g4rZRyRzI24M75oYmLihiHH6AP0Y_OtAHvpNGbVTH1Btr09STwP1Ql66hIOsmpra6qnz0yT2J_d9c7C4gBe082CONu4UBEDrcGk_mc-RXjjzfi7wEa4I0ILwYNB-1_qkePDbusjji-JtGX122ND0bsajKpRhHJ82GgDbAQ4mrZ0-Oo9tAbxUEZjWaZXiwYbBq8anEM',
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.sky600,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.sky600.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.terminal, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColors.slate900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.sky100,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky700,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.slate500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onSearchTap ?? () {},
            icon: const Icon(Icons.search, color: AppColors.slate600),
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.slate200,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.emerald500,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
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
