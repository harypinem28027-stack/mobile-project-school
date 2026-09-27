import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Kartu tips coding untuk pemula di bagian bawah HomePage.
class TipsCard extends StatelessWidget {
  const TipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.amber50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.amber200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 2),
            decoration:
                BoxDecoration(color: AppColors.amber200.withOpacity(0.7), shape: BoxShape.circle),
            child: const Icon(Icons.lightbulb_outline, color: AppColors.amber800, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'TIPS CODING PEMULA',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: AppColors.amber900,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Sintaks Dasar',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: AppColors.amber700),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 12, color: AppColors.amber900, height: 1.5),
                    children: [
                      TextSpan(text: 'Selalu periksa sepasang tag buka dan tutup seperti '),
                      TextSpan(
                        text: '<p>...</p>',
                        style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ' serta tanda kurung '),
                      TextSpan(
                        text: 'alert()',
                        style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ' agar tidak terjadi error sintaks.'),
                    ],
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
