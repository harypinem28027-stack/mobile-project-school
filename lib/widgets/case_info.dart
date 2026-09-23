import 'package:flutter/material.dart';

class CaseInfo extends StatelessWidget {
  const CaseInfo({
    super.key,
    required this.sky,
    required this.skyDark,
  });

  final Color sky;
  final Color skyDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _badge(
                'CASE STUDY #01',
                background: const Color(0xFFF0F9FF),
                foreground: skyDark,
                border: const Color(0xFFBAE6FD),
              ),
              _smallCodeBadge('id_materi: CSS-01'),
              _smallCodeBadge('id_lab: LAB-01'),
              _badge(
                '●  CSS Syntax Error: Typo',
                background: const Color(0xFFFFF1F2),
                foreground: const Color(0xFFBE123C),
                border: const Color(0xFFFECDD3),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Bedah Kasus Sederhana #01: '
            'Teks Tidak Berwarna Merah (CSS Typo)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _infoChip(
                Icons.code,
                'CSS Dasar',
                sky,
              ),
              _infoChip(
                Icons.signal_cellular_alt,
                'Tingkat: Pemula',
                const Color(0xFF059669),
              ),
              _infoChip(
                Icons.person_outline,
                'Kelas X / Siswa Baru',
                sky,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(
    String text, {
    required Color background,
    required Color foreground,
    required Color border,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: border),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: foreground,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _smallCodeBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF475569),
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _infoChip(
    IconData icon,
    String text,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }
}
