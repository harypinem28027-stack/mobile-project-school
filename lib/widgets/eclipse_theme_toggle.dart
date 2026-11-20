import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EclipseThemeToggle extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggle;
  final double width;
  final double height;

  const EclipseThemeToggle({
    super.key,
    required this.isDark,
    required this.onToggle,
    this.width = 76,
    this.height = 38,
  });

  @override
  State<EclipseThemeToggle> createState() => _EclipseThemeToggleState();
}

class _EclipseThemeToggleState extends State<EclipseThemeToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curved;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 620),
      value: widget.isDark ? 1.0 : 0.0,
    );
    _curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void didUpdateWidget(covariant EclipseThemeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDark != oldWidget.isDark) {
      if (widget.isDark) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.selectionClick();
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: _handleTap,
        behavior: HitTestBehavior.opaque,
        child: Tooltip(
          message:
              widget.isDark ? 'Beralih ke Tema Terang' : 'Beralih ke Tema Gelap',
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: AnimatedBuilder(
              animation: _curved,
              builder: (context, _) {
                return CustomPaint(
                  size: Size(widget.width, widget.height),
                  painter: _EclipseTogglePainter(progress: _curved.value),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _EclipseTogglePainter extends CustomPainter {
  final double progress;

  _EclipseTogglePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress.clamp(0.0, 1.0);
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(size.height / 2));

    final outerBorderPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.lerp(const Color(0xFFFFFFFF), const Color(0xFF475569), t)!,
          Color.lerp(const Color(0xFF94A3B8), const Color(0xFF0F172A), t)!,
        ],
      ).createShader(rect);
    canvas.drawRRect(rrect, outerBorderPaint);

    const double borderThickness = 2.0;
    final innerRect = rect.deflate(borderThickness);
    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      Radius.circular(innerRect.height / 2),
    );

    canvas.save();
    canvas.clipRRect(innerRRect);

    final skyTop = t < 0.65
        ? Color.lerp(
            const Color(0xFFBAE6FD),
            const Color(0xFF1E1B4B),
            (t / 0.65).clamp(0.0, 1.0),
          )!
        : Color.lerp(
            const Color(0xFF1E1B4B),
            const Color(0xFF070B14),
            ((t - 0.65) / 0.35).clamp(0.0, 1.0),
          )!;

    final skyBottom = t < 0.65
        ? Color.lerp(
            const Color(0xFFE0F2FE),
            const Color(0xFF9A3412),
            (t / 0.65).clamp(0.0, 1.0),
          )!
        : Color.lerp(
            const Color(0xFF9A3412),
            const Color(0xFF111827),
            ((t - 0.65) / 0.35).clamp(0.0, 1.0),
          )!;

    canvas.drawRect(
      innerRect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [skyTop, skyBottom],
        ).createShader(innerRect),
    );

    final padding = innerRect.height * 0.14;
    final bodyRadius = (innerRect.height / 2) - padding;
    final leftX = innerRect.left + padding + bodyRadius;
    final rightX = innerRect.right - padding - bodyRadius;
    final centerY = innerRect.center.dy;

    final sunX = leftX + (rightX - leftX) * t;
    final sunCenter = Offset(sunX, centerY);
    final moonCenter = Offset(rightX, centerY);

    final dayAlpha = (1.0 - t * 1.4).clamp(0.0, 1.0);
    if (dayAlpha > 0.01) {
      final beamPaint = Paint()
        ..color = Colors.white.withOpacity(0.24 * dayAlpha);
      for (int i = 0; i < 8; i++) {
        final angle = (i * math.pi / 4) + 0.2;
        final beamPath = Path()
          ..moveTo(sunCenter.dx, sunCenter.dy)
          ..lineTo(
            sunCenter.dx + math.cos(angle - 0.12) * size.width,
            sunCenter.dy + math.sin(angle - 0.12) * size.width,
          )
          ..lineTo(
            sunCenter.dx + math.cos(angle + 0.12) * size.width,
            sunCenter.dy + math.sin(angle + 0.12) * size.width,
          )
          ..close();
        canvas.drawPath(beamPath, beamPaint);
      }
    }

    final starAlpha = ((t - 0.55) / 0.45).clamp(0.0, 1.0);
    if (starAlpha > 0.01) {
      final starPositions = [
        Offset(innerRect.left + innerRect.width * 0.18,
            innerRect.top + innerRect.height * 0.28),
        Offset(innerRect.left + innerRect.width * 0.34,
            innerRect.top + innerRect.height * 0.68),
        Offset(innerRect.left + innerRect.width * 0.46,
            innerRect.top + innerRect.height * 0.26),
        Offset(innerRect.left + innerRect.width * 0.24,
            innerRect.top + innerRect.height * 0.52),
      ];
      for (int i = 0; i < starPositions.length; i++) {
        _drawSparkleStar(
          canvas,
          starPositions[i],
          (i % 2 == 0 ? 2.4 : 1.7) * starAlpha,
          Colors.white.withOpacity(0.85 * starAlpha),
        );
      }
    }

    final coronaStrength = ((t - 0.72) / 0.28).clamp(0.0, 1.0);
    if (coronaStrength > 0.01) {
      canvas.drawCircle(
        moonCenter,
        bodyRadius * 1.62,
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withOpacity(0.95 * coronaStrength),
              const Color(0xFFFEF08A).withOpacity(0.55 * coronaStrength),
              const Color(0xFF38BDF8).withOpacity(0.22 * coronaStrength),
              Colors.transparent,
            ],
            stops: const [0.52, 0.68, 0.84, 1.0],
          ).createShader(
            Rect.fromCircle(center: moonCenter, radius: bodyRadius * 1.62),
          ),
      );
    }

    final sunGlowRadius = bodyRadius * 1.48;
    canvas.drawCircle(
      sunCenter,
      sunGlowRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFDE047)
                .withOpacity(0.75 * (1.0 - coronaStrength * 0.5)),
            const Color(0xFFF59E0B)
                .withOpacity(0.25 * (1.0 - coronaStrength * 0.5)),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: sunCenter, radius: sunGlowRadius)),
    );

    canvas.drawCircle(
      sunCenter,
      bodyRadius * 0.96,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.25, -0.25),
          colors: const [
            Color(0xFFFFFBEB),
            Color(0xFFFDE047),
            Color(0xFFF59E0B),
            Color(0xFFEA580C),
          ],
          stops: const [0.0, 0.42, 0.78, 1.0],
        ).createShader(Rect.fromCircle(center: sunCenter, radius: bodyRadius)),
    );

    final moonPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        colors: [
          Color.lerp(const Color(0xFF64748B), const Color(0xFF1E293B), t)!,
          Color.lerp(const Color(0xFF334155), const Color(0xFF090D16), t)!,
          Color.lerp(const Color(0xFF1E293B), const Color(0xFF030712), t)!,
        ],
      ).createShader(Rect.fromCircle(center: moonCenter, radius: bodyRadius));

    canvas.drawCircle(moonCenter, bodyRadius, moonPaint);

    final craterOpacity = 0.35 - (t * 0.15);
    final craterPaint =
        Paint()..color = const Color(0xFF0F172A).withOpacity(craterOpacity);
    canvas.drawCircle(
      Offset(moonCenter.dx - bodyRadius * 0.32,
          moonCenter.dy - bodyRadius * 0.22),
      bodyRadius * 0.22,
      craterPaint,
    );
    canvas.drawCircle(
      Offset(moonCenter.dx + bodyRadius * 0.25,
          moonCenter.dy + bodyRadius * 0.28),
      bodyRadius * 0.26,
      craterPaint,
    );
    canvas.drawCircle(
      Offset(moonCenter.dx + bodyRadius * 0.28,
          moonCenter.dy - bodyRadius * 0.30),
      bodyRadius * 0.14,
      craterPaint,
    );
    canvas.drawCircle(
      Offset(moonCenter.dx - bodyRadius * 0.24,
          moonCenter.dy + bodyRadius * 0.34),
      bodyRadius * 0.15,
      craterPaint,
    );

    final diamondPeak = math.exp(-math.pow((t - 0.78) / 0.11, 2));
    if (diamondPeak > 0.04) {
      final flareCenter =
          Offset(moonCenter.dx - bodyRadius * 0.92, moonCenter.dy);
      final flarePaint = Paint()
        ..color = Colors.white.withOpacity(0.95 * diamondPeak)
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(flareCenter.dx - size.width * 0.42 * diamondPeak, flareCenter.dy),
        Offset(flareCenter.dx + size.width * 0.42 * diamondPeak, flareCenter.dy),
        flarePaint,
      );
      canvas.drawLine(
        Offset(flareCenter.dx, flareCenter.dy - size.height * 0.45 * diamondPeak),
        Offset(flareCenter.dx, flareCenter.dy + size.height * 0.45 * diamondPeak),
        flarePaint,
      );
      canvas.drawCircle(
        flareCenter,
        bodyRadius * 0.48 * diamondPeak,
        Paint()..color = Colors.white.withOpacity(0.95 * diamondPeak),
      );
    }

    canvas.drawRRect(
      innerRRect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..color = Colors.black.withOpacity(0.18),
    );

    canvas.restore();
  }

  void _drawSparkleStar(
      Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(center.dx, center.dy - radius)
      ..lineTo(center.dx + radius * 0.32, center.dy - radius * 0.32)
      ..lineTo(center.dx + radius, center.dy)
      ..lineTo(center.dx + radius * 0.32, center.dy + radius * 0.32)
      ..lineTo(center.dx, center.dy + radius)
      ..lineTo(center.dx - radius * 0.32, center.dy + radius * 0.32)
      ..lineTo(center.dx - radius, center.dy)
      ..lineTo(center.dx - radius * 0.32, center.dy - radius * 0.32)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _EclipseTogglePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}