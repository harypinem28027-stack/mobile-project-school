import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Membuat PageRoute dengan transisi lembut menuju halaman berikutnya.
PageRoute<T> buildLiquidPageRoute<T>({
  required Widget page,
  Duration duration = const Duration(milliseconds: 480),
}) {
  return PageRouteBuilder<T>(
    transitionDuration: duration,
    reverseTransitionDuration: const Duration(milliseconds: 340),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );

      return FadeTransition(
        opacity: curved,
        child: child,
      );
    },
  );
}

/// Layar transisi berlatar kode hacker bersih dengan tulisan "Berhasil Login".
class LiquidWelcomeTransition extends StatefulWidget {
  final String studentName;
  final Widget destination;

  const LiquidWelcomeTransition({
    super.key,
    required this.studentName,
    required this.destination,
  });

  @override
  State<LiquidWelcomeTransition> createState() =>
      _LiquidWelcomeTransitionState();
}

class _LiquidWelcomeTransitionState extends State<LiquidWelcomeTransition>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _rainController;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1350),
    );

    _rainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    HapticFeedback.lightImpact();
    _mainController.forward();

    _mainController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          buildLiquidPageRoute(
            page: widget.destination,
            duration: const Duration(milliseconds: 420),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _rainController.dispose();
    super.dispose();
  }

  String get _displayName {
    final raw = widget.studentName.trim();
    if (raw.isEmpty) return 'Siswa';
    if (raw.contains('@')) return raw.split('@').first;
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060D1A),
      body: Stack(
        children: [
          // 1. Latar Belakang Hujan Kode Hacker
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _rainController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _CyberCodeRainPainter(
                    progress: _rainController.value,
                  ),
                );
              },
            ),
          ),

          // 2. Pendaran Cahaya Halus di Tengah
          Center(
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF10B981).withOpacity(0.16),
                    const Color(0xFF060D1A).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // 3. Teks Bersih "Berhasil Login" Tanpa Border/Kotak
          Center(
            child: AnimatedBuilder(
              animation: _mainController,
              builder: (context, _) {
                final t = _mainController.value;
                final fadeIn =
                    Curves.easeOut.transform((t / 0.35).clamp(0.0, 1.0));
                final dropY = (1.0 -
                        Curves.easeOutBack
                            .transform((t / 0.45).clamp(0.0, 1.0))) *
                    -26.0;

                return Opacity(
                  opacity: fadeIn,
                  child: Transform.translate(
                    offset: Offset(0, dropY),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 46,
                          color: Color(0xFF34D399),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Berhasil Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Color(0x8834D399),
                                blurRadius: 18,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Selamat datang, $_displayName',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6EE7B7).withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter hujan karakter kode (biner, heksadesimal & sintaks pemrograman)
class _CyberCodeRainPainter extends CustomPainter {
  final double progress;

  _CyberCodeRainPainter({required this.progress});

  static const List<String> _tokens = [
    '0',
    '1',
    '<>',
    '{}',
    '0x7F',
    '//',
    '=>',
    'FF',
    '01',
    ';',
    '10',
    '0x2A',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const double columnSpacing = 28.0;
    final columns = (size.width / columnSpacing).ceil();

    for (int col = 0; col < columns; col++) {
      final rand = math.Random(col * 137 + 19);
      final speed = 0.65 + rand.nextDouble() * 0.85;
      final phase = rand.nextDouble();
      final x = col * columnSpacing + 8;

      const int rows = 14;
      for (int row = 0; row < rows; row++) {
        final normY = ((row / rows) + progress * speed + phase) % 1.0;
        final y = normY * size.height;

        final headBoost =
            (row == rows - 1) ? 0.36 : 0.08 + (row / rows) * 0.14;
        final isEmerald = (col + row) % 3 == 0;

        final textPainter = TextPainter(
          text: TextSpan(
            text:
                _tokens[(col + row + (progress * 10).floor()) % _tokens.length],
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: row == rows - 1 ? FontWeight.w800 : FontWeight.w500,
              color: (isEmerald
                      ? const Color(0xFF34D399)
                      : const Color(0xFF38BDF8))
                  .withOpacity(headBoost),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        textPainter.paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CyberCodeRainPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}