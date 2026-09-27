import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/main_scaffold.dart';

/// Halaman Progres (tab index 3).
class ProgresPage extends StatelessWidget {
  const ProgresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 3,
      headerSubtitle: 'Progres Belajar',
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.insights_outlined, size: 48, color: AppColors.slate400),
              SizedBox(height: 12),
              Text(
                'Halaman Progres',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.slate800),
              ),
              SizedBox(height: 4),
              Text(
                'Ringkasan progres belajar siswa akan ditampilkan di sini.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.slate500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
