import 'package:flutter/material.dart';

import '../models/case_study.dart';
import '../theme/app_colors.dart';

/// Kartu kode bergaya "terminal gelap" dengan title bar (dot merah/kuning/
/// abu), nomor baris, dan pewarnaan per baris/kata. Reusable untuk:
/// - kartu "kode bermasalah"/"kode perbaikan" di Studi Kasus
/// - preview kode di Lab Test
class CodeTerminalCard extends StatelessWidget {
  final String title;
  final String filename;
  final Color accent;
  final List<CodeLine> codeLines;
  final Widget? footer;

  const CodeTerminalCard({
    super.key,
    required this.title,
    required this.filename,
    required this.accent,
    required this.codeLines,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.slate900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8)],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildTitleBar(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: codeLines.map(_buildLine).toList()),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      color: const Color(0xFF020617),
      child: Row(
        children: [
          Row(
            children: [
              _dot(accent),
              const SizedBox(width: 5),
              _dot(const Color(0xFFF59E0B)),
              const SizedBox(width: 5),
              _dot(const Color(0xFF475569)),
            ],
          ),
          const SizedBox(width: 9),
          Text(
            title,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w700, color: accent, letterSpacing: 0.7),
          ),
          const Spacer(),
          Text(
            filename,
            style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildLine(CodeLine line) {
    final error = line.type == CodeLineType.error;
    final success = line.type == CodeLineType.success;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
      decoration: BoxDecoration(
        color: error
            ? const Color(0x33F43F5E)
            : success
                ? const Color(0x3322C55E)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: error
            ? const Border(left: BorderSide(color: Color(0xFFF43F5E), width: 2))
            : success
                ? const Border(left: BorderSide(color: Color(0xFF10B981), width: 2))
                : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25,
            child: Text(
              line.number,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: error
                    ? const Color(0xFFFB7185)
                    : success
                        ? const Color(0xFF34D399)
                        : const Color(0xFF64748B),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: _buildText(line)),
        ],
      ),
    );
  }

  Widget _buildText(CodeLine line) {
    if (line.spans != null) {
      return RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: Colors.white),
          children: line.spans!
              .map((s) => TextSpan(
                    text: s.text,
                    style: TextStyle(
                      color: s.color ?? Colors.white,
                      fontWeight: s.bold ? FontWeight.bold : FontWeight.normal,
                      decoration: s.underline ? TextDecoration.underline : null,
                      decorationColor: const Color(0xFFF43F5E),
                      decorationThickness: 2,
                    ),
                  ))
              .toList(),
        ),
      );
    }
    return Text(
      line.text,
      style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: Color(0xFFE2E8F0)),
    );
  }
}

/// Footer kecil untuk feedback error/berhasil di bawah CodeTerminalCard.
class CodeFeedbackFooter extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final String? title;
  final String message;
  final String? trailing;

  const CodeFeedbackFooter({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    this.title,
    required this.message,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: color,
                        fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 3),
                ],
                Text(
                  message,
                  style: TextStyle(fontSize: 11, color: color.withOpacity(0.85), height: 1.4),
                ),
              ],
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: TextStyle(fontSize: 10, color: color.withOpacity(0.8), fontFamily: 'monospace'),
            ),
        ],
      ),
    );
  }
}
