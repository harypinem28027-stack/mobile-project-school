import 'package:flutter/material.dart';

import '../../models/bug_note.dart';
import '../../theme/app_colors.dart';
import '../glass_morphism_box.dart';

/// Kartu catatan bug bergaya Liquid Glass dengan kontras kode yang nyaman.
class BugNoteCard extends StatelessWidget {
  final BugNote note;
  const BugNoteCard({super.key, required this.note});

  Color get _categoryColor {
    switch (note.category) {
      case 'html':
        return AppColors.amber700;
      case 'css':
        return AppColors.sky700;
      case 'js':
      default:
        return AppColors.isDark
            ? const Color(0xFFFDA4AF)
            : const Color(0xFFBE123C);
    }
  }

  Color get _categoryBg {
    switch (note.category) {
      case 'html':
        return AppColors.amber50;
      case 'css':
        return AppColors.sky50;
      case 'js':
      default:
        return AppColors.isDark
            ? const Color(0xFF4C0519)
            : const Color(0xFFFFF1F2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return GlassMorphismBox(
      borderRadius: 26,
      opacity: 0.48,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                decoration: BoxDecoration(
                  color: _categoryBg.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isDark
                        ? _categoryColor.withOpacity(0.35)
                        : Colors.white.withOpacity(0.9),
                  ),
                ),
                child: Text(
                  note.categoryLabel,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: _categoryColor,
                  ),
                ),
              ),
              Text(
                note.date,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.slate500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            note.title,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: AppColors.slate900,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF0B1120)
                  : const Color(0xFF0F172A).withOpacity(0.94),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withOpacity(0.14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.filename,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '- ${note.wrongCode}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: AppColors.rose300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '+ ${note.correctCode}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: Color(0xFF6EE7B7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1E293B).withOpacity(0.65)
                  : Colors.white.withOpacity(0.58),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1.1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 17,
                  color: AppColors.sky600,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    note.solutionText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.slate700,
                      height: 1.45,
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