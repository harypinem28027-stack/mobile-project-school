import 'package:flutter/material.dart';
import '../models/code_line.dart';
import 'code_card.dart';

class DiffView extends StatelessWidget {
  const DiffView({
    super.key,
    required this.sky,
    required this.slate200,
  });

  final Color sky;
  final Color slate200;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CodeCard(
          title: 'KODE BERMASALAH',
          filename: 'style.broken.css',
          accent: const Color(0xFFF43F5E),
          codeLines: [
            CodeLine(
              number: '1',
              text: 'h1 {',
              type: CodeType.normal,
            ),
            CodeLine(
              number: '2',
              text: '    collor: red;',
              type: CodeType.error,
            ),
            CodeLine(
              number: '3',
              text: '}',
              type: CodeType.normal,
            ),
          ],
          footer: _buildErrorFooter(),
        ),
        const SizedBox(height: 10),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: slate200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 4,
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_downward,
            size: 18,
            color: sky,
          ),
        ),
        const SizedBox(height: 10),
        CodeCard(
          title: 'KODE PERBAIKAN',
          filename: 'style.fixed.css',
          accent: const Color(0xFF10B981),
          codeLines: [
            CodeLine(
              number: '1',
              text: 'h1 {',
              type: CodeType.normal,
            ),
            CodeLine(
              number: '2',
              text: '    color: red;',
              type: CodeType.success,
            ),
            CodeLine(
              number: '3',
              text: '}',
              type: CodeType.normal,
            ),
          ],
          footer: _buildSuccessFooter(),
        ),
      ],
    );
  }

  Widget _buildErrorFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: const Color(0x331E293B),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFFB7185),
            size: 18,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Diagnosis Kesalahan CSS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFDA4AF),
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "⚠️ Properti 'collor' tidak dikenali oleh browser.",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFCBD5E1),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      color: const Color(0x2210B981),
      child: Row(
        children: [
          const Icon(
            Icons.verified,
            color: Color(0xFF34D399),
            size: 18,
          ),
          const SizedBox(width: 7),
          const Expanded(
            child: Text(
              'Berhasil! Teks judul kini berwarna merah cerah.',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF34D399),
                fontFamily: 'monospace',
              ),
            ),
          ),
          const Text(
            '0 Error',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xCC34D399),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
