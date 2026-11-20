import 'package:flutter/material.dart';

import '../models/quiz.dart';
import '../theme/app_colors.dart';
import '../widgets/code_terminal_card.dart';
import '../widgets/glass_morphism_box.dart';

enum _ViewMode { attempt, result }

/// Halaman kuis & pembahasan bergaya Glassmorphism / Liquid Glass.
class ModalTestPage extends StatefulWidget {
  final QuizModule module;
  final bool reviewMode;

  ModalTestPage({
    super.key,
    required this.module,
    this.reviewMode = false,
  });

  @override
  State<ModalTestPage> createState() => _ModalTestPageState();
}

class _ModalTestPageState extends State<ModalTestPage> {
  late List<QuizQuestion> _questions;
  _ViewMode _mode = _ViewMode.attempt;

  int _index = 0;
  int? _selected;
  bool _confirmed = false;
  int _correctCount = 0;

  @override
  void initState() {
    super.initState();
    _questions = widget.module.questions;
    if (widget.reviewMode) {
      _selected = _questions[_index].correctIndex;
      _confirmed = true;
    }
  }

  QuizQuestion get _current => _questions[_index];
  bool get _isLast => _index == _questions.length - 1;

  void _selectOption(int i) {
    if (_confirmed) return;
    setState(() => _selected = i);
  }

  void _confirmAnswer() {
    if (_selected == null) return;
    setState(() {
      _confirmed = true;
      if (_selected == _current.correctIndex) _correctCount++;
    });
  }

  void _goNext() {
    if (_isLast) {
      if (widget.reviewMode) {
        Navigator.of(context).pop();
      } else {
        setState(() => _mode = _ViewMode.result);
      }
      return;
    }
    setState(() {
      _index++;
      if (widget.reviewMode) {
        _selected = _current.correctIndex;
        _confirmed = true;
      } else {
        _selected = null;
        _confirmed = false;
      }
    });
  }

  void _goPrev() {
    if (_index == 0) return;
    setState(() {
      _index--;
      if (widget.reviewMode) {
        _selected = _current.correctIndex;
        _confirmed = true;
      }
    });
  }

  void _restart() {
    setState(() {
      _index = 0;
      _selected = null;
      _confirmed = false;
      _correctCount = 0;
      _mode = _ViewMode.attempt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -40,
            child: _AmbientGlow(
              size: 230,
              color: widget.module.accentColor.withOpacity(0.14),
            ),
          ),
          Positioned(
            top: 260,
            left: -60,
            child: _AmbientGlow(
              size: 210,
              color: const Color(0xFF38BDF8).withOpacity(0.12),
            ),
          ),
          Positioned(
            bottom: 70,
            right: -50,
            child: _AmbientGlow(
              size: 240,
              color: const Color(0xFF818CF8).withOpacity(0.13),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                if (_mode == _ViewMode.attempt) _buildProgressBar(),
                Expanded(
                  child: _mode == _ViewMode.result
                      ? _buildResultView()
                      : _buildQuestionView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: GlassMorphismBox(
              borderRadius: 999,
              opacity: 0.55,
              padding: EdgeInsets.all(9),
              child: Icon(
                Icons.close_rounded,
                color: AppColors.slate700,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.reviewMode)
                  Text(
                    'MODE PEMBAHASAN',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: widget.module.accentColor,
                      letterSpacing: 0.6,
                    ),
                  ),
                Text(
                  widget.module.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.slate900,
                  ),
                ),
              ],
            ),
          ),
          if (_mode == _ViewMode.attempt) ...[
            SizedBox(width: 8),
            GlassMorphismBox(
              borderRadius: 999,
              opacity: 0.58,
              blurSigma: 12,
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
              child: Text(
                'Soal ${_index + 1}/${_questions.length}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_index + (_confirmed ? 1 : 0)) / _questions.length;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 2, 16, 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: LinearProgressIndicator(
          value: progress.clamp(0, 1),
          minHeight: 6,
          backgroundColor: AppColors.slate200.withOpacity(0.75),
          valueColor: AlwaysStoppedAnimation(widget.module.accentColor),
        ),
      ),
    );
  }

  Widget _buildQuestionView() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 24),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassMorphismBox(
                      borderRadius: 28,
                      opacity: 0.52,
                      padding: EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: widget.module.accentColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color:
                                    widget.module.accentColor.withOpacity(0.30),
                              ),
                            ),
                            child: Text(
                              'PERTANYAAN #${_index + 1}',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: widget.module.accentColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _current.prompt,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.slate900,
                              height: 1.4,
                            ),
                          ),
                          if (_current.codeSnippet != null) ...[
                            SizedBox(height: 14),
                            CodeTerminalCard(
                              title: 'CUPLIKAN KODE',
                              filename: _current.codeFilename ?? 'kode',
                              accent: widget.module.accentColor,
                              codeLines: _current.codeSnippet!,
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ...List.generate(
                        _current.options.length, (i) => _optionTile(i)),
                    if (_confirmed) ...[
                      SizedBox(height: 8),
                      _explanationBox(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildBottomActionBar(),
      ],
    );
  }

  Widget _optionTile(int i) {
    final letter = String.fromCharCode(65 + i);
    final isSelected = _selected == i;
    final isCorrect = i == _current.correctIndex;

    Color tint = Colors.white;
    double opacity = 0.48;
    Color fg = AppColors.slate800;
    Color badgeBg = AppColors.slate100;
    Color? highlightBorder;
    IconData? trailingIcon;
    Color? trailingColor;

    if (_confirmed) {
      if (isCorrect) {
        tint = AppColors.emerald50;
        opacity = 0.68;
        fg = AppColors.emerald700;
        badgeBg = AppColors.emerald500.withOpacity(0.18);
        highlightBorder = AppColors.emerald500.withOpacity(0.55);
        trailingIcon = Icons.check_circle_rounded;
        trailingColor = AppColors.emerald700;
      } else if (isSelected) {
        tint = const Color(0xFFFFF1F2);
        opacity = 0.68;
        fg = const Color(0xFFBE123C);
        badgeBg = const Color(0xFFBE123C).withOpacity(0.14);
        highlightBorder = const Color(0xFFFB7185).withOpacity(0.6);
        trailingIcon = Icons.cancel_rounded;
        trailingColor = const Color(0xFFBE123C);
      }
    } else if (isSelected) {
      tint = AppColors.sky50;
      opacity = 0.68;
      fg = AppColors.sky700;
      badgeBg = AppColors.sky600.withOpacity(0.15);
      highlightBorder = AppColors.sky600.withOpacity(0.55);
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => _selectOption(i),
        child: GlassMorphismBox(
          borderRadius: 22,
          opacity: opacity,
          tintColor: tint,
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: highlightBorder != null
                  ? Border.all(color: highlightBorder, width: 1.5)
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: badgeBg,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.85),
                      width: 1.1,
                    ),
                  ),
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: fg,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _current.options[i],
                    style: TextStyle(
                      fontSize: 13.5,
                      color: fg,
                      fontWeight: isSelected || (_confirmed && isCorrect)
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
                if (trailingIcon != null) ...[
                  SizedBox(width: 8),
                  Icon(trailingIcon, size: 20, color: trailingColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _explanationBox() {
    final isCorrect = _selected == _current.correctIndex;
    final tint = isCorrect ? AppColors.emerald50 : AppColors.amber50;
    final fg = isCorrect ? AppColors.emerald700 : AppColors.amber900;
    final accent = isCorrect ? AppColors.emerald700 : AppColors.amber800;

    return GlassMorphismBox(
      borderRadius: 24,
      opacity: 0.62,
      tintColor: tint,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: (isCorrect
                    ? AppColors.emerald500
                    : const Color(0xFFF59E0B))
                .withOpacity(0.45),
            width: 1.3,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCorrect ? Icons.verified_rounded : Icons.lightbulb_rounded,
                size: 18,
                color: accent,
              ),
            ),
            SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCorrect ? 'Penjelasan Jawaban Benar' : 'Catatan Koreksi',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    _current.explanation,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: fg,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionBar() {
    final action = _primaryButtonAction();
    final isEnabled = action != null;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 14),
      child: GlassMorphismBox(
        borderRadius: 999,
        opacity: 0.52,
        padding: EdgeInsets.all(6),
        child: Row(
          children: [
            if (widget.reviewMode && _index > 0) ...[
              GestureDetector(
                onTap: _goPrev,
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.slate200),
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                    color: AppColors.slate700,
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
            Expanded(
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: isEnabled
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            widget.module.accentColor,
                            Color.lerp(widget.module.accentColor,
                                    const Color(0xFF6366F1), 0.45) ??
                                widget.module.accentColor,
                          ],
                        )
                      : null,
                  color: isEnabled ? null : AppColors.slate200.withOpacity(0.8),
                  boxShadow: isEnabled
                      ? [
                          BoxShadow(
                            color: widget.module.accentColor.withOpacity(0.30),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: ElevatedButton(
                  onPressed: action,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    disabledForegroundColor: AppColors.slate500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _primaryButtonLabel(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        _isLast
                            ? Icons.check_circle_outline_rounded
                            : Icons.arrow_forward_rounded,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback? _primaryButtonAction() {
    if (widget.reviewMode) return _goNext;
    if (!_confirmed) return _selected == null ? null : _confirmAnswer;
    return _goNext;
  }

  String _primaryButtonLabel() {
    if (widget.reviewMode) {
      return _isLast ? 'Selesai Pembahasan' : 'Lanjut Pembahasan';
    }
    if (!_confirmed) return 'Konfirmasi Jawaban';
    return _isLast ? 'Lihat Hasil' : 'Lanjut ke Soal Berikutnya';
  }

  Widget _buildResultView() {
    final total = _questions.length;
    final scorePercent = ((_correctCount / total) * 100).round();
    final passed = scorePercent >= widget.module.kkmPercent;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 420),
          child: GlassMorphismBox(
            borderRadius: 30,
            opacity: 0.52,
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 6),
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: passed
                          ? [
                              AppColors.emerald50,
                              const Color(0xFFD1FAE5).withOpacity(0.7),
                            ]
                          : [
                              AppColors.amber50,
                              AppColors.amber100.withOpacity(0.7),
                            ],
                    ),
                    border: Border.all(
                      color:
                          passed ? AppColors.emerald200 : AppColors.amber200,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (passed
                                ? AppColors.emerald500
                                : const Color(0xFFF59E0B))
                            .withOpacity(0.20),
                        blurRadius: 18,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '$scorePercent',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: passed
                            ? AppColors.emerald700
                            : AppColors.amber800,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  passed ? 'Kuis Tuntas! 🎉' : 'Belum Mencapai KKM',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: AppColors.slate900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '$_correctCount dari $total soal benar • KKM ${widget.module.kkmPercent}%',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.slate600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      colors: [
                        widget.module.accentColor,
                        Color.lerp(widget.module.accentColor,
                                const Color(0xFF6366F1), 0.45) ??
                            widget.module.accentColor,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.module.accentColor.withOpacity(0.28),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _restart,
                    icon: Icon(Icons.replay_rounded, size: 18),
                    label: Text(
                      'Ulangi Kuis',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.55),
                      foregroundColor: AppColors.slate700,
                      side: BorderSide(color: AppColors.slate300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'Kembali ke Daftar Kuis',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  final double size;
  final Color color;

  _AmbientGlow({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withOpacity(0.0)],
          ),
        ),
      ),
    );
  }
}