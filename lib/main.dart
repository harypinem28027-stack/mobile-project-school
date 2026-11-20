import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

import 'pages/splash_page.dart';
import 'theme/app_colors.dart';
import 'theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    UserProfile.instance.load(),
    ThemeController.instance.load(),
  ]);
  runApp(const DebugTikApp());
}

class DebugTikApp extends StatelessWidget {
  const DebugTikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'DebugTIK',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeController.instance.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            fontFamily: 'Inter',
            scaffoldBackgroundColor: AppColors.slate50,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF4F46E5),
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            fontFamily: 'Inter',
            scaffoldBackgroundColor: AppColors.slate50,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF818CF8),
              brightness: Brightness.dark,
            ),
          ),
          home: SplashPage(),
        );
      },
    );
  }
}