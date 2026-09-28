import 'package:flutter/material.dart';

import '../../models/bug_note.dart';
import '../../theme/app_colors.dart';

/// Kartu satu catatan bug: kode salah vs benar (gaya terminal gelap) +
/// solusi singkat dari guru.
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
        return const Color(0xFFBE123C);
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
        return const Color(0xFFFFF1F2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: _categoryBg, borderRadius: BorderRadius.circular(6), border: Border.all(color: _categoryColor.withOpacity(0.3))),
                      child: Text(note.categoryLabel,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.w800, color: _categoryColor)),
                    ),
                    _tinyBadge(note.materialId),
                    _tinyBadge(note.quizId),
                  ],
                ),
              ),
              Text(note.date, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.slate400)),
            ],
          ),
          const SizedBox(height: 8),
          Text(note.title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.slate900)),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.slate900, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _dot(const Color(0xFFF43F5E)),
                    const SizedBox(width: 4),
                    _dot(const Color(0xFFF59E0B)),
                    const SizedBox(width: 4),
                    _dot(const Color(0xFF10B981)),
                    const SizedBox(width: 8),
                    Text(note.filename, style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF94A3B8))),
                  ],
                ),
                Container(margin: const EdgeInsets.symmetric(vertical: 8), height: 1, color: const Color(0xFF334155)),
                Text(note.wrongCode, style: const TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: Color(0xFFFB7185))),
                const SizedBox(height: 4),
                Text(note.correctCode, style: const TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: Color(0xFF34D399))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb, size: 17, color: Color(0xFFF59E0B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 12, color: AppColors.slate700, height: 1.5),
                    children: [
                      const TextSpan(text: 'Solusi: ', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.slate900)),
                      TextSpan(text: note.solutionText),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tinyBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: AppColors.slate600)),
    );
  }

  Widget _dot(Color color) => Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}
