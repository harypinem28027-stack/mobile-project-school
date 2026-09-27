import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'theme/app_colors.dart';

void main() {
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
      home: const HomePage(),
    );
  }
}
