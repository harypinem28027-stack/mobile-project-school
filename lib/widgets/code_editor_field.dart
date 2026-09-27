import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Kotak editor kode gelap (mirip gaya CodeTerminalCard tapi bisa
/// diketik). Reusable untuk editor HTML/CSS/JS di Lab Test, atau fitur
/// "coba sendiri" lain nanti.
class CodeEditorField extends StatelessWidget {
  final TextEditingController controller;
  final String filename;
  final Color accent;
  final String hintText;

  const CodeEditorField({
    super.key,
    required this.controller,
    required this.filename,
    required this.accent,
    this.hintText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.slate900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8)],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            color: const Color(0xFF020617),
            child: Row(
              children: [
                _dot(accent),
                const SizedBox(width: 5),
                _dot(const Color(0xFFF59E0B)),
                const SizedBox(width: 5),
                _dot(const Color(0xFF475569)),
                const SizedBox(width: 9),
                Text(
                  filename,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              maxLines: 12,
              minLines: 8,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'monospace', height: 1.5),
              cursorColor: accent,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFF64748B), fontFamily: 'monospace', fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}
