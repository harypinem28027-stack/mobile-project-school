import 'package:flutter/material.dart';

/// Jenis baris kode di kartu terminal (untuk pewarnaan baris).
enum CodeLineType { normal, error, success }

/// Satu potongan teks berwarna di dalam satu baris kode.
/// Dipakai untuk highlight kata tertentu (mis. "collor" vs "color").
class CodeSpan {
  final String text;
  final Color? color;
  final bool bold;
  final bool underline;

  const CodeSpan(
    this.text, {
    this.color,
    this.bold = false,
    this.underline = false,
  });
}

/// Satu baris kode di dalam CodeTerminalCard.
class CodeLine {
  final String number;
  final String text;
  final CodeLineType type;

  /// Opsional: kalau diisi, baris ditampilkan per-span (untuk highlight
  /// kata tertentu). Kalau null, `text` ditampilkan polos sesuai [type].
  final List<CodeSpan>? spans;

  const CodeLine({
    required this.number,
    required this.text,
    this.type = CodeLineType.normal,
    this.spans,
  });
}

/// Model lengkap satu studi kasus (bug + perbaikan + penjelasan guru).
class CaseStudy {
  final String caseNumber; // "CASE STUDY #01"
  final String materialId; // "id_materi: CSS-01"
  final String labId; // "id_lab: LAB-01"
  final String errorTag; // "CSS Syntax Error: Typo"
  final String title;
  final String subject; // "CSS Dasar"
  final String level; // "Tingkat: Pemula"
  final String targetClass; // "Kelas X / Siswa Baru"
  final String problemScenario;

  final String brokenFilename;
  final List<CodeLine> brokenCode;
  final String errorDiagnosisTitle;
  final String errorDiagnosisText;

  final String fixedFilename;
  final List<CodeLine> fixedCode;
  final String successText;

  final String wrongSnippet;
  final String correctSnippet;
  final String comparisonTip;

  final String teacherId;
  final String teacherName;
  final String teacherTipsTitle;
  final String teacherTipsText;

  const CaseStudy({
    required this.caseNumber,
    required this.materialId,
    required this.labId,
    required this.errorTag,
    required this.title,
    required this.subject,
    required this.level,
    required this.targetClass,
    required this.problemScenario,
    required this.brokenFilename,
    required this.brokenCode,
    required this.errorDiagnosisTitle,
    required this.errorDiagnosisText,
    required this.fixedFilename,
    required this.fixedCode,
    required this.successText,
    required this.wrongSnippet,
    required this.correctSnippet,
    required this.comparisonTip,
    required this.teacherId,
    required this.teacherName,
    required this.teacherTipsTitle,
    required this.teacherTipsText,
  });
}
