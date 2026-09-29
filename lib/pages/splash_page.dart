import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import 'home_page.dart';
import 'login_page.dart';

/// Halaman pembuka: dicek sekali saat app baru dibuka untuk menentukan
/// tujuan pertama — langsung ke HomePage (kalau sudah pernah login)
/// atau ke LoginPage (kalau belum). Dipakai sebagai `home:` di main.dart.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await AuthService.isLoggedIn();
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => loggedIn ? const HomePage() : const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: AppColors.sky600, borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.terminal, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 16),
            const Text('DebugTIK', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.slate900)),
            const SizedBox(height: 20),
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.sky600),
            ),
          ],
        ),
      ),
    );
  }
}
