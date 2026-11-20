import 'package:flutter/material.dart';
import 'theme_controller.dart';

/// Palet warna adaptif (Eye-Care Soft Light Mode & Clear Dark Mode) untuk DebugTIK.
class AppColors {
  static bool get isDark => ThemeController.instance.isDark;

  // Primary Accent
  static Color get sky600 =>
      isDark ? const Color(0xFF818CF8) : const Color(0xFF4338CA);
  static Color get sky700 =>
      isDark ? const Color(0xFFC7D2FE) : const Color(0xFF312E81);
  static Color get sky50 =>
      isDark ? const Color(0xFF1E1B4B) : const Color(0xFFDCE3F5);
  static Color get sky100 =>
      isDark ? const Color(0xFF312E81) : const Color(0xFFCFD8EE);
  static Color get sky200 =>
      isDark ? const Color(0xFF3730A3) : const Color(0xFFB8C4E6);

  // Neutral Slate (Light Mode dibuat redup/teduh agar tidak silau)
  static Color get slate50 =>
      isDark ? const Color(0xFF090D16) : const Color(0xFFDCE2EC);
  static Color get slate100 =>
      isDark ? const Color(0xFF111827) : const Color(0xFFD2DAE6);
  static Color get slate200 =>
      isDark ? const Color(0xFF1F2937) : const Color(0xFFBFC9D9);
  static Color get slate300 =>
      isDark ? const Color(0xFF374151) : const Color(0xFFA3B1C6);
  static Color get slate400 =>
      isDark ? const Color(0xFF6B7280) : const Color(0xFF64748B);
  static Color get slate500 =>
      isDark ? const Color(0xFF9CA3AF) : const Color(0xFF475569);
  static Color get slate600 =>
      isDark ? const Color(0xFFD1D5DB) : const Color(0xFF334155);
  static Color get slate700 =>
      isDark ? const Color(0xFFE5E7EB) : const Color(0xFF1E293B);
  static Color get slate800 =>
      isDark ? const Color(0xFFF3F4F6) : const Color(0xFF162032);
  static Color get slate900 =>
      isDark ? const Color(0xFFF9FAFB) : const Color(0xFF0F172A);

  // Permukaan kartu / input kaca adaptif (tanpa pantulan putih menyengat)
  static Color get glassFill => isDark
      ? const Color(0xFF0F172A).withOpacity(0.28)
      : const Color(0xFFE8EDF5).withOpacity(0.72);
  static Color get glassBorder => isDark
      ? Colors.white.withOpacity(0.20)
      : Colors.white.withOpacity(0.58);

  // Status: Sukses / Selesai
  static Color get emerald50 =>
      isDark ? const Color(0xFF064E3B) : const Color(0xFFD1EFE3);
  static Color get emerald200 =>
      isDark ? const Color(0xFF047857) : const Color(0xFF86D4B6);
  static const Color emerald500 = Color(0xFF10B981);
  static Color get emerald700 =>
      isDark ? const Color(0xFF34D399) : const Color(0xFF065F46);
  static Color get emerald950 =>
      isDark ? const Color(0xFFD1FAE5) : const Color(0xFF022C22);

  // Status: Peringatan / Level
  static Color get amber50 =>
      isDark ? const Color(0xFF451A03) : const Color(0xFFF3E6C8);
  static Color get amber100 =>
      isDark ? const Color(0xFF78350F) : const Color(0xFFebd7ad);
  static const Color amber200 = Color(0xFFE5C585);
  static const Color amber300 = Color(0xFFFCD34D);
  static Color get amber700 =>
      isDark ? const Color(0xFFFBBF24) : const Color(0xFF92400E);
  static Color get amber800 =>
      isDark ? const Color(0xFFFDE68A) : const Color(0xFF78350F);
  static Color get amber900 =>
      isDark ? const Color(0xFFFEF3C7) : const Color(0xFF5C280B);

  static Color get orange50 =>
      isDark ? const Color(0xFF431407) : const Color(0xFFF5DFD3);
  static const Color orange600 = Color(0xFFD94E0A);
  static Color get orange100 =>
      isDark ? const Color(0xFF7C2D12) : const Color(0xFFEDCCB8);

  // Status: Error / Kode Salah
  static const Color rose300 = Color(0xFFFDA4AF);
  static const Color rose400 = Color(0xFFFB7185);
}