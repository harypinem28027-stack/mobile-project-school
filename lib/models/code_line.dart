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

/// Satu baris kode di dalam CodeTerminalCard. Reusable untuk kartu kode
/// di halaman manapun (studi kasus, kuis, dst).
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
