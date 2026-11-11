import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'pages/splash_page.dart';
import 'services/leaderboard_service.dart';
import 'theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Login anonim di belakang layar, supaya leaderboard bisa dibaca/ditulis.
  try {
    await LeaderboardService().ensureSignedIn();
  } catch (_) {
    // Offline saat pertama buka: tidak apa-apa, dicoba lagi nanti.
  }

  runApp(const DebugTikApp());
}

class DebugTikApp extends StatelessWidget {
  const DebugTikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DebugTIK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.slate50,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.sky600),
      ),
      home: const SplashPage(),
    );
  }
}
