import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

import 'pages/splash_page.dart';
import 'theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserProfile.instance.load();
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