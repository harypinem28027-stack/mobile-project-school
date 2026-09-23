import 'package:flutter/material.dart';

class ComparisonView extends StatelessWidget {
  const ComparisonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _miniCodeCard(
                title: 'SALAH',
                code: 'h1 {\n  collor: red;\n}',
                color: const Color(0xFFF43F5E),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniCodeCard(
                title: 'BENAR',
                code: 'h1 {\n  color: red;\n}',
                color: const Color(0xFF10B981),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFA7F3D0),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.verified,
                color: Color(0xFF059669),
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Gunakan "color", bukan "collor".',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF047857),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miniCodeCard({
    required String title,
    required String code,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            code,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              height: 1.6,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
