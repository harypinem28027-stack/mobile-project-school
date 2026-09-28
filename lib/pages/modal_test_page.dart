import 'package:flutter/material.dart';

import '../models/quiz.dart';
import '../theme/app_colors.dart';
import '../widgets/code_terminal_card.dart';

enum _ViewMode { attempt, result }

/// Halaman kuis saat "dimasukin" (dibuka) — dipakai untuk 2 keperluan:
/// - Mengerjakan kuis baru / mengulang kuis (reviewMode = false)
/// - Melihat pembahasan kuis yang sudah selesai (reviewMode = true)
///
/// Dibuka sebagai fullscreen dialog dari [TestPage].
class ModalTestPage extends StatefulWidget {
  final QuizModule module;
  final bool reviewMode;

  const ModalTestPage({super.key, required this.module, this.reviewMode = false});

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
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            if (_mode == _ViewMode.attempt) _buildProgressBar(),
            Expanded(
              child: _mode == _ViewMode.result ? _buildResultView() : _buildQuestionView(),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Top bar ----------------
  Widget _buildTopBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: AppColors.slate600),
          ),
          Expanded(
            child: Text(
              widget.reviewMode ? 'Pembahasan: ${widget.module.title}' : widget.module.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.slate900),
            ),
          ),
          if (_mode == _ViewMode.attempt)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                'Soal ${_index + 1}/${_questions.length}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: AppColors.slate500),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_index + (_confirmed ? 1 : 0)) / _questions.length;
    return ClipRRect(
      child: LinearProgressIndicator(
        value: progress.clamp(0, 1),
        minHeight: 4,
        backgroundColor: AppColors.slate200,
        valueColor: AlwaysStoppedAnimation(widget.module.accentColor),
      ),
    );
  }

  // ---------------- Question view ----------------
  Widget _buildQuestionView() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _current.prompt,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.slate900, height: 1.4),
                    ),
                    if (_current.codeSnippet != null) ...[
                      const SizedBox(height: 12),
                      CodeTerminalCard(
                        title: 'CUPLIKAN KODE',
                        filename: _current.codeFilename ?? 'kode',
                        accent: widget.module.accentColor,
                        codeLines: _current.codeSnippet!,
                      ),
                    ],
                    const SizedBox(height: 16),
                    ...List.generate(_current.options.length, (i) => _optionTile(i)),
                    if (_confirmed) ...[
                      const SizedBox(height: 8),
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
    final letter = String.fromCharCode(65 + i); // A, B, C, D
    final isSelected = _selected == i;
    final isCorrect = i == _current.correctIndex;

    Color border = AppColors.slate200;
    Color bg = Colors.white;
    Color fg = AppColors.slate800;
    IconData? trailingIcon;
    Color? trailingColor;

    if (_confirmed) {
      if (isCorrect) {
        border = AppColors.emerald200;
        bg = AppColors.emerald50;
        fg = AppColors.emerald700;
        trailingIcon = Icons.check_circle;
        trailingColor = AppColors.emerald700;
      } else if (isSelected) {
        border = const Color(0xFFFECDD3);
        bg = const Color(0xFFFFF1F2);
        fg = const Color(0xFFBE123C);
        trailingIcon = Icons.cancel;
        trailingColor = const Color(0xFFBE123C);
      }
    } else if (isSelected) {
      border = AppColors.sky200;
      bg = AppColors.sky50;
      fg = AppColors.sky700;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => _selectOption(i),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border, width: isSelected || (_confirmed && isCorrect) ? 1.5 : 1),
          ),
          child: Row(
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected || (_confirmed && isCorrect) ? fg.withOpacity(0.12) : AppColors.slate100,
                  shape: BoxShape.circle,
                ),
                child: Text(letter, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: fg)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(_current.options[i], style: TextStyle(fontSize: 13, color: fg, fontWeight: FontWeight.w500)),
              ),
              if (trailingIcon != null) Icon(trailingIcon, size: 18, color: trailingColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _explanationBox() {
    final isCorrect = _selected == _current.correctIndex;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCorrect ? AppColors.emerald50 : AppColors.amber50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isCorrect ? AppColors.emerald200 : AppColors.amber200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(isCorrect ? Icons.verified : Icons.lightbulb, size: 18, color: isCorrect ? AppColors.emerald700 : AppColors.amber800),
          const SizedBox(width: 8),
          Expanded(
            child: Text(_current.explanation,
                style: TextStyle(fontSize: 12, height: 1.5, color: isCorrect ? AppColors.emerald700 : AppColors.amber900)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.slate200))),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (widget.reviewMode && _index > 0)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: OutlinedButton(
                  onPressed: _goPrev,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    side: const BorderSide(color: AppColors.slate300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Icon(Icons.arrow_back, size: 18, color: AppColors.slate600),
                ),
              ),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _primaryButtonAction(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.module.accentColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.slate200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(_primaryButtonLabel(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
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
    if (widget.reviewMode) return _isLast ? 'Selesai' : 'Lanjut Pembahasan';
    if (!_confirmed) return 'Konfirmasi Jawaban';
    return _isLast ? 'Lihat Hasil' : 'Lanjut ke Soal Berikutnya';
  }

  // ---------------- Result view ----------------
  Widget _buildResultView() {
    final total = _questions.length;
    final scorePercent = ((_correctCount / total) * 100).round();
    final passed = scorePercent >= widget.module.kkmPercent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: passed ? AppColors.emerald50 : AppColors.amber50,
                  border: Border.all(color: passed ? AppColors.emerald200 : AppColors.amber200, width: 3),
                ),
                child: Center(
                  child: Text('$scorePercent',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w800, color: passed ? AppColors.emerald700 : AppColors.amber800)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                passed ? 'Kuis Tuntas! 🎉' : 'Belum Mencapai KKM',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.slate900),
              ),
              const SizedBox(height: 6),
              Text(
                '$_correctCount dari $total soal benar • KKM ${widget.module.kkmPercent}%',
                style: const TextStyle(fontSize: 13, color: AppColors.slate500),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _restart,
                  icon: const Icon(Icons.replay, size: 18),
                  label: const Text('Ulangi Kuis', style: TextStyle(fontWeight: FontWeight.w700)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.module.accentColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.slate700,
                    side: const BorderSide(color: AppColors.slate300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Kembali ke Daftar Kuis', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
