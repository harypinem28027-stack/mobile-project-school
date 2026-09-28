import 'package:flutter/material.dart';

import 'code_line.dart';

/// Status pengerjaan satu modul kuis.
enum QuizStatus {
  completed, // sudah dikerjakan & nilai bagus
  newChallenge, // belum dikerjakan, wajib
  needsImprovement, // sudah dikerjakan tapi nilai perlu naik
}

/// Satu butir soal pilihan ganda.
class QuizQuestion {
  final String prompt;

  /// Opsional: potongan kode yang ditampilkan di atas pilihan jawaban
  /// (dipakai lewat CodeTerminalCard).
  final List<CodeLine>? codeSnippet;
  final String? codeFilename;

  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.prompt,
    this.codeSnippet,
    this.codeFilename,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

/// Satu modul kuis (mis. "Kuis Modul 01: HTML Dasar").
class QuizModule {
  final String materialId; // MAT-HTML-01
  final String title; // Kuis Modul 01: HTML Dasar
  final Color accentColor;
  final QuizStatus status;

  final int? score; // null kalau belum dikerjakan
  final int? correctCount;
  final int totalQuestions;
  final int estimatedMinutes;
  final int kkmPercent;

  final String topicLabel; // "Cakupan Tag Sintaks:" / "Target Analisis..."
  final List<String> topicChips;
  final String? topicNote;

  final List<QuizQuestion> questions;

  const QuizModule({
    required this.materialId,
    required this.title,
    required this.accentColor,
    required this.status,
    this.score,
    this.correctCount,
    required this.totalQuestions,
    required this.estimatedMinutes,
    required this.kkmPercent,
    required this.topicLabel,
    this.topicChips = const [],
    this.topicNote,
    required this.questions,
  });

  bool get isPassing => (score ?? 0) >= kkmPercent;
}
