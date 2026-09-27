import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Kotak notice/info generic (ikon + judul opsional + teks).
/// Dipakai untuk "Skenario Masalah", tips guru, catatan komparasi, dst —
/// tinggal ganti warna & ikonnya lewat parameter.
class NoticeCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String? title;
  final String message;
  final Color background;
  final Color? border;
  final TextStyle? messageStyle;

  const NoticeCard({
    super.key,
    required this.icon,
    required this.iconColor,
    this.title,
    required this.message,
    this.background = AppColors.slate100,
    this.border,
    this.messageStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: border != null ? Border.all(color: border!) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.slate900),
                  ),
                  const SizedBox(height: 6),
                ],
                Text(
                  message,
                  style: messageStyle ??
                      const TextStyle(fontSize: 14, height: 1.5, color: AppColors.slate700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
