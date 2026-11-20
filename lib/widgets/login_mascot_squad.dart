import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Squad 5 makhluk bulat berbulu yang interaktif di atas kartu login:
/// - mood 0: normal, bernapas lembut, melirik ketikan & memantul saat mengetik
/// - mood 1: fokus password -> menutup mata dengan cakar berbulu
/// - mood 2: password terlihat -> mengintip dari sela cakar, berbisik & nguping
class LoginMascotSquad extends StatefulWidget {
  final int mood;
  final double lookRatio;
  final int nodTrigger;

  LoginMascotSquad({
    super.key,
    required this.mood,
    required this.lookRatio,
    required this.nodTrigger,
  });

  @override
  State<LoginMascotSquad> createState() => _LoginMascotSquadState();
}

class _LoginMascotSquadState extends State<LoginMascotSquad>
    with TickerProviderStateMixin {
  late final AnimationController _idleController;
  late final AnimationController _nodController;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _nodController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void didUpdateWidget(covariant LoginMascotSquad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.nodTrigger != oldWidget.nodTrigger && widget.mood == 0) {
      _nodController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _idleController.dispose();
    _nodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 310,
        height: 118,
        child: AnimatedBuilder(
          animation: Listenable.merge([_idleController, _nodController]),
          builder: (context, _) {
            final breathe = math.sin(_idleController.value * math.pi);
            final nodWave = math.sin(_nodController.value * math.pi);

            return CustomPaint(
              size: Size(310, 118),
              painter: _FluffySquadPainter(
                mood: widget.mood,
                lookRatio: widget.lookRatio,
                breathe: breathe,
                nod: nodWave,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FluffySquadPainter extends CustomPainter {
  final int mood;
  final double lookRatio;
  final double breathe;
  final double nod;

  _FluffySquadPainter({
    required this.mood,
    required this.lookRatio,
    required this.breathe,
    required this.nod,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Urutan gambar dari belakang ke depan agar makhluk tengah terlihat paling menonjol
    // 1. Paling Kiri: Mint Fluffy Bunny
    _drawFluffyCreature(
      canvas: canvas,
      center: Offset(38, 76 - breathe * 2.0 - nod * 4.5),
      radius: 25,
      tuftCount: 16,
      tuftDepth: 3.6,
      topColor: const Color(0xFF6EE7B7),
      bottomColor: const Color(0xFF059669),
      cheekColor: const Color(0xFFFDA4AF),
      earType: _EarType.bunny,
      eyeSpacing: 8.5,
      eyeRadius: 4.5,
      scaleX: 1.0 + nod * 0.05,
      scaleY: 1.0 - nod * 0.05,
      lookX: mood == 2 ? 1.0 : lookRatio, // Menoleh ke kanan berbisik saat mood 2
      lookY: mood == 2 ? -0.2 : 0.1,
      pawState: mood == 1
          ? _PawState.coverEyes
          : (mood == 2 ? _PawState.whisper : _PawState.restOnCard),
      cardTopY: 102,
      isWhispering: mood == 2,
    );

    // 2. Paling Kanan: Sakura Pink Pom-Pom
    _drawFluffyCreature(
      canvas: canvas,
      center: Offset(272, 79 - (1 - breathe) * 2.0 - nod * 5.0),
      radius: 23,
      tuftCount: 15,
      tuftDepth: 3.5,
      topColor: const Color(0xFFF9A8D4),
      bottomColor: const Color(0xFFDB2777),
      cheekColor: const Color(0xFFFECDD3),
      earType: _EarType.pomStar,
      eyeSpacing: 8.0,
      eyeRadius: 4.3,
      scaleX: 1.0 + nod * 0.06,
      scaleY: 1.0 - nod * 0.06,
      lookX: mood == 2 ? -1.0 : lookRatio, // Menoleh ke kiri nguping saat mood 2
      lookY: mood == 2 ? -0.2 : 0.1,
      pawState: mood == 1
          ? _PawState.coverEyes
          : (mood == 2 ? _PawState.eavesdrop : _PawState.restOnCard),
      cardTopY: 102,
      isSurprised: mood == 2,
    );

    // 3. Tengah Kiri: Lavender Chibi Bear-Cloud
    _drawFluffyCreature(
      canvas: canvas,
      center: Offset(89, 68 - (1 - breathe) * 2.4 - nod * 5.5),
      radius: 30,
      tuftCount: 18,
      tuftDepth: 4.0,
      topColor: const Color(0xFFA5B4FC),
      bottomColor: const Color(0xFF4F46E5),
      cheekColor: const Color(0xFFFDA4AF),
      earType: _EarType.bear,
      eyeSpacing: 10.5,
      eyeRadius: 5.2,
      scaleX: 1.0 + nod * 0.05,
      scaleY: 1.0 - nod * 0.05,
      lookX: mood == 2 ? -0.85 : lookRatio, // Ikut nguping ke kiri saat mood 2
      lookY: 0.05,
      pawState: mood == 1
          ? _PawState.coverEyes
          : (mood == 2 ? _PawState.eavesdrop : _PawState.restOnCard),
      cardTopY: 102,
      isSurprised: mood == 2,
    );

    // 4. Tengah Kanan: Sunny Peach Fox-Puff
    _drawFluffyCreature(
      canvas: canvas,
      center: Offset(221, 69 - breathe * 2.4 - nod * 5.5),
      radius: 29,
      tuftCount: 18,
      tuftDepth: 4.0,
      topColor: const Color(0xFFFCD34D),
      bottomColor: const Color(0xFFD97706),
      cheekColor: const Color(0xFFFB7185),
      earType: _EarType.fox,
      eyeSpacing: 10.0,
      eyeRadius: 5.0,
      scaleX: 1.0 + nod * 0.05,
      scaleY: 1.0 - nod * 0.05,
      lookX: mood == 2 ? 0.85 : lookRatio, // Ikut berbisik ke kanan saat mood 2
      lookY: 0.05,
      pawState: mood == 1
          ? _PawState.coverEyes
          : (mood == 2 ? _PawState.whisper : _PawState.restOnCard),
      cardTopY: 102,
      isWhispering: mood == 2,
    );

    // 5. Tengah Utama (Hero): Sky-Blue Big Fluffy Monster
    _drawFluffyCreature(
      canvas: canvas,
      center: Offset(155, 58 - breathe * 3.0 - nod * 7.0),
      radius: 38,
      tuftCount: 22,
      tuftDepth: 4.8,
      topColor: const Color(0xFF7DD3FC),
      bottomColor: const Color(0xFF0284C7),
      cheekColor: const Color(0xFFFDA4AF),
      earType: _EarType.crownTuft,
      eyeSpacing: 13.5,
      eyeRadius: 6.4,
      scaleX: 1.0 + nod * 0.06,
      scaleY: 1.0 - nod * 0.06,
      lookX: lookRatio,
      lookY: 0.12,
      pawState: mood == 1
          ? _PawState.coverEyes
          : (mood == 2 ? _PawState.peekOneEye : _PawState.restOnCard),
      cardTopY: 102,
      isHero: true,
    );
  }

  void _drawFluffyCreature({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required int tuftCount,
    required double tuftDepth,
    required Color topColor,
    required Color bottomColor,
    required Color cheekColor,
    required _EarType earType,
    required double eyeSpacing,
    required double eyeRadius,
    required double scaleX,
    required double scaleY,
    required double lookX,
    required double lookY,
    required _PawState pawState,
    required double cardTopY,
    bool isHero = false,
    bool isWhispering = false,
    bool isSurprised = false,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleX, scaleY);

    final bodyShader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [topColor, bottomColor],
    ).createShader(Rect.fromCircle(center: Offset.zero, radius: radius + tuftDepth));

    final bodyPaint = Paint()..shader = bodyShader;

    // 1. Telinga / Jambul Berbulu di Bagian Atas
    _drawEars(canvas, radius, topColor, bottomColor, earType);

    // 2. Bayangan lembut di bawah tubuh bulat
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(0, radius * 0.85),
        width: radius * 1.65,
        height: radius * 0.45,
      ),
      Paint()..color = bottomColor.withOpacity(0.20),
    );

    // 3. Tubuh Bulat Berbulu (Fluffy Cloud-Scallop Circle)
    final furPath = _buildFluffyCirclePath(radius, tuftCount, tuftDepth);
    canvas.drawPath(furPath, bodyPaint);

    // Kilau lembut di bagian atas kepala agar terlihat empuk & 3D
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(-radius * 0.22, -radius * 0.46),
        width: radius * 0.72,
        height: radius * 0.34,
      ),
      Paint()..color = Colors.white.withOpacity(0.32),
    );

    // 4. Patch Wajah / Perut Lembut Bagian Bawah
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(0, radius * 0.28),
        width: radius * 1.18,
        height: radius * 0.82,
      ),
      Paint()..color = Colors.white.withOpacity(0.22),
    );

    // 5. Pipi Merona (Rosy Cheeks)
    final cheekPaint = Paint()..color = cheekColor.withOpacity(0.65);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(-eyeSpacing - eyeRadius * 0.55, eyeRadius * 0.95),
        width: eyeRadius * 1.35,
        height: eyeRadius * 0.78,
      ),
      cheekPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(eyeSpacing + eyeRadius * 0.55, eyeRadius * 0.95),
        width: eyeRadius * 1.35,
        height: eyeRadius * 0.78,
      ),
      cheekPaint,
    );

    // 6. Mata Besar Imut + Pupil yang Melirik
    final eyeOffsetY = -radius * 0.08;
    _drawCuteEye(
      canvas: canvas,
      eyeCenter: Offset(-eyeSpacing, eyeOffsetY),
      eyeRadius: eyeRadius,
      lookX: lookX,
      lookY: lookY,
    );
    _drawCuteEye(
      canvas: canvas,
      eyeCenter: Offset(eyeSpacing, eyeOffsetY),
      eyeRadius: eyeRadius,
      lookX: lookX,
      lookY: lookY,
    );

    // 7. Mulut Mungil Imut (Senyum / Kaget / Berbisik)
    _drawMouth(
      canvas: canvas,
      mouthCenter: Offset(0, eyeOffsetY + eyeRadius * 1.25),
      radius: radius,
      isHero: isHero,
      isWhispering: isWhispering,
      isSurprised: isSurprised,
    );

    // 8. Cakar Bulat Berbulu (Tangan) sesuai ekspresi
    _drawPaws(
      canvas: canvas,
      centerWorldY: center.dy,
      radius: radius,
      eyeSpacing: eyeSpacing,
      eyeOffsetY: eyeOffsetY,
      eyeRadius: eyeRadius,
      topColor: topColor,
      bottomColor: bottomColor,
      pawState: pawState,
      cardTopY: cardTopY,
    );

    canvas.restore();
  }

  /// Membuat siluet lingkaran dengan gelombang bulu halus di sekelilingnya
  Path _buildFluffyCirclePath(double radius, int tuftCount, double tuftDepth) {
    final path = Path();
    final totalSteps = tuftCount * 6;

    for (int i = 0; i <= totalSteps; i++) {
      final theta = (i / totalSteps) * math.pi * 2;
      // Gelombang bulu lembut (abs(sin)) menghasilkan tonjolan bulu bulat yang empuk
      final wave = math.sin(theta * tuftCount * 0.5).abs();
      final r = radius - tuftDepth * 0.35 + wave * tuftDepth;
      final x = math.cos(theta) * r;
      final y = math.sin(theta) * r;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  void _drawEars(
    Canvas canvas,
    double radius,
    Color topColor,
    Color bottomColor,
    _EarType earType,
  ) {
    final earPaint = Paint()..color = topColor;
    final innerPaint = Paint()..color = const Color(0xFFFDA4AF).withOpacity(0.75);

    switch (earType) {
      case _EarType.bunny:
        // Sepasang telinga kelinci berbulu panjang
        for (final side in [-1.0, 1.0]) {
          canvas.save();
          canvas.translate(side * radius * 0.46, -radius * 0.88);
          canvas.rotate(side * 0.22);
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(center: Offset.zero, width: 10, height: 22),
              Radius.circular(99),
            ),
            earPaint,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(center: Offset(0, 1), width: 4.5, height: 14),
              Radius.circular(99),
            ),
            innerPaint,
          );
          canvas.restore();
        }
        break;

      case _EarType.bear:
        // Sepasang telinga beruang bulat berbulu
        for (final side in [-1.0, 1.0]) {
          final pos = Offset(side * radius * 0.68, -radius * 0.68);
          canvas.drawCircle(pos, 8.5, earPaint);
          canvas.drawCircle(pos, 4.5, innerPaint);
        }
        break;

      case _EarType.fox:
        // Sepasang telinga rubah/kucing runcing lembut
        for (final side in [-1.0, 1.0]) {
          final path = Path()
            ..moveTo(side * radius * 0.32, -radius * 0.72)
            ..quadraticBezierTo(
              side * radius * 0.78,
              -radius * 1.25,
              side * radius * 0.88,
              -radius * 0.46,
            )
            ..close();
          canvas.drawPath(path, earPaint);
        }
        break;

      case _EarType.pomStar:
        // Jambul pom-pom mungil + hiasan bintang kuning imut
        canvas.drawCircle(Offset(0, -radius * 0.96), 6.5, earPaint);
        final starPaint = Paint()..color = const Color(0xFFFDE047);
        canvas.drawCircle(Offset(radius * 0.56, -radius * 0.72), 4.2, starPaint);
        break;

      case _EarType.crownTuft:
        // Tiga helai jambul bulu lembut + antena pom-pom di puncak kepala
        for (int i = -1; i <= 1; i++) {
          canvas.save();
          canvas.translate(i * 7.5, -radius * 0.96 + i.abs() * 2.0);
          canvas.rotate(i * 0.28);
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(center: Offset.zero, width: 7.5, height: 14),
              Radius.circular(99),
            ),
            earPaint,
          );
          canvas.restore();
        }
        break;
    }
  }

  void _drawCuteEye({
    required Canvas canvas,
    required Offset eyeCenter,
    required double eyeRadius,
    required double lookX,
    required double lookY,
  }) {
    // Bagian putih mata
    canvas.drawCircle(
      eyeCenter,
      eyeRadius,
      Paint()..color = Colors.white,
    );

    // Iris / pupil gelap yang bergerak melirik
    final maxShift = eyeRadius * 0.34;
    final pupilCenter = Offset(
      eyeCenter.dx + lookX.clamp(-1.0, 1.0) * maxShift,
      eyeCenter.dy + lookY.clamp(-1.0, 1.0) * maxShift * 0.7,
    );

    canvas.drawCircle(
      pupilCenter,
      eyeRadius * 0.66,
      Paint()..color = const Color(0xFF0F172A),
    );

    // Kilau mata anime/chibi (2 titik cahaya putih)
    canvas.drawCircle(
      Offset(
        pupilCenter.dx - eyeRadius * 0.22,
        pupilCenter.dy - eyeRadius * 0.24,
      ),
      eyeRadius * 0.25,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      Offset(
        pupilCenter.dx + eyeRadius * 0.20,
        pupilCenter.dy + eyeRadius * 0.18,
      ),
      eyeRadius * 0.12,
      Paint()..color = Colors.white.withOpacity(0.85),
    );
  }

  void _drawMouth({
    required Canvas canvas,
    required Offset mouthCenter,
    required double radius,
    required bool isHero,
    required bool isWhispering,
    required bool isSurprised,
  }) {
    final mouthPaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHero ? 2.1 : 1.7
      ..strokeCap = StrokeCap.round;

    if (isSurprised || isWhispering) {
      // Mulut bulat kecil 'o' saat nguping/berbisik
      canvas.drawCircle(
        mouthCenter,
        isHero ? 3.2 : 2.5,
        Paint()..color = const Color(0xFFBE123C),
      );
      return;
    }

    // Mulut imut berbentuk 'w' / senyum kucing kecil
    final w = isHero ? 5.2 : 3.8;
    final h = isHero ? 3.2 : 2.3;
    final path = Path()
      ..moveTo(mouthCenter.dx - w, mouthCenter.dy - h * 0.3)
      ..quadraticBezierTo(
        mouthCenter.dx - w * 0.5,
        mouthCenter.dy + h,
        mouthCenter.dx,
        mouthCenter.dy - h * 0.1,
      )
      ..quadraticBezierTo(
        mouthCenter.dx + w * 0.5,
        mouthCenter.dy + h,
        mouthCenter.dx + w,
        mouthCenter.dy - h * 0.3,
      );
    canvas.drawPath(path, mouthPaint);
  }

  void _drawPaws({
    required Canvas canvas,
    required double centerWorldY,
    required double radius,
    required double eyeSpacing,
    required double eyeOffsetY,
    required double eyeRadius,
    required Color topColor,
    required Color bottomColor,
    required _PawState pawState,
    required double cardTopY,
  }) {
    final pawRadius = radius * 0.27;
    final pawFill = Paint()
      ..color = Color.lerp(topColor, Colors.white, 0.38)!;
    final pawBorder = Paint()
      ..color = bottomColor.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    void drawSinglePaw(Offset pos) {
      canvas.drawCircle(pos, pawRadius, pawFill);
      canvas.drawCircle(pos, pawRadius, pawBorder);
      // Bantalan cakar (paw pad) mungil berwarna pink lembut
      canvas.drawCircle(
        Offset(pos.dx, pos.dy + pawRadius * 0.12),
        pawRadius * 0.34,
        Paint()..color = const Color(0xFFFDA4AF).withOpacity(0.55),
      );
    }

    switch (pawState) {
      case _PawState.restOnCard:
        // Bertumpu manis di garis atas kartu login
        final restY = (cardTopY - centerWorldY).clamp(radius * 0.55, radius * 1.15);
        drawSinglePaw(Offset(-eyeSpacing * 0.95, restY));
        drawSinglePaw(Offset(eyeSpacing * 0.95, restY));
        break;

      case _PawState.coverEyes:
        // Menutup kedua mata dengan cakar berbulu saat mengetik sandi
        drawSinglePaw(Offset(-eyeSpacing * 0.85, eyeOffsetY));
        drawSinglePaw(Offset(eyeSpacing * 0.85, eyeOffsetY));
        break;

      case _PawState.peekOneEye:
        // Satu cakar menutup mata kiri, cakar kanan turun sedikit mengintip!
        drawSinglePaw(Offset(-eyeSpacing * 0.85, eyeOffsetY));
        drawSinglePaw(Offset(eyeSpacing * 0.95, eyeOffsetY + eyeRadius * 1.45));
        break;

      case _PawState.whisper:
        // Satu cakar di samping mulut seolah berbisik rahasia
        final restY = (cardTopY - centerWorldY).clamp(radius * 0.55, radius * 1.15);
        drawSinglePaw(Offset(-eyeSpacing * 0.95, restY));
        drawSinglePaw(Offset(eyeSpacing * 0.65, eyeOffsetY + eyeRadius * 1.25));
        break;

      case _PawState.eavesdrop:
        // Satu cakar di dekat telinga seolah menguping
        final restY = (cardTopY - centerWorldY).clamp(radius * 0.55, radius * 1.15);
        drawSinglePaw(Offset(-radius * 0.82, eyeOffsetY - eyeRadius * 0.5));
        drawSinglePaw(Offset(eyeSpacing * 0.95, restY));
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _FluffySquadPainter oldDelegate) {
    return oldDelegate.mood != mood ||
        oldDelegate.lookRatio != lookRatio ||
        oldDelegate.breathe != breathe ||
        oldDelegate.nod != nod;
  }
}

enum _EarType { bunny, bear, fox, pomStar, crownTuft }

enum _PawState { restOnCard, coverEyes, peekOneEye, whisper, eavesdrop }