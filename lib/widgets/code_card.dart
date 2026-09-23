import 'package:flutter/material.dart';
import '../models/code_line.dart';

class CodeCard extends StatelessWidget {
  const CodeCard({
    super.key,
    required this.title,
    required this.filename,
    required this.accent,
    required this.codeLines,
    required this.footer,
  });

  final String title;
  final String filename;
  final Color accent;
  final List<CodeLine> codeLines;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accent.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
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
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: accent,
                    letterSpacing: 0.7,
                  ),
                ),
                const Spacer(),
                Text(
                  filename,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF94A3B8),
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: codeLines.map((line) => _buildCodeLine(line)).toList(),
            ),
          ),
          footer,
        ],
      ),
    );
  }

  Widget _buildCodeLine(CodeLine line) {
    final bool error = line.type == CodeType.error;
    final bool success = line.type == CodeType.success;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: error
            ? const Color(0x33F43F5E)
            : success
                ? const Color(0x3322C55E)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: error
            ? const Border(
                left: BorderSide(
                  color: Color(0xFFF43F5E),
                  width: 2,
                ),
              )
            : success
                ? const Border(
                    left: BorderSide(
                      color: Color(0xFF10B981),
                      width: 2,
                    ),
                  )
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
                color: error || success
                    ? (error
                        ? const Color(0xFFFB7185)
                        : const Color(0xFF34D399))
                    : const Color(0xFF64748B),
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildCodeText(
              line.text,
              error: error,
              success: success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeText(
    String text, {
    bool error = false,
    bool success = false,
  }) {
    if (error) {
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: Colors.white,
          ),
          children: [
            const TextSpan(
              text: 'collor',
              style: TextStyle(
                color: Color(0xFFFB7185),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFF43F5E),
                decorationThickness: 2,
              ),
            ),
            const TextSpan(
              text: ': ',
              style: TextStyle(color: Colors.white),
            ),
            const TextSpan(
              text: 'red',
              style: TextStyle(
                color: Color(0xFFFDA4AF),
              ),
            ),
            const TextSpan(
              text: ';',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    if (success) {
      return RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
          ),
          children: [
            TextSpan(
              text: 'color',
              style: TextStyle(
                color: Color(0xFF34D399),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ': ',
              style: TextStyle(color: Colors.white),
            ),
            TextSpan(
              text: 'red',
              style: TextStyle(
                color: Color(0xFF7DD3FC),
              ),
            ),
            TextSpan(
              text: ';',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontFamily: 'monospace',
        color: Color(0xFFE2E8F0),
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
