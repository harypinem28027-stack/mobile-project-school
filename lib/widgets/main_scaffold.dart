import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_bottom_nav.dart';
import 'app_header.dart';

/// Scaffold utama yang dipakai SEMUA halaman.
///
/// Ini bungkusan header + body + bottom navbar. Di halaman baru,
/// tinggal panggil:
/// ```dart
/// return MainScaffold(
///   currentIndex: 2, // index tab aktif
///   body: Column(...), // isi halamanmu
/// );
/// ```
/// tanpa perlu menulis ulang header/bottom nav.
class MainScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final String headerTitle;
  final String headerSubtitle;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    this.headerTitle = 'DebugTIK',
    this.headerSubtitle = 'Modul Pembelajaran',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppHeader(title: headerTitle, subtitle: headerSubtitle),
            Expanded(child: body),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: currentIndex),
    );
  }
}
