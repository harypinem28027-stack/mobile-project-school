import 'dart:ui';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

/// Komponen reusable bergaya Glassmorphism & Liquid Glass yang adaptif
/// terhadap Eye-Care Light Mode & Clear Dark Mode serta tetap mulus 60fps.
class GlassMorphismBox extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double blurSigma;
  final double opacity;
  final Color? tintColor;
  final List<BoxShadow>? boxShadow;
  final bool enableBlur;

  const GlassMorphismBox({
    super.key,
    required this.child,
    this.borderRadius = 26,
    this.padding,
    this.blurSigma = 22,
    this.opacity = 0.42,
    this.tintColor,
    this.boxShadow,
    this.enableBlur = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    final isDark = ThemeController.instance.isDark;

    final Widget glassSurface;

    if (isDark) {
      final sheenAlpha = (opacity * 0.22).clamp(0.06, 0.16);
      final midAlpha = (opacity * 0.46).clamp(0.14, 0.36);
      final bottomAlpha = (opacity * 0.54).clamp(0.16, 0.42);

      final baseDark = (tintColor != null && tintColor != Colors.white)
          ? tintColor!
          : const Color(0xFF0F172A);

      glassSurface = Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(
            color: Colors.white.withOpacity(0.20),
            width: 1.2,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.48, 1.0],
            colors: [
              Colors.white.withOpacity(sheenAlpha),
              baseDark.withOpacity(midAlpha),
              Color.lerp(baseDark, const Color(0xFF312E81), 0.35)!
                  .withOpacity(bottomAlpha),
            ],
          ),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.22),
                  blurRadius: 16,
                  spreadRadius: -3,
                  offset: const Offset(0, 6),
                ),
              ],
        ),
        child: child,
      );
    } else {
      // Soft Eye-Care Light Glass: tidak memakai putih menyengat (#FFFFFF)
      final effectiveTint = (tintColor == null || tintColor == Colors.white)
          ? const Color(0xFFE9EEF6)
          : tintColor!;
      final topAlpha = (opacity + 0.22).clamp(0.38, 0.76);
      final midAlpha = (opacity + 0.10).clamp(0.30, 0.66);
      final bottomAlpha = (opacity + 0.16).clamp(0.34, 0.72);

      glassSurface = Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(
            color: Colors.white.withOpacity(0.55),
            width: 1.2,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.52, 1.0],
            colors: [
              effectiveTint.withOpacity(topAlpha),
              effectiveTint.withOpacity(midAlpha),
              Color.lerp(effectiveTint, const Color(0xFFD5DDF0), 0.45)!
                  .withOpacity(bottomAlpha),
            ],
          ),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: const Color(0xFF1E293B).withOpacity(0.07),
                  blurRadius: 14,
                  spreadRadius: -2,
                  offset: const Offset(0, 6),
                ),
              ],
        ),
        child: child,
      );
    }

    if (!enableBlur) {
      return glassSurface;
    }

    final safeSigma = blurSigma.clamp(0.0, 8.0);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: safeSigma, sigmaY: safeSigma),
        child: glassSurface,
      ),
    );
  }
}